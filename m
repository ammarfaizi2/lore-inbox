Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265902AbUFVVCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbUFVVCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 17:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUFVVCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:02:50 -0400
Received: from fmr03.intel.com ([143.183.121.5]:13472 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S265900AbUFVVBs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:01:48 -0400
Message-Id: <200406222100.i5ML0TY32225@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: Bug fix in mm/hugetlb.c - use safe iterater
Date: Tue, 22 Jun 2004 14:01:45 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRYnCAzAMaAtxsgT1iqPqQq1PnuSg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With list poisoning on by default from linux-2.6.7, it's easier
than ever to trigger the bug in try_to_free_low().  It ought to
use the safe version of list iterater.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


diff -Nurp linux-2.6.7.orig/mm/hugetlb.c linux-2.6.7/mm/hugetlb.c
--- linux-2.6.7.orig/mm/hugetlb.c	2004-06-15 22:19:37.000000000 -0700
+++ linux-2.6.7/mm/hugetlb.c	2004-06-22 13:45:11.000000000 -0700
@@ -134,8 +134,8 @@ static int try_to_free_low(unsigned long
 {
 	int i;
 	for (i = 0; i < MAX_NUMNODES; ++i) {
-		struct page *page;
-		list_for_each_entry(page, &hugepage_freelists[i], lru) {
+		struct page *page, *next;
+		list_for_each_entry_safe(page, next, &hugepage_freelists[i], lru) {
 			if (PageHighMem(page))
 				continue;
 			list_del(&page->lru);


