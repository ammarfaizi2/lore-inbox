Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269445AbUJSPAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269445AbUJSPAO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269449AbUJSPAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:00:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33927 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269445AbUJSO7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 10:59:40 -0400
Date: Mon, 18 Oct 2004 13:04:44 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: akpm@osdl.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] change pagevec counters back to unsigned long and cacheline align
Message-ID: <20041018150444.GD2403@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Change pagevec "nr" and "cold" back to "unsigned long", 
because 4 byte accesses can be slow on architectures < Pentium III 
(additional "data16" operand on instruction).

This still honours the cacheline alignment, making the size
of "pagevec" structure a power of two (either 64 or 128 bytes).

Haven't been able to see any significant change on performance on my 
limited testing.



--- rc4-mm1.orig/include/linux/pagevec.h	2004-10-15 01:02:39.209481760 -0300
+++ rc4-mm1/include/linux/pagevec.h	2004-10-15 01:17:58.853674592 -0300
@@ -5,14 +5,15 @@
  * pages.  A pagevec is a multipage container which is used for that.
  */
 
-#define PAGEVEC_SIZE	15
+/* 14 pointers + two long's align the pagevec structure to a power of two */
+#define PAGEVEC_SIZE	14
 
 struct page;
 struct address_space;
 
 struct pagevec {
-	unsigned short nr;
-	unsigned short cold;
+	unsigned long nr;
+	unsigned long cold;
 	struct page *pages[PAGEVEC_SIZE];
 };
 

----- End forwarded message -----
