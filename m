Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVDANlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVDANlq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 08:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVDANlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 08:41:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44756 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262650AbVDANlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 08:41:44 -0500
Date: Fri, 1 Apr 2005 15:41:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: kus Kusche Klaus <kus@keba.com>
Cc: stern@rowland.harvard.edu, linux-usb-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11, USB: High latency?
Message-ID: <20050401134127.GA4992@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F3673231DB@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231DB@MAILIT.keba.co.at>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* kus Kusche Klaus <kus@keba.com> wrote:

>    IRQ 7-724   0d..1    1us : end_8259A_irq (do_hardirq)
>    IRQ 7-724   0d..1    1us!: enable_8259A_irq (do_hardirq)
>    IRQ 7-724   0d...  832us : do_hardirq (do_irqd)
>    IRQ 7-724   0d...  833us : trace_irqs_on (do_hardirq)

>     mmap-1000  0d.h1   21us : end_8259A_irq (__do_IRQ)
>     mmap-1000  0d.h1   22us!: enable_8259A_irq (__do_IRQ)
>     mmap-1000  0d.h.  662us : irq_exit (do_IRQ)
>     mmap-1000  0d..1  662us : do_softirq (irq_exit)

>     mmap-1000  0d.h.    0us : do_IRQ (c012d6d5 7 0)
>     mmap-1000  0d.h1    2us!: mask_and_ack_8259A (__do_IRQ)
>     mmap-1000  0d.h1  938us : redirect_hardirq (__do_IRQ)
>     mmap-1000  0d.h1  939us : wake_up_process (redirect_hardirq)

such 'freezes' almost certainly signal some sort of hardware latency - 
some device holding the system bus up during DMA. There is no 
algorithmic reason for any of those steps above to take several hundreds 
of microseconds.

	Ingo
