Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVEZWho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVEZWho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVEZWhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:37:43 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:26641 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261840AbVEZWgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:36:05 -0400
Message-Id: <200505262230.j4QMUQ5m014682@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/7] UML - Turn off kmalloc always on a fatal signal
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 26 May 2005 18:30:26 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We should turn off kmalloc when getting a fatal signal regardless of the
mode we're in.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/main.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/main.c	2005-05-26 16:51:14.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/main.c	2005-05-26 17:05:40.000000000 -0400
@@ -71,7 +71,7 @@ static __init void do_uml_initcalls(void
 
 static void last_ditch_exit(int sig)
 {
-	CHOOSE_MODE(kmalloc_ok = 0, (void) 0);
+        kmalloc_ok = 0;
 	signal(SIGINT, SIG_DFL);
 	signal(SIGTERM, SIG_DFL);
 	signal(SIGHUP, SIG_DFL);

