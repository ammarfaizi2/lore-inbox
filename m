Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVBQVAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVBQVAY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 16:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVBQVAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 16:00:05 -0500
Received: from tux.jeffco.net ([205.159.194.1]:16098 "EHLO slashmail.org")
	by vger.kernel.org with ESMTP id S262353AbVBQU7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:59:20 -0500
From: Michael Kreitzer <mrgrim@gr1m.org>
Reply-To: mrgrim@gr1m.org
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/starfire.c
Date: Thu, 17 Feb 2005 14:59:15 -0600
User-Agent: KMail/1.7.92
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 613
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502171459.16102.mrgrim@gr1m.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See http://bugme.osdl.org/show_bug.cgi?id=4208 for all relevant information.

--

--- drivers/net/starfire.c.old	2005-02-17 04:12:20.987861182 -0600
+++ drivers/net/starfire.c	2005-02-17 04:11:55.038499137 -0600
@@ -271,7 +271,7 @@
  * This SUCKS.
  * We need a much better method to determine if dma_addr_t is 64-bit.
  */
-#if (defined(__i386__) && defined(CONFIG_HIGHMEM) && (LINUX_VERSION_CODE > 0x20500 || defined(CONFIG_HIGHMEM64G))) || defined(__x86_64__) || defined (__ia64__) || defined(__mips64__) || (defined(__mips__) && defined(CONFIG_HIGHMEM) && defined(CONFIG_64BIT_PHYS_ADDR))
+#if (defined(__i386__) && defined(CONFIG_HIGHMEM64G)) || defined(__x86_64__) || defined (__ia64__) || defined(__mips64__) || (defined(__mips__) && defined(CONFIG_HIGHMEM) && defined(CONFIG_64BIT_PHYS_ADDR))
 /* 64-bit dma_addr_t */
 #define ADDR_64BITS	/* This chip uses 64 bit addresses. */
 #define cpu_to_dma(x) cpu_to_le64(x)
@@ -1401,7 +1401,7 @@
 		}
 
 		if (has_bad_length)
-			skb_checksum_help(skb);
+			skb_checksum_help(skb, 0);
 	}
 #endif /* ZEROCOPY && HAS_BROKEN_FIRMWARE */
 
