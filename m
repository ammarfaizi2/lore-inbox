Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265399AbUFTLov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbUFTLov (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 07:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265793AbUFTLov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 07:44:51 -0400
Received: from aun.it.uu.se ([130.238.12.36]:51089 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265399AbUFTLos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 07:44:48 -0400
Date: Sun, 20 Jun 2004 13:44:34 +0200 (MEST)
Message-Id: <200406201144.i5KBiY5a014451@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: 2.4.27-rc1 reintroduced x86-64 2x timer bug
Cc: discuss@x86-64.org, len.brown@intel.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.27-rc1 reintroduced the "2x timer" ACPI bug on
x86-64 which was fixed previously in 2.4.27-pre3.

dmesg diff below between pre6 (ok) and rc1 (buggy).

/Mikael

--- dmesg-amd64-2.4.27-pre6	2004-06-20 13:12:48.000000000 +0200
+++ dmesg-amd64-2.4.27-rc1	2004-06-20 13:28:53.000000000 +0200
@@ -38,9 +38,6 @@
 IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
 ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
 ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
-ACPI: IRQ0 used by override.
-ACPI: IRQ2 used by override.
-ACPI: IRQ9 used by override.
 Using ACPI (MADT) for SMP configuration information
 Kernel command line: BOOT_IMAGE=linux auto
 Initializing CPU#0
@@ -61,7 +58,7 @@
 testing NMI watchdog ... OK.
 ENABLING IO-APIC IRQs
 init IO_APIC IRQs
- IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
+ IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
 ..TIMER: vector=0x31 pin1=2 pin2=-1
 Using local APIC timer interrupts.
 Detected 12.500 MHz APIC timer.
@@ -98,7 +95,7 @@
 00:00:05[D] -> 2-19 -> vector 0xd1 -> IRQ 19 level low
 00:00:10[A] -> 2-21 -> vector 0xd9 -> IRQ 21 level low
 00:00:12[A] -> 2-23 -> vector 0xe1 -> IRQ 23 level low
-number of MP IRQ sources: 15.
+number of MP IRQ sources: 18.
 number of IO-APIC #2 registers: 24.
 testing the IO APIC.......................
 
@@ -111,7 +108,7 @@
 .......     : IO APIC version: 0003
 .... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
- 00 000 00  1    0    0   0   0    0    0    00
+ 00 001 01  0    0    0   0   0    1    1    31
  01 001 01  0    0    0   0   0    1    1    39
  02 001 01  0    0    0   0   0    1    1    31
  03 001 01  0    0    0   0   0    1    1    41
@@ -136,7 +133,7 @@
  16 001 01  1    1    0   1   0    1    1    C1
  17 001 01  1    1    0   1   0    1    1    E1
 IRQ to pin mappings:
-IRQ0 -> 0:2
+IRQ0 -> 0:0-> 0:2
 IRQ1 -> 0:1
 IRQ3 -> 0:3
 IRQ4 -> 0:4
