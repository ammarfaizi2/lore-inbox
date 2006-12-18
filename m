Return-Path: <linux-kernel-owner+w=401wt.eu-S1753900AbWLRMD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbWLRMD0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 07:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbWLRMD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 07:03:26 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:3205 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753867AbWLRMDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 07:03:25 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 07:03:24 EST
Message-ID: <45868576.30100@openvz.org>
Date: Mon, 18 Dec 2006 15:11:34 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: tony.luck@intel.com, linux-ia64@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: [PATCH] IA64: virt_to_page() can be called with NULL arg
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[IA64] virt_to_page() cannot be called with NULL (mainstream bug)

It does not return NULL when arg is NULL.

Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>

--- linus-2.6.git/include/asm-ia64/pgalloc.h.orig	2006-12-18 14:59:09.000000000 +0300
+++ linus-2.6.git/include/asm-ia64/pgalloc.h	2006-12-18 15:07:44.000000000 +0300
@@ -137,7 +137,8 @@ pmd_populate_kernel(struct mm_struct *mm
 static inline struct page *pte_alloc_one(struct mm_struct *mm,
 					 unsigned long addr)
 {
-	return virt_to_page(pgtable_quicklist_alloc());
+	void *pg = pgtable_quicklist_alloc();
+	return pg ? virt_to_page(pg) : NULL;
 }
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
