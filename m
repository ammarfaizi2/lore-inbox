Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132734AbRARKPk>; Thu, 18 Jan 2001 05:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132774AbRARKPa>; Thu, 18 Jan 2001 05:15:30 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:25096 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S132734AbRARKPW>;
	Thu, 18 Jan 2001 05:15:22 -0500
Date: Thu, 18 Jan 2001 11:14:59 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux not adhering to BIOS Drive boot order?
To: Andreas Dilger <adilger@turbolinux.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3A66C223.F9144139@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <200101172323.f0HNNt529625@webber.adilger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andreas Dilger wrote:
> 
> David Balazic writes:
> > Andreas Dilger <adilger@turbolinux.com> wrote :
> > > In the end I re-wrote most of the patch, so
> > > that we resolve ROOT_DEV before calling mount_root(), just to be a bit
> > > more consistent. I will release a new patch for 2.2.18 and 2.4.0 after
> > > David Balazic has a look at it.
> >
> > Cool, send it to me !
> 
> Need to test it a bit first (i.e. at least compile it)...

I will just throw a quick look into it , nothing more , as my setup is
a mess right now. I no kernel guru either, I just wrote the patch :-)

 > > > I know a bit about LILO, so I should be able to get the
"root=LABEL=" to
> > > work there as well.
> >
> > There were no problems with the original patch with LILO.
> > You just must use append="root=xxxxx" instead of simply
> > root=xxx , because LILO tries to be "smart" .... at least the
> > version I used then did.
> 
> Actually, there are 2 ways to go about this: LILO could do the UUID/LABEL
> resolution at the time lilo is run (to store root dev into kernel), and
> _also_ append "root=LABEL=X" to kernel options, so that if the kernel
> can't resolve the UUID/LABEL (i.e. no support for this option) we can fall
> back to the root dev from when LILO was run.
> 
> > > One reason why this may NOT ever make it into the kernel is that I know
> > > "kernel poking at devices" is really frowned upon.
> >
> > This an ugly hack , if you ask me. The identificators ( be it labels ,
> > UUIDs or whatever ) should be outside the partitions. Otherwise cases with
> > swap partitions , <any FS that doesn't support labels/UUIDs> unformatted
> > partitions etc. can not be handled.
> 
> LVM now has UUID-like identifiers for all "partitions" (Logical Volumes),
> although they are not really accessible by any tools right now. The "LABEL"
> is actually the LV name, so it is used directly all the time:
> 
> /dev/vgroot/lvroot      /       ext3    defaults        1       1
> /dev/vgroot/lvswap      none    swap    sw,pri=100      0       0

Is /dev/vgroot some kind of pseudo filesystem ?
With plain device files you have the same problems as with the "old"
partitions , I think. ( they have to be mapped to minors and nodes for
them must be created somehow ). I didn't try it yet and with devfs
it should work OK.

> This obviates most of the reason for the UUID/LABEL support, but not
> everyone runs LVM (yet ;-) and ext2 UUID/LABELs are still useful.

And LVM is not windows compatible , AFAIK, is it ?

 
-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
