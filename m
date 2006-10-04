Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWJDDj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWJDDj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 23:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWJDDj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 23:39:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751061AbWJDDjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 23:39:55 -0400
Date: Tue, 3 Oct 2006 20:36:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] clockevents: drivers for i386, fix #2
Message-Id: <20061003203620.d85df9c6.akpm@osdl.org>
In-Reply-To: <20061003103503.GA6350@elte.hu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
	<20061002210053.16e5d23c.akpm@osdl.org>
	<20061003084729.GA24961@elte.hu>
	<20061003103503.GA6350@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 12:35:03 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> add back a mistakenly removed udelay(10) to the PIT initialization
> sequence.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  arch/i386/kernel/i8253.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux/arch/i386/kernel/i8253.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/i8253.c
> +++ linux/arch/i386/kernel/i8253.c
> @@ -45,6 +45,7 @@ static void init_pit_timer(enum clock_ev
>  		outb_p(0x34, PIT_MODE);
>  		udelay(10);
>  		outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
> +		udelay(10);
>  		outb(LATCH >> 8 , PIT_CH0);	/* MSB */
>  		break;
>  

Doesn't help.

> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > yeah, i suspect it works again if you disable:
> > 
> >  CONFIG_X86_UP_APIC=y
> >  CONFIG_X86_UP_IOAPIC=y
> >  CONFIG_X86_LOCAL_APIC=y
> >  CONFIG_X86_IO_APIC=y
> > 
> > as the slowdown has the feeling of a runaway lapic timer irq.
> > 

Disabling IO_APIC doesn't fix the slowdown.

Disabling LOCAL_APIC does fix it.
