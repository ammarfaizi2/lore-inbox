Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWEQWMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWEQWMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWEQWME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:12:04 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52099 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751233AbWEQWMD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:03 -0400
Message-Id: <20060517221412.608278000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:18 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Christoph Lameter <clameter@sgi.com>
Subject: [PATCH 18/22] [PATCH] Remove cond_resched in gather_stats()
Content-Disposition: inline; filename=remove-cond_resched-in-gather_stats.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

gather_stats() is called with a spinlock held from check_pte_range.  We
cannot reschedule with a lock held.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 mm/mempolicy.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-2.6.16.16.orig/mm/mempolicy.c
+++ linux-2.6.16.16/mm/mempolicy.c
@@ -1796,7 +1796,6 @@ static void gather_stats(struct page *pa
 		md->mapcount_max = count;
 
 	md->node[page_to_nid(page)]++;
-	cond_resched();
 }
 
 #ifdef CONFIG_HUGETLB_PAGE

--
