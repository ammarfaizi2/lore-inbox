Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbTGCWGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbTGCWGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:06:12 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:24591 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S265418AbTGCWFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:05:00 -0400
Date: Thu, 3 Jul 2003 16:19:27 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Grant Grundler <grundler@parisc-linux.org>,
       James Bottomley <James.Bottomley@SteelEye.com>, axboe@suse.de,
       davem@redhat.com, suparna@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030703221927.GC12433@dsl2.external.hp.com>
References: <1057077975.2135.54.camel@mulgrave> <20030702015701.6007ac26.ak@suse.de> <20030702165510.GC11739@dsl2.external.hp.com> <1057180598.20318.32.camel@dhcp22.swansea.linux.org.uk> <20030702235619.GA21567@wotan.suse.de> <1057263988.21508.18.camel@dhcp22.swansea.linux.org.uk> <20030703212415.GA30277@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703212415.GA30277@wotan.suse.de>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 11:24:15PM +0200, Andi Kleen wrote:
...
> Also it's likely cheaper just submit more segments than to have the IOMMU
> overhead

It depends on the device. If using something like 8237A to master DMA cycles,
then CPU cost of merging is relatively cheap. If sending the SG list is
just a sequence of MMIO space writes, then passing the raw list is cheaper.
ZX1 and PARISC IOMMUs clearly add some overhead both in terms of CPU
utilization (manage IOMMU) and DMA latency (IOMMU TLB misses sometimes).

...
> (at least for sane devices, if not it may be worth to artificially limit the
> dma mask of the device to force IOMMU on IA64 and x86-64) 

Agreed. We are only doing that until BIO code and IOMMU code can
agree on how merging works without requiring the IOMMU.

thanks,
grant
