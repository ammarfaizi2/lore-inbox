Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129283AbRBZRuK>; Mon, 26 Feb 2001 12:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129423AbRBZRtu>; Mon, 26 Feb 2001 12:49:50 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:22513 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129283AbRBZRts>; Mon, 26 Feb 2001 12:49:48 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102261748.f1QHmwd10698@webber.adilger.net>
Subject: Re: 2.2.18/ext2: special file corruption?
In-Reply-To: <3A9A2E3D.9135.8E1BCE@localhost> from Ulrich Windl at "Feb 26, 2001
 10:21:51 am"
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Date: Mon, 26 Feb 2001 10:48:58 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Windl writes:
> I had an interesting effect: Due to NVdriver I had a lot of system 
> freezes, and I had to reboot. Using e2fsck 1.19a (SuSE 7.1) I got the 
> message that one specific "Special (device/socket/fifo) inode .. has 
> non-zero size. FIXED."
> 
> Interestingly I got the message for every reboot. So either the kernel 
> corrupts the very same inode every time, or e2fsck does not really fix 
> it, or the error simply doesn't exist. I think the kernel doesn't 
> temporarily set the size to non-zero, so this seems strange.

It is strange that it thinks ".." is a special inode.  Maybe e2fsck is
fixing the wrong problem (i.e. truncating the directory ".."), and it
later fixes the zero-length directory...  Could you try two things:

1) unmount the filesystem and run e2fsck on the broken filesystem 1 or 2
   times, to see if e2fsck is fixing the problem or not.

2) If it is fixing the problem you need to wait until the next time you have
   a system crash, start in single user mode.  If it is NOT fixing the problem
   you can do this right away.  Run "e2fsck -n" to see which inode number is
   corrupt (the -n option means e2fsck will not fix the filesystem), and then
   run "debugfs /dev/X", type "dump <inode_number>" and "ncheck inode_number"
   at the prompt (note you NEED the <> around the inode number for dump).
   Send the output.

Cheers, Andreas  
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
