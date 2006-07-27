Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWG0PhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWG0PhR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWG0PhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:37:17 -0400
Received: from mo31.po.2iij.net ([210.128.50.54]:42041 "EHLO mo31.po.2iij.net")
	by vger.kernel.org with ESMTP id S932568AbWG0PhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:37:16 -0400
Date: Fri, 28 Jul 2006 00:37:08 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] highmem: fixed ip27-memory.c build error
Message-Id: <20060728003708.29ff1a86.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
References: <20060727015639.9c89db57.akpm@osdl.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has fixed following build error.
This error occurred in relation to reduce-max_nr_zones-move-highmem-counters-into-highmemc-h.patch .

  CC      arch/mips/sgi-ip27/ip27-memory.o
arch/mips/sgi-ip27/ip27-memory.c: In function `mem_init':
arch/mips/sgi-ip27/ip27-memory.c:582: error: `totalhigh_pages' undeclared (first use in this function)
arch/mips/sgi-ip27/ip27-memory.c:582: error: (Each undeclared identifier is reported only once
arch/mips/sgi-ip27/ip27-memory.c:582: error: for each function it appears in.)
make[1]: *** [arch/mips/sgi-ip27/ip27-memory.o] Error 1
make: *** [arch/mips/sgi-ip27] Error 2

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X linux-2.6.18-rc2-mm1/Documentation/dontdiff linux-2.6.18-rc2-mm1-orig/arch/mips/sgi-ip27/ip27-memory.c linux-2.6.18-rc2-mm1/arch/mips/sgi-ip27/ip27-memory.c
--- linux-2.6.18-rc2-mm1-orig/arch/mips/sgi-ip27/ip27-memory.c	2006-07-27 20:15:23.680114000 +0900
+++ linux-2.6.18-rc2-mm1/arch/mips/sgi-ip27/ip27-memory.c	2006-07-27 19:40:11.234693250 +0900
@@ -19,6 +19,7 @@
 #include <linux/swap.h>
 #include <linux/bootmem.h>
 #include <linux/pfn.h>
+#include <linux/highmem.h>
 #include <asm/page.h>
 #include <asm/sections.h>
 

