Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbTD2Lsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 07:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTD2Lsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 07:48:55 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:27141 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S261747AbTD2Lsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 07:48:54 -0400
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org>
	<20030429150532.A3984@jurassic.park.msu.ru>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 29 Apr 2003 13:58:29 +0200
Message-ID: <wrpvfwx5xcq.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030429150532.A3984@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ivan" == Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

Ivan> Then the rest would be

Ivan> static inline dma_addr_t
Ivan> dma_map_single(struct device *dev, void *cpu_addr, size_t size,
Ivan> 	       enum dma_data_direction dir)
Ivan> {
Ivan> 	return pci_map_single(pci_dev_to_pci(dev), cpu_addr, size, dir);
Ivan> }

That's exactly what I wanted to avoid : It we feed NULL (for a non PCI
device) to pci_map_single (for example), we limit the max DMA address
to 24 bits, and this is quite bad for an EISA device, which is 32 bits
capable.

This approch doesn't look better to me than the pci_* implementation,
while the one I suggested gives us some full control over the DMA
mask.

Or am I completly wrong ?

        M.
-- 
Places change, faces change. Life is so very strange.
