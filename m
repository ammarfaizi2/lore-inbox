Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbUKNO0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbUKNO0F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 09:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbUKNO0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 09:26:05 -0500
Received: from alog0162.analogic.com ([208.224.220.177]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261310AbUKNOZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 09:25:54 -0500
Date: Sun, 14 Nov 2004 09:25:09 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTC Chip and IRQ8 on 2.6.9
In-Reply-To: <4196E0EB.8050106@osdl.org>
Message-ID: <Pine.LNX.4.61.0411140921500.13939@chaos.analogic.com>
References: <Pine.LNX.4.61.0411121145520.14827@chaos.analogic.com>
 <4196E0EB.8050106@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2004, Randy.Dunlap wrote:

> linux-os wrote:
>> 
>> I must use the RTC and IRQ8 in a driver being ported from
>> 2.4.20 to 2.6.9. When I attempt request_irq(8,...), it
>> returns -EBUSY. I have disabled everything in .config
>> that has "RTC" in it.
>> 
>> The RTC interrupt is used to precisely time the sequencing
>> of a precision A/D converter. It is mandatory that I use
>> it because the precise interval is essential for its
>> IIR filter that produces 20 bits of resolution from a
>> 16 bit A/D.
>> 
>>            CPU0
>>   0:   60563767    IO-APIC-edge  timer
>>   1:      57096    IO-APIC-edge  i8042
>>   8:          1    IO-APIC-edge  rtc
>>   9:          0   IO-APIC-level  acpi
>>  12:         66    IO-APIC-edge  i8042
>>  14:     112322    IO-APIC-edge  ide0
>>  16:          0   IO-APIC-level  uhci_hcd, uhci_hcd
>>  18:        640   IO-APIC-level  libata, uhci_hcd, Analogic Corp DLB
>>  19:          0   IO-APIC-level  uhci_hcd
>>  20:    4894484   IO-APIC-level  eth0
>>  21:     110543   IO-APIC-level  aic7xxx
>>  23:          0   IO-APIC-level  ehci_hcd
>> NMI:          0 LOC:   60565403 ERR:          0
>> MIS:          0
>> 
>> This stuff works fine in 2.4.22 and, in fact, I'm the guy
>> that added the global rtc_lock so that this very driver
>> could run without interfering with anybody. Now, some code,
>> somewhere (not in a module), has allocated the interrupt
>> and generated exactly 1 interrupt. The kernel won't let
>> me use that interrupt!
>> 
>> How do I undo this so I can use my hardware on my machine?
>
> I happen to be running a 2.6.9-rc1 kernel right now, with
> an IO APIC (P4 UP), and no RTC support built into it,
> and /proc/interrupts show IRQ 8 empty/unassigned:
>
>           CPU0
>  0:  777037582    IO-APIC-edge  timer
>  1:     185323    IO-APIC-edge  i8042
>  7:          0    IO-APIC-edge  parport0
>  9:          0   IO-APIC-level  acpi
> 12:    2838473    IO-APIC-edge  i8042
> 14:    1197859    IO-APIC-edge  ide0
> 15:         42    IO-APIC-edge  ide1
> 17:         49   IO-APIC-level  aic7xxx, ohci_hcd
> 19:          0   IO-APIC-level  uhci_hcd
> 21:        197   IO-APIC-level  ohci1394, ohci_hcd, ohci_hcd, ohci_hcd, 
> ohci_hc
> d, ohci_hcd
> 22:     832350   IO-APIC-level  ehci_hcd, eth0
> 23:      16387   IO-APIC-level  es1371, uhci_hcd
> NMI:          0
> LOC:  776994543
> ERR:          0
> MIS:          0
>
>
> Perhaps your .config and a simple test case would help.

Yep. The .config needed to set up RTC as a module so that
I could unload it (seriously) in order to free it up.

Otherwise the built-in RTC software grabbed IRQ8 even though
it never used it.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
