Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbUBZTiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbUBZTiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:38:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:13185 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262826AbUBZTgm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:36:42 -0500
Date: Thu, 26 Feb 2004 14:39:34 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Tim Bird <tim.bird@am.sony.com>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why no interrupt priorities?
In-Reply-To: <403E4363.2070908@am.sony.com>
Message-ID: <Pine.LNX.4.53.0402261423170.4239@chaos>
References: <403E4363.2070908@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Tim Bird wrote:

> What's the rationale for not supporting interrupt priorities
> in the kernel?

Interrupt priorities are supported and have been supported
since the first cascaded interrupt controllers and, now
with the APIC. The interrupt priorities are enforced by
hardware. There are no "software interrupt priorities"
because we have more than one interrupt, already prioritized
by the hardware. The basic PC/AT has IRQ0 through IRQ15 interrupt
sources. The IO-APIC code emulates this. The priorites go like this:

Highest priority
  |
IRQ0	PIT channel 0
IRQ1	Keyboard
IRQ2	Cascade to second controller
IRQ8
IRQ9
IRQ10
IRQ11
IRQ12
IRQ13
IRQ14
IRQ15
IRQ3	Serial 1, Serial 3
IRQ4	Serial 0, Serial 2
IRQ5	Floppy disk
IRQ6
IRQ7	Printer
 |
Lowest priority

You can't do software interrupt priorities with hardware interrupt
controllers unless you funnel everything into one master ISR that
ACKs the hardware, then sorts through some priority lists. The
result is an abortion that wastes CPU cycles and throws away
the hardware advantage that you already have.

If you have an architecture that has only one hardware interrupt,
then you have no choice but to impliment some sort of software
priority scheme. This is not what we have on the ix86.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


