Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030675AbWJKQZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030675AbWJKQZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030671AbWJKQZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:25:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55228 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030680AbWJKQY4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:24:56 -0400
To: torvalds@osdl.org
Subject: [PATCH] m32r: more __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXgt5-0005Yj-7A@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:24:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m32r/kernel/sys_m32r.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m32r/kernel/sys_m32r.c b/arch/m32r/kernel/sys_m32r.c
index b567351..b4e7bcb 100644
--- a/arch/m32r/kernel/sys_m32r.c
+++ b/arch/m32r/kernel/sys_m32r.c
@@ -31,7 +31,7 @@ #include <asm/unistd.h>
 /*
  * sys_tas() - test-and-set
  */
-asmlinkage int sys_tas(int *addr)
+asmlinkage int sys_tas(int __user *addr)
 {
 	int oldval;
 
@@ -90,7 +90,7 @@ sys_pipe(unsigned long r0, unsigned long
 
 	error = do_pipe(fd);
 	if (!error) {
-		if (copy_to_user((void *)r0, (void *)fd, 2*sizeof(int)))
+		if (copy_to_user((void __user *)r0, fd, 2*sizeof(int)))
 			error = -EFAULT;
 	}
 	return error;
@@ -201,7 +201,7 @@ asmlinkage int sys_ipc(uint call, int fi
 	}
 }
 
-asmlinkage int sys_uname(struct old_utsname * name)
+asmlinkage int sys_uname(struct old_utsname __user * name)
 {
 	int err;
 	if (!name)
-- 
1.4.2.GIT

