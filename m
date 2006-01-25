Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWAYJCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWAYJCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWAYJCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:02:30 -0500
Received: from mo01.po.2iij.net ([210.130.202.205]:46278 "EHLO
	mo01.po.2iij.net") by vger.kernel.org with ESMTP id S1751007AbWAYJC3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:02:29 -0500
Date: Wed, 25 Jan 2006 18:01:26 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yoichi_yuasa@tripeaks.co.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: follow the change of split_page()
Message-Id: <20060125180126.06ee2198.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060124232406.50abccd1.akpm@osdl.org>
References: <20060124232406.50abccd1.akpm@osdl.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch follows the change of split_page().

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -urN -X dontdiff mm3-orig/arch/mips/mm/init.c mm3/arch/mips/mm/init.c
--- mm3-orig/arch/mips/mm/init.c	2006-01-25 17:28:24.574182000 +0900
+++ mm3/arch/mips/mm/init.c	2006-01-25 17:37:48.369417500 +0900
@@ -53,7 +53,8 @@
  */
 unsigned long setup_zero_pages(void)
 {
-	unsigned long order, size;
+	unsigned int order;
+	unsigned long size;
 	struct page *page;
 
 	if (cpu_has_vce)
@@ -66,7 +67,7 @@
 		panic("Oh boy, that early out of memory?");
 
 	page = virt_to_page(empty_zero_page);
-	split_page(page);
+	split_page(page, order);
 	while (page < virt_to_page(empty_zero_page + (PAGE_SIZE << order))) {
 		SetPageReserved(page);
 		page++;
