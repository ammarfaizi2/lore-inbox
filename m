Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVDDIEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVDDIEM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVDDIEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:04:12 -0400
Received: from general.keba.co.at ([193.154.24.243]:33199 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261162AbVDDIED convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:04:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.11, USB: High latency?
Date: Mon, 4 Apr 2005 10:03:59 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231DD@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.11, USB: High latency?
Thread-Index: AcU2wIqTikKq5rSqTtO1+r7+67pooQCKpNMg
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <stern@rowland.harvard.edu>, <linux-usb-users@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * kus Kusche Klaus <kus@keba.com> wrote:
> >    IRQ 7-724   0d..1    1us : end_8259A_irq (do_hardirq)
> >    IRQ 7-724   0d..1    1us!: enable_8259A_irq (do_hardirq)
> >    IRQ 7-724   0d...  832us : do_hardirq (do_irqd)
> >    IRQ 7-724   0d...  833us : trace_irqs_on (do_hardirq)
> 
> >     mmap-1000  0d.h1   21us : end_8259A_irq (__do_IRQ)
> >     mmap-1000  0d.h1   22us!: enable_8259A_irq (__do_IRQ)
> >     mmap-1000  0d.h.  662us : irq_exit (do_IRQ)
> >     mmap-1000  0d..1  662us : do_softirq (irq_exit)
> 
> >     mmap-1000  0d.h.    0us : do_IRQ (c012d6d5 7 0)
> >     mmap-1000  0d.h1    2us!: mask_and_ack_8259A (__do_IRQ)
> >     mmap-1000  0d.h1  938us : redirect_hardirq (__do_IRQ)
> >     mmap-1000  0d.h1  939us : wake_up_process (redirect_hardirq)
> 
> such 'freezes' almost certainly signal some sort of hardware 
> latency - 
> some device holding the system bus up during DMA. There is no 
> algorithmic reason for any of those steps above to take 
> several hundreds 
> of microseconds.
> 
> 	Ingo

I asked our hardware team. The hardware has two devices which are
in use and capable of busmaster/DMA transfers: 
The intel e100 ethernet controller and the intel PIIX4 USB 
controller. 
The IDE interface is also a busmaster, but there are only PIO IDE
devices.

I suspect the latter, as USB reads were running in parallel...
How many bytes are transferred at most by the USB controller 
for a single request? How long may this take?

Any experiences / opinitions / advices?

Moreover, we know from experience that the "WBINDV" instruction
(Write back and invalidate CPU cache) can cause such latencies. 

Does this instruction occur anywhere in Linux?

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-8919
E-Mail: kus@keba.com                                WWW: www.keba.com
