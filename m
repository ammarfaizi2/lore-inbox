Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbUDATdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbUDATdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:33:02 -0500
Received: from main.gmane.org ([80.91.224.249]:27594 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263076AbUDATbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:31:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: sean <seandarcy@hotmail.com>
Subject: irq 16 : Nobody cared  - alsa v. io-apic in 2.6.5-rc3-bk2
Date: Thu, 01 Apr 2004 14:24:44 -0500
Message-ID: <c4hq9t$96n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ool-4356fe48.dyn.optonline.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040319
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a VIA k400 motherboard.

 From dmesg:

...................
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 
08:19:30 2004 UTC).
ALSA device list:
   #0: C-Media PCI CMI8738-MC6 (model 55) at 0xe800, irq 16
NET: Registered protocol family 2
.....................
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 372k freed
irq 16: nobody cared!
Call Trace:
  [<c0108508>] __report_bad_irq+0x28/0x80
  [<c01088ae>] do_IRQ+0x15e/0x1a0
  [<c0106e08>] common_interrupt+0x18/0x20
  [<c01044e3>] default_idle+0x23/0x30
  [<c010455d>] cpu_idle+0x2d/0x40
  [<c04ee61b>] start_kernel+0x2ab/0x320
  [<c04ee1c0>] unknown_bootoption+0x0/0x180
 

handlers:
[<c0395800>] (snd_cmipci_interrupt+0x0/0x130)
Disabling IRQ #16
..............

I'm not sure which of the io-apic output is relevant but:

ENABLING IO-APIC IRQs
init IO_APIC IRQs
  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 
2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
.................
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
SCSI subsystem initialized
......................
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:01[A] -> 2-16 -> IRQ 16
..........................
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
  00 000 00  1    0    0   0   0    0    0    00
  01 001 01  0    0    0   0   0    1    1    39
  02 001 01  0    0    0   0   0    1    1    31
  03 001 01  0    0    0   0   0    1    1    41
  04 001 01  0    0    0   0   0    1    1    49
  05 001 01  0    0    0   0   0    1    1    51
  06 001 01  0    0    0   0   0    1    1    59
  07 001 01  0    0    0   0   0    1    1    61
  08 001 01  0    0    0   0   0    1    1    69
  09 001 01  0    1    0   1   0    1    1    71
  0a 001 01  0    0    0   0   0    1    1    79
  0b 001 01  0    0    0   0   0    1    1    81
  0c 001 01  0    0    0   0   0    1    1    89
  0d 001 01  0    0    0   0   0    1    1    91
  0e 001 01  0    0    0   0   0    1    1    99
  0f 001 01  0    0    0   0   0    1    1    A1
  10 001 01  1    1    0   1   0    1    1    A9
  11 001 01  1    1    0   1   0    1    1    B1
  12 001 01  1    1    0   1   0    1    1    C1
  13 001 01  1    1    0   1   0    1    1    C9
  14 000 00  1    0    0   0   0    0    0    00
  15 001 01  1    1    0   1   0    1    1    D1
  16 001 01  1    1    0   1   0    1    1    B9
  17 001 01  1    1    0   1   0    1    1    D9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
.......................
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
...................


sean

