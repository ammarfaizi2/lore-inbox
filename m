Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263755AbUDMVSp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 17:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263757AbUDMVSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 17:18:42 -0400
Received: from Makaera.com ([199.202.113.33]:24588 "EHLO Soo.com")
	by vger.kernel.org with ESMTP id S263755AbUDMVSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 17:18:30 -0400
Date: Tue, 13 Apr 2004 17:18:24 -0400
From: really bensoo_at_soo_dot_com <lnx-kern@soo.com>
To: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2
Message-ID: <20040413211824.GA12636@Sophia.soo.com>
Mail-Followup-To: Ross Dickson <ross@datscreative.com.au>,
	linux-kernel@vger.kernel.org
References: <200404131117.31306.ross@datscreative.com.au> <20040413040145.GA3327@Sophia.soo.com> <200404131455.52195.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404131455.52195.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 02:55:52PM +1000, Ross Dickson wrote:
> Are you using my io-apic patch with the apic ack delay or with the
> C1idle version?
> i.e. patched io_apic.c and apic.c and using kernel arg "apic_tack="
> or patched io_apic.c and process.c and using kernel arg "idle=C1halt"?

i'm using your C1idle patches:

nforce2-idleC1halt-rd-2.6.3.patch
nforce2-ioapic-rd-2.6.3.patch

cat /proc/cmdline
BOOT_IMAGE=linux-test ro root=305 idebus=33 acpi=on idle=C1halt

> Could you please cat /proc/interrupts.
> I would like to see how irq0 is routed.

My irq0 says XT-PIC.  i'm not complaining, box's still
very stable and since the last post i've burned a few
DVDs on it while running the file share client and
playing music.

cat /proc/interrupts

           CPU0       
  0:  759809583          XT-PIC  timer
  1:     382279    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:    6386931    IO-APIC-edge  i8042
 14:    2117474    IO-APIC-edge  ide0
 15:    5575006    IO-APIC-edge  ide1
201:    6425958   IO-APIC-level  EMU10K1
209:  167929203   IO-APIC-level  eth0
NMI:          0 
LOC:  759718637 
ERR:          0
MIS:          0


> 
> And from boot log
> with my new timer setup

my boot dmesg timer setup:

ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC INTIN2
..TIMER: Is timer irq0 connected to IO-APIC INTIN0? ...
IOAPIC[0]: Set PCI routing entry (2-0 -> 0x31 -> IRQ 0 Mode:0 Active:0)
IOAPIC[0]: Set PCI routing entry (2-2 -> 0x31 -> IRQ 0 Mode:0 Active:0)
..MP-BIOS: 8254 timer not connected to IO-APIC INTIN0
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2135.0772 MHz.
..... host bus clock speed is 388.0322 MHz.

-------------------------------------------------------------
ioapic routing:

number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  1    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  1    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   0   0    1    1    D1
 11 001 01  1    1    0   0   0    1    1    D9
 12 001 01  1    1    0   0   0    1    1    E1
 13 001 01  1    1    0   0   0    1    1    C9
 14 001 01  1    1    0   0   0    1    1    B1
 15 001 01  1    1    0   0   0    1    1    C1
 16 001 01  1    1    0   0   0    1    1    B9
 17 001 01  1    1    0   0   0    1    1    A9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing

> I am now using forcedeth for onboard ether. It works well and is
> convenient when rebuilding and testing kernels and modules.

i would too but am still on a coax network here...
What?  Upgrade?  What?

b
