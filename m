Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWFDCQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWFDCQe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 22:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWFDCQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 22:16:14 -0400
Received: from [198.99.130.12] ([198.99.130.12]:41389 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751399AbWFDCQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 22:16:10 -0400
Message-Id: <200606040216.k542GJ8Y004852@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6/6] UML - add -ffreestanding to CFLAGS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Jun 2006 22:16:19 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the undefined reference to strcpy seen when building modules
on i386.  Tracked down by Al Viro.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/Makefile-i386
===================================================================
--- linux-2.6.16.orig/arch/um/Makefile-i386	2006-05-25 16:08:03.000000000 -0400
+++ linux-2.6.16/arch/um/Makefile-i386	2006-05-26 12:26:09.000000000 -0400
@@ -33,5 +33,9 @@ include $(srctree)/arch/i386/Makefile.cp
 # prevent gcc from keeping the stack 16 byte aligned. Taken from i386.
 cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
 
+# Prevent sprintf in nfsd from being converted to strcpy and resulting in
+# an unresolved reference.
+cflags-y += -ffreestanding
+
 CFLAGS += $(cflags-y)
 USER_CFLAGS += $(cflags-y)

