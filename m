Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTLDU34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 15:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTLDU34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 15:29:56 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:35594 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S262591AbTLDU3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 15:29:52 -0500
Message-ID: <3FCF9D9A.4070202@nishanet.com>
Date: Thu, 04 Dec 2003 15:48:26 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11) - IRQ
 flood related ?
References: <3FCF25F2.6060008@netzentry.com> <1070551149.4063.8.camel@athlonxp.bradney.info> <20031204163243.GA10471@forming> <frodoid.frodo.87vfow33zm.fsf@usenet.frodoid.org> <20031204175548.GB10471@forming> <20031204200208.GA4167@localnet>
In-Reply-To: <20031204200208.GA4167@localnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cheuche+lkml@free.fr wrote:

>Hello,
>
>Along with the lockups already described here, I've noticed an
>unidentified source of interrupts on IRQ7.
>
Have you seen "IRQ7 Disabled" errors?

On my nforce2 mboard(MSI K7N2 MCP2-T) I would
see that err if onboard ethernet was enabled. I haven't gotten
eth to work and I have to disable onboard ethernet. I
had to disable usb for a while, now it just doesn't work
but doesn't cause a problem so I disable it anyway. I
am using a tulip card instead of onboard ethernet. I
disable the parallel port.

This is /proc/interrupts with apic, lapic, onboard eth
disabled, parallel disabled, bios flash, stable with
kernel 2.6.0-test* test11   no irq 7!

 cat /proc/interrupts
           CPU0      
  0:   47830174          XT-PIC  timer
  1:      24026    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:        228    IO-APIC-edge  serial
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     125368    IO-APIC-edge  i8042
 14:         22    IO-APIC-edge  ide0
 15:         24    IO-APIC-edge  ide1
 16:     592751   IO-APIC-level  3ware Storage Controller, yenta, yenta
 17:    1309695   IO-APIC-level  eth0
 21:          0   IO-APIC-level  NVidia nForce2
NMI:          0
LOC:   47829780
ERR:          0
MIS:          4

-Bob

> Several people posted their
>/proc/interrupts but it only shows interrupts a driver registered and is
>using. I noticed a non-constant stream of interrupts on IRQ7 using sar
>and I am also able to see it under /proc/interrupts when loading
>parport_pc with options to get the driver using the interrupt. However
>it is not related to the parallel port because putting it on IRQ5 or
>disabling it in the BIOS does not affect the stream of interrupts on
>IRQ7. I wonder if people experiencing lockup problems also have these
>noise interrupts, and I don't know if this has something to do with the
>lockups or if it is an independant problem.
>
>Of course, booting with noapic nolapic, the system is rock-solid, and
>the interrupt counter on IRQ7 stays solidly at 1 (should it be 0 ?),
>until I use something on the parallel port of course.
>
>Motherboard : abit nfs7-s v2.0, nforce2 chipset
>Kernels : 2.6.0-test9, 2.6.0-test10, 2.6.0-test10-mm1, 2.6.0-test11
>
>/proc/interrupts with apic+lapic, shortly after boot, already 408
>interrupts on IRQ7 :
>           CPU0
>  0:     121148          XT-PIC  timer
>  1:        279    IO-APIC-edge  i8042
>  2:          0          XT-PIC  cascade
>  7:        408    IO-APIC-edge  parport0
>  8:          4    IO-APIC-edge  rtc
>  9:          0   IO-APIC-level  acpi
> 14:       2591    IO-APIC-edge  ide0
> 15:       2916    IO-APIC-edge  ide1
> 16:         47   IO-APIC-level  eth0
> 18:          0   IO-APIC-level  EMU10K1
> 19:       4373   IO-APIC-level  mga@PCI:2:0:0
> 20:         31   IO-APIC-level  ohci-hcd
> 21:          0   IO-APIC-level  ehci_hcd, NVidia nForce2
> 22:          0   IO-APIC-level  ohci-hcd
>NMI:          0
>LOC:     120982
>ERR:          0
>MIS:          0
>
>/proc/interrupts with noapic and nolapic, with IRQ7 showing only 1
>interrupt since boot : 
>           CPU0
>  0:     803521          XT-PIC  timer
>  1:       1446          XT-PIC  i8042
>  2:          0          XT-PIC  cascade
>  5:      54875          XT-PIC  mga@PCI:2:0:0
>  7:          1          XT-PIC  parport0
>  8:          4          XT-PIC  rtc
>  9:          0          XT-PIC  acpi
> 10:      16027          XT-PIC  ohci_hcd,eth0, NVidia nForce2
> 11:    1903732          XT-PIC  bttv0, ehci_hcd, EMU10K1
> 12:       9416          XT-PIC  ohci_hcd
> 14:       8513          XT-PIC  ide0
> 15:       3910          XT-PIC  ide1
>NMI:          0
>LOC:          0
>ERR:          0
>MIS:          0
>
>
>
>Mathieu
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


