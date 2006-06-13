Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWFMDOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWFMDOr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 23:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWFMDOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 23:14:47 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:35241 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751150AbWFMDOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 23:14:46 -0400
Message-Id: <200606130314.k5D3Ei09008886@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH] UML - Fix wall_to_monotonic initialization
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Jun 2006 23:14:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.17 material.

Change a variable from unsigned to signed in order to get sign-extension
when the thing is negated.  Without this, uptime is horribly confused.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/time_kern.c	2006-06-12 22:57:34.000000000 -0400
+++ linux-2.6.16/arch/um/kernel/time_kern.c	2006-06-12 23:01:48.000000000 -0400
@@ -87,7 +87,7 @@ void timer_irq(union uml_pt_regs *regs)
 
 void time_init_kern(void)
 {
-	unsigned long long nsecs;
+	long long nsecs;
 
 	nsecs = os_nsecs();
 	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,

