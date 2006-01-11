Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWAKGTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWAKGTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWAKGTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:19:04 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:14468 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932361AbWAKGTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:19:02 -0500
Date: Tue, 10 Jan 2006 22:18:46 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Cliff Wickman <cpw@sgi.com>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net,
       Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [PATCH 0/5] Direct Migration V9: Overview
In-Reply-To: <43C47AD9.10800@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.62.0601102217190.20806@schroedinger.engr.sgi.com>
References: <20060110224114.19138.10463.sendpatchset@schroedinger.engr.sgi.com>
 <43C47AD9.10800@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006, KAMEZAWA Hiroyuki wrote:

> I think  current limitation is just Hugetlb pages and mlocked pages. right ?
> Could you make it clear and add comment or doc before going to -mm ?

These are checked by the code in mm/mempolicy.c. Add some
comments to migrate_pages() stating the limitations.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15/mm/vmscan.c
===================================================================
--- linux-2.6.15.orig/mm/vmscan.c	2006-01-10 22:13:37.000000000 -0800
+++ linux-2.6.15/mm/vmscan.c	2006-01-10 22:16:45.000000000 -0800
@@ -842,6 +842,12 @@ EXPORT_SYMBOL(migrate_page);
  * are movable anymore because t has become empty
  * or no retryable pages exist anymore.
  *
+ * Limitations:
+ * Cannot migrate mlocked pages because there is a danger
+ * that those may be swapped out. Also cannot migrate
+ * huge pages. We also cannot migrate pages of VMA's with
+ * special attributes (VM_IO, VM_LOCKED, VM_PFNMAP).
+ *
  * Return: Number of pages not migrated when "to" ran empty.
  */
 int migrate_pages(struct list_head *from, struct list_head *to,
