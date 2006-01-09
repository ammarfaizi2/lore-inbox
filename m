Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWAIDTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWAIDTW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 22:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWAIDTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 22:19:00 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:44485 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751028AbWAIDSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 22:18:55 -0500
Message-Id: <200601090411.k094B5aH001196@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/6] UML - Eliminate doubled boot output
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Jan 2006 23:11:05 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CON_PRINTBUFFER was a bad idea for the mconsole console.  It causes
the boot output to be printed twice.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/mconsole_kern.c	2006-01-06 20:49:21.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/mconsole_kern.c	2006-01-06 20:49:48.000000000 -0500
@@ -500,7 +500,7 @@ static void console_write(struct console
 
 static struct console mc_console = { .name	= "mc",
 				     .write	= console_write,
-				     .flags	= CON_PRINTBUFFER | CON_ENABLED,
+				     .flags	= CON_ENABLED,
 				     .index	= -1 };
 
 static int mc_add_console(void)

