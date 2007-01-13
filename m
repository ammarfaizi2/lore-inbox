Return-Path: <linux-kernel-owner+w=401wt.eu-S1161247AbXAMD2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbXAMD2d (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161230AbXAMD2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:28:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:46736 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161215AbXAMD14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:27:56 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, thomas@tungstengraphics.com
Message-Id: <20070113011536.9479.46456.sendpatchset@linux.site>
In-Reply-To: <20070113011526.9479.79596.sendpatchset@linux.site>
References: <20070113011526.9479.79596.sendpatchset@linux.site>
Subject: [patch 1/7] mm: debug check for the fault vs invalidate race
Date: Sat, 13 Jan 2007 04:27:51 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bugcheck for Andrea's pagefault vs invalidate race. This is triggerable
for both linear and nonlinear pages with a userspace test harness (using
direct IO and truncate, respectively).

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -120,6 +120,8 @@ void __remove_from_page_cache(struct pag
 	page->mapping = NULL;
 	mapping->nrpages--;
 	__dec_zone_page_state(page, NR_FILE_PAGES);
+
+	BUG_ON(page_mapped(page));
 }
 
 void remove_from_page_cache(struct page *page)
