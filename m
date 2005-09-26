Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbVIZWqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVIZWqA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 18:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVIZWqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 18:46:00 -0400
Received: from palrel10.hp.com ([156.153.255.245]:40841 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S932515AbVIZWp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 18:45:59 -0400
Date: Mon, 26 Sep 2005 15:46:03 -0700
From: Grant Grundler <iod00d@hp.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, linux-ia64@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, ak@suse.de,
       "Mallick, Asit K" <asit.k.mallick@intel.com>, gregkh@suse.de
Subject: Re: [patch 2.6.14-rc2 0/5] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Message-ID: <20050926224603.GD16113@esmail.cup.hp.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F047E9021@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F047E9021@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 03:08:23PM -0700, Luck, Tony wrote:
> Historically swiotlb.c was written with just PCI in mind (hence
> all the comments ("... implement the PCI DMA API",  "The PCI address
> to use is returned", "teardown the PCI dma mapping") and a few
> error messages ("PCI-DMA: Out of SW-IOMMU space ...", "PCI-DMA: Memory
> would be corrupted", "PCI-DMA: Random memory would be DMAed").
> Perhaps back then the only options were PCI and ISA????

Yes. The DMA interface davem/et al introduce in linux-2.4 only
supported "PCI-Like" busses. Ie the API required struct pci_dev.

> Matthew is probably technically right in that this is a more
> generic interface ... but is it actually being used for anything
> other than PCI?  Will it ever be so used?

Besides 32-bit PCI devices, I expect legacy 24-bit E/ISA DMA will
need it.  Is ISA ~= PCI? I never got a clear answer on that.
I'm inclined to say it's not.

But since swiotlb complies with DMA-API interface and is not related
to any particular type of bus, I'd rather it go into lib/ instead of
drivers/pci.

hth,
grant
