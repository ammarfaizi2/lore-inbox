Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266144AbUGIMU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbUGIMU0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 08:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUGIMU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 08:20:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6528 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266144AbUGIMUY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 08:20:24 -0400
Date: Fri, 9 Jul 2004 08:18:22 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Harish K Harshan <harish@amritapuri.amrita.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Interrupt Handling in linux
In-Reply-To: <40916.203.197.150.195.1089366068.squirrel@203.197.150.195>
Message-ID: <Pine.LNX.4.53.0407090808130.919@chaos>
References: <40916.203.197.150.195.1089366068.squirrel@203.197.150.195>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2004, Harish K Harshan wrote:

> Hi.
>
>  Can Interrupt handlers in linux, be interrupted by other running
> processes??? to make it more clear, im developing a driver for and ADC
> card, and would like to know if the CPU can or rather WILL schedule
> wnother running process in the middle of the ISR, when a timer interrupt
> comes in. If thats the case, then we need to use spinlocks or other
> mechanisms in our ISR, right?? im new to this, so if theres something not
> clear, it just just that my understanding of this topic is not very deep.
>
> Harish.
>
>

The usual case is that a hardware interrupt occurs, gets dispatched
by the kernel to the interrupt service routine, and is quickly
executed without interruption.

If you don't design your interrupt service code to be interrupted,
it won't be interrupted. However, another CPU may be executing
so you need to protect critical sections of code, including
your ISR, with spin-locks.

If you design your ISR to be interrupted, generally it will because,
especially on a network, there is always something that needs
interrupt service. There are so-called bottom-half handlers that
can be dispatched by your ISR to finish up what could be done
with interrupts enabled.

If your ADC board requires periodic service at a regular
interval as many do, (perhaps for an IIR filter) you might
think about writing code that executes on a timer queue,
rather than an interrupt.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


