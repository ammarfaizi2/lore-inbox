Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130776AbQKNSZ7>; Tue, 14 Nov 2000 13:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130680AbQKNSZj>; Tue, 14 Nov 2000 13:25:39 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:7663 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129676AbQKNSZa>; Tue, 14 Nov 2000 13:25:30 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011141755.eAEHtQK28643@webber.adilger.net>
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
In-Reply-To: <3A117311.8DC02909@holly-springs.nc.us> "from Michael Rothwell at
 Nov 14, 2000 12:14:57 pm"
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Date: Tue, 14 Nov 2000 10:55:26 -0700 (MST)
CC: no To-header on input <@fsa.enel.ucalgary.ca@vger.kernel.org>,
        Josue.Amaro@oracle.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell writes:
> 4) A high reliability internal file system. 
> 
> Ext2 + bdflush + kupdated? Not likely.  To quote the Be Filesystems
> book, Ext2 throws safety to the wind to achieve speed. This also ties
> into Linux' convoluted VM system, and is shot in the foot by NFS. We
> would need minimally a journaled filesystem and a clean VM design,
> probably with a unified cache (no separate buffer, directory entry and
> page caches). The Tux2 Phase Trees look to be a good step in the
> direction as well, in terms of FS reliability.

Ext3 is doing pretty well...

> The filesystem would have
> to do checksums on every block. Some type of mirroring/clustering would
> be good. And the ability to grow filesystems online, and replace disks
> online, would be key. If your disks are getting old, you may want to
> pre-emptively replace them with faster, newer, larger ones with more
> MTBF left.

You can always do this in the hardware - no reason to do it in software.
If you are using RAID 5, and you wanted to take the performance hit you
could always calculate the checksums for each stripe on read to detect
errors.  You may even be able to add a second parity disk to do ECC on
the disk data.

As for online resizing, you can do this with ext2 for a long time with
my ext2online patches/tools.  LVM lets you migrate between disks online.
You need hardware support (available) to do hot-swap disks - SCSI works,
but I don't think the IDE code is ready for hot-swap yet.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
