Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVFQBQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVFQBQD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 21:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVFQBQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 21:16:03 -0400
Received: from fmr22.intel.com ([143.183.121.14]:6083 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261873AbVFQBP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 21:15:57 -0400
Date: Thu, 16 Jun 2005 18:15:39 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <gregkh@suse.de>, Rajesh Shah <rajesh.shah@intel.com>,
       len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/04] PCI: use the MCFG table to properly access pci devices (x86-64)
Message-ID: <20050616181535.A10031@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com> <20050615053214.GD23394@kroah.com> <20050616153404.B5337@unix-os.sc.intel.com> <20050616224223.GA13619@suse.de> <20050616230020.GM7048@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050616230020.GM7048@bragg.suse.de>; from ak@suse.de on Fri, Jun 17, 2005 at 01:00:20AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 01:00:20AM +0200, Andi Kleen wrote:
> On Thu, Jun 16, 2005 at 03:42:23PM -0700, Greg KH wrote:
> > On Thu, Jun 16, 2005 at 03:34:06PM -0700, Rajesh Shah wrote:
> > > On Tue, Jun 14, 2005 at 10:32:14PM -0700, Greg KH wrote:
> > > > 
> > > > +	for (i = 0; i < pci_mmcfg_config_num; ++i) {
> > > > +		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
> > > > +		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address, MMCONFIG_APER_SIZE);
> > > 
> > > This will map 256MB for each mmcfg aperture, probably better
> > > to restrict it based on bus number range for this aperture.
> > 
> > It should be 1MB per bus number, right?

Yes.

> 
> It shouldn't make much difference anyways - we have plenty of vmalloc
> space on x86-64
> 
Depends on how much you trust firmware :-). In the worst case, it
could create one such entry for each bus.

I noticed this because I worked on picking up resources for root
bridges from firmware recently, and noticed more than one system
in which firmware created ~10 entries for resources that were
adjacent to each other and could be coalesced into a single
resource range. Not illegal, just not optimal.

Rajesh

