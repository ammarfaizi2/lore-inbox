Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262911AbUKYAfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbUKYAfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbUKXXZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:25:27 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:26116
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262946AbUKXXUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:20:37 -0500
Message-Id: <200411242306.iAON6Lbn005398@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Nov 2004 18:06:21 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser - Make UML's restorer match i386.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/sys-i386/signal.c
===================================================================
--- 2.6.9.orig/arch/um/sys-i386/signal.c	2004-11-16 21:25:23.000000000 -0500
+++ 2.6.9/arch/um/sys-i386/signal.c	2004-11-16 21:25:44.000000000 -0500
@@ -227,15 +227,15 @@
 				      sizeof(frame->extramask));
 
 	/*
-	 * This is movl $,%eax ; int $0x80
+	 * This is popl %eax ; movl $,%eax ; int $0x80
 	 *
 	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
 	 * reasons and because gdb uses it as a signature to notice
 	 * signal handler stack frames.
 	 */
-	err |= __put_user(0xb8, (char __user *)(frame->retcode+0));
-	err |= __put_user(__NR_rt_sigreturn, (int __user *)(frame->retcode+1));
-	err |= __put_user(0x80cd, (short __user *)(frame->retcode+5));
+	err |= __put_user(0xb858, (short __user *)(frame->retcode+0));
+	err |= __put_user(__NR_sigreturn, (int __user *)(frame->retcode+2));
+	err |= __put_user(0x80cd, (short __user *)(frame->retcode+6));
 
 	if(err)
 		return(err);

