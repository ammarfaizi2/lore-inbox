Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUCAOcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 09:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUCAOcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 09:32:53 -0500
Received: from mail.timesys.com ([65.117.135.102]:46079 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261296AbUCAOcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 09:32:47 -0500
Message-ID: <4043498F.7050101@timesys.com>
Date: Mon, 01 Mar 2004 09:32:47 -0500
From: "Steven J. Hill" <Steve.Hill@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Make linux/swap.h usable by userspace code.
Content-Type: multipart/mixed;
 boundary="------------010507090807030105010105"
X-OriginalArrivalTime: 01 Mar 2004 14:25:17.0562 (UTC) FILETIME=[050245A0:01C3FF99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010507090807030105010105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greetings.

This patch allows 'swap.h' to be included by userspace code. AFAIK the
LTP suite is the only code that does this so far.

-Steve

--------------010507090807030105010105
Content-Type: text/x-patch;
 name="linux-2.6-swap.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6-swap.h.patch"

--- linux/include/linux/swap.h	Thu Feb  5 17:46:32 2004
+++ linux-new/include/linux/swap.h	Mon Mar  1 09:00:35 2004
@@ -2,6 +2,20 @@
 #define _LINUX_SWAP_H
 
 #include <linux/config.h>
+
+/*
+ * MAX_SWAPFILES defines the maximum number of swaptypes: things which can
+ * be swapped to.  The swap type and the offset into that swap type are
+ * encoded into pte's and into pgoff_t's in the swapcache.  Using five bits
+ * for the type means that the maximum number of swapcache pages is 27 bits
+ * on 32-bit-pgoff_t architectures.  And that assumes that the architecture packs
+ * the type/offset into the pte as 5/27 as well.
+ */
+#define MAX_SWAPFILES_SHIFT	5
+#define MAX_SWAPFILES		(1 << MAX_SWAPFILES_SHIFT)
+
+#ifdef __KERNEL__
+
 #include <linux/spinlock.h>
 #include <linux/linkage.h>
 #include <linux/mmzone.h>
@@ -20,17 +34,6 @@
 }
 
 /*
- * MAX_SWAPFILES defines the maximum number of swaptypes: things which can
- * be swapped to.  The swap type and the offset into that swap type are
- * encoded into pte's and into pgoff_t's in the swapcache.  Using five bits
- * for the type means that the maximum number of swapcache pages is 27 bits
- * on 32-bit-pgoff_t architectures.  And that assumes that the architecture packs
- * the type/offset into the pte as 5/27 as well.
- */
-#define MAX_SWAPFILES_SHIFT	5
-#define MAX_SWAPFILES		(1 << MAX_SWAPFILES_SHIFT)
-
-/*
  * Magic header for a swap area. The first part of the union is
  * what the swap magic looks like for the old (limited to 128MB)
  * swap area format, the second part of the union adds - in the
@@ -72,8 +75,6 @@
 struct reclaim_state {
 	unsigned long reclaimed_slab;
 };
-
-#ifdef __KERNEL__
 
 struct address_space;
 struct pte_chain;

--------------010507090807030105010105--
