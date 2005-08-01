Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVHABov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVHABov (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 21:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVHABop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 21:44:45 -0400
Received: from server3.hostingitnow.com ([202.172.233.146]:17573 "EHLO
	mail.hostingitnow.com") by vger.kernel.org with ESMTP
	id S261831AbVHABoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 21:44:07 -0400
Message-ID: <42ED7E59.2010007@holidaymarketing.com>
Date: Mon, 01 Aug 2005 09:43:53 +0800
From: Pedro Pla <pedropla@holidaymarketing.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-smp@vger.kernel.org
Subject: GOT IT WORKING - Problem with SMP and NCCH-DL motherboard
References: <42E5E19E.2090003@holidaymarketing.com> <42E6F56D.3030305@holidaymarketing.com>
In-Reply-To: <42E6F56D.3030305@holidaymarketing.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.142 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In case anyone has the same problem I got it solved. I basically
disabled everything that was on the motherboard such as the promise
sata, sound, usb, etc. It then seemed to work except it choked on
loading the AACRAID driver so I set the pci=usepirqmask and it then got
it. I then tried reenabling USB and it gave the same problem again so I
disabled the USB legacy support and left USB 2.0 on and tried again,
this time it worked. Now why would USB legacy support prevent linux from
detecting the other cpus and make it reboot? Not that I'm too worried
about it but it might be something a kernel hacker might want to look at...

Pedro

Pedro Pla wrote:

>Hi Again,
>
>I've done some further tests disabling hyperthreading which then lets me
>disable apic on the motherboard and when I disable these I can boot a
>kernel compiled with smp, however it boots detecting only 1 cpu rather
>than the 2 on the motherboard. If I then reenable APIC in the bios with
>hyperthreading still disabled it fails in the same way, so the problem
>seems to be with APIC. Any ideas what more I can try?
>
>Thanks in advance!!
>Pedro
>
>Pedro Pla wrote:
>
>  
>
>>Hello,
>>
>>I'm running a system with an Asus NCCH-DL motherboard with dual Nocona
>>Xeon 3.2 GHZ cpu's, when I boot the system with a single cpu kernel with
>>acpi not compiled in it works fine, however when I try to boot a kernel
>>with smp it gives a timeout detecting the cpus and then the machine
>>reboots after I think trying to work out the irq tables, I say I think
>>because it happens so fast that I can barely see what is on the screen
>>before it reboots.
>>
>>I've tried recompiling the kernel with many different options both in
>>and out and the only one that lets me boot is a single cpu without acpi,
>>apic and hpet, I tried googling for similar problems but haven't been
>>able to find anything that applies. I've also tried using an EM64T
>>kernel in case it had to do with the Nocona being incompatible with smp
>>in 32bit mode but that didn't seem to work and gave the same error.
>>
>>Is it a kernel problem or a hardware issue? I tried swapping cpu's in
>>case one was broken but that didn't help, I also tried flashing the bios
>>to the latest one from Asus in case there was some issue with that but
>>no luck either.
>>
>>Also in case this is helpful in locating the problem, when I get it to
>>boot a single cpu 2.6.12.1 kernel without acpi or apic I get the
>>following errors with the PCI:
>>
>>NET: Registered protocol family 16
>>PCI: PCI BIOS revision 2.10 entry at 0xf1d30, last bus=4
>>PCI: Using configuration type 1
>>SCSI subsystem initialized
>>PCI: Probing PCI hardware
>>PCI: Probing PCI hardware (bus 00)
>>PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
>>Boot video device is 0000:01:00.0
>>PCI: Transparent bridge - 0000:00:1e.0
>>PCI: Using IRQ router PIIX/ICH [8086/25a1] at 0000:00:1f.0
>>PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try
>>pci=usepirqmask
>>PCI: Found IRQ 11 for device 0000:00:1f.1
>>PCI: Cannot allocate resource region 0 of device 0000:01:00.0
>>
>>Any ideas or advice would be greatly appreciated.
>>
>>Best regards,
>>Pedro
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>> 
>>
>>    
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

