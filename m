Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280328AbRKJANx>; Fri, 9 Nov 2001 19:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280343AbRKJANo>; Fri, 9 Nov 2001 19:13:44 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:14321 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280328AbRKJANi>;
	Fri, 9 Nov 2001 19:13:38 -0500
Date: Fri, 9 Nov 2001 17:13:11 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Terje Eggestad <terje.eggestad@scali.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: confused about raw-io blocksizes
Message-ID: <20011109171311.J1778@lynx.no>
Mail-Followup-To: Terje Eggestad <terje.eggestad@scali.no>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111092333100.24890-100000@elin.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0111092333100.24890-100000@elin.scali.no>; from terje.eggestad@scali.no on Sat, Nov 10, 2001 at 12:52:47AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10, 2001  00:52 +0100, Terje Eggestad wrote:
> I'm curious as to what sets the smallest legal blocksize for raw-io, I
> get different values for different partitions on the same disk drive.
> 
> In all my tests I've used
> raw /dev/raw/raw2 <block speclial file>
> and to test block size:
> dd if=/dev/raw/raw2 of=/dev/null bs=N count=1
> where N is either 512, 1024, or 4096.
> (I've a RH7.1 with a dd that do propper buffer alignment)
> Failure is always "invalid argument" which singify either misaligned
> buffer or illegal read length.
> 
> What confuses me is that when raw2 is bound to /dev/hda bs=512 is ok.
> However when binding raw2 to the different partitions on /dev/hda, some
> are ok with 512, some will only accept 1024, and one required 4096.

It may be getting confused with the filesystem blocksize.  Check tune2fs -l
for those devices.

> When creating an lvm vg on one partition (/dev/hda6), and I've created
> two logical volumes on it, one was ok with 1024 and the other required
> 4096. When binding a raw to /dev/hda6 dd with bs=512 was ok.

LVM is broken in this regard, unless you have a recent patch (Linus'
kernel does not).  I sent him a patch to fix that, but it did not get in.

What kernel version/LVM do you have?  Are you using LVM on all of these
partitions, or only some?  Did you have filesystems on them? 

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

