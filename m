Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbUJZEa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUJZEa4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUJZE0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 00:26:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:42456 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262108AbUJZEYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 00:24:54 -0400
Subject: [PATCH] ppc64: PCI ignores empty phb regions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 14:21:49 +1000
Message-Id: <1098764509.5153.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The ppc64 PCI code, when parsing the OF tree, may end up getting empty
regions in addition to the "normal" ones for the PHB (some pSeries OF
device-tree contains weird "ranges" properties). These are harmless but
do trigger some annoying warnings during boot, so let's ignore them.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pci.c	2004-10-25 21:58:12.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pci.c	2004-10-26 14:18:54.171775248 +1000
@@ -654,6 +654,8 @@
 			cpu_phys_addr = cpu_phys_addr << 32 | ranges[4];
 
 		size = (unsigned long)ranges[na+3] << 32 | ranges[na+4];
+		if (size == 0)
+			continue;
 		switch ((ranges[0] >> 24) & 0x3) {
 		case 1:		/* I/O space */
 			hose->io_base_phys = cpu_phys_addr;


