Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbTB1GgL>; Fri, 28 Feb 2003 01:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267540AbTB1GgL>; Fri, 28 Feb 2003 01:36:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6407 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267528AbTB1GgL>;
	Fri, 28 Feb 2003 01:36:11 -0500
Date: Fri, 28 Feb 2003 06:46:31 +0000
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Proposal: Eliminate GFP_DMA
Message-ID: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm thinking about doing something along these lines:

--- linux-2.5.63/include/linux/gfp.h    2003-02-24 13:05:13.000000000 -0600
+++ linux-2.5.63-gfpdma/include/linux/gfp.h     2003-02-27 17:24:39.000000000 -0600
@@ -26,11 +26,8 @@
 
-/* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
-   platforms, used as appropriate on others */
-
-#define GFP_DMA                __GFP_DMA
-
+#define GFP_ATOMIC_DMA (GFP_ATOMIC | __GFP_DMA)
+#define GFP_KERNEL_DMA (GFP_KERNEL | __GFP_DMA)

combined with changing some users to use __GFP_DMA if they really do mean
the bitmask.  Comments?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
