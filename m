Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTJDGyZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 02:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTJDGyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 02:54:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:4779 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261925AbTJDGyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 02:54:21 -0400
Date: Fri, 3 Oct 2003 23:55:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [updated patch] for efi support in ia32 kernels
Message-Id: <20031003235559.3ca10b33.akpm@osdl.org>
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE713@fmsmsx406.fm.intel.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE713@fmsmsx406.fm.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tolentino, Matthew E" <matthew.e.tolentino@intel.com> wrote:
>
>  Attached is another patch that enables EFI boot-up support in ia32 kernels.

When I enable CONFIG_ACPI_EFI on a fairly vanilla PC, the ethernet card
fails to generate any interrupts.  See below for the unpromising changes
which CONFIG_ACPI_EFI made to my dmesg output.

Yes, this needs to be fixed - EFI-capable kernels should run unaffected on
hardware with older BIOSes.


 ACPI: Subsystem revision 20030918
-IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
-ACPI: Interpreter enabled
-ACPI: Using IOAPIC for interrupt routing
-ACPI: PCI Root Bridge [PCI0] (00:00)
+ACPI: System description tables not found
+    ACPI-0084: *** Error: acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
+    ACPI-0134: *** Error: acpi_load_tables: Could not load tables: AE_NOT_FOUND
+ACPI: Unable to load the System Description Tables
+PCI: Probing PCI hardware
 PCI: Probing PCI hardware (bus 00)
 Transparent bridge - 0000:00:1e.0
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
-ACPI: Power Resource [FDDP] (off)
-ACPI: Power Resource [URP1] (off)
-ACPI: Power Resource [URP2] (off)
-ACPI: Power Resource [LPTP] (off)
-ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
-ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
-ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
-ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
-ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
-ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
-ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
-ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
-IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
-00:00:1f[B] -> 2-17 -> IRQ 17
-IOAPIC[0]: Set PCI routing entry (2-23 -> 0xb1 -> IRQ 23 Mode:1 Active:1)
-00:00:1f[C] -> 2-23 -> IRQ 23
-IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1 Active:1)
-00:00:1f[D] -> 2-19 -> IRQ 19
-IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16 Mode:1 Active:1)
-00:00:01[A] -> 2-16 -> IRQ 16
-Pin 2-17 already programmed
-IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21 Mode:1 Active:1)
-00:02:09[A] -> 2-21 -> IRQ 21
-IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd1 -> IRQ 22 Mode:1 Active:1)
-00:02:09[B] -> 2-22 -> IRQ 22
-Pin 2-23 already programmed
-Pin 2-17 already programmed
-Pin 2-22 already programmed
-Pin 2-23 already programmed
-Pin 2-17 already programmed
-Pin 2-21 already programmed
-Pin 2-23 already programmed
-Pin 2-17 already programmed
-Pin 2-21 already programmed
-Pin 2-22 already programmed
-Pin 2-17 already programmed
-Pin 2-21 already programmed
-Pin 2-22 already programmed
-Pin 2-23 already programmed
-Pin 2-21 already programmed
-Pin 2-22 already programmed
-Pin 2-23 already programmed
-Pin 2-17 already programmed
-Pin 2-22 already programmed
-Pin 2-23 already programmed
-Pin 2-17 already programmed
-Pin 2-21 already programmed
-Pin 2-17 already programmed
-IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd9 -> IRQ 20 Mode:1 Active:1)
-00:02:08[A] -> 2-20 -> IRQ 20
-Pin 2-19 already programmed
-IOAPIC[0]: Set PCI routing entry (2-18 -> 0xe1 -> IRQ 18 Mode:1 Active:1)
-00:02:01[B] -> 2-18 -> IRQ 18
-Pin 2-23 already programmed
-PCI: Using ACPI for IRQ routing
-PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
+PCI: Using IRQ router PIIX [8086/2440] at 0000:00:1f.0
+PCI BIOS passed nonexistent PCI bus 0!
+PCI BIOS passed nonexistent PCI bus 0!
+PCI BIOS passed nonexistent PCI bus 0!
+PCI BIOS passed nonexistent PCI bus 1!
+PCI BIOS passed nonexistent PCI bus 0!
+PCI BIOS passed nonexistent PCI bus 2!
+PCI BIOS passed nonexistent PCI bus 0!
+PCI BIOS passed nonexistent PCI bus 2!
+PCI BIOS passed nonexistent PCI bus 0!
+PCI BIOS passed nonexistent PCI bus 2!
+PCI BIOS passed nonexistent PCI bus 0!
+PCI BIOS passed nonexistent PCI bus 2!
+PCI BIOS passed nonexistent PCI bus 0!
+PCI BIOS passed nonexistent PCI bus 2!
+PCI BIOS passed nonexistent PCI bus 0!
 Machine check exception polling timer started.
 Starting balanced_irq
 Total HugeTLB memory allocated, 0
@@ -785,9 +744,6 @@
 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
 6355ac22e890d0a3c8481a5ca4825bc884d3e7a1ff98a2fc2ac7d8e064c3b2e6
 pass
-ACPI: Power Button (FF) [PWRF]
-ACPI: Processor [CPU1] (supports C1)
-ACPI: Processor [CPU2] (supports C1)
 pty: 256 Unix98 ptys configured
 Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
 ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
@@ -830,11 +786,10 @@
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 NET: Registered protocol family 15
-ACPI: (supports S0 S1 S4 S5)
 EXT3-fs: INFO: recovery required on readonly filesystem.
 EXT3-fs: write access will be enabled during recovery.

