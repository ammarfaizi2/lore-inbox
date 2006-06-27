Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161252AbWF0Rqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161252AbWF0Rqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161263AbWF0Rqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:46:35 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5568 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161252AbWF0RqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:46:09 -0400
Date: Tue, 27 Jun 2006 10:46:01 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20060627174601.11172.18432.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060627174551.11172.49700.sendpatchset@schroedinger.engr.sgi.com>
References: <20060627174551.11172.49700.sendpatchset@schroedinger.engr.sgi.com>
Subject: [ZVC 3/4] Include vmstat.h in mm.h and not in page-flags.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move include of vmstat.h into mm.h

Some inline functions in vmstat.h need inline definitions from mm.h

So do the same as we already to for page-flags: Include vmstat.h in
mm.h where it fits in.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm3/include/linux/mm.h
===================================================================
--- linux-2.6.17-mm3.orig/include/linux/mm.h	2006-06-27 09:40:23.405892736 -0700
+++ linux-2.6.17-mm3/include/linux/mm.h	2006-06-27 10:29:56.424844789 -0700
@@ -4,7 +4,6 @@
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/capability.h>
-#include <linux/vmstat.h>
 
 #ifdef __KERNEL__
 
@@ -524,6 +523,11 @@ static inline void set_page_links(struct
 	set_page_section(page, pfn_to_section_nr(pfn));
 }
 
+/*
+ * Some inline functions in vmstat.h depend on page_zone()
+ */
+#include <linux/vmstat.h>
+
 #ifndef CONFIG_DISCONTIGMEM
 /* The array of struct pages - for discontigmem use pgdat->lmem_map */
 extern struct page *mem_map;
Index: linux-2.6.17-mm3/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-mm3.orig/include/linux/page-flags.h	2006-06-27 09:40:23.561156562 -0700
+++ linux-2.6.17-mm3/include/linux/page-flags.h	2006-06-27 10:27:36.956934646 -0700
@@ -6,7 +6,6 @@
 #define PAGE_FLAGS_H
 
 #include <linux/types.h>
-#include <linux/vmstat.h>
 
 /*
  * Various page->flags bits:
