Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWIZRyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWIZRyg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWIZRyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:54:36 -0400
Received: from [198.99.130.12] ([198.99.130.12]:5539 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932216AbWIZRyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:54:35 -0400
Message-Id: <200609261753.k8QHrOOC005545@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] UML - Fix sleep length bug
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Sep 2006 13:53:24 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

um_timer shouldn't add local_offset to the host time since get_time already
did it.  This threw off sleep when a settimeofday or equivalent had happened.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/kernel/time.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/time.c	2006-09-12 10:43:38.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/time.c	2006-09-22 10:15:45.000000000 -0400
@@ -95,7 +95,7 @@ irqreturn_t um_timer(int irq, void *dev,
 
 	do_timer(1);
 
-	nsecs = get_time() + local_offset;
+	nsecs = get_time();
 	xtime.tv_sec = nsecs / NSEC_PER_SEC;
 	xtime.tv_nsec = nsecs - xtime.tv_sec * NSEC_PER_SEC;
 

