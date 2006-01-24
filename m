Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWAXBTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWAXBTP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWAXBSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:18:17 -0500
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:30675 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030272AbWAXBRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:17:53 -0500
Date: Mon, 23 Jan 2006 20:16:09 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2/9] ia32 syscalls: rename some i386 syscalls
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601232017_MC3-1-B683-9F39@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <200601231938_MC3-1-B687-7C42@compuserve.com>
In-Reply-To: <200601231938_MC3-1-B687-7C42@compuserve.com>

Shared ia32 syscall table 2/9:

Rename some i386 syscalls so they match up better with x86_64
32-bit syscalls.

Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>

---

 arch/i386/kernel/sys_i386.c      |    4 ++--
 arch/i386/kernel/syscall_table.S |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- 2.6.16-rc1-mm2.orig/arch/i386/kernel/sys_i386.c
+++ 2.6.16-rc1-mm2/arch/i386/kernel/sys_i386.c
@@ -89,7 +89,7 @@ struct mmap_arg_struct {
 	unsigned long offset;
 };
 
-asmlinkage int old_mmap(struct mmap_arg_struct __user *arg)
+asmlinkage int sys_old_mmap(struct mmap_arg_struct __user *arg)
 {
 	struct mmap_arg_struct a;
 	int err = -EFAULT;
@@ -113,7 +113,7 @@ struct sel_arg_struct {
 	struct timeval __user *tvp;
 };
 
-asmlinkage int old_select(struct sel_arg_struct __user *arg)
+asmlinkage int sys_old_select(struct sel_arg_struct __user *arg)
 {
 	struct sel_arg_struct a;
 
--- 2.6.16-rc1-mm2.orig/arch/i386/kernel/syscall_table.S
+++ 2.6.16-rc1-mm2/arch/i386/kernel/syscall_table.S
@@ -81,7 +81,7 @@ ENTRY(sys_call_table)
 	.long sys_settimeofday
 	.long sys_getgroups16	/* 80 */
 	.long sys_setgroups16
-	.long old_select
+	.long sys_old_select
 	.long sys_symlink
 	.long sys_lstat
 	.long sys_readlink	/* 85 */
@@ -89,7 +89,7 @@ ENTRY(sys_call_table)
 	.long sys_swapon
 	.long sys_reboot
 	.long old_readdir
-	.long old_mmap		/* 90 */
+	.long sys_old_mmap	/* 90 */
 	.long sys_munmap
 	.long sys_truncate
 	.long sys_ftruncate
-- 
Chuck
