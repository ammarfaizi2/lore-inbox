Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424420AbWKPTn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424420AbWKPTn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 14:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424424AbWKPTn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 14:43:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:23250 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424383AbWKPTn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 14:43:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cF30aQ4QArcAGFYz4U9gLZKwyR2Ebeg3h38/rxq3IDyGchSpkLzS5k9TEpJt+uGv+8DSvLsYDArrP0JzptlYC3nfAyVXrFSD1XVUHsBT3n+cspOYZqh03c2b4xa9RtBM8AcawGXD80YEoelh875soy2ILIY0uvneEOAtiHYh/oM=
Message-ID: <4807377b0611161143m565f96e2g2bf2028347012ed5@mail.gmail.com>
Date: Thu, 16 Nov 2006 11:43:56 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Krzysztof Sierota" <Krzysztof.Sierota@firma.o2.pl>
Subject: Re: 2.6.19-rc6: irq 48: nobody cared
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <200611161629.45149.Krzysztof.Sierota@firma.o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611161629.45149.Krzysztof.Sierota@firma.o2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/06, Krzysztof Sierota <Krzysztof.Sierota@firma.o2.pl> wrote:
> Hi,
>
> I'm getting the following in dmesg with 2.6.19-rc5 and 2.6.19-rc6 kernels quad
> opteron server running 64bit kernel, and the network card gets disabled.
>
> On identical server running 32bit kernel, same cards, same slots, same
> configuration running rc5 I see no errors.
>
> irq 48: nobody cared (try booting with the "irqpoll" option)

its an e1000 adapter on irq 48

>  41:        579          0          0          0   IO-APIC-fasteoi   eth2
>  42:       1482          0          0          0   IO-APIC-fasteoi   eth3
>  47:      36323          0          0          0   IO-APIC-fasteoi   eth4
>  48:      99905         10         83          2   IO-APIC-fasteoi   eth5

got quite a few interrupts considering there are no link events in
your logs for eth4 or eth5

> ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 4, address 0xfec00000, GSI 0-23
> ACPI: IOAPIC (id[0x09] address[0xfeafe000] gsi_base[40])
> IOAPIC[1]: apic_id 9, address 0xfeafe000, GSI 40-46
> ACPI: IOAPIC (id[0x0a] address[0xfeaff000] gsi_base[47])
> IOAPIC[2]: apic_id 10, address 0xfeaff000, GSI 47-53

um, GSI 48 is the only interrupt using IOAPIC[2], could that be related?

> Intel(R) PRO/1000 Network Driver - version 7.2.9-k4-NAPI
> Copyright (c) 1999-2006 Intel Corporation.
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 19
> ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKD] -> GSI 19 (level, low) ->
> IRQ 19
> PCI: Setting latency timer of device 0000:02:00.0 to 64
> e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:32-bit)
> 00:15:17:0b:82:13
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 18
> ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKC] -> GSI 18 (level, low) ->
> IRQ 18
> PCI: Setting latency timer of device 0000:01:00.0 to 64
> e1000: 0000:01:00.0: e1000_probe: (PCI Express:2.5Gb/s:32-bit)
> 00:15:17:0b:81:ae
> e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
> ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 41 (level, low) -> IRQ 41
> e1000: 0000:06:02.0: e1000_probe: (PCI-X:100MHz:64-bit) 00:04:23:b0:6b:6e
> e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
> ACPI: PCI Interrupt 0000:06:02.1[B] -> GSI 42 (level, low) -> IRQ 42
> e1000: 0000:06:02.1: e1000_probe: (PCI-X:100MHz:64-bit) 00:04:23:b0:6b:6f
> e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
> ACPI: PCI Interrupt 0000:05:03.0[A] -> GSI 47 (level, low) -> IRQ 47
> e1000: 0000:05:03.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:30:48:57:3e:a0
> e1000: eth4: e1000_probe: Intel(R) PRO/1000 Network Connection
> ACPI: PCI Interrupt 0000:05:03.1[B] -> GSI 48 (level, low) -> IRQ 48
> e1000: 0000:05:03.1: e1000_probe: (PCI-X:133MHz:64-bit) 00:30:48:57:3e:a1
> e1000: eth5: e1000_probe: Intel(R) PRO/1000 Network Connection

how come you aren't bringing the interfaces up?  At least I don't see
any link messages. We request the IRQ only at open.  Something else is
causing interrupts on the e1000 devices' lines.

I suspect the IOAPIC code or ACPI code.

Jesse
