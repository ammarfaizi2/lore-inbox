Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWGaAdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWGaAdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWGaAdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:33:15 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:16116 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932491AbWGaAdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:33:14 -0400
Subject: Re: FP in kernelspace
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <44CC97A4.8050207@gmail.com>
References: <44CC97A4.8050207@gmail.com>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 20:33:09 -0400
Message-Id: <1154305989.10074.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 13:27 +0159, Jiri Slaby wrote:
> Hello,
> 
> I have a driver written for 2.4 + RT patches with FP support. I want it to work 
> in 2.6. How to implement FP? Has anybody developped some "protocol" between KS 
> and US yet? If not, could somebody point me, how to do it the best -- with low 
> latency.
> The device doesn't generate irqs *), I need to quickly respond to timer call, 
> because interval between two posts of data to the device has to be equal as much 
> as possible (BTW is there any way how to gain up to 5000Hz).
> I've one idea: have a thread with RT priority and wake the app in US waiting in 
> read of character device when timer ticks, post a struct with 2 floats and 
> operation and wait in write for the result. App computes, writes the result, we 
> are woken and can post it to the device. But I'm afraid it would be tooo slow.
> 
> *) I don't know how to persuade it (standard PLX chip with unknown piece of 
> logic behind) to generate, because official driver is closed and _very_ 
> expensive. Old (2.4) driver was implemented with RT thread and timer, where FP 
> is implemented within RT and computed directly in KS.
> 
> So 2 questions are:
> 1) howto FP in kernel
> 2) howto precise timer (may mingo RT patches help?)

Well Ingo's RT patch set has the high resolution timers developed by
Thomas Gleixner, which may help you here.

> 3) any way to have faster ticks (up to 5000Hz)?

Why do you need faster ticks?  The high res timers are done in nano
secs, and the resolution is up to the hardware.

> 
> Any suggestions, please?

--  Steve


