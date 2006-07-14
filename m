Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161187AbWGNWe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbWGNWe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 18:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbWGNWe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 18:34:59 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4576
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161187AbWGNWe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 18:34:58 -0400
Date: Fri, 14 Jul 2006 15:35:03 -0700 (PDT)
Message-Id: <20060714.153503.123972494.davem@davemloft.net>
To: ralphc@pathscale.com
Cc: muli@il.ibm.com, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Suggestions for how to remove bus_to_virt()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1152916027.4572.391.camel@brick.pathscale.com>
References: <20060712.174013.95062313.davem@davemloft.net>
	<20060713054658.GC5096@rhun.ibm.com>
	<1152916027.4572.391.camel@brick.pathscale.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <ralphc@pathscale.com>
Date: Fri, 14 Jul 2006 15:27:07 -0700

> Note that the current design only supports one IOMMU type in a system.
> This could support multiple IOMMU types at the same time.

This is not true, the framework allows multiply such types
and in fact Sparc64 takes advantage of this.  We have about
4 or 5 different PCI controllers, and the IOMMUs are slightly
different in each.

Even with the standard PCI DMA mapping calls, we can gather the
platform private information necessary to program the IOMMU
appropriately for a given chipset.

The dma_mapping_ops idea will never get accepted by folks like Linus,
for reasons I've outlined in previous emails in this thread.  So, it's
best to look elsewhere for solutions to your problem, such as the
ideas used by the USB and IEE1394 device layers.
