Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280619AbRKJL4A>; Sat, 10 Nov 2001 06:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280620AbRKJLzv>; Sat, 10 Nov 2001 06:55:51 -0500
Received: from elin.scali.no ([62.70.89.10]:63496 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S280619AbRKJLzm>;
	Sat, 10 Nov 2001 06:55:42 -0500
Date: Sat, 10 Nov 2001 12:55:36 +0100 (CET)
From: Terje Eggestad <terje.eggestad@scali.no>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Terje Eggestad <terje.eggestad@scali.no>, <linux-kernel@vger.kernel.org>
Subject: Re: confused about raw-io blocksizes
In-Reply-To: <20011109171311.J1778@lynx.no>
Message-ID: <Pine.LNX.4.30.0111101231350.24890-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001, Andreas Dilger wrote:

> On Nov 10, 2001  00:52 +0100, Terje Eggestad wrote:
> > I'm curious as to what sets the smallest legal blocksize for raw-io, I
> > get different values for different partitions on the same disk drive.
> >
> > In all my tests I've used
> > raw /dev/raw/raw2 <block speclial file>
> > and to test block size:
> > dd if=/dev/raw/raw2 of=/dev/null bs=N count=1
> > where N is either 512, 1024, or 4096.
> > (I've a RH7.1 with a dd that do propper buffer alignment)
> > Failure is always "invalid argument" which singify either misaligned
> > buffer or illegal read length.
> >
> > What confuses me is that when raw2 is bound to /dev/hda bs=512 is ok.
> > However when binding raw2 to the different partitions on /dev/hda, some
> > are ok with 512, some will only accept 1024, and one required 4096.
>
> It may be getting confused with the filesystem blocksize.  Check tune2fs -l
> for those devices.
>
> > When creating an lvm vg on one partition (/dev/hda6), and I've created
> > two logical volumes on it, one was ok with 1024 and the other required
> > 4096. When binding a raw to /dev/hda6 dd with bs=512 was ok.
>
> LVM is broken in this regard, unless you have a recent patch (Linus'
> kernel does not).  I sent him a patch to fix that, but it did not get in.

I'm been trying with RH 2.4.2-2, stock 2.4.10, stock 2.4.13, and a RH
2.4.3 with some additional patches. All of them  has lvm 0.9.1_beta2
(isn't that getting old??)

That patch of ours may fix my problem, could you forward it to me please?
Is it included in later lvm versin from sistna?
I really want to be using lvm for the oracle partitions.

>
> What kernel version/LVM do you have?  Are you using LVM on all of these
> partitions, or only some?  Did you have filesystems on them?
>

The two disk I've used for exploration is:
/dev/hda1   *         1       500   4016218+  83  Linux
/dev/hda2           501       935   3494137+   5  Extended
/dev/hda5           501       564    514048+  82  Linux swap
/dev/hda6           565       935   2980026   8e  Linux LVM

hda bs=512, hda1 bs=4096, hda2 bs=512, hda5 bs=512, hda6 bs=512


/dev/hda1             1       102     51376+  83  Linux
/dev/hda2           103     20928  10496304    5  Extended
/dev/hda5           103     12293   6144232+  83  Linux
/dev/hda6         12294     12903    307408+  82  Linux swap
/dev/hda7         12904     20928   4044568+  83  Linux

hda bs=512, hda1 bs=1024, hda2 bs=512, hda5 bs=1024, hda6 bs=512,
hda7 bs=1024

Looks like your absolutly right about the fs, they're the only one
causing trouble.

The lvm volumes was zero out by dd if=/dev/zero of=loc.block.spec.file
the only reason I started with disk partitions was to try to figure out
what was going on.


Thx
	TJ

> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY
_________________________________________________________________________

