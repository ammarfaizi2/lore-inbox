Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVADTCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVADTCY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVADTCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:02:23 -0500
Received: from alog0168.analogic.com ([208.224.220.183]:3712 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261825AbVADTCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:02:00 -0500
Date: Tue, 4 Jan 2005 13:53:00 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: aryix <aryix@softhome.net>, lug-list@lugmen.org.ar,
       linux-kernel@vger.kernel.org
Subject: Re: dmesg: PCI interrupts are no longer routed automatically.........
In-Reply-To: <1104862721.1846.49.camel@eeyore>
Message-ID: <Pine.LNX.4.61.0501041342070.5445@chaos.analogic.com>
References: <20041229095559.5ebfc4d4@sophia> <1104862721.1846.49.camel@eeyore>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Bjorn Helgaas wrote:

> Do you have a device that doesn't work unless you specify
> "pci=routeirq"?
>
> If all your devices work, you can ignore the note in dmesg.
>
> -

I note that pci_enable_device() needs to be executed __before__
the IRQ is obtained on 2.6.10, otherwise you get the wrong IRQ
(IRQ10 on this system)B.

This doesn't seem to be correct since the IRQ connection was set
by the BIOS and certainly shouldn't be changed. On this system,
interrupts that were not shared on 2.4.n and early 2.6.n end
up being shared... See IRQ18 below.

            CPU0
   0:    1135520    IO-APIC-edge  timer
   1:       3203    IO-APIC-edge  i8042
   7:          0    IO-APIC-edge  parport0
   8:          1    IO-APIC-edge  rtc
   9:          0   IO-APIC-level  acpi
  12:         66    IO-APIC-edge  i8042
  14:      10637    IO-APIC-edge  ide0
  16:          0   IO-APIC-level  uhci_hcd, uhci_hcd
  18:         81   IO-APIC-level  libata, uhci_hcd, Analogic Corp DLB
  19:          0   IO-APIC-level  uhci_hcd
  20:        801   IO-APIC-level  eth0
  21:        982   IO-APIC-level  aic7xxx
  23:          0   IO-APIC-level  ehci_hcd
NMI:          0 
LOC:    1135484 
ERR:          0
MIS:          0

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
