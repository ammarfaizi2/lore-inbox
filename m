Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267598AbUIXBVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267598AbUIXBVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUIXBR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 21:17:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:8161 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267632AbUIXBMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 21:12:38 -0400
Subject: [PATCH] ppc32: Fix typo/bug in bus resource allocation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095988340.3830.33.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 11:12:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The code re-allocating new bus resources in case of conflicts use a
function called probe_resource(), which has a typo (spotted by the
uninitialized variable use of gcc) causing it to potentially return
bogus results. This fixes it:

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc/kernel/pci.c 1.43 vs edited =====
--- 1.43/arch/ppc/kernel/pci.c	2004-08-26 16:43:07 +10:00
+++ edited/arch/ppc/kernel/pci.c	2004-09-24 11:08:49 +10:00
@@ -411,7 +411,7 @@
 			r = &dev->resource[i];
 			if (!r->flags || (r->flags & IORESOURCE_UNSET))
 				continue;
-			if (pci_find_parent_resource(bus->self, r) != pr)
+			if (pci_find_parent_resource(dev, r) != pr)
 				continue;
 			if (r->end >= res->start && res->end >= r->start) {
 				*conflict = r;


