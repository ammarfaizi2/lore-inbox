Return-Path: <linux-kernel-owner+w=401wt.eu-S932578AbXASRCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbXASRCn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbXASRCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:02:43 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:51981 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932578AbXASRCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:02:42 -0500
X-Originating-Ip: 74.109.98.130
Date: Fri, 19 Jan 2007 11:56:30 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: rth@twiddle.net
Subject: [PATCH] Stop making "inline" imply forced inlining.
Message-ID: <Pine.LNX.4.64.0701191156000.24621@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove the macros that define simple "inlining" to mean forced
inlining, since you can (and *should*) get that effect with the
CONFIG_FORCED_INLINING kernel config variable instead.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  this change was compile tested on x86 with "make allyesconfig",
followed by turning off forced inlining.

  now the alpha folks can simplify their compiler.h file. :-)


diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 6e1c44a..5a90bd9 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -23,9 +23,6 @@
     (typeof(ptr)) (__ptr + (off)); })


-#define inline		inline		__attribute__((always_inline))
-#define __inline__	__inline__	__attribute__((always_inline))
-#define __inline	__inline	__attribute__((always_inline))
 #define __deprecated			__attribute__((deprecated))
 #define  noinline			__attribute__((noinline))
 #define __attribute_pure__		__attribute__((pure))
