Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262754AbTDATT2>; Tue, 1 Apr 2003 14:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262763AbTDATT2>; Tue, 1 Apr 2003 14:19:28 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:64179 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262754AbTDATTZ>; Tue, 1 Apr 2003 14:19:25 -0500
Date: Tue, 01 Apr 2003 11:20:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 529] New: ACPI under 2.5.50+ (approx) locks system hard during bootup 
Message-ID: <130680000.1049224849@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=529

           Summary: ACPI under 2.5.50+ (approx) locks system hard during
                    bootup
    Kernel Version: 2.5.50 - 2.5.66 at least.  Trying to find the last one
                    that work
            Status: NEW
          Severity: normal
             Owner: andrew.grover@intel.com
         Submitter: mharrell-lk@bittwiddlers.com


Distribution: Debian Woody / Sid
Hardware Environment: HP ZT1195 laptop
Software Environment:
Problem Description: Ever since that that update around 2.5.50 of the ACPI
system I cannot boot my laptop at all with anything other than acpi=off.  I am
trying to build the older kernels to determine exactly which version started
this problem.  I do have a working version of 2.5.48 I'm using right now which
produces the following 

interrupts:
             CPU0
  0:     725368          XT-PIC  timer
  1:       4038          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
  9:         31          XT-PIC  acpi, VIA8233
 10:        581          XT-PIC  uhci-hcd, eth0
 11:       3160          XT-PIC  PCI device 1524:1410 (ENE Technology Inc), eth1
12:      14931          XT-PIC  i8042
 14:       9367          XT-PIC  ide0
 15:         27          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0

dmesg sections from 2.5.45:

ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 126960
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 122864 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 OID_00                     ) @ 0x000e5010
ACPI: RSDT (v001 INSYDE RSDT_000 00000.00001) @ 0x1efffbc0
ACPI: FADT (v003 INSYDE FACP_000 00000.00256) @ 0x1efffac0
ACPI: BOOT (v001 INSYDE SYS_BOOT 00000.00256) @ 0x1efffb50
ACPI: DBGP (v001 INSYDE DBGP_000 00000.00256) @ 0x1efffb80
ACPI: DSDT (v001 INSYDE   VT8633 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
....
ACPI: Subsystem revision 20021022
    ACPI-0357: *** Warning: Inconsistent FADT length (0x84) and revision (0x3),
using FADT V1.0 portion of table
    ACPI-0508: *** Info: GPE Block0 defined as GPE0 to GPE15
ACPI breakpoint: Executed AML Breakpoint opcode
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 10, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 *10)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 1)


dmesg from my latest attempt, 2.5.66-bk7 with a fixed DSDT:

On node 0 totalpages: 126960
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 122864 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 OID_00                     ) @ 0x000e5010
ACPI: RSDT (v001 INSYDE RSDT_000 00000.00001) @ 0x1efffbc0
ACPI: FADT (v003 INSYDE FACP_000 00000.00256) @ 0x1efffac0
ACPI: BOOT (v001 INSYDE SYS_BOOT 00000.00256) @ 0x1efffb50
ACPI: DBGP (v001 INSYDE DBGP_000 00000.00256) @ 0x1efffb80
ACPI: DSDT (v001 INSYDE   VT8633 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
...
ACPI: Subsystem revision 20030228
tbconvrt-0375: *** Warning: Inconsistent FADT length (0x84) and revision (0x3),
using FADT V1.0 portion of table
   tbget-0292: *** Info: Table [DSDT] replaced by host OS
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control
Methods:................................................................................................................................................
Table [DSDT] - 664 Objects with 45 Devices 144 Methods 27 Regions
ACPI Namespace successfully loaded at root c0428bbc
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
   evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at
0000000000001020
   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE15
Executing all Device _STA and_INI methods:........<3>ACPI breakpoint: Executed
AML Breakpoint opcode
.....................................
45 Devices found containing: 45 _STA, 5 _INI methods
Completing Region/Field/Buffer/Package
initialization:............................................................
Initialized 18/27 Regions 0/0 Fields 21/21 Buffers 21/21 Packages (664 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 10, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 *10)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 1)


I've downloaded and installed the latest BIOS from HP and that didn't change
anything.  I also followed the instructions on fixing my dsdt table and put that
in the kernel but that didn't change anything either.


Steps to reproduce: Just boot :)
   Everything appears fine until it gets to the point around where acpid starts
- at that point the system slows down immensely and then freezes a few minutes
later.  If I prevent acpid from starting then it freezes on the next program,
the alsa setup.  If I take that out then it freezes on lircd.  When it does
freeze the hard drive light stays on solid but the hard drive makes no noise. 
The system is totally unresponsive and requires a hard reset.

