Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUBFVgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUBFVgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:36:19 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:17673 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265792AbUBFVgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:36:14 -0500
Date: Fri, 6 Feb 2004 21:36:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Good Oleg <olecom.gnu-linux@mail.ru>
cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       marcel cotta <mc123@mail.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]: kernel BUG at mm/swapfile.c:806! (2.6)
In-Reply-To: <E1ApAqS-0000nh-00.olecom-gnu-linux-mail-ru@f22.mail.ru>
Message-ID: <Pine.LNX.4.44.0402062124120.2552-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix your swapfile.c:806.
Looks like mail.ru XFS users get more jumbled block allocations.
I've other fixes and tidyups hereabouts, but they can wait.

Hugh

--- 2.6.2/mm/swapfile.c	2004-02-04 02:45:17.000000000 +0000
+++ linux/mm/swapfile.c	2004-02-06 21:21:08.011274104 +0000
@@ -841,7 +841,8 @@
 	lh = sis->extent_list.next;	/* The highest-addressed block */
 	while (lh != &sis->extent_list) {
 		se = list_entry(lh, struct swap_extent, list);
-		if (se->start_block + se->nr_pages == start_block) {
+		if (se->start_block + se->nr_pages == start_block &&
+		    se->start_page  + se->nr_pages == start_page) {
 			/* Merge it */
 			se->nr_pages += nr_pages;
 			return 0;

