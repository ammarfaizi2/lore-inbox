Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbUKOJAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbUKOJAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 04:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbUKOJAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 04:00:22 -0500
Received: from mail.suse.de ([195.135.220.2]:30356 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261555AbUKOJAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 04:00:10 -0500
Date: Mon, 15 Nov 2004 09:33:05 +0100
From: Andi Kleen <ak@suse.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Andi Kleen <ak@suse.de>, Michael Chan <mchan@broadcom.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Message-ID: <20041115083305.GA1662@wotan.suse.de>
References: <B1508D50A0692F42B217C22C02D849720312DED3@NT-IRVA-0741.brcm.ad.broadcom.com> <20041113194634.GC3023@colo.lackof.org> <20041114085831.GF16795@wotan.suse.de> <20041115060021.GA3302@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115060021.GA3302@colo.lackof.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 11:00:21PM -0700, Grant Grundler wrote:
> > writes to handle Michael's power management issue properly. 
> > That would be definitely the safer approach.
> 
> hrm...are you suggesting another entry point in the struct raw_pci_ops?

Yes.

> 
> There are two tests in arch/i386/pci/mmconfig.c:pci_mmcfg_init() before
> the raw_pci_ops is set to &pci_mmcfg. Perhaps some additional crude tests
> could select a different set of pci_raw_ops to deal with posted writes
> to mmconfig space. Someone more familiar with those chipsets might
> find a more elegant solution.

I cannot think of a generic good way to detect posting from the software
side.

> 
> > > That means someone has to introduce a new method to access
> > > mmconfig if they implement postable writes.
> > 
> > 
> > Problem is that it adds silently a very subtle bug and there
> > is no way I know of for ACPI to tell the firmware it shouldn't use
> > posting.
> 
> Uhm, ACPI needs to tell the firmware?
> I would expect firmware to be platform/chip specific and "just know".

x86-64 always uses direct hardware access, x86 can use the 32bit PCI BIOS,
but it's now discouraged. 


> 
> If you meant OS, we already embed knowledge about specific chipsets
> for bug workarounds (e.g. tg3 driver). I think that's an option here too.
> I mean tweaking mmconfig.c to install a (possibly) chip specific
> method (raw_pci_ops) to flush posted mmconfig writes.

Possibly yes.  One issue is that we have a subtle bug until we notice
though. 

-Andi
