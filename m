Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756237AbWKRICh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237AbWKRICh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 03:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756228AbWKRICh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 03:02:37 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:52138 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1756237AbWKRICg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 03:02:36 -0500
Date: Sat, 18 Nov 2006 00:02:22 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, Nick Piggin <npiggin@suse.de>,
       Andre Noll <maan@systemlinux.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: do not call bad_page on PG_reserved check
In-Reply-To: <20061117204036.GK31879@stusta.de>
Message-ID: <Pine.LNX.4.64N.0611172359200.6177@attu4.cs.washington.edu>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
 <20061117204036.GK31879@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of free_pages_check() indicates if PG_reserved was set.
If so, the calling functions return immediately and no pages are freed so
there is no need to call bad_page().

Cc: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <npiggin@suse.de>
Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 mm/page_alloc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bf2f6cf..99bc29d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -439,7 +439,6 @@ static inline int free_pages_check(struc
 			1 << PG_slab	|
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_reserved |
 			1 << PG_buddy ))))
 		bad_page(page);
 	if (PageDirty(page))
