Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272680AbTHKPo7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272729AbTHKPo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:44:59 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:63247 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S272680AbTHKPo4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:44:56 -0400
Date: Mon, 11 Aug 2003 17:44:44 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, andrew.grover@intel.com
Subject: Re: Linux 2.4.22-rc2 : ACPI warning ?
Message-ID: <20030811154444.GA2868@alpha.home.local>
References: <Pine.LNX.4.44.0308081751390.10734-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308081751390.10734-100000@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 05:53:24PM -0300, Marcelo Tosatti wrote:
> 
> Hi, 
> 
> Here goes release candidate 2. 
> 
> It contains yet another bunch of important fixes, detailed below.

Hi Marcelo,

-rc2 seems really fine to me.

But I noticed a strange message at boot time during the PCI IRQ routing through
ACPI, and I'm not sure whether it's an info, a warning or an error :

ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 8d & 1f -> 0d
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PPB_._PRT]
ACPI: Power Resource [PCR0] (off)
ACPI: Power Resource [PCR1] (off)
schedule_task(): keventd has not started
^^^^^^^^^^^^^^^^
=> this one  !!

PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing

And here is the portion of .config related to ACPI. I can send the whole
config too, but that doesn't seem useful to me to pollute LKML for the rest...

# CONFIG_HOTPLUG_PCI_ACPI is not set
# ACPI Support
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_RELAXED_AML=y

Cheers,
Willy

