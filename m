Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVCHTJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVCHTJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVCHTJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:09:07 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:16034 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261522AbVCHTIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:08:47 -0500
Date: Tue, 8 Mar 2005 12:09:58 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Francesco Oppedisano <francesco.oppedisano@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: about interrupt latency
In-Reply-To: <875fe4a50503081039328ffede@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503081156360.30824@montezuma.fsmlabs.com>
References: <875fe4a50503081039328ffede@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco,

On Tue, 8 Mar 2005, Francesco Oppedisano wrote:

> i'm trying to estimate the interrupt latency (time between hardware 
> interrrupt and the start of the ISR) of a linux kernel 2.4.29 and i used 
> a simple tecnique: inside the do_timer_interrupt i read the 8259 counter 
> to obtain the elapsed time. By this mean i found a latency of about 6/7 
> microseconds that is very similar to the time measured in some articles 
> but with CPU much slower while i expected the latency was shorter on 
> faster CPUs. So, my questions are: 1)what's the depency between the 
> interrupt latency and the CPU speed? 2)what are the factors at the 
> origin of th interrupt latency?

At some cpu frequency point on i386 the main cause of your interrupt 
service latency will be in the interrupt controller and how long from irq 
assertion to the signal being recognised, resultant vector being 
dispatched to the processor and the necessary interrupt controller 
acknowledge steps required. This is also helped by the fact that the 
Linux/i386 interrupt vector stubs are very small and fast, so there isn't 
all that much code to execute to reach the ISR from the vector table. I'm 
not sure if you've tested this, but you may notice that timer interrupt 
via Local APIC will have lower dispatch latency than timer interrupt via 
i8259 only. But that's all at the lower end of the latency graph, you will 
most likely run into other sources on a busy system.

	Zwane
