Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWHNPLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWHNPLX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbWHNPLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:11:23 -0400
Received: from mo30.po.2iij.net ([210.128.50.53]:18717 "EHLO mo30.po.2iij.net")
	by vger.kernel.org with ESMTP id S1751486AbWHNPLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:11:22 -0400
Date: Tue, 15 Aug 2006 00:11:12 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yoichi_yuasa@tripeaks.co.jp, linux-kernel@vger.kernel.org
Subject: [-mm PATCH] ioremap: fixed MIPS build error
Message-Id: <20060815001112.2972b6eb.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
References: <20060813012454.f1d52189.akpm@osdl.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch has fixed following build error.
This error occurred in relation to generic-ioremap_page_range-mips-conversion.patch

  CC      arch/mips/mm/ioremap.o
  arch/mips/mm/ioremap.c: In function `__ioremap':
  arch/mips/mm/ioremap.c:58: error: `high_memory' undeclared (first use in this function)
  arch/mips/mm/ioremap.c:58: error: (Each undeclared identifier is reported only once
  arch/mips/mm/ioremap.c:58: error: for each function it appears in.)
  arch/mips/mm/ioremap.c:65: error: `mem_map' undeclared (first use in this function)
  arch/mips/mm/ioremap.c:65: error: increment of pointer to unknown structure
  arch/mips/mm/ioremap.c:65: error: arithmetic on pointer to an incomplete type
  arch/mips/mm/ioremap.c:66: warning: implicit declaration of function `PageReserved'
  make[1]: *** [arch/mips/mm/ioremap.o] Error 1
  make: *** [arch/mips/mm] Error 2

diff -pruN -X linux-2.6.18-rc4-mm1/Documentation/dontdiff linux-2.6.18-rc4-mm1-orig/arch/mips/mm/ioremap.c linux-2.6.18-rc4-mm1/arch/mips/mm/ioremap.c
--- linux-2.6.18-rc4-mm1-orig/arch/mips/mm/ioremap.c	2006-08-14 15:36:38.910018250 +0900
+++ linux-2.6.18-rc4-mm1/arch/mips/mm/ioremap.c	2006-08-14 23:30:48.321004750 +0900
@@ -6,6 +6,7 @@
  * (C) Copyright 1995 1996 Linus Torvalds
  * (C) Copyright 2001, 2002 Ralf Baechle
  */
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <asm/addrspace.h>
 #include <asm/byteorder.h>
