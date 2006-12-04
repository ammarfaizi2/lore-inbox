Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967753AbWLDXQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967753AbWLDXQc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967750AbWLDXQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:16:28 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:47869 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759827AbWLDXQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:16:22 -0500
Message-Id: <200612042312.kB4NCMck024566@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/4] UML - Size register files correctly
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Dec 2006 18:12:22 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were using the wrong symbol to size register files.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/include/sysdep-i386/ptrace.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/sysdep-i386/ptrace.h	2006-11-27 18:55:15.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/sysdep-i386/ptrace.h	2006-11-29 04:39:05.000000000 -0500
@@ -75,7 +75,7 @@ union uml_pt_regs {
 #endif
 #ifdef UML_CONFIG_MODE_SKAS
 	struct skas_regs {
-		unsigned long regs[HOST_FRAME_SIZE];
+		unsigned long regs[MAX_REG_NR];
 		unsigned long fp[HOST_FP_SIZE];
 		unsigned long xfp[HOST_XFP_SIZE];
                 struct faultinfo faultinfo;
Index: linux-2.6.18-mm/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/sysdep-x86_64/ptrace.h	2006-11-27 18:55:15.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/sysdep-x86_64/ptrace.h	2006-11-29 04:38:13.000000000 -0500
@@ -108,7 +108,7 @@ union uml_pt_regs {
 		 * file size, while i386 uses FRAME_SIZE.  Therefore, we need
 		 * to use UM_FRAME_SIZE here instead of HOST_FRAME_SIZE.
 		 */
-		unsigned long regs[UM_FRAME_SIZE];
+		unsigned long regs[MAX_REG_NR];
 		unsigned long fp[HOST_FP_SIZE];
                 struct faultinfo faultinfo;
 		long syscall;

