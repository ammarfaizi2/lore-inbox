Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbVIQEZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbVIQEZg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 00:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVIQEZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 00:25:36 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:62660 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1750878AbVIQEZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 00:25:35 -0400
Date: Sat, 17 Sep 2005 13:25:21 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: Fixed build error
Message-Id: <20050917132521.1d157d50.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050916022319.12bf53f3.akpm@osdl.org>
References: <20050916022319.12bf53f3.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has fixed the following build error on MIPS.

  CC      mm/mremap.o
mm/mremap.c: In function `move_one_page':
mm/mremap.c:146: error: syntax error before ')' token
make[1]: *** [mm/mremap.o] Error 1
make: *** [mm] Error 2

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm1-orig/include/asm-generic/pgtable.h mm1/include/asm-generic/pgtable.h
--- mm1-orig/include/asm-generic/pgtable.h	2005-09-17 11:31:04.000000000 +0900
+++ mm1/include/asm-generic/pgtable.h	2005-09-17 11:22:43.000000000 +0900
@@ -165,7 +165,7 @@
 ({									\
  	pte_t newpte = (pte);						\
 	if (pfn_valid(pte_pfn(pte)) && pte_page(pte) == ZERO_PAGE(old_addr)) \
-		newpte = mk_pte(ZERO_PAGE(new_addr), (prot)));		\
+		newpte = mk_pte(ZERO_PAGE(new_addr), (prot));		\
 	newpte;								\
 })
 #endif

