Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVAMGnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVAMGnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 01:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVAMGnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 01:43:55 -0500
Received: from waste.org ([216.27.176.166]:57731 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261171AbVAMGnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 01:43:40 -0500
Date: Wed, 12 Jan 2005 22:43:31 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Y. Ts'o" <tytso@MIT.EDU>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] random run-time configurable debugging
Message-ID: <20050113064331.GY2940@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add run-time switchable entropy debugging. Entire debug infrastructure
remains compiled out by default.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 21:27:53.763311053 -0800
+++ rnd/drivers/char/random.c	2005-01-12 21:27:56.027022454 -0800
@@ -473,12 +473,15 @@
 #endif
 
 #if 0
-#define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random %04d %04d %04d: " \
+static int debug = 0;
+module_param(debug, bool, 0644);
+#define DEBUG_ENT(fmt, arg...) do { if (debug) \
+	printk(KERN_DEBUG "random %04d %04d %04d: " \
 	fmt,\
 	random_state->entropy_count,\
 	sec_random_state->entropy_count,\
 	urandom_state->entropy_count,\
-	## arg)
+	## arg); } while (0)
 #else
 #define DEBUG_ENT(fmt, arg...) do {} while (0)
 #endif


-- 
Mathematics is the supreme nostalgia of our time.
