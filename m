Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265771AbTFSLWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 07:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265770AbTFSLWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 07:22:44 -0400
Received: from zork.zork.net ([64.81.246.102]:39828 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S265771AbTFSLWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 07:22:43 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] 2.5.72-mjb2
References: <26110000.1056006164@[10.10.2.4]>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, lse-tech <lse-tech@lists.sourceforge.net>
Date: Thu, 19 Jun 2003 12:36:33 +0100
In-Reply-To: <26110000.1056006164@[10.10.2.4]> (Martin J. Bligh's message of
 "Thu, 19 Jun 2003 00:02:44 -0700")
Message-ID: <6ud6hawb7i.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During build:

include/linux/mm.h: In function `page_to_nid':
include/linux/mm.h:620: warning: implicit declaration of function `pfn_to_nid'

This patch shuts it up, but I'm only guessing as to whether
page_to_nid is NUMA-specific.


--- C72-mjb2/include/linux/mm.h~	2003-06-19 12:19:12.000000000 +0100
+++ C72-mjb2/include/linux/mm.h	2003-06-19 12:33:51.000000000 +0100
@@ -611,6 +611,7 @@
 extern int remap_page_range(struct vm_area_struct *vma, unsigned long from,
 		unsigned long to, unsigned long size, pgprot_t prot);
 
+#ifdef CONFIG_NUMA
 /* 
  * Given a struct page, determine which node's memory it is from.
  * TODO: There's probably a more efficient way to do this...
@@ -620,7 +621,6 @@
 	return pfn_to_nid(page_to_pfn(page));
 }
 
-#ifdef CONFIG_NUMA
 static inline void zero_rss(struct mm_struct *mm)
 {
 	mm->rss = 0;

