Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVCIOpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVCIOpl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 09:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVCIOpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 09:45:40 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:6456 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261768AbVCIOnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 09:43:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YGp55ISMdFcWUEmLL0J8hVawqAPv+NVNP5tlqzKIW51qtbc8SibLSO0pFOiU+gyfEbwIqsqRar378MAJ1BEYXEYZZ8EN9XnjBZPOtKJFifawjZnlqeoqeM7mVWhurHTBxD7BuX+JxoWsImhXxskcj1xORercpl1QzVPE2Ht5MwA=
Message-ID: <875fe4a505030906438a76cb5@mail.gmail.com>
Date: Wed, 9 Mar 2005 14:43:15 +0000
From: Francesco Oppedisano <francesco.oppedisano@gmail.com>
Reply-To: Francesco Oppedisano <francesco.oppedisano@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: about interrupt latency
In-Reply-To: <Pine.LNX.4.61.0503081156360.30824@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <875fe4a50503081039328ffede@mail.gmail.com>
	 <Pine.LNX.4.61.0503081156360.30824@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 12:09:58 -0700 (MST), Zwane Mwaikambo
<zwane@arm.linux.org.uk> wrote:

> At some cpu frequency point on i386 the main cause of your interrupt
> service latency will be in the interrupt controller and how long from irq
> assertion to the signal being recognised, resultant vector being
> dispatched to the processor and the necessary interrupt controller
> acknowledge steps required. This is also helped by the fact that the
> Linux/i386 interrupt vector stubs are very small and fast, so there isn't
> all that much code to execute to reach the ISR from the vector table. I'm
> not sure if you've tested this, but you may notice that timer interrupt
> via Local APIC will have lower dispatch latency than timer interrupt via
> i8259 only. But that's all at the lower end of the latency graph, you will
> most likely run into other sources on a busy system.
> 
>         Zwane
> 
Very interesting zwane....i haven't tested the local APIC....do you
think this dispatch time can vary with the system I/O load (many
pending interrupts in the PIC)?

I think the interrupt latency is influenced even by the code inside
the kernel: if a lot of code is running with interrupts disabled then
the interrupt latency will grow. Am i right?

So probably we can state that the factors influencing the interrupt latency are:
1)Dispatching time in the PIC 
2)Waiting time on the PIC (if there are pending interrupt of lower vector)
3)fetching ISR from main memory
4)wait time when CPU is running with disabled interrupt

Do U agree?

Thank u very much
Francesco Oppedisano
