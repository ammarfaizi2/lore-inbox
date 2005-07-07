Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVGGHIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVGGHIp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 03:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVGGHIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 03:08:45 -0400
Received: from odin2.bull.net ([192.90.70.84]:53664 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261210AbVGGHIo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 03:08:44 -0400
Subject: Re: PREEMPT_RT and mptfusion
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050706143157.GA22156@elte.hu>
References: <1120633558.6225.64.camel@ibiza.btsn.frna.bull.fr>
	 <20050706120848.GB16843@elte.hu>
	 <1120653209.6225.96.camel@ibiza.btsn.frna.bull.fr>
	 <1120659178.6225.99.camel@ibiza.btsn.frna.bull.fr>
	 <20050706143157.GA22156@elte.hu>
Content-Type: text/plain; charset=iso-8859-15
Organization: BTS
Message-Id: <1120719326.6225.102.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Thu, 07 Jul 2005 08:55:27 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 06/07/2005 à 16:31, Ingo Molnar a écrit :
> * Serge Noiraud <serge.noiraud@bull.net> wrote:
> 
> > > Yes it was 50-47.
> > > CONFIG_X86_UP_IOAPIC is not present in my .config
> > > CONFIG_PCI_MSI is set to yes.
> > > 
> > > I'll try with CONFIG_PCI_MSI=n
> > It's OK for me. good job.
> 
> good. But it would be nice to make it work with PCI_MSI=y too. Does 
> PCI_MSI=y work if you apply the patch below?
> 
> 	Ingo
> 
> --- linux/arch/i386/kernel/io_apic.c.orig
> +++ linux/arch/i386/kernel/io_apic.c
> @@ -2136,11 +2136,7 @@ static void end_level_ioapic_vector (uns
>  {
>  	int irq = vector_to_irq(vector);
>  
> -#ifdef CONFIG_PREEMPT_HARDIRQS
> -	if (!(irq_desc[vector].status & (IRQ_DISABLED | IRQ_INPROGRESS)) &&
> -							irq_desc[vector].action)
> -#endif
> -		end_level_ioapic_irq(irq);
> +	end_level_ioapic_irq(irq);
>  }
>  
>  static void enable_level_ioapic_vector(unsigned int vector)

Same problem with this patch and CONFIG_PCI_MSI=y
This is not the solution.

