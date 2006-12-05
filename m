Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937324AbWLEFVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937324AbWLEFVf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937341AbWLEFVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:21:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:3825 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937324AbWLEFVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:21:34 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,496,1157353200"; 
   d="scan'208"; a="23128534:sNHT1598359491"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [patch] add an iterator index in struct pagevec
Date: Mon, 4 Dec 2006 21:21:31 -0800
Message-ID: <000101c7182d$3a0b6a10$ba88030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccYLTjykWwauakwR1iWROV3GPJJQw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pagevec is never expected to be more than PAGEVEC_SIZE, I think a
unsigned char is enough to count them.  This patch makes nr, cold
to be unsigned char and also adds an iterator index. With that,
the size can be even bumped up by 1 to 15.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


diff -Nurp linux-2.6.19/include/linux/pagevec.h linux-2.6.19.ken/include/linux/pagevec.h
--- linux-2.6.19/include/linux/pagevec.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.ken/include/linux/pagevec.h	2006-12-04 19:18:21.000000000 -0800
@@ -8,15 +8,16 @@
 #ifndef _LINUX_PAGEVEC_H
 #define _LINUX_PAGEVEC_H
 
-/* 14 pointers + two long's align the pagevec structure to a power of two */
-#define PAGEVEC_SIZE	14
+/* 15 pointers + 3 char's align the pagevec structure to a power of two */
+#define PAGEVEC_SIZE	15
 
 struct page;
 struct address_space;
 
 struct pagevec {
-	unsigned long nr;
-	unsigned long cold;
+	unsigned char nr;
+	unsigned char cold;
+	unsigned char idx;
 	struct page *pages[PAGEVEC_SIZE];
 };
 
