Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161445AbWASVx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161445AbWASVx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161447AbWASVx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:53:28 -0500
Received: from 81-179-234-91.dsl.pipex.com ([81.179.234.91]:26565 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1161445AbWASVx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:53:27 -0500
Date: Thu, 19 Jan 2006 21:52:59 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       lhms-devel@lists.sourceforge.net, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/2] GFP_ZONETYPES calculate from GFP_ZONEMASK
Message-ID: <20060119215259.GA29627@shadowen.org>
References: <1137205485.7130.81.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <1137205485.7130.81.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GFP_ZONETYPES calculate from GFP_ZONEMASK

GFP_ZONETYPES's value is directly related to the value of GFP_ZONEMASK. 
It takes one of two forms depending whether the top bit of GFP_ZONEMASK
is a 'loner'.  Supply both forms, enabling the loner.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 mmzone.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
diff -upN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h
+++ current/include/linux/mmzone.h
@@ -98,11 +98,14 @@ struct per_cpu_pageset {
  * of three zone modifier bits, we could require up to eight zonelists.
  * If the left most zone modifier is a "loner" then the highest valid
  * zonelist would be four allowing us to allocate only five zonelists.
+ * Use the first form for GFP_ZONETYPES when the left most bit is not
+ * a "loner", otherwise use the second.
  *
  * NOTE! Make sure this matches the zones in <linux/gfp.h>
  */
 #define GFP_ZONEMASK	0x07
-#define GFP_ZONETYPES	5
+/* #define GFP_ZONETYPES       (GFP_ZONEMASK + 1) */           /* Non-loner */
+#define GFP_ZONETYPES  ((GFP_ZONEMASK + 1) / 2 + 1)            /* Loner */
 
 /*
  * On machines where it is needed (eg PCs) we divide physical memory
