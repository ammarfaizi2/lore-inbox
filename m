Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbUAaAcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 19:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUAaAcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 19:32:11 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:964 "EHLO fed1mtao06.cox.net")
	by vger.kernel.org with ESMTP id S264441AbUAaAcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 19:32:07 -0500
Date: Fri, 30 Jan 2004 17:32:05 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: torvalds@osdl.org, akpm@osdl.org
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Replace pci_pool with generic dma_pool
Message-ID: <20040131003205.GA24967@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All,

This set of patches against 2.6.2-rc2 removes the PCI-specific pci_pool 
structure and replaces it with a generic dma_pool. For compatibility with 
existing PCI drivers, macros are provided that map pci_pool_* to dma_pool_*.
This is extremely useful for architecture that have non-PCI devices but 
require DMA buffer pools. A good example is USB, where we've had to make
some hacks in the ARM implementation of the DMA API to get around the
USB's usage of the PCI DMA API and pci_pools with non-PCI device.
The patch has been tested on x86, ppc, and xscale (ARM).

Patch portions are posted as replies to this email.

If this patch is accepted, I'll post a follow-on patch to the USB list 
to clean up the USB layer to only use the generic DMA functions instead 
of the PCI functions.

~Deepak

diffstat:

 linux/drivers/base/Makefile   |    2 
 linux/drivers/base/core.c     |    1 
 linux/drivers/base/dmapool.c  |  409 ++++++++++++++++++++++++++++++++++++++++++++++
 linux/drivers/pci/Makefile    |    2 
 linux/drivers/pci/probe.c     |    2 
 linux/include/linux/device.h  |    1 
 linux/include/linux/dmapool.h |   27 +++
 linux/include/linux/pci.h     |   14 -
 linux/drivers/pci/pool.c      |  404 ---------------------------------------------
 9 files changed, 448 insertions(+), 414 deletions(-)

-- 
Deepak Saxena - dsaxena@plexity.net
