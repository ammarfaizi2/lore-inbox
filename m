Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131212AbQLVAqb>; Thu, 21 Dec 2000 19:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131388AbQLVAqV>; Thu, 21 Dec 2000 19:46:21 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:3323 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S131212AbQLVAqF>; Thu, 21 Dec 2000 19:46:05 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012220015.eBM0FPJ20543@webber.adilger.net>
Subject: Re: strange nfs behavior in 2.2.18 and 2.4.0-test12
In-Reply-To: <Pine.LNX.4.21.0012211828510.840-100000@ccs.covici.com>
 "from John Covici at Dec 21, 2000 06:35:30 pm"
To: John Covici <covici@ccs.covici.com>
Date: Thu, 21 Dec 2000 17:15:25 -0700 (MST)
CC: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Covici writes:
> Here is my /etc/exports
> 
> / ccs2(rw,no_root_squash)
> /usr ccs2(rw,no_root_squash)
> /usr/src ccs2(rw,no_root_squash)
> /home ccs2(rw,no_root_squash)
> /hard1 ccs2(rw,no_root_squash)
> /hard2 ccs2(rw,no_root_squash)
> /hard3 ccs2(rw,no_root_squash)
> /hard4 ccs2(rw,no_root_squash)
> /usr/bbs ccs2(rw,no_root_squash)

According to your fstab, these are all separate devices, so they should
export OK.  You trust this "ccs2" machine a lot, however...  Exporting
root with no_root_squash is a big security hole.

> # /etc/fstab: static file system information.
> #
> # <file system>	<mount point>	<type>	<options>			<dump>	<pass>
> /dev/hda2	/		ext2	defaults,errors=remount-ro 1	1
> /dev/hdc2	none		swap	sw			0	0
> /dev/hdc4	none		swap	sw			0	0

Having two swaps configured like this on the same disk is a net performance
loss.  If anything, you should set one of them to have a lower priority
(via pri=), so that it will only be used if the first one is full.

> /dev/hdb7	none		swap	sw			0	0
> proc		/proc		proc	defaults		0	0
> /dev/fd0	/floppy		auto	defaults,user,noauto	0	0
> /dev/cdrom	/cdrom		iso9660	defaults,ro,user,noauto	0	0
> /dev/hdc3	/usr		ext2	rw			1	2
> /dev/hdb6	/usr/bbs	ext2	rw			1	2
> /dev/hda3	/usr/src	ext2	rw			1	2
> /dev/hda4	/home		ext2	rw			1	3
> 
> and here are mounts executed out of /etc/rc.local
> 
> mount -t vfat /dev/hdb1 /hard2
> mount -t vfat /dev/hdb5 /hard4
> mount -t vfat /dev/hdc1 /hard3
> mount -t vfat /dev/hda1 /hard1

Out of curiosity, why not just put them into /etc/fstab?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
