Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVDLSOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVDLSOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVDLKbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:31:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:57031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262109AbVDLKa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:30:59 -0400
Message-Id: <200504121030.j3CAUta6005179@shell0.pdx.osdl.net>
Subject: [patch 017/198] vmscan: pageout(): remove unneeded test
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We only call pageout() for dirty pages, so this test is redundant.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/mm/vmscan.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN mm/vmscan.c~vmscan-pageout-remove-unneeded-test mm/vmscan.c
--- 25/mm/vmscan.c~vmscan-pageout-remove-unneeded-test	2005-04-12 03:21:07.489998248 -0700
+++ 25-akpm/mm/vmscan.c	2005-04-12 03:21:07.493997640 -0700
@@ -318,7 +318,7 @@ static pageout_t pageout(struct page *pa
 		 * Some data journaling orphaned pages can have
 		 * page->mapping == NULL while being dirty with clean buffers.
 		 */
-		if (PageDirty(page) && PagePrivate(page)) {
+		if (PagePrivate(page)) {
 			if (try_to_free_buffers(page)) {
 				ClearPageDirty(page);
 				printk("%s: orphaned page\n", __FUNCTION__);
_
