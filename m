Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbUCAOc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 09:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUCAOc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 09:32:27 -0500
Received: from mail.timesys.com ([65.117.135.102]:33023 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261294AbUCAOcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 09:32:25 -0500
Message-ID: <4043496B.4080308@timesys.com>
Date: Mon, 01 Mar 2004 09:32:11 -0500
From: "Steven J. Hill" <Steve.Hill@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] Make linux/swap.h usable by userspace code.
Content-Type: multipart/mixed;
 boundary="------------030808050909060306080304"
X-OriginalArrivalTime: 01 Mar 2004 14:24:41.0750 (UTC) FILETIME=[EFA9CB60:01C3FF98]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030808050909060306080304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greetings.

This patch allows 'swap.h' to be included by userspace code. AFAIK the
LTP suite is the only code that does this so far.

-Steve

--------------030808050909060306080304
Content-Type: text/x-patch;
 name="linux-2.4-swap.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4-swap.h.patch"

--- linux/include/linux/swap.h	Fri Jan 23 08:30:29 2004
+++ linux-new/include/linux/swap.h	Mon Mar  1 09:10:44 2004
@@ -1,6 +1,12 @@
 #ifndef _LINUX_SWAP_H
 #define _LINUX_SWAP_H
 
+#include <linux/config.h>
+
+#define MAX_SWAPFILES 32
+
+#ifdef __KERNEL__
+
 #include <linux/spinlock.h>
 #include <asm/page.h>
 
@@ -8,8 +14,6 @@
 #define SWAP_FLAG_PRIO_MASK	0x7fff
 #define SWAP_FLAG_PRIO_SHIFT	0
 
-#define MAX_SWAPFILES 32
-
 /*
  * Magic header for a swap area. The first part of the union is
  * what the swap magic looks like for the old (limited to 128MB)
@@ -38,8 +42,6 @@
 		unsigned int badpages[1];
 	} info;
 };
-
-#ifdef __KERNEL__
 
 /*
  * Max bad pages in the new format..

--------------030808050909060306080304--
