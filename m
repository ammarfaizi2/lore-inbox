Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVAUWGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVAUWGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVAUWFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:05:15 -0500
Received: from waste.org ([216.27.176.166]:24537 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262517AbVAUVlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:41:16 -0500
Date: Fri, 21 Jan 2005 15:41:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1.314297600@selenic.com>
Message-Id: <2.314297600@selenic.com>
Subject: [PATCH 1/12] random pt4: Create new rol32/ror32 bitops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add rol32 and ror32 bitops to bitops.h

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd2/drivers/char/random.c
===================================================================
--- rnd2.orig/drivers/char/random.c	2005-01-19 22:59:59.000000000 -0800
+++ rnd2/drivers/char/random.c	2005-01-20 09:18:47.000000000 -0800
@@ -374,11 +374,6 @@
 static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 
-static inline __u32 rol32(__u32 word, int shift)
-{
-	return (word << shift) | (word >> (32 - shift));
-}
-
 #if 0
 static int debug = 0;
 module_param(debug, bool, 0644);
Index: rnd2/include/linux/bitops.h
===================================================================
--- rnd2.orig/include/linux/bitops.h	2005-01-19 22:57:54.000000000 -0800
+++ rnd2/include/linux/bitops.h	2005-01-20 09:20:24.641660815 -0800
@@ -134,4 +134,26 @@
 	return sizeof(w) == 4 ? generic_hweight32(w) : generic_hweight64(w);
 }
 
+/*
+ * rol32 - rotate a 32-bit value left
+ *
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+static inline __u32 rol32(__u32 word, int shift)
+{
+	return (word << shift) | (word >> (32 - shift));
+}
+
+/*
+ * ror32 - rotate a 32-bit value right
+ *
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+static inline __u32 ror32(__u32 word, int shift)
+{
+	return (word >> shift) | (word << (32 - shift));
+}
+
 #endif
