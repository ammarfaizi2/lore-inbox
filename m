Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWJTMaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWJTMaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWJTMaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:30:11 -0400
Received: from mta13.adelphia.net ([68.168.78.44]:36010 "EHLO
	mta13.adelphia.net") by vger.kernel.org with ESMTP id S964799AbWJTMaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:30:09 -0400
Message-ID: <4538C152.2000305@Adelphia.net>
Date: Fri, 20 Oct 2006 08:30:10 -0400
From: Dyson <Linux@Adelphia.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Still broken sata (VIA) on Asus A8V (kernel 2.6.14+) with	irqbalance
References: <4534F41A.1030504@Adelphia.net>	 <200610181526.05336.sergio@sergiomb.no-ip.org>	 <4536606F.80606@Adelphia.net> <1161194751.21484.10.camel@localhost.localdomain>
In-Reply-To: <1161194751.21484.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sergio Monteiro Basto wrote:
> On Wed, 2006-10-18 at 13:12 -0400, Dyson wrote:
>   
>> I edited the original 2.6.16 quirks.c to not fixup the IDE bus and
>> still
>> fixup the USB IRQs. 
>>     
>
> Please, send /proc/interrupts to see what interrupt is USB ? 
> if USB interrupt it lower than 15 should try latest patch.  
>
> I think this always the same problem.
> if we don't do the IRQ routing well, the drivers team will workaround,
> when we put IRQ routing well, the workaround will blow it.
>
> thanks,
> --
> Sérgio M. B. 
>
>   

Here is /proc/interrupts after the latest irq quirk fixup patch on
2.6.16.21-0.25 (SuSE 10.1)

            CPU0       CPU1
  0:    4764315    4776891    IO-APIC-edge  timer
  1:       1561       1760    IO-APIC-edge  i8042
  7:          0          2    IO-APIC-edge  parport0
  8:          0          0    IO-APIC-edge  rtc
  9:          0          1   IO-APIC-level  acpi
 12:      19297      16184    IO-APIC-edge  i8042
 14:     340719     349253    IO-APIC-edge  ide0
 15:     238846     223092    IO-APIC-edge  ide1
177:    2190978    2192974   IO-APIC-level  uhci_hcd:usb1,
uhci_hcd:usb2, uhci_hcd:usb3, ehci_hcd:usb4
185:    2887523    2860372   IO-APIC-level  EMU10K1, eth0, nvidia
193:          0          3   IO-APIC-level  ohci1394
201:          0          0   IO-APIC-level  cx88[0]
NMI:      37523      37525
LOC:    9541392    9541212
ERR:          0
MIS:          0

After much more testing I'm thinking it's a hardware problem with the
SATA ports on the motherboard so they are disabled.

I may go back to an older kernel version to see if it still freezes
using USB, IDE and SATA at the same time.

This is the fixup messages I got before the patch:

<6>PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 9
<6>PCI: VIA IRQ fixup for 0000:00:10.0, from 10 to 1
<6>PCI: VIA IRQ fixup for 0000:00:10.1, from 10 to 1
<6>PCI: VIA IRQ fixup for 0000:00:10.2, from 11 to 1

0000:00:10.x are the USB ports.
0000:00:0f.1 is the IDE.

The USB interrupt is the same pre and post patch.

Thanks,

Dyson

