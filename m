Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVDHAyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVDHAyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVDHAwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:52:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:9426 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262638AbVDHAvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:51:18 -0400
Date: Thu, 7 Apr 2005 17:51:45 -0700
From: Nick Wilson <njw@osdl.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, rddunlap@osdl.org
Subject: [PATCH 5/6] lib/bitmap.c: use generic round_up_pow2() macro
Message-ID: <20050408005145.GF4260@njw.pdx.osdl.net>
References: <20050408004428.GA4260@njw.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408004428.GA4260@njw.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Wilson <njw@osdl.org>

Use the generic round_up_pow2() instead of a custom rounding method.

Signed-off-by: Nick Wilson <njw@osdl.org>
---


 bitmap.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: linux/lib/bitmap.c
===================================================================
--- linux.orig/lib/bitmap.c	2005-04-07 15:13:56.000000000 -0700
+++ linux/lib/bitmap.c	2005-04-07 15:46:15.000000000 -0700
@@ -289,7 +289,6 @@ EXPORT_SYMBOL(__bitmap_weight);
 
 #define CHUNKSZ				32
 #define nbits_to_hold_value(val)	fls(val)
-#define roundup_power2(val,modulus)	(((val) + (modulus) - 1) & ~((modulus) - 1))
 #define unhex(c)			(isdigit(c) ? (c - '0') : (toupper(c) - 'A' + 10))
 #define BASEDEC 10		/* fancier cpuset lists input in decimal */
 
@@ -316,7 +315,7 @@ int bitmap_scnprintf(char *buf, unsigned
 	if (chunksz == 0)
 		chunksz = CHUNKSZ;
 
-	i = roundup_power2(nmaskbits, CHUNKSZ) - CHUNKSZ;
+	i = round_up_pow2(nmaskbits, CHUNKSZ) - CHUNKSZ;
 	for (; i >= 0; i -= CHUNKSZ) {
 		chunkmask = ((1ULL << chunksz) - 1);
 		word = i / BITS_PER_LONG;
_
