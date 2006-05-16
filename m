Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWEPRHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWEPRHx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWEPRHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:07:53 -0400
Received: from cantor2.suse.de ([195.135.220.15]:14226 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932155AbWEPRHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:07:52 -0400
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jeff@garzik.org>,
       "Deguara, Joachim" <joachim.deguara@amd.com>
Subject: Re: [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
Date: Tue, 16 May 2006 19:07:42 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <200605161559.k4GFx3Mi017163@hera.kernel.org> <4469FB26.5070605@garzik.org>
In-Reply-To: <4469FB26.5070605@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161907.42826.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 18:17, Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
> > commit 5491d0f3e206beb95eeb506510d62a1dab462df1
> > tree 5c4aadcfb4a93535e2f6e0f5977e930ccacec0e9
> > parent f0fdabf8bf187c9aafeb139a828c530ef45cf022
> > author Andi Kleen <ak@suse.de> Mon, 15 May 2006 18:19:41 +0200
> > committer Linus Torvalds <torvalds@g5.osdl.org> Tue, 16 May 2006 21:59:31 -0700
> > 
> > [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
> > 
> > This is needed to see all devices.
> > 
> > The system has multiple PCI segments and we don't handle that properly
> > yet in PCI and ACPI. Short term before this is fixed blacklist it to
> > pci=noacpi.
> > 
> > Acked-by: len.brown@intel.com
> > Cc: gregkh@suse.de
> > Signed-off-by: Andi Kleen <ak@suse.de>
> > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> > 
> >  arch/i386/kernel/acpi/boot.c |    8 ++++++++
> >  1 files changed, 8 insertions(+)
> > 
> > diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
> > index 40e5aba..daee695 100644
> > --- a/arch/i386/kernel/acpi/boot.c
> > +++ b/arch/i386/kernel/acpi/boot.c
> > @@ -1066,6 +1066,14 @@ static struct dmi_system_id __initdata a
> >  		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
> >  		     },
> >  	 },
> > +	{
> > +	 .callback = disable_acpi_pci,
> > +	 .ident = "HP xw9300",
> > +	 .matches = {
> > +		    DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> > +		    DMI_MATCH(DMI_PRODUCT_NAME, "HP xw9300 Workstation"),
> 
> Strong NAK.  Please revert.  This majorly screws my primary workstation, 
> and many other users with this workstation.

Did you test that? I had two persons with that workstation test all combinations
and it worked for them. 

Wait - you have a engineering sample haven't you? I don't think i care about
those. Maybe they behave differently. Use pci=acpi

[Don't try to update the BIOS either - it can be deadly]

> At a minimum, you should test to see if the BIOS has activated PCI 
> domain support first!

It worked in both cases on the production system. Without pci=noacpi
the PCI-X bus couldn't be seen.

-Andi
 
