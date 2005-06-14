Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVFNSix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVFNSix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVFNSiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:38:52 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:42702 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261289AbVFNSii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:38:38 -0400
Date: Tue, 14 Jun 2005 14:38:12 -0400
From: Bob Picco <bob.picco@hp.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Bob Picco <bob.picco@hp.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: hpet patches
Message-ID: <20050614183812.GA5920@localhost.localdomain>
References: <88056F38E9E48644A0F562A38C64FB6004F77C29@scsmsx403.amr.corp.intel.com> <9e473391050614092661d665ee@mail.gmail.com> <20050614164605.GQ3728@localhost.localdomain> <9e4733910506141050a7c7728@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910506141050a7c7728@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:	[Tue Jun 14 2005, 01:50:49PM EDT]
> On 6/14/05, Bob Picco <bob.picco@hp.com> wrote:
> > Jon,
> > Jon Smirl wrote:        [Tue Jun 14 2005, 12:26:41PM EDT]
> > > Apparently there are many Dell systems that have an HPET but Dell is
> > > not providing the ACPI entry. Can we add some probing for the HPET or
> > > use something like the ICH5 PCI ID to enable it?
> > This is also true of HP x86 and x86_64 (AMD 8000 chipset) hardware.  I enabled
> > it on my HP x86_64 with the appropriate PCI commands but it has been a while
> > and can't recall the details.  This solution is good for platform specific
> > configuration but of course doesn't enable the driver discovery to work.
> > 
> > I also verified that the Documentation/hpet.txt sample program worked. I can't
> > remember who (SuSE ?) posted the x86_64 HPET stuff just before I
> > finished.  So I never posted. I didn't feel great about the solution because
> > the address was hardcoded. I found myself more irritated at HP for not having
> > configured it in the BIOS and ACPI table.
> > >
> > > I have verified that all Dimension 8300, PE400, Precision 360 have
> > > this problem. From what I can tell many other Dell models are also
> > > missing HPET ACPI. The problem is not universal, there are a few Dell
> > > models that do have the ACPI entry.
> > 
> > bob
> > 
> 
> Problem like this are usually fixed with quirks:
> 
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,   
> PCI_DEVICE_ID_INTEL_82801EB_0,  quirk_intel_ich5_hpet);
> 
> quirk_intel_ich5_hpet()
> {
>     if (!hpet_address)
>           hpet_address = 0xfed00000ULL;
> }
> 
> 0xfed00000ULL is right for ICH5, do you want to start adding these as
> part of HPET support? My hpet works fine once the address is set. For
> complete coverage you need a list of these for all of the AMD/Intel
> chipsets with hpet support. The list isn't very big.
> 
Well my ignorance is going to show here.  The platform initialization code
has already run and PCI probing happens later.  How do you reconcile Venki's
concern for an HPET armed for legacy support when platform
is already using PIT?  Also the hpet driver isn't a PCI driver but 
ACPI driver.  It's working for you so I'm obviously missing a detail.

bob
