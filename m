Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUIXAdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUIXAdD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267598AbUIXAdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:33:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:56032 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267566AbUIXAaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:30:46 -0400
Subject: [PATCH] ppc32: Fix use of uninitialized pointer in offb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095985833.12950.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 10:30:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The recent ppc64 changes for offb introduced an uninitialized pointer
use for ppc32, here's the fix:

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== drivers/video/offb.c 1.32 vs edited =====
--- 1.32/drivers/video/offb.c	2004-09-23 17:36:23 +10:00
+++ edited/drivers/video/offb.c	2004-09-24 10:29:23 +10:00
@@ -246,7 +246,7 @@
 
 int __init offb_init(void)
 {
-	struct device_node *dp, *boot_disp = NULL;
+	struct device_node *dp = NULL, *boot_disp = NULL;
 #if defined(CONFIG_BOOTX_TEXT) && defined(CONFIG_PPC32)
 	struct device_node *macos_display = NULL;
 #endif


