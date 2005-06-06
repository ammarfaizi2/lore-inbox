Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVFFT4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVFFT4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVFFTx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:53:59 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:23786 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261651AbVFFTwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:52:51 -0400
Date: Mon, 6 Jun 2005 20:53:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Guenter Geiger <geiger@debian.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] rme96xx: fix PageReserved range
Message-ID: <Pine.LNX.4.61.0506062052260.5000@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 06 Jun 2005 19:52:45.0746 (UTC) 
    FILETIME=[4F15B920:01C56AD1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rme96xx busmaster_malloc miscalculates and fails to set PageReserved on
any page of char *buf; but busmaster_free does it right, so do the same
(I don't have the card, just noticed this while sifting for rmap BUGs).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 sound/oss/rme96xx.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.12-rc6/sound/oss/rme96xx.c	2005-03-02 07:38:55.000000000 +0000
+++ linux/sound/oss/rme96xx.c	2005-06-04 20:41:55.000000000 +0100
@@ -807,7 +807,7 @@ static void* busmaster_malloc(int size) 
                 struct page* page, *last_page;
 
                 page = virt_to_page(buf);
-                last_page = virt_to_page(buf + (1 << pg));
+                last_page = page + (1 << pg);
                 DBG(printk("setting reserved bit\n"));
                 while (page < last_page) {
 			SetPageReserved(page);
