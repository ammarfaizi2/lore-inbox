Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbUKNEjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbUKNEjR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 23:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbUKNEjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 23:39:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:64704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261243AbUKNEii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 23:38:38 -0500
Message-ID: <4196E0EB.8050106@osdl.org>
Date: Sat, 13 Nov 2004 20:36:59 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTC Chip and IRQ8 on 2.6.9
References: <Pine.LNX.4.61.0411121145520.14827@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0411121145520.14827@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> 
> I must use the RTC and IRQ8 in a driver being ported from
> 2.4.20 to 2.6.9. When I attempt request_irq(8,...), it
> returns -EBUSY. I have disabled everything in .config
> that has "RTC" in it.
> 
> The RTC interrupt is used to precisely time the sequencing
> of a precision A/D converter. It is mandatory that I use
> it because the precise interval is essential for its
> IIR filter that produces 20 bits of resolution from a
> 16 bit A/D.
> 
>            CPU0
>   0:   60563767    IO-APIC-edge  timer
>   1:      57096    IO-APIC-edge  i8042
>   8:          1    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  12:         66    IO-APIC-edge  i8042
>  14:     112322    IO-APIC-edge  ide0
>  16:          0   IO-APIC-level  uhci_hcd, uhci_hcd
>  18:        640   IO-APIC-level  libata, uhci_hcd, Analogic Corp DLB
>  19:          0   IO-APIC-level  uhci_hcd
>  20:    4894484   IO-APIC-level  eth0
>  21:     110543   IO-APIC-level  aic7xxx
>  23:          0   IO-APIC-level  ehci_hcd
> NMI:          0 LOC:   60565403 ERR:          0
> MIS:          0
> 
> This stuff works fine in 2.4.22 and, in fact, I'm the guy
> that added the global rtc_lock so that this very driver
> could run without interfering with anybody. Now, some code,
> somewhere (not in a module), has allocated the interrupt
> and generated exactly 1 interrupt. The kernel won't let
> me use that interrupt!
> 
> How do I undo this so I can use my hardware on my machine?

I happen to be running a 2.6.9-rc1 kernel right now, with
an IO APIC (P4 UP), and no RTC support built into it,
and /proc/interrupts show IRQ 8 empty/unassigned:

            CPU0
   0:  777037582    IO-APIC-edge  timer
   1:     185323    IO-APIC-edge  i8042
   7:          0    IO-APIC-edge  parport0
   9:          0   IO-APIC-level  acpi
  12:    2838473    IO-APIC-edge  i8042
  14:    1197859    IO-APIC-edge  ide0
  15:         42    IO-APIC-edge  ide1
  17:         49   IO-APIC-level  aic7xxx, ohci_hcd
  19:          0   IO-APIC-level  uhci_hcd
  21:        197   IO-APIC-level  ohci1394, ohci_hcd, ohci_hcd, 
ohci_hcd, ohci_hc
d, ohci_hcd
  22:     832350   IO-APIC-level  ehci_hcd, eth0
  23:      16387   IO-APIC-level  es1371, uhci_hcd
NMI:          0
LOC:  776994543
ERR:          0
MIS:          0


Perhaps your .config and a simple test case would help.

-- 
~Randy
