Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbULMO73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbULMO73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 09:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbULMO73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 09:59:29 -0500
Received: from fsmlabs.com ([168.103.115.128]:18892 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261225AbULMO7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 09:59:23 -0500
Date: Mon, 13 Dec 2004 07:59:13 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Dimitris Lampridis <labis@mhl.tuc.gr>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI interrupt lost
In-Reply-To: <1102941933.3415.14.camel@naousa.mhl.tuc.gr>
Message-ID: <Pine.LNX.4.61.0412130755290.22212@montezuma.fsmlabs.com>
References: <1102941933.3415.14.camel@naousa.mhl.tuc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Dimitris Lampridis wrote:

> I'm writing a device driver for an embedded USB controller (philips
> ISP116x). I'm using the evaluation board provided by philips for my
> work. This board is a PCI board featuring the Host Controller ISP1160
> and a PCI bridge by PLX.
> 
> The bad news (for me) is that I don't get to see any interrupts from my
> device. 
> 
> The good news is that I've managed to narrow down the problem. Here is
> my case:
> 1) The Host Controller is configured and operating and is producing
> interrupts (I used a logic Analyzer and saw it happening).
> 2) The driver never services these interrupts. The exact behaviour is
> dictated by the "trigger" setting of the INT pin. If it is
> edge-triggered, the interrupts keep on coming from the HC. If it is
> level-triggered, only one interrupt happens and since it is never
> serviced, it keeps on forever, blocking any further signals.
> 3) The driver IS ABLE to service interrupts. The ISR is installed and
> functioning (I was able to see that, when the device was sharing the IRQ
> and the ISR was called only to return IRQ_NONE, nevertheless showing
> that IF an interrupt was to be received, coming from the Host
> Controller, the routine would be called, thus clearing the interrupt on
> the controller).
> 
> So, to make things short, my device is generating interrupts, my code
> has a functioning and registered interrupt routine (/proc/interrupts
> agrees as well but interrupt count is 0 for the specific IRQ), but no
> interrupt is ever received from the PCI card.

What does the PCI device report as the interrupt line? What do you 
register with request_irq?

	Zwane

Ps. Isn't there already a driver for that controller?

