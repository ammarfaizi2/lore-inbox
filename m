Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264770AbUEYF2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbUEYF2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 01:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUEYF2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 01:28:55 -0400
Received: from ozlabs.org ([203.10.76.45]:36801 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264770AbUEYF2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 01:28:54 -0400
Date: Tue, 25 May 2004 15:27:19 +1000
From: Anton Blanchard <anton@samba.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, paulus@samba.org, olof@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc64] bump IOMMU_MAX_ORDER
Message-ID: <20040525052719.GF3893@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We have cards that want over 2MB of PCI consistent memory. The
IOMAP_MAX_ORDER limit is just to catch bad drivers early, so we can bump
this a bit. 

We want some room to grow but our maximum get_free_pages allocation on
ppc64 is currently 16MB, so it doesnt make sense to go above that.

Signed-off-by: Anton Blanchard <anton@samba.org>

===== include/asm-ppc64/iommu.h 1.6 vs edited =====
--- 1.6/include/asm-ppc64/iommu.h	Tue Apr 13 03:54:09 2004
+++ edited/include/asm-ppc64/iommu.h	Tue May 25 15:16:24 2004
@@ -29,10 +29,10 @@
 
 /*
  * IOMAP_MAX_ORDER defines the largest contiguous block
- * of dma (tce) space we can get.  IOMAP_MAX_ORDER = 10 
- * allows up to 2**9 pages (512 * 4096) = 2 MB
+ * of dma (tce) space we can get.  IOMAP_MAX_ORDER = 13
+ * allows up to 2**12 pages (4096 * 4096) = 16 MB
  */
-#define IOMAP_MAX_ORDER 10
+#define IOMAP_MAX_ORDER 13
 
 /*
  * Tces come in two formats, one for the virtual bus and a different
