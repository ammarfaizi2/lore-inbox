Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbUDVDvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUDVDvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 23:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUDVDvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 23:51:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:22711 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262190AbUDVDvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 23:51:16 -0400
Subject: [PATCH] Set ARCH_MIN_TASKALIGN on ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082605798.28232.101.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 22 Apr 2004 13:49:59 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply, or the task struct gets unaligned when using SLAB_DEBUG,
causing random problems with FP and Altivec.

Ben.


-----Forwarded Message-----
From: David Woodhouse <dwmw2@infradead.org>
To: benh@kernel.crashing.org
Subject: [PATCH] Set ARCH_MIN_TASKALIGN on ppc32
Date: Wed, 21 Apr 2004 22:14:23 -0400

...lest CONFIG_DEBUG_SLAB make it unaligned.

--- include/asm-ppc/processor.h~	2004-04-21 16:38:03.000000000 -0400
+++ include/asm-ppc/processor.h	2004-04-21 21:48:48.000000000 -0400
@@ -121,6 +121,8 @@
 #endif /* CONFIG_ALTIVEC */
 };
 
+#define ARCH_MIN_TASKALIGN 16
+
 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
 
 #define INIT_THREAD { \
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

