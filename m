Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbTLOLlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 06:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTLOLlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 06:41:20 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:10513 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263513AbTLOLlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 06:41:03 -0500
Message-ID: <3FDD9DD1.8000409@nishanet.com>
Date: Mon, 15 Dec 2003 06:41:05 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
References: <200312140407.28580.ross@datscreative.com.au>
In-Reply-To: <200312140407.28580.ross@datscreative.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:

>It also reports its existence on boot if used. e.g.
>
>..APIC TIMER ack delay, reload:16701, safe:16691
>
>And if  
>
>#define APIC_DEBUG 0
>
>is set to 1 in 
>
>/usr/src/linux-2.4.23-rd2/include/asm-i386/apic.h
>  
>
I'm trying the two new patches with 2.6 and my Award
bios which fixes the crash problem itself but didn't turn
on edge timer without a patch, and didn't turn on
nmi_watchdog=1 with the first patch, only =2.

nmi_watchdog gets a lot more ticks with =1, too.

bob@where  cat /proc/interrupts
           CPU0      
  0:     924534    IO-APIC-edge  timer
  1:       1070    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:      14077    IO-APIC-edge  i8042
 14:         10    IO-APIC-edge  ide0
 15:         10    IO-APIC-edge  ide1
 16:      44086   IO-APIC-level  ide2, ide3, eth0
 17:          0   IO-APIC-level  yenta, yenta
 19:      35570   IO-APIC-level  ide4, ide5
 21:          0   IO-APIC-level  NVidia nForce2
NMI:     924555
LOC:     924432
ERR:          0
MIS:         22

I stayed with 600UL 100ndelay just to see if anything
breaks with amd XP3000+ and patches with a bios
that doesn't crash with nforce2 but needs help from
patches on other points(to get edge timer on and
to use nmi_watchdog=1 rather than =2). Also hope
we get a clue about what Award bios update does
that Phoenix does not do so far.

/usr/src/kernel-source-2.6.0/include/asm-i386/apic.h
#define APIC_DEBUG 1

...but I don't see any

calibrating APIC timer ...
..... CPU clock speed is 2079.0146 MHz.
..... host bus clock speed is 332.0663 MHz.
NET: Registered protocol family 16
..APIC TIMER ack delay, reload:20791, safe:20779
..APIC TIMER ack delay, predelay count: 20769

etc

in the area of "NET: Registered" I see the following--

Dec 15 05:34:30 where kernel: PCI: Setting latency timer of device 
0000:00:06.0 to 64
Dec 15 05:34:30 where kernel: intel8x0: clocking to 47414
Dec 15 05:34:30 where kernel: ALSA device list:
Dec 15 05:34:30 where kernel:   #0: Dummy 1
Dec 15 05:34:30 where kernel:   #1: Virtual MIDI Card 1
Dec 15 05:34:30 where kernel:   #2: NVidia nForce2 at 0xe5080000, irq 21
Dec 15 05:34:30 where kernel: NET: Registered protocol family 2
Dec 15 05:34:30 where kernel: IP: routing cache hash table of 8192 
buckets, 64Kbytes
Dec 15 05:34:30 where kernel: TCP: Hash tables configured (established 
262144 bind 65536)
Dec 15 05:34:30 where kernel: ip_conntrack version 2.1 (8191 buckets, 
65528 max) - 296 bytes per conntrack
Dec 15 05:34:30 where kernel: ip_tables: (C) 2000-2002 Netfilter core team
Dec 15 05:34:30 where kernel: ipt_recent v0.3.1: Stephen Frost 
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_rece
nt/
Dec 15 05:34:30 where kernel: NET: Registered protocol family 1
Dec 15 05:34:30 where kernel: NET: Registered protocol family 17
Dec 15 05:34:30 where kernel: BIOS EDD facility v0.10 2003-Oct-11, 4 
devices found
Dec 15 05:34:30 where kernel: Please report your BIOS at 
http://domsch.com/linux/edd30/results.html
Dec 15 05:34:30 where kernel: md: Autodetecting RAID arrays.

Dec 15 05:34:30 where kernel: NFORCE2: chipset revision 162

log starts with this acpi stuff--

Dec 15 05:34:30 where kernel: klogd 1.4.1#10, log source = /proc/kmsg 
started.
Dec 15 05:34:30 where kernel: Inspecting /boot/System.map-2.6.0.nf2
Dec 15 05:34:30 where kernel: Loaded 33440 symbols from 
/boot/System.map-2.6.0.nf2.
Dec 15 05:34:30 where kernel: Symbols match kernel version 2.6.0.
Dec 15 05:34:30 where kernel: No module symbols loaded - kernel modules 
not enabled.
Dec 15 05:34:30 where kernel: IRQs 3 4 *5 6 7 10 11 12 14 15)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 
5 6 7 10 11 12 14 15)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 
5 6 7 10 11 12 14 15)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 
5 6 7 10 11 12 14 15)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APC1] (IRQs *16)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APC2] (IRQs *17)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APC3] (IRQs *18)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APC4] (IRQs *19)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APC5] (IRQs 16)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCF] (IRQs 20 
21 22)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCG] (IRQs 20 
21 22)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCH] (IRQs 20 
21 22)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCI] (IRQs 20 
21 22)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCJ] (IRQs 20 
21 22)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCK] (IRQs 20 
21 22)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCS] (IRQs *23)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCL] (IRQs 20 
21 22)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCM] (IRQs 20 
21 22)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [AP3C] (IRQs 20 
21 22)
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCZ] (IRQs 20 
21 22)
Dec 15 05:34:30 where kernel: Linux Plug and Play Support v0.97 (c) Adam 
Belay
Dec 15 05:34:30 where kernel: pnp: the driver 'system' has been registered
Dec 15 05:34:30 where kernel: PnPBIOS: Scanning system for PnP BIOS 
support...
Dec 15 05:34:30 where kernel: PnPBIOS: Found PnP BIOS installation 
structure at 0xc00fc660
Dec 15 05:34:30 where kernel: PnPBIOS: PnP BIOS version 1.0, entry 
0xf0000:0xc690, dseg 0xf0000
Dec 15 05:34:30 where kernel: pnp: match found with the PnP device 
'00:07' and the driver 'system'
Dec 15 05:34:30 where kernel: pnp: match found with the PnP device 
'00:08' and the driver 'system'
Dec 15 05:34:30 where kernel: PnPBIOS: 13 nodes reported by PnP BIOS; 13 
recorded by driver
Dec 15 05:34:30 where kernel: SCSI subsystem initialized
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCS] enabled at 
IRQ 23
Dec 15 05:34:30 where kernel: IOAPIC[0]: Set PCI routing entry (2-23 -> 
0xa9 -> IRQ 23 Mode:1 Active:0)
Dec 15 05:34:30 where kernel: 00:00:01[A] -> 2-23 -> IRQ 23
Dec 15 05:34:30 where kernel: Pin 2-23 already programmed
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCF] enabled at 
IRQ 20
Dec 15 05:34:30 where kernel: IOAPIC[0]: Set PCI routing entry (2-20 -> 
0xb1 -> IRQ 20 Mode:1 Active:0)
Dec 15 05:34:30 where kernel: 00:00:02[A] -> 2-20 -> IRQ 20
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCG] enabled at 
IRQ 22
Dec 15 05:34:30 where kernel: IOAPIC[0]: Set PCI routing entry (2-22 -> 
0xb9 -> IRQ 22 Mode:1 Active:0)
Dec 15 05:34:30 where kernel: 00:00:02[B] -> 2-22 -> IRQ 22
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCL] enabled at 
IRQ 21
Dec 15 05:34:30 where kernel: IOAPIC[0]: Set PCI routing entry (2-21 -> 
0xc1 -> IRQ 21 Mode:1 Active:0)
Dec 15 05:34:30 where kernel: 00:00:02[C] -> 2-21 -> IRQ 21
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCH] enabled at 
IRQ 20
Dec 15 05:34:30 where kernel: Pin 2-20 already programmed
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCI] enabled at 
IRQ 22
Dec 15 05:34:30 where kernel: Pin 2-22 already programmed
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCJ] enabled at 
IRQ 21
Dec 15 05:34:30 where kernel: Pin 2-21 already programmed
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCK] enabled at 
IRQ 20
Dec 15 05:34:30 where kernel: Pin 2-20 already programmed
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCM] enabled at 
IRQ 22
Dec 15 05:34:30 where kernel: Pin 2-22 already programmed
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [AP3C] enabled at 
IRQ 21
Dec 15 05:34:30 where kernel: Pin 2-21 already programmed
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APCZ] enabled at 
IRQ 20
Dec 15 05:34:30 where kernel: Pin 2-20 already programmed
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APC4] enabled at 
IRQ 19
Dec 15 05:34:30 where kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 
0xc9 -> IRQ 19 Mode:1 Active:0)
Dec 15 05:34:30 where kernel: 00:01:06[A] -> 2-19 -> IRQ 19
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APC1] enabled at 
IRQ 16
Dec 15 05:34:30 where kernel: IOAPIC[0]: Set PCI routing entry (2-16 -> 
0xd1 -> IRQ 16 Mode:1 Active:0)
Dec 15 05:34:30 where kernel: 00:01:06[B] -> 2-16 -> IRQ 16
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APC2] enabled at 
IRQ 17
Dec 15 05:34:30 where kernel: IOAPIC[0]: Set PCI routing entry (2-17 -> 
0xd9 -> IRQ 17 Mode:1 Active:0)
Dec 15 05:34:30 where kernel: 00:01:06[C] -> 2-17 -> IRQ 17
Dec 15 05:34:30 where kernel: ACPI: PCI Interrupt Link [APC3] enabled at 
IRQ 18
Dec 15 05:34:30 where kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 
0xe1 -> IRQ 18 Mode:1 Active:0)
Dec 15 05:34:30 where kernel: 00:01:06[D] -> 2-18 -> IRQ 18
Dec 15 05:34:30 where kernel: Pin 2-16 already programmed
Dec 15 05:34:30 where kernel: Pin 2-17 already programmed
Dec 15 05:34:30 where kernel: Pin 2-18 already programmed
Dec 15 05:34:30 where kernel: Pin 2-19 already programmed
Dec 15 05:34:30 where kernel: Pin 2-17 already programmed
Dec 15 05:34:30 where kernel: Pin 2-18 already programmed
Dec 15 05:34:30 where kernel: Pin 2-19 already programmed
Dec 15 05:34:30 where kernel: Pin 2-16 already programmed
Dec 15 05:34:30 where kernel: Pin 2-19 already programmed
Dec 15 05:34:30 where kernel: Pin 2-16 already programmed
Dec 15 05:34:30 where kernel: Pin 2-17 already programmed
Dec 15 05:34:30 where kernel: Pin 2-18 already programmed
Dec 15 05:34:30 where kernel: Pin 2-16 already programmed
Dec 15 05:34:30 where kernel: Pin 2-17 already programmed
Dec 15 05:34:30 where kernel: Pin 2-18 already programmed
Dec 15 05:34:30 where kernel: Pin 2-19 already programmed
Dec 15 05:34:30 where kernel: Pin 2-18 already programmed
Dec 15 05:34:30 where last message repeated 3 times
Dec 15 05:34:30 where kernel: Pin 2-19 already programmed
Dec 15 05:34:30 where kernel: PCI: Using ACPI for IRQ routing


