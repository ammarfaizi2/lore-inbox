Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSHZBz1>; Sun, 25 Aug 2002 21:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317778AbSHZBz1>; Sun, 25 Aug 2002 21:55:27 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:54745 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317176AbSHZBz0> convert rfc822-to-8bit;
	Sun, 25 Aug 2002 21:55:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "Grover, Andrew" <andrew.grover@intel.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] 2.5.31 Summit NUMA patch with dynamic IRQ balancing
Date: Sun, 25 Aug 2002 18:59:29 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <EDC461A30AC4D511ADE10002A5072CAD0236DDD3@orsmsx119.jf.intel.com>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DDD3@orsmsx119.jf.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208251859.29185.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 August 2002 05:29 pm, Grover, Andrew wrote:
> > From: James Cleverdon [mailto:jamesclv@us.ibm.com]
> >
> > > This should be moved to acpi.h
> >
> > Will be, once I'm sure this is the right way to go.  As
> > mentioned earlier, I'm
> > having ACPI problems that seem to imply ACPI isn't building
> > the full IRQ
> > table.  In 2.4 we could let MPS do this.  Maybe 2.5 will need
> > to revert to
> > that behavior.
>
> What happens when you use the FULL ACPI support? I suspect that you really
> do want the interpreter, in order to evaluate _PRTs properly.
>
> ISTR that the reason you are thinking that ACPI only is programming some of
> the ioapic entries is because whatever is printing them is looking at the
> mp_irqs array. Which is MPS specific. So ACPI doesn't bother filling it all
> in. :)
>
> Is that a bug? Should ACPI fill it in completely, or maybe not at all?
> Don't know. But it is strictly unnecessary.
>
> Regards -- Andy

Bingo!  With full ACPI turned on, the system does indeed boot.  The extra I/O 
APIC entries are being programmed from the PRT.

(Call chain is:  pci_acpi_init --> acpi_pci_irq_init --> mp_parse_prt --> 
io_apic_set_pci_routing)

So, given that quite a number of our customers would like to run with 
hyperthreading turned on, but do not want full ACPI, what is the right thing 
to do in the HT-only case?  Add extra code to process the PRT?  Fall back on 
MPS's IRQ records?  Something else entirely?

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

