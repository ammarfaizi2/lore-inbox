Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161132AbWGNPqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161132AbWGNPqY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 11:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbWGNPqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 11:46:23 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:5509 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1161132AbWGNPqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 11:46:23 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.2
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, greg@kroah.com, cw@f00f.org, harmon@ksu.edu,
       linux-kernel@vger.kernel.org, Daniel Drake <dsd@gentoo.org>
In-Reply-To: <20060714074305.1248b98e.akpm@osdl.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net>
	 <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org>
	 <44B78538.6030909@garzik.org>  <20060714074305.1248b98e.akpm@osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Fri, 14 Jul 2006 16:46:20 +0100
Message-Id: <1152891980.3205.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 07:43 -0700, Andrew Morton wrote:
> On Fri, 14 Jul 2006 07:51:20 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
> > Daniel Drake wrote:
> > > Jeff Garzik wrote:
> > >> Daniel Drake wrote:
> > >>> Gentoo users at http://bugs.gentoo.org/138036 reported a 2.6.16.17 
> > >>> regression:
> > >>> new kernels will not boot their system from their VIA SATA hardware.
> > >>>
> > >>> The solution is just to add the SATA device to the fixup list.
> > >>> This should also fix the same problem reported by Scott J. Harmon on 
> > >>> LKML.
> > >>>
> > >>> Signed-off-by: Daniel Drake <dsd@gentoo.org>
> > >>
> > >> Same NAK comment as before...
> > > 
> > > I didn't see this patch posted anywhere before, but I just did some more 
> > > searching and found something similar. Are you referring to 
> > > http://lkml.org/lkml/2006/6/24/184 ?
> > 
> > Same rationale, but the VIA SATA PCI ID had been submitted before, as 
> > well...
> > 
> 
> argh.  Is someone able to confirm that 2.6.18-rc1-mm2 works OK?  In that
> kernel I did a desperation reversion of the offending patches
> (revert-VIA-quirk-fixup-additional-PCI-IDs.patch and
> revert-PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch).
> 
> Guys, this is a really serious failure but afaict nobody is working on it
> and generally nothing at all is happening.
> 
> How do we fix all this?  (Who owns it?)

Andrew, 
please listen to me ,
I think 
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq)
is wright if interrupts are in XT-PIC mode, If we disable APIC or/and
Local APIC, yes we have to quirk the VIA PCI interrupts, ok ?

if not, if we have IO-APIC enabled (with ACPI I guess, ACPI knows make
IRQ routings ), we don't need neither should quirks the VIA PCIs.
This is my opinion base on some emails from Alan Cox , Bjorn Helgas
etc.. and for now is the best shot we have.


Thanks,
---
Sérgio M. B.


