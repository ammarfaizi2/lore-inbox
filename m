Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbTBEUnt>; Wed, 5 Feb 2003 15:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbTBEUnt>; Wed, 5 Feb 2003 15:43:49 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:1276 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S264883AbTBEUns>; Wed, 5 Feb 2003 15:43:48 -0500
Date: Wed, 5 Feb 2003 12:52:51 -0800
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5-bk trivial LSM cleanup
Message-ID: <20030205125251.A30281@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	rddunlap@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Trivial patch from Randy Dunlap <rddunlap@osdl.org> removes some useless
error/retval assignments.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


--- ./fs/ioctl.c%CLEAN	Wed Jan  8 20:03:57 2003
+++ ./fs/ioctl.c	Wed Jan  8 20:38:51 2003
@@ -57,7 +57,6 @@
 	filp = fget(fd);
 	if (!filp)
 		goto out;
-	error = 0;

 	error = security_file_ioctl(filp, cmd, arg);
 	if (error) {
--- ./fs/namespace.c%SCLN	Wed Jan  8 20:04:17 2003
+++ ./fs/namespace.c	Thu Jan  9 10:48:25 2003
@@ -287,7 +287,7 @@
 static int do_umount(struct vfsmount *mnt, int flags)
 {
 	struct super_block * sb = mnt->mnt_sb;
-	int retval = 0;
+	int retval;

 	retval = security_sb_umount(mnt, flags);
 	if (retval)
--- ./kernel/sys.c%SCLN	Thu Jan  9 11:12:29 2003
+++ ./kernel/sys.c	Thu Jan  9 11:12:40 2003
@@ -1317,7 +1317,7 @@
 asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
 			  unsigned long arg4, unsigned long arg5)
 {
-	int error = 0;
+	int error;
 	int sig;

 	error = security_task_prctl(option, arg2, arg3, arg4, arg5);
