Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVAPLpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVAPLpG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 06:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVAPLpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 06:45:06 -0500
Received: from verein.lst.de ([213.95.11.210]:8413 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262483AbVAPLpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 06:45:02 -0500
Date: Sun, 16 Jan 2005 12:44:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix CONFIG_AGP depencies
Message-ID: <20050116114457.GA13506@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I did an allmodconfig on ppc64 it selected agp although ppc64
doesn't support agp and has not agp.h so the build failed.

This patch makes CONFIG_AGP depend on the architectures that actually
support agp.


--- 1.39/drivers/char/agp/Kconfig	2005-01-08 01:15:52 +01:00
+++ edited/drivers/char/agp/Kconfig	2005-01-16 11:39:56 +01:00
@@ -1,5 +1,6 @@
 config AGP
-	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU && !M68K && !ARM
+	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU
+	depends on ALPHA || IA64 || PPC || X86
 	default y if GART_IOMMU
 	---help---
 	  AGP (Accelerated Graphics Port) is a bus system mainly used to
