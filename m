Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVCCPr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVCCPr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 10:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVCCPr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 10:47:58 -0500
Received: from webapps.arcom.com ([194.200.159.168]:36623 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261887AbVCCPrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 10:47:40 -0500
Message-ID: <42273149.7030802@cantab.net>
Date: Thu, 03 Mar 2005 15:46:17 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kai@germaschewski.name, sam@ravnborg.org
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kbuild Makefile: allow checking if ARCH and CROSS_COMPILE is set
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2005 15:51:51.0281 (UTC) FILETIME=[EA4F2610:01C52008]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It can be useful for distributors for kernel source trees intended
for cross-compilation only (e.g., for embedded targets) to ensure
the user has set ARCH and CROSS_COMPILE.

This patch allows one to create the file .force-cross-compile containing
the word "yes" to enable such a test.

Signed-off-by: David Vrabel <dvrabel@arcom.com>

Index: linux-2.6-working/Makefile
===================================================================
--- linux-2.6-working.orig/Makefile	2005-03-03 15:03:33.177767998 +0000
+++ linux-2.6-working/Makefile	2005-03-03 15:21:44.366657764 +0000
@@ -189,6 +189,19 @@
 # Default value for CROSS_COMPILE is not to prefix executables
 # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile

+# Creating the file .force-cross-compile containing the word "yes"
+# will ensure the user specifies ARCH and CROSS_COMPILE.  This is
+# handy for distributers of kernel trees intended for
+# cross-compilation only.
+ifeq ($(shell cat .force-cross-compile),yes)
+  ifeq ($(ARCH),)
+    $(error ARCH is unset)
+  endif
+  ifeq ($(CROSS_COMPILE),)
+    $(error CROSS_COMPILE is unset)
+  endif
+endif
+
 ARCH		?= $(SUBARCH)
 CROSS_COMPILE	?=

