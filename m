Return-Path: <linux-kernel-owner+w=401wt.eu-S1758846AbWLIEuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758846AbWLIEuc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 23:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758849AbWLIEuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 23:50:32 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:36692 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758846AbWLIEub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 23:50:31 -0500
Date: Sat, 9 Dec 2006 13:53:37 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, clameter@engr.sgi.com,
       apw@shadowen.org
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [3/4] static
 virtual mem_map
Message-Id: <20061209135337.44a3acc4.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061209124141.a945854d.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208160708.c263a393.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208163020.4650bbaa.akpm@osdl.org>
	<20061209114950.307d57ca.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208193323.8c5382c6.akpm@osdl.org>
	<20061209124141.a945854d.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for avoiding complex inclusion of headr file in the middle of another header
file.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: devel-2.6.19/include/linux/mmzone.h
===================================================================
--- devel-2.6.19.orig/include/linux/mmzone.h	2006-12-08 15:05:18.000000000 +0900
+++ devel-2.6.19/include/linux/mmzone.h	2006-12-09 13:00:32.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/seqlock.h>
 #include <linux/nodemask.h>
+#include <linux/mm_types.h>
 #include <asm/atomic.h>
 #include <asm/page.h>
 
@@ -562,7 +563,6 @@
 #error Allocator MAX_ORDER exceeds SECTION_SIZE
 #endif
 
-struct page;
 struct mem_section {
 	/*
 	 * This is, logically, a pointer to an array of struct
@@ -619,7 +619,6 @@
 #error "PAGE_SIZE/SECTION_SIZE relationship is not suitable for vmem_map"
 #endif
 #ifdef CONFIG_SPARSEMEM_VMEMMAP_STATIC
-#include <linux/mm_types.h>
 extern struct page mem_map[];
 #else
 extern struct page* mem_map;

