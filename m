Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRCKUIF>; Sun, 11 Mar 2001 15:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbRCKUH4>; Sun, 11 Mar 2001 15:07:56 -0500
Received: from front5.grolier.fr ([194.158.96.55]:44506 "EHLO
	front5.grolier.fr") by vger.kernel.org with ESMTP
	id <S129115AbRCKUHj> convert rfc822-to-8bit; Sun, 11 Mar 2001 15:07:39 -0500
Date: Sun, 11 Mar 2001 18:56:18 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: John William <jw2357@hotmail.com>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: HP Vectra XU 5/90 interrupt problems
In-Reply-To: <F61uN6tdqVvPdLFYxc900008c66@hotmail.com>
Message-ID: <Pine.LNX.4.10.10103111834120.468-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Mar 2001, John William wrote:

> If shared, edge triggered interrupts are ok then I will talk to the driver 
> maintainers about the problem. If this isn't ok, then maybe the sanity check 
> in pci-irq.c would be to force level triggering only on shared PCI 
> interrupts?

DEFINITELY NO!

Given a PCI device + driver pair, level triggerred interrupt may be 
required for them to work properly, even when the line is not shared.
Anyway, it is a requirement. OTOH, the PCI device must know how to 
trigger the interrupt.

Edge triggerred interrupts cannot be shared. Level triggerred (level
sensitive is a better wording, in my opinion) can be shared.

Even when it is not shared (as it is required), an edge triggerred
interrupt can be lost by the driver. Using level sensitive interrupt let
the interrupt condition active as long as the condition is present at, at
least, one device that wants to interrupt the CPU.

Apart sharing of interrupt lines, level sensitive interrupt allows the
device firmware to run concurrently to the CPU (software driver) without
losing interrupt condition, providing that both driver and firmware use
appropriate barriers against buffering in the bridge.
In the same situation, using edge triggerred interrupt (not shared) can
lead to interrupt condition being lost by the software driver.

  Gérard.

