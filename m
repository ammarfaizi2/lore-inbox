Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUC2GcY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 01:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbUC2GcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 01:32:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:34450 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262709AbUC2GcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 01:32:23 -0500
Subject: [PATCH] ppc32: Fix sector_t definition with CONFIG_LBD
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080541934.1210.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 16:32:15 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

sector_t depends on CONFIG_LBD but include/config.h may not be there
thus causing interesting breakage in some places...

Here's the fix for ppc32 (problem found by Roman Zippel, other archs
need a similar fix).

diff -urN linux-2.5/include/asm-ppc/types.h linuxppc-2.5-benh/include/asm-ppc/types.h
--- linux-2.5/include/asm-ppc/types.h	2004-03-01 18:13:06.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-ppc/types.h	2004-03-29 13:14:50.000000000 +1000
@@ -37,6 +37,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/config.h>
+
 typedef signed char s8;
 typedef unsigned char u8;
 


