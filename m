Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVIJL6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVIJL6y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 07:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVIJL6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 07:58:53 -0400
Received: from mail.suse.de ([195.135.220.2]:36015 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750762AbVIJL6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 07:58:50 -0400
Date: Sat, 10 Sep 2005 13:58:49 +0200
From: "Andi Kleen" <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [3/3] {PREFIX:-x86_64}: Remove near all BUGs in mm/mempolicy.c
Message-ID: <4322CA79.mailAO7119H91@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove near all BUGs in mm/mempolicy.c

Most of them can never be triggered and were only for development.

Index: linux-2.6.13-work/mm/mempolicy.c
===================================================================
--- linux-2.6.13-work.orig/mm/mempolicy.c
+++ linux-2.6.13-work/mm/mempolicy.c
@@ -185,7 +185,6 @@ static struct zonelist *bind_zonelist(no
 				policy_zone = k;
 		}
 	}
-	BUG_ON(num >= max);
 	zl->zones[num] = NULL;
 	return zl;
 }
@@ -708,7 +707,6 @@ static unsigned interleave_nodes(struct 
 	struct task_struct *me = current;
 
 	nid = me->il_next;
-	BUG_ON(nid >= MAX_NUMNODES);
 	next = next_node(1+nid, policy->v.nodes);
 	if (next >= MAX_NUMNODES)
 		next = first_node(policy->v.nodes);
@@ -730,7 +728,6 @@ static unsigned offset_il_node(struct me
 		nid = next_node(nid+1, pol->v.nodes);
 		c++;
 	} while (c <= target);
-	BUG_ON(nid >= MAX_NUMNODES);
 	return nid;
 }
 
@@ -741,7 +738,6 @@ static struct page *alloc_page_interleav
 	struct zonelist *zl;
 	struct page *page;
 
-	BUG_ON(!node_online(nid));
 	zl = NODE_DATA(nid)->node_zonelists + (gfp & GFP_ZONEMASK);
 	page = __alloc_pages(gfp, order, zl);
 	if (page && page_zone(page) == zl->zones[0]) {
@@ -784,8 +780,6 @@ alloc_page_vma(unsigned int __nocast gfp
 		unsigned nid;
 		if (vma) {
 			unsigned long off;
-			BUG_ON(addr >= vma->vm_end);
-			BUG_ON(addr < vma->vm_start);
 			off = vma->vm_pgoff;
 			off += (addr - vma->vm_start) >> PAGE_SHIFT;
 			nid = offset_il_node(pol, vma, off);
