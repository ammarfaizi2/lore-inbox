Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266736AbUGLG41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266736AbUGLG41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 02:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266740AbUGLG40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 02:56:26 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:48608 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S266736AbUGLG4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 02:56:25 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 12 Jul 2004 08:55:09 +0200
MIME-Version: 1.0
Subject: Murphy hits (Kernel 2.6, ext2, "check=strict"): corrupted filesystem
Message-ID: <40F251F1.1057.35E0C3@rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.21a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.80+2.19+2.07.060+05 April 2004+90300@20040712.064816Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I'd like to present a little story how to shredder your ext2 filesystem:

I was installing SuSE Linux 9.1 when the kernel froze rather late during 
installation. So I had to reset the PC. There is a minor bug in the forementioned 
distribution that prevents a filesystem check of the root filesystem after such a 
crash it seems. Anyway, the system booted without a fsck being run. I realized 
that and shut down (maybe it would have been better to hit the reset button 
immediately), but during the manual fsck, the system reported (among a lot of 
others) about 1700 inodes that share blocks. You can imagine what that means...

Why I'm writing this: If something can go wrong, eventually it will. For a true 
disaster you always need more than just one problem (1: Kernel freeze, 2: no fsck 
being run, 3: kernel happily mounts unclean filesystem for read-write).

In Kernel 2.2 there was a "check=strict" that caused some extra checks during 
mounting a filesystem. In 2.4 the option was ignored, and a warning was presented 
instead. In 2.6 it seems that "check=strict" prevents the filesystem from being 
mounted read-write (I ended up with an read-only root filesystem when having that 
option).

I'll have to spend a few more days to cleanup the mess in the root filesystem 
(which is everything except /home and /boot), but the lession to learn might be 
this: The kernel should not mount a unclean filesystem read-write. Maybe also if a 
filesystem code results in an attempt to access a partition outside its limits, 
the filesystem should trtigger a panic immediately instead of going on.

I think nobody really wants to read reports where Linux has shreddered a 
filesystem, do we?

Regards,
Ulrich


