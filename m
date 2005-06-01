Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVFAAI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVFAAI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 20:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVFAAIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 20:08:25 -0400
Received: from dvhart.com ([64.146.134.43]:39334 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261198AbVFAAIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 20:08:23 -0400
Date: Tue, 31 May 2005 17:08:19 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] add page_state info to show_mem
Message-ID: <375690000.1117584499@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This helps a lot when debugging out of memory stuff - useful especially
to see if all the memory is sucked into slab, etc.

diff -purN -X /home/mbligh/.diff.exclude 2.6.11/arch/i386/mm/pgtable.c 2.6.11-show_mem_slab/arch/i386/mm/pgtable.c
--- 2.6.11/arch/i386/mm/pgtable.c	2005-03-02 02:59:09.000000000 -0800
+++ 2.6.11-show_mem_slab/arch/i386/mm/pgtable.c	2005-05-31 15:58:36.000000000 -0700
@@ -30,6 +30,7 @@ void show_mem(void)
 	struct page *page;
 	pg_data_t *pgdat;
 	unsigned long i;
+	struct page_state ps;
 
 	printk("Mem-info:\n");
 	show_free_areas();
@@ -53,6 +54,13 @@ void show_mem(void)
 	printk("%d reserved pages\n",reserved);
 	printk("%d pages shared\n",shared);
 	printk("%d pages swap cached\n",cached);
+
+	get_page_state(&ps);
+	printk("%d pages dirty\n", ps.nr_dirty);
+	printk("%d pages writeback\n", ps.nr_writeback);
+	printk("%d pages mapped\n", ps.nr_mapped);
+	printk("%d pages slab\n", ps.nr_slab);
+	printk("%d pages pagetables\n", ps.nr_page_table_pages);
 }
 
 /*

