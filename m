Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268310AbUHKXBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268310AbUHKXBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268302AbUHKWvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:51:20 -0400
Received: from holomorphy.com ([207.189.100.168]:6791 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268292AbUHKWtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:49:36 -0400
Date: Wed, 11 Aug 2004 15:46:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1: legacy_va_layout compile error with SYSCTL=n
Message-ID: <20040811224620.GW11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <20040810002110.4fd8de07.akpm@osdl.org> <20040811221825.GM26174@fs.tum.de> <20040811223353.GT11200@holomorphy.com> <20040811224217.GV11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811224217.GV11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 03:33:53PM -0700, William Lee Irwin III wrote:
>> Does this help?

On Wed, Aug 11, 2004 at 03:42:17PM -0700, William Lee Irwin III wrote:
> Hmm, looks like there's a hugetlb warning too.

hugetlb CONFIG_SYSCTL=n fix, take 2: the real thing.


Index: mm1-2.6.8-rc4/mm/hugetlb.c
===================================================================
--- mm1-2.6.8-rc4.orig/mm/hugetlb.c	2004-08-10 23:00:25.100832480 -0700
+++ mm1-2.6.8-rc4/mm/hugetlb.c	2004-08-11 15:34:59.574933488 -0700
@@ -123,6 +123,7 @@
 }
 __setup("hugepages=", hugetlb_setup);
 
+#ifdef CONFIG_SYSCTL
 static void update_and_free_page(struct page *page)
 {
 	int i;
@@ -188,7 +189,6 @@
 	return nr_huge_pages;
 }
 
-#ifdef CONFIG_SYSCTL
 int hugetlb_sysctl_handler(struct ctl_table *table, int write,
 			   struct file *file, void __user *buffer,
 			   size_t *length, loff_t *ppos)
