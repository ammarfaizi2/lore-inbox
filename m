Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268295AbUHKWus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbUHKWus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268303AbUHKWti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:49:38 -0400
Received: from holomorphy.com ([207.189.100.168]:2951 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268295AbUHKWpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:45:39 -0400
Date: Wed, 11 Aug 2004 15:42:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1: legacy_va_layout compile error with SYSCTL=n
Message-ID: <20040811224217.GV11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <20040810002110.4fd8de07.akpm@osdl.org> <20040811221825.GM26174@fs.tum.de> <20040811223353.GT11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811223353.GT11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 12:18:25AM +0200, Adrian Bunk wrote:
>> This patch breaks compilation with CONFIG_SYSCTL=n:
>> <--  snip  -->
>> ...
>>   LD      .tmp_vmlinux1
>> arch/i386/mm/built-in.o(.text+0x1cd6): In function `arch_pick_mmap_layout':
>> : undefined reference to `sysctl_legacy_va_layout'
>> make: *** [.tmp_vmlinux1] Error 1
>> <--  snip  -->

On Wed, Aug 11, 2004 at 03:33:53PM -0700, William Lee Irwin III wrote:
> Does this help?

Hmm, looks like there's a hugetlb warning too.


Index: mm1-2.6.8-rc4/mm/hugetlb.c
===================================================================
--- mm1-2.6.8-rc4.orig/mm/hugetlb.c	2004-08-10 23:00:25.100832480 -0700
+++ mm1-2.6.8-rc4/mm/hugetlb.c	2004-08-11 15:30:37.473778920 -0700
@@ -163,6 +163,7 @@
 }
 #endif
 
+#ifdef CONFIG_SYSCTL
 static unsigned long set_max_huge_pages(unsigned long count)
 {
 	while (count > nr_huge_pages) {
@@ -188,7 +189,6 @@
 	return nr_huge_pages;
 }
 
-#ifdef CONFIG_SYSCTL
 int hugetlb_sysctl_handler(struct ctl_table *table, int write,
 			   struct file *file, void __user *buffer,
 			   size_t *length, loff_t *ppos)
