Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbUKOIBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbUKOIBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 03:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbUKOIBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 03:01:22 -0500
Received: from colo.lackof.org ([198.49.126.79]:60322 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261540AbUKOIBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 03:01:17 -0500
Date: Mon, 15 Nov 2004 01:01:16 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Michael Chan <mchan@broadcom.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Message-ID: <20041115080116.GA5793@colo.lackof.org>
References: <B1508D50A0692F42B217C22C02D849720312DED5@NT-IRVA-0741.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1508D50A0692F42B217C22C02D849720312DED5@NT-IRVA-0741.brcm.ad.broadcom.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 11:07:13PM -0800, Michael Chan wrote:
> Grant Grundler wrote:
>  
> > There are two tests in arch/i386/pci/mmconfig.c:pci_mmcfg_init() before
> > the raw_pci_ops is set to &pci_mmcfg. Perhaps some additional crude tests
> > could select a different set of pci_raw_ops to deal with posted writes
> > to mmconfig space. Someone more familiar with those chipsets might
> > find a more elegant solution.
> 
> Do you mean something like pci_mmcfg1 for Intel chipsets that implement
> non-posted mmconfig and pci_mmcfg2 for other chipsets that may implement
> posted mmconfig?

Yes.

> pci_mmcfg2's write method will guarantee that the write has reached
> the target before returning. If pci_mmcfg2's write method uses read
> from the target to flush the write, we are back to the original problem
> of out-of-spec read when writing the PMCSR register. If the flush does
> not require reading from the target device, then it's fine.

Yes - agreed.

I do expect chip designers are aware of this problem.
It's not a new problem.
But it's certainly possible some are not. :^(

thanks,
grant

>  
> Michael
> 
> 
>  
