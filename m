Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVGZIVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVGZIVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 04:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVGZIT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 04:19:29 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:25452 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261854AbVGZISM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 04:18:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=i9TFr/7c6ZWOfwzkDHmO1gfsMiTs9axoqD4EgvIBI75kqjMTEOxF7gflGqw7sfbCXa9HWULNqnXnoQQ38lbqPYzDaHglC/uFZFHbv7z2Px2kwtUKOjOiKw6IFidoQVmDPxvtPs1r1p1cOtHqCHeg9E8bxXwAaEqHf73M3tSHhKs=  ;
Message-ID: <42E5F1BF.7060604@yahoo.com.au>
Date: Tue, 26 Jul 2005 18:18:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 3/6] mm: cleanup rmap
References: <42E5F139.70002@yahoo.com.au> <42E5F173.3010409@yahoo.com.au> <42E5F19A.6050407@yahoo.com.au>
In-Reply-To: <42E5F19A.6050407@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------000802000604070406040103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000802000604070406040103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

3/6


--------------000802000604070406040103
Content-Type: text/plain;
 name="mm-cleanup-rmap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-cleanup-rmap.patch"

Thanks to Bill Irwin for pointing this out.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -448,16 +448,12 @@ void page_add_anon_rmap(struct page *pag
 
 	if (atomic_inc_and_test(&page->_mapcount)) {
 		struct anon_vma *anon_vma = vma->anon_vma;
-		pgoff_t index;
 
 		BUG_ON(!anon_vma);
 		anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 		page->mapping = (struct address_space *) anon_vma;
 
-		index = (address - vma->vm_start) >> PAGE_SHIFT;
-		index += vma->vm_pgoff;
-		index >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
-		page->index = index;
+		page->index = linear_page_index(vma, address);
 
 		inc_page_state(nr_mapped);
 	}

--------------000802000604070406040103--
Send instant messages to your online friends http://au.messenger.yahoo.com 
