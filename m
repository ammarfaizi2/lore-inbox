Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTIEWRv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 18:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTIEWRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 18:17:51 -0400
Received: from lidskialf.net ([62.3.233.115]:46540 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S262524AbTIEWRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 18:17:49 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
Date: Sat, 6 Sep 2003 00:16:15 +0100
User-Agent: KMail/1.5.3
Cc: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, linux-acpi@intel.com
References: <200309051958.02818.adq_dvb@lidskialf.net> <3F59018E.5060604@pobox.com>
In-Reply-To: <3F59018E.5060604@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309060016.16545.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 Sep 2003 10:35 pm, Jeff Garzik wrote:
> Andrew de Quincey wrote:
> > Hi, this is my next round of ACPI IRQ fixes. Attached are patches for
> > linux-2.4.23-pre3 and linux-2.6.0-test4.
> >
> > Please CC me on any replies. I seem to be having issues with
> > vger.kernel.org right now.
> >
> >
> > This patch addresses the following issues:
> >
> > 1) ACPI now drops back to PIC mode if configuration in APIC mode fails.
> >
> > 2) Removed 2 lines of erroneous code in mpparse.c which causes IO-APICs
> > to be misconfigured.
> >
> > 3) ACPI now supports PIC controllers properly.
> >
> > 4) This patch includes a patch by "Jun Nakajima" <jun.nakajima@intel.com>
> > which fixes ACPI IRQ routing for all VIA motherboards I have had tested
> > so far. I've included it in this patch as it changes one of the same
> > files.
> >
> > 5) Now retries with an extended IRQ descriptor if programming a link
> > device with a "standard" IRQ descriptor fails.
> >
> > This has already been tested successfully by multiple people.
>
> Patch looks pretty good.  It is _very_ difficult to pick through, and
> pick apart, though.
>
> Consider that one or more people reading your email (a) would want some
> of these fixes but (b) already have some of these fixes.
>
> This is why we _really_ need you to split up your patches.  Multiple
> split-up patches, one per email, is preferred.  Don't worry about
> sending us too much email:  we like it like that.

If/when I split it up, is it acceptable to number the patches to give the 
order they have to be applied in? The major problem with these particular 
fixes is that they all run over the same set of files, even the same 
functions, so they all conflict with each other. 

> As an aside, I know at least part of the VIA irq routing stuff still 
> needs fixing.  For some on-board VIA southbridge devices, irq routing is 
> accomplished by writing the PCI_INTERRUPT_xxx values to PCI config 
> registers of the target device; for others, the normal pirq PCI config 
> registers on the southbridge are used.  Alan's new irq stuff in 2.4.x 
> IMO should be merged into 2.6.x soonish, as Alan's work makes a big step 
> towards making it possible to fix some of the harder-to-fix irq routing 
> problems.

Is this still an issue when using ACPI? Surely it should insulate the OS from 
this chipset-specific stuff? 

I can see what you mean from the VT8235 docs if you were programming it 
directly, but the ACPI code in all the VIA BIOSes I have analysed takes care 
of this fine.

