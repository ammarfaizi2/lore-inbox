Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTKNJue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 04:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTKNJue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 04:50:34 -0500
Received: from eva.fit.vutbr.cz ([147.229.10.14]:25348 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S262291AbTKNJub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 04:50:31 -0500
Date: Fri, 14 Nov 2003 10:50:28 +0100
From: David Jez <dave.jez@seznam.cz>
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] sys32_module_warning cleanup from 2.6.0-test9
Message-ID: <20031114095027.GA42967@stud.fit.vutbr.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi, i send you trivial patch for 2.6.0-test9 kernel which removes
obsolete warning. It is 2.6 kernel, that use module-init-tools so IMHO
this warning is not necessary.

  Regards,
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.0-test9-amd64.cleanup.diff"

diff -urN linux-2.6.0-test9.orig/arch/x86_64/ia32/ia32entry.S linux-2.6.0-test9/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.0-test9.orig/arch/x86_64/ia32/ia32entry.S	2003-10-25 18:43:32.000000000 +0000
+++ linux-2.6.0-test9/arch/x86_64/ia32/ia32entry.S	2003-11-12 22:44:16.000000000 +0000
@@ -330,10 +330,10 @@
 	.quad sys32_adjtimex
 	.quad sys32_mprotect		/* 125 */
 	.quad compat_sys_sigprocmask
-	.quad sys32_module_warning	/* create_module */
+	.quad ni_syscall		/* create_module */
 	.quad sys_init_module
 	.quad sys_delete_module
-	.quad sys32_module_warning	/* 130  get_kernel_syms */
+	.quad ni_syscall		/* 130  get_kernel_syms */
 	.quad ni_syscall	/* quotactl */ 
 	.quad sys_getpgid
 	.quad sys_fchdir
diff -urN linux-2.6.0-test9.orig/arch/x86_64/ia32/sys_ia32.c linux-2.6.0-test9/arch/x86_64/ia32/sys_ia32.c
--- linux-2.6.0-test9.orig/arch/x86_64/ia32/sys_ia32.c	2003-10-25 18:43:30.000000000 +0000
+++ linux-2.6.0-test9/arch/x86_64/ia32/sys_ia32.c	2003-11-12 22:44:31.000000000 +0000
@@ -1817,13 +1817,6 @@
 }
 #endif
 
-long sys32_module_warning(void)
-{ 
-		printk(KERN_INFO "%s: 32bit 2.4.x modutils not supported on 64bit kernel\n",
-		       current->comm);
-	return -ENOSYS ;
-} 
-
 extern long sys_io_setup(unsigned nr_reqs, aio_context_t *ctx);
 
 long sys32_io_setup(unsigned nr_reqs, u32 *ctx32p)

--FCuugMFkClbJLl1L--
