Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbULWXbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbULWXbl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 18:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbULWXbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 18:31:41 -0500
Received: from mail.dif.dk ([193.138.115.101]:2753 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261266AbULWXbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 18:31:39 -0500
Date: Fri, 24 Dec 2004 00:42:28 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix mm/rmap.c build failure if CONFIG_SWAP is not defined
 (2.6.10-rc3-bk16) 
Message-ID: <Pine.LNX.4.61.0412240037211.3504@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just tried a allnoconfig build of 2.6.10-rc3-bk16, and it fails on 
mm/rmap.c since swap_token_default_timeout is not defined by 
include/linux/swap.h if CONFIG_SWAP is not defined.  The patch below just 
makes the small bit that uses swap_token_default_timeout be conditionally 
build depending on CONFIG_SWAP being defined or not, but I have no idea if 
this is the proper way to fix this (it does allow it to build though).


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc3-bk16-orig/mm/rmap.c linux-2.6.10-rc3-bk16/mm/rmap.c
--- linux-2.6.10-rc3-bk16-orig/mm/rmap.c	2004-12-23 23:26:50.000000000 +0100
+++ linux-2.6.10-rc3-bk16/mm/rmap.c	2004-12-24 00:36:01.000000000 +0100
@@ -395,9 +395,10 @@ int page_referenced(struct page *page, i
 {
 	int referenced = 0;
 
+#ifdef CONFIG_SWAP
 	if (!swap_token_default_timeout)
 		ignore_token = 1;
-
+#endif
 	if (page_test_and_clear_young(page))
 		referenced++;
 


