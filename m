Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265243AbUD3T5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbUD3T5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265244AbUD3T5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:57:17 -0400
Received: from vena.lwn.net ([206.168.112.25]:55465 "HELO lwn.net")
	by vger.kernel.org with SMTP id S265243AbUD3T5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:57:13 -0400
Message-ID: <20040430195711.16275.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: [MICROPATCH] Make x86_64 build work without GART_IOMMU
cc: ak@suse.de
From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 30 Apr 2004 13:57:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you try to build a 2.6.6-rc3 kernel with CONFIG_GART_IOMMU turned off,
the link fails because bad_dma_address is undefined.  This little hack just
defines the variable in pci-nommu.c as well.  It may not be an optimal fix,
but it does make the kernel build.

Why do I care?  My Radeon 9200SE goes nuts if I build a GART-enabled
kernel.  Haven't figured out why...

jon

--- 2.6.6-rc3-slab/arch/x86_64/kernel/pci-nommu.c.orig	2004-02-06 00:51:20.000000000 -0700
+++ 2.6.6-rc3-slab/arch/x86_64/kernel/pci-nommu.c	2004-04-30 13:40:35.000000000 -0600
@@ -5,6 +5,7 @@
 #include <asm/proto.h>
 
 int iommu_merge = 0;
+dma_addr_t bad_dma_address;
 
 /* 
  * Dummy IO MMU functions
