Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161230AbWAMD7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161230AbWAMD7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161314AbWAMD7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:59:43 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:717 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161230AbWAMD7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:59:43 -0500
Date: Thu, 12 Jan 2006 19:59:36 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: yhlu <yhlu.kernel@gmail.com>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: can not compile in the latest git
In-Reply-To: <86802c440601121236s47d5737fo45105ce3ebc746a6@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0601121958570.2740@schroedinger.engr.sgi.com>
References: <86802c440601111021m7cb40881m7206d9342534f844@mail.gmail.com> 
 <Pine.LNX.4.62.0601111213270.24355@schroedinger.engr.sgi.com>
 <86802c440601121236s47d5737fo45105ce3ebc746a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006, yhlu wrote:

> It turns out, if I disable "Support for paging of anonymous memory
> (swap)" --- SWAP
> 
> the CONFIG_MIGRATION will disappear from the .config
> 
> the mm/mempolicy.c may need some #if CONFIG_MIRGRATION to comment out
> these calling.

Could you try this patch:

Index: linux-2.6/include/linux/swap.h
===================================================================
--- linux-2.6.orig/include/linux/swap.h	2006-01-08 22:37:45.504089980 -0800
+++ linux-2.6/include/linux/swap.h	2006-01-12 19:56:35.665086037 -0800
@@ -180,6 +180,11 @@
 extern int putback_lru_pages(struct list_head *l);
 extern int migrate_pages(struct list_head *l, struct list_head *t,
 		struct list_head *moved, struct list_head *failed);
+#else
+static inline int isolate_lru_pages(struct page *p) { return -ENOSYS; }
+static inline int putback_lru_pages(struct list_head *) { return 0; }
+static inline int migrate_pages(struct list_head *l, struct list_head *t,
+	struct list_head *moved, struct list_head *failed) { return -ENOSYS; }
 #endif
 
 #ifdef CONFIG_MMU
