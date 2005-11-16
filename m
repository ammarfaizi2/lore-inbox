Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030558AbVKPXAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030558AbVKPXAQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030559AbVKPXAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:00:16 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:57571
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S1030558AbVKPXAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:00:14 -0500
Date: Wed, 16 Nov 2005 23:00:03 +0000
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/3] kvaddr_to_nid not used in common code
Message-ID: <20051116230003.GA16467@shadowen.org>
References: <exportbomb.1132181992@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1132181992@pinky>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kvaddr_to_nid not used in common code

kvaddr_to_nid() isn't used in common code nor in i386 code.
Remove these definitions.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 asm-i386/mmzone.h |    5 -----
 linux/mmzone.h    |    5 -----
 2 files changed, 10 deletions(-)
diff -upN reference/include/asm-i386/mmzone.h current/include/asm-i386/mmzone.h
--- reference/include/asm-i386/mmzone.h
+++ current/include/asm-i386/mmzone.h
@@ -76,11 +76,6 @@ static inline int pfn_to_nid(unsigned lo
  * Following are macros that each numa implmentation must define.
  */
 
-/*
- * Given a kernel address, find the home node of the underlying memory.
- */
-#define kvaddr_to_nid(kaddr)	pfn_to_nid(__pa(kaddr) >> PAGE_SHIFT)
-
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 #define node_end_pfn(nid)						\
 ({									\
diff -upN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h
+++ current/include/linux/mmzone.h
@@ -575,11 +575,6 @@ static inline int valid_section_nr(unsig
 	return valid_section(__nr_to_section(nr));
 }
 
-/*
- * Given a kernel address, find the home node of the underlying memory.
- */
-#define kvaddr_to_nid(kaddr)	pfn_to_nid(__pa(kaddr) >> PAGE_SHIFT)
-
 static inline struct mem_section *__pfn_to_section(unsigned long pfn)
 {
 	return __nr_to_section(pfn_to_section_nr(pfn));
