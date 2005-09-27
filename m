Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVI0GKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVI0GKX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 02:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVI0GKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 02:10:22 -0400
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:64421 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S964823AbVI0GKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 02:10:21 -0400
Date: Mon, 26 Sep 2005 23:16:50 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [RFT][PATCH] i386 per cpu IDT (2.6.12-rc1-mm1)
In-Reply-To: <200509262342_MC3-1-AB3C-C0FF@compuserve.com>
Message-ID: <Pine.LNX.4.61.0509262243500.1684@montezuma.fsmlabs.com>
References: <200509262342_MC3-1-AB3C-C0FF@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chuck,

On Mon, 26 Sep 2005, Chuck Ebbert wrote:

> In-Reply-To: <Pine.LNX.4.61.0509251101060.1684@montezuma.fsmlabs.com>
> > +/* Build the IRQ entry stubs */
> >  vector=0
> > -ENTRY(irq_entries_start)
> > +     .align IRQ_STUB_SIZE,0x90
> > +ENTRY(interrupt)
> >  .rept NR_IRQS
> >       ALIGN     <===================================
> 
>   That ALIGN could cause problems if someone changed default i386 alignment to
> something larger than IRQ_STUB_SIZE.  Why is it there?

Yep, that's dead code and should go.

> > +#define IRQ_STUB_SIZE 16        <=================================
> > +#define NR_IRQ_NODES 1
> >  #define NR_IRQ_VECTORS NR_IRQS
> >  #endif
> >  #endif
> >  
> > +/* number of vectors available for external interrupts in Linux */
> > +#define NR_DEVICE_VECTORS    190
> > +
> >  #endif /* _ASM_IRQ_VECTORS_LIMITS_H */
> 
>  Can't these be 8 bytes when there are only 16 IRQs?

It actually should be constant regardless of IRQ count since it's used to 
provide a 'size' for the code (since it's indexed via C and an array).

>  And is there any way to special-case kernels built with max of two CPUs so there are
> only 24 IRQs allocated?  That seems to be the maximum for that case.

My 2 processor Xeon(HT) has 3 IOAPICs and currently has IRQ48 in use;

           CPU0       CPU1       CPU2       CPU3
  0:   30914980   30909270   30971083   30937399    IO-APIC-edge  timer
  1:      85361      88979      71974     119655    IO-APIC-edge  i8042
  8:      15080      10142      18495      20252    IO-APIC-edge  rtc
  9:          0          0          0          0   IO-APIC-level  acpi
 12:     559735     572493     467452     687913    IO-APIC-edge  i8042
 14:    3921063    2503225     767373    5974789    IO-APIC-edge  ide0
 15:     959112     612792     354578    1413090    IO-APIC-edge  ide1
 16:        657       2755        611       3090   IO-APIC-level  uhci_hcd
 19:    1088213   26750060    1845615       4948   IO-APIC-level  uhci_hcd, eth0
 20:      69658      19831     472397      55840   IO-APIC-level  eth3
 22:     239568     115070      53537     307576   IO-APIC-level  ide2, ide3
 23:      19206      70661      46499     481665   IO-APIC-level  eth4
 24:       1247      99474      43945     517674   IO-APIC-level  eth1
 28:    3950153    1827325    3359121    2111991   IO-APIC-level  EMU10K1
 48:     129473          0     616272      37889   IO-APIC-level  eth2

Thanks for all the feedback, i'll incorporate your suggestions.

	Zwane

