Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVFPXHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVFPXHY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 19:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVFPXEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 19:04:01 -0400
Received: from ns.suse.de ([195.135.220.2]:14501 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261876AbVFPXA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 19:00:26 -0400
Date: Fri, 17 Jun 2005 01:00:20 +0200
From: Andi Kleen <ak@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: Rajesh Shah <rajesh.shah@intel.com>, len.brown@intel.com, ak@suse.de,
       acpi-devel@lists.sourceforge.net, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/04] PCI: use the MCFG table to properly access pci devices (x86-64)
Message-ID: <20050616230020.GM7048@bragg.suse.de>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com> <20050615053214.GD23394@kroah.com> <20050616153404.B5337@unix-os.sc.intel.com> <20050616224223.GA13619@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616224223.GA13619@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 03:42:23PM -0700, Greg KH wrote:
> On Thu, Jun 16, 2005 at 03:34:06PM -0700, Rajesh Shah wrote:
> > On Tue, Jun 14, 2005 at 10:32:14PM -0700, Greg KH wrote:
> > > 
> > > +	for (i = 0; i < pci_mmcfg_config_num; ++i) {
> > > +		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
> > > +		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address, MMCONFIG_APER_SIZE);
> > 
> > This will map 256MB for each mmcfg aperture, probably better
> > to restrict it based on bus number range for this aperture.
> 
> It should be 1MB per bus number, right?

It shouldn't make much difference anyways - we have plenty of vmalloc
space on x86-64

The only advantage of using the exact number would be maybe to detect overruns.

-Andi
