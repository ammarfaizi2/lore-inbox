Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWEQG2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWEQG2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 02:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWEQG2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 02:28:11 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:28889 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932445AbWEQG2J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 02:28:09 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Christoph Lameter <clameter@sgi.com>
Subject: [PATCH][respin] mm: cleanup swap unused warning
Date: Wed, 17 May 2006 16:27:40 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-mm@kvack.org, Andrew Morton <akpm@osdl.org>
References: <200605102132.41217.kernel@kolivas.org> <200605162314.36059.kernel@kolivas.org> <Pine.LNX.4.64.0605160859230.6065@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0605160859230.6065@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605171627.41653.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 May 2006 02:00, Christoph Lameter wrote:
> On Tue, 16 May 2006, Con Kolivas wrote:
> > The variable is not compiled in so the empty static inline as suggested
> > by Pekka suffices to silence this warning.
>
> Maybe you could redo the whole thing? Is it a problem to make all the
> similar functions inlines?

No problem.

---
if CONFIG_SWAP is not defined we get:

mm/vmscan.c: In function ‘remove_mapping’:
mm/vmscan.c:387: warning: unused variable ‘swap’

Convert defines in swap.h into blank inline functions to fix this warning
and be consistent.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 include/linux/swap.h |   64 ++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 53 insertions(+), 11 deletions(-)

Index: linux-2.6.17-rc4-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.17-rc4-mm1.orig/include/linux/swap.h	2006-05-17 15:57:48.000000000 +1000
+++ linux-2.6.17-rc4-mm1/include/linux/swap.h	2006-05-17 16:21:03.000000000 +1000
@@ -286,18 +286,60 @@ static inline void disable_swap_token(vo
 #define free_pages_and_swap_cache(pages, nr) \
 	release_pages((pages), (nr), 0);
 
-#define show_swap_cache_info()			/*NOTHING*/
-#define free_swap_and_cache(swp)		/*NOTHING*/
-#define swap_duplicate(swp)			/*NOTHING*/
-#define swap_free(swp)				/*NOTHING*/
-#define read_swap_cache_async(swp,vma,addr)	NULL
-#define lookup_swap_cache(swp)			NULL
-#define valid_swaphandles(swp, off)		0
+static inline void show_swap_cache_info(void)
+{
+}
+
+static inline void free_swap_and_cache(swp_entry_t swp)
+{
+}
+
+static inline int swap_duplicate(swp_entry_t swp)
+{
+	return 0;
+}
+
+static inline void swap_free(swp_entry_t swp)
+{
+}
+
+static inline struct page *read_swap_cache_async(swp_entry_t swp,
+			struct vm_area_struct *vma, unsigned long addr)
+{
+	return NULL;
+}
+
+static inline struct page *lookup_swap_cache(swp_entry_t swp)
+{
+	return NULL;
+}
+
+static inline int valid_swaphandles(swp_entry_t entry, unsigned long *offset)
+{
+	return 0;
+}
+
 #define can_share_swap_page(p)			(page_mapcount(p) == 1)
-#define move_to_swap_cache(p, swp)		1
-#define move_from_swap_cache(p, i, m)		1
-#define __delete_from_swap_cache(p)		/*NOTHING*/
-#define delete_from_swap_cache(p)		/*NOTHING*/
+
+static inline int move_to_swap_cache(struct page *page, swp_entry_t entry)
+{
+	return 1;
+}
+
+static inline int move_from_swap_cache(struct page *page, unsigned long index,
+					struct address_space *mapping)
+{
+	return 1;
+}
+
+static inline void __delete_from_swap_cache(struct page *page)
+{
+}
+
+static inline void delete_from_swap_cache(struct page *page)
+{
+}
+
 #define swap_token_default_timeout		0
 
 static inline int remove_exclusive_swap_page(struct page *p)

-- 
-ck
