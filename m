Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbUKLCvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbUKLCvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 21:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbUKLCvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 21:51:35 -0500
Received: from fmr06.intel.com ([134.134.136.7]:42176 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262429AbUKLCv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 21:51:26 -0500
Subject: Re: [PATCH] fix  platform_rename_gsi related ia32 build breakage
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <Pine.LNX.4.58.0411111552030.2301@ppc970.osdl.org>
References: <4192A959.9020806@conectiva.com.br>
	 <4192A9BF.2080606@conectiva.com.br> <4192ADF4.1050907@conectiva.com.br>
	 <Pine.LNX.4.58.0411101621020.2301@ppc970.osdl.org>
	 <1100211749.5510.753.camel@d845pe>
	 <Pine.LNX.4.58.0411111427050.2301@ppc970.osdl.org>
	 <1100215538.5876.779.camel@d845pe>
	 <Pine.LNX.4.58.0411111552030.2301@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1100227848.5520.862.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Nov 2004 21:50:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 19:01, Linus Torvalds wrote:
> 
> On Thu, 11 Nov 2004, Len Brown wrote:

> We _definitely_ prefer "irq" over something else that means the same
> thing.

Hopeless, I know, to debate the "Royal We" on points of style,
especially when underscores have been invoked;-)

But humor me -- offer a concise definition of the term IRQ, and then
examine usage of the term to see if actually fits within the
definition.  The term started off to mean the interrupt pin numbers on
the 8259A PIC, then it started to mean PCI interrupts (PIRQ) pins too,
and sort of IO-APIC pin numbers, except of course when the pin numbers
don't actually linearly map to the IRQ numbers, and it can also be an
interrupt vector, you see some system never had 8259's, and it can also
be the name of the routine that handles an interrupt, and there are
softirqs, which are different from hardirqs, and there are fixup-irqs
etc. etc.

It isn't possible to offer a term that means the same thing as IRQ,
because IRQ is so over-used that it no longer means anything at all.

The term GSI is simple, it is an interrupt number that applies to the
entire system, as if the system had a completely flat interrupt model. 
They even drew a little picture to make this clear in the ACPI spec at
http://www.acpi.info Who would think such a simple thing would merit a
diagram?

> If GSI means some _specific_ interrupt, and thus has additional
> meaning over "irq", then by all means, use it, but spell it out.
> "Global System Interrupt" means _nothing_ to me. What makes it
> "global"? What makes it "system"?
>
> The _only_ thing that uses "gsi" is the MP table stuff, and that's
> apparently just from the documentation.

Don't those silly tech-writers know that software can be written
directly from the silicon, and that source-code and the terms used in it
is all the documentation that anybody could ever need?:-)

GSI actually did not appear in the MP spec, that referred only to 8259A
ISA/EISA IRQ's, PCI PIRQs, and IOAPIC INTINs.  If they were not PCI
interrupts, the "source bus IRQs" are the same as 8259A Interrupt
Request pins.

> In other words, if it's a normal interrupt, it's "irq" or "interrupt".
> The same way a "disk" is a "disk" - it's not a DASD.
> 
> Stupid acronyms that don't actually mean anything more than the
> standard name are nothing but stupid.

I agree 100%, and submit that the term "IRQ" fits this definition of a
"stupid acronym".

> Interrupts are interrupts. We call them something else only if they
> are _specific_ interrupts (ie a "NMI" clearly has a very _specific_
> meaning, as has "SCI", although the latter is already obscure enough
> that it's probably a good idea to spell it out a bit if it is ever
> used outside of a context where use is obvious).

It is true that a GSI and 8259 ISA IRQ are synonyms when their values
are < 16., but the term IRQ is being mis-used whenever it is not in that
context.

-Len

ps. note that x86 built with MSI or other architectures such as ia64
translate the simple GSI number into a vector and pass it around in that
form.  I don't know if this is a bug or a feature, but doing so means
that all the interrupt code didn't have to be re-written to accomodate
these varied architectures, and the semantics of a GSI as a unique
global integer identifying an interrupt source remain intact.


