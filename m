Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVASIUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVASIUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVASISu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:18:50 -0500
Received: from waste.org ([216.27.176.166]:26796 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261665AbVASIRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:17:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <10.64403262@selenic.com>
Message-Id: <11.64403262@selenic.com>
Subject: [PATCH 10/12] random pt3: Simplify hash folding
Date: Wed, 19 Jan 2005 00:17:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify output hash folding

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-18 10:42:17.993300522 -0800
+++ rnd/drivers/char/random.c	2005-01-18 10:42:39.078612373 -0800
@@ -1166,15 +1166,10 @@
 	 * In case the hash function has some recognizable
 	 * output pattern, we fold it in half.
 	 */
-	for (i = 0; i <  HASH_BUFFER_SIZE / 2; i++)
-		buf[i] ^= buf[i + (HASH_BUFFER_SIZE + 1) / 2];
 
-	if (HASH_BUFFER_SIZE & 1) {
-		/* There's a middle word to deal with */
-		x = buf[HASH_BUFFER_SIZE/2];
-		x ^= (x >> 16);	/* Fold it in half */
-		((__u16 *)buf)[HASH_BUFFER_SIZE - 1] = (__u16)x;
-	}
+	buf[0] ^= buf[3];
+	buf[1] ^= buf[4];
+	buf[0] ^= rol32(buf[3], 16);
 }
 
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
