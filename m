Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269417AbUJFTzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269417AbUJFTzY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269440AbUJFTzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:55:23 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:62687 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S269417AbUJFTye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:54:34 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
Date: Wed, 6 Oct 2004 13:54:15 -0600
User-Agent: KMail/1.7
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200409301014.00725.bjorn.helgaas@hp.com> <200410010858.27390.bjorn.helgaas@hp.com> <20041006083249.C18379@flint.arm.linux.org.uk>
In-Reply-To: <20041006083249.C18379@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410061354.15746.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 October 2004 1:32 am, Russell King wrote:
> On Fri, Oct 01, 2004 at 08:58:27AM -0600, Bjorn Helgaas wrote:
> > My main point is that I think the early init stuff (i.e.,
> > serial8250_isa_init_ports()) should go away, so we don't have the
> > dichotomy of having the compiled-in stuff handled differently than
> > the run-time enumerated stuff.
> 
> You're always going to have this.  For instance, the standard ISA serial
> ports may not show up in any "enumerated stuff" on an x86 box - and x86
> people expect that the port at 0x3f8 is ttyS0, 2f8 is ttyS1 etc.
> 
> Change that order and they'll scream at you.

I don't forsee any order changing.  I would expect to use link
ordering so all the 8250_platform ports are registered first, then
all the 8250_acpi, then all the 8250_pci.

The order WOULD change in some cases on ia64, because we'd get rid
of the current wierdness where the device in the HCDP/PCDP firmware
table always becomes ttyS0, regardless of where it lives.  This
would be an improvement, though, because the devices would stop
changing names just because you selected a different firmware
console.

> See my previous mail why this doesn't work - x86 serial console
> requirements.
> 
> I think you'll do better to discuss this problem with Alan so that
> he can change his (and maybe others) points of view wrt when the
> serial console is initialised.  Until then I'm going to continue
> sitting on the fence on this point.

Yeah, I'll poke him about "console=uart".  I sent it to you because I
think a clean solution requires minor 8250 hooks so we can look up
the ttyS device that corresponds to an MMIO or IO address.
