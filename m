Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWHGRQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWHGRQL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 13:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWHGRQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 13:16:10 -0400
Received: from [198.99.130.12] ([198.99.130.12]:43969 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932235AbWHGRQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 13:16:09 -0400
Message-Id: <200608071715.k77HFkX1004664@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH] UML - Fix botched signal handling patch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Aug 2006 13:15:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I botched a previous patch which changed how UML handles signals.  I
left out a bit which sets the signal handler to be one provided by the
architecture.

This patch sets the handler correctly.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/signal.c	2006-08-07 10:05:32.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/signal.c	2006-08-07 10:15:38.000000000 -0400
@@ -118,7 +118,8 @@ void set_handler(int sig, void (*handler
 	sigset_t sig_mask;
 	int mask;
 
-	action.sa_handler = handler;
+	handlers[sig] = (void (*)(int, struct sigcontext *)) handler;
+	action.sa_handler = hard_handler;
 
 	sigemptyset(&action.sa_mask);
 

