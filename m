Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279505AbRKRN0w>; Sun, 18 Nov 2001 08:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279509AbRKRN0l>; Sun, 18 Nov 2001 08:26:41 -0500
Received: from 59dyn119.com21.casema.net ([213.17.63.119]:36235 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S279505AbRKRN0a>; Sun, 18 Nov 2001 08:26:30 -0500
Message-Id: <200111181326.OAA28770@cave.bitwizard.nl>
Subject: DD-ing from device to device. 
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Date: Sun, 18 Nov 2001 14:26:19 +0100 (MET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I should NOT get a "file too large" error when copying from a device
to a device, right?

I should NOT get a "file too large" if the files are openeed using
the "O_LARGEFILE" option, right?

Well: 

execve("/bin/dd", ["dd", "if=/dev/hda", "of=/dev/hdc", "bs=1024k", "count=10"], [/* 46 vars */]) = 0
[... libs and stuff ... ]
open("/dev/hda", O_RDONLY|O_LARGEFILE)  = 4
open("/dev/hdc", O_RDWR|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 5
[....signals and stuff. ]
read(4, ""..., 1048576) = 1048576
write(5, ""..., 1048576) = 1048576
read(4, ""..., 1048576) = 1048576
write(5, ""..., 1048576) = 1048576
read(4, ""..., 1048576) = 1048576
write(5, ""..., 1048576) = 1048576
read(4, ""..., 1048576) = 1048576
write(5, ""..., 1048576) = 1048576
read(4, ""..., 1048576) = 1048576
write(5, ""..., 1048576) = 1048576
read(4, ""..., 1048576) = 1048576
write(5, ""..., 1048576) = 1048576
read(4, ""..., 1048576) = 1048576
write(5, ""..., 1048576) = 1048576
read(4, ""..., 1048576) = 1048576
write(5, ""..., 1048576) = 1048576
read(4, ""..., 1048576) = 1048576
write(5, ""..., 1048576) = 1048576
read(4, ""..., 1048576) = 1048576
write(5, ""..., 1048576) = 1048576
munmap(0x400fb000, 1052672)             = 0
write(2, "10+0 records in\n", 16)       = 16
write(2, "10+0 records out\n", 17)      = 17
close(4)                                = 0
close(5)                                = 0
_exit(0)                                = ?


But without the "count=10" I get: 

read(4, ""..., 1048576) = 1048576
write(5, ""..., 1048576) = 1048576
read(4, ""..., 1048576) = 1048576
write(5, ""..., 1048576) = 1048575
write(5, ".", 1)                     = -1 EFBIG (File too large)



This is on 2.2.14. I Could swear we made a working copy of a disk 30
minutes earlier....

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
