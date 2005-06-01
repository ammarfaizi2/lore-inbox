Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVFAQs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVFAQs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 12:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVFAQs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 12:48:28 -0400
Received: from holomorphy.com ([66.93.40.71]:47304 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261461AbVFAQsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 12:48:23 -0400
Date: Wed, 1 Jun 2005 09:48:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: 2.6.12-rc5-mm2
Message-ID: <20050601164817.GO20782@holomorphy.com>
References: <20050601022824.33c8206e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601022824.33c8206e.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 02:28:24AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm2/
> - Dropped bk-acpi.patch.  Too old, too much breakage.
> - A few more subsystem trees have moved to using git
> - There are a large number of patches here which fix patches which people
>   have already sent.  A very large number.  Are we getting a bit careless?

This small patch silences some iomem-related warnings in sunzilog.c
by declaring mapped_addr as void __iomem * and inserting a cast in
one case.


Index: mm2-2.6.12-rc5/drivers/serial/sunzilog.c
===================================================================
--- mm2-2.6.12-rc5.orig/drivers/serial/sunzilog.c	2005-06-01 08:11:54.863223871 -0700
+++ mm2-2.6.12-rc5/drivers/serial/sunzilog.c	2005-06-01 09:40:25.196930439 -0700
@@ -1071,7 +1071,7 @@
  */
 static struct zilog_layout __iomem * __init get_zs_sun4u(int chip, int zsnode)
 {
-	unsigned long mapped_addr;
+	void __iomem *mapped_addr;
 	unsigned int sun4u_ino;
 	struct sbus_bus *sbus = NULL;
 	struct sbus_dev *sdev = NULL;
@@ -1111,9 +1111,9 @@
 		apply_fhc_ranges(central_bus->child,
 				 &zsregs[0], 1);
 		apply_central_ranges(central_bus, &zsregs[0], 1);
-		mapped_addr =
-			(((u64)zsregs[0].which_io)<<32UL) |
-			((u64)zsregs[0].phys_addr);
+		mapped_addr = (void __iomem *)
+			((((u64)zsregs[0].which_io)<<32UL) |
+			((u64)zsregs[0].phys_addr));
 	}
 
 	if (zilog_irq == -1) {
