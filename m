Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262740AbTCJGDr>; Mon, 10 Mar 2003 01:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262741AbTCJGDr>; Mon, 10 Mar 2003 01:03:47 -0500
Received: from franka.aracnet.com ([216.99.193.44]:44942 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262740AbTCJGDn>; Mon, 10 Mar 2003 01:03:43 -0500
Date: Sun, 09 Mar 2003 22:14:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 455] New: 2.5.64 Dell Inspiron 5000e heaps of suspend/resume problems 
Message-ID: <72540000.1047276850@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=455

           Summary: 2.5.64 Dell Inspiron 5000e heaps of suspend/resume
                    problems
    Kernel Version: 2.5.64
            Status: NEW
          Severity: normal
             Owner: andrew.grover@intel.com
         Submitter: andi@lisas.de


Distribution: Debian testing/unstable
Hardware Environment: bare-bone I5Ke, with mini-PCI wireless card
Software Environment: gcc 3.2.2, libc6 2.3.1, 2.5.64 standard
Problem Description:
When suspending via echo 1>/proc/acpi/sleep, upon resume I get the following
errors frequently:
Debug: sleeping function called from illegal context at
include/linux/rwsem.h:43
Mar  9 23:43:48 localhost kernel: Call Trace:
Mar  9 23:43:48 localhost kernel:  [sync_supers+121/240] sync_supers+0x79/0xf0
Mar  9 23:43:48 localhost kernel:  [wb_kupdate+96/352] wb_kupdate+0x60/0x160
Mar  9 23:43:48 localhost kernel:  [__wake_up_common+58/96]
__wake_up_common+0x3a/0x60
Mar  9 23:43:48 localhost kernel:  [printk+280/384] printk+0x118/0x180
Mar  9 23:43:48 localhost kernel:  [context_switch+124/304]
context_switch+0x7c/0x130
Mar  9 23:43:48 localhost kernel:  [show_trace+66/144] show_trace+0x42/0x90
Mar  9 23:43:48 localhost kernel:  [kernel_thread_helper+5/24]
kernel_thread_helper+0x5/0x18
Mar  9 23:43:48 localhost kernel:  [schedule+332/560] schedule+0x14c/0x230
Mar  9 23:43:48 localhost kernel:  [__pdflush+220/480] __pdflush+0xdc/0x1e0
Mar  9 23:43:48 localhost kernel:  [pdflush+0/32] pdflush+0x0/0x20
Mar  9 23:43:48 localhost kernel:  [pdflush+17/32] pdflush+0x11/0x20
Mar  9 23:43:48 localhost kernel:  [wb_kupdate+0/352] wb_kupdate+0x0/0x160
Mar  9 23:43:48 localhost kernel:  [kernel_thread_helper+5/24]
kernel_thread_helper+0x5/0x18


bad: scheduling while atomic!
Call Trace:
 [<c011d4c0>] schedule+0x220/0x230
 [<c0140608>] __pdflush+0x98/0x1e0
 [<c0140750>] pdflush+0x0/0x20
 [<c0140761>] pdflush+0x11/0x20
 [<c010826d>] kernel_thread_helper+0x5/0x18

The system is still sort-of-usable in console (keeps having errors though),
but as soon as I switch back to X11, BOOM, that's it.

When trying an echo 3>/proc/acpi/sleep, the notebook doesn't react AT ALL
after resume (it does resume, though, but it's dead).

Steps to reproduce:
This happens both with extensive module/driver/support programs loaded and
without ANY modules loaded (just to check whether some driver is guilty of
producing this mess).

Yeah, I know that Dell produces incredibly crappy BIOS power mgmt code, but it'd
be nice to see this running anyway ;-)

Any ideas?

And what do the various seemingly important error messages below mean?

Thanks!

Andreas Mohr, Wine developer

ACPI boot output:

Mar  9 23:45:03 localhost kernel: ACPI: Subsystem revision 20030228
Mar  9 23:45:03 localhost kernel:  tbxface-0117 [03] acpi_load_tables      : ACP
I Tables successfully acquired
Mar  9 23:45:03 localhost kernel: Parsing all Control Methods:..................
................................................................................
...........................................................................
Mar  9 23:45:03 localhost kernel: Table [DSDT] - 602 Objects with 51 Devices 173
 Methods 16 Regions
Mar  9 23:45:03 localhost kernel: ACPI Namespace successfully loaded at root c03
b2b3c
Mar  9 23:45:03 localhost kernel: evxfevnt-0092 [04] acpi_enable           : Tra
nsition to ACPI mode successful
Mar  9 23:45:03 localhost kernel:    evgpe-0416 [06] ev_create_gpe_block   : GPE
 Block: 2 registers at 000000000000100C
Mar  9 23:45:03 localhost kernel:    evgpe-0421 [06] ev_create_gpe_block   : GPE
 Block defined as GPE0 to GPE15
Mar  9 23:45:03 localhost kernel: Executing all Device _STA and_INI methods:....
...........[ACPI Debug] String: LNKA_STA
Mar  9 23:45:03 localhost kernel: [ACPI Debug] Integer: 000000000000000B
Mar  9 23:45:03 localhost kernel: ...............[ACPI Debug] String: PCI IDE Pr
imary _STA
Mar  9 23:45:03 localhost kernel: ......[ACPI Debug] String: USB_STA
Mar  9 23:45:03 localhost kernel: ..[ACPI Debug] String: AUD_STA
Mar  9 23:45:03 localhost kernel: .[ACPI Debug] String: MDM1_STA
Mar  9 23:45:03 localhost kernel: ......[ACPI Debug] String: VGA_STA
Mar  9 23:45:03 localhost kernel: ......
Mar  9 23:45:03 localhost kernel: 51 Devices found containing: 51 _STA, 2 _INI m
ethods
Mar  9 23:45:03 localhost kernel: Completing Region/Field/Buffer/Package initial
ization:........................................................................
.......
Mar  9 23:45:03 localhost kernel: Initialized 9/16 Regions 0/0 Fields 25/25 Buff
ers 45/46 Packages (602 nodes)
Mar  9 23:45:03 localhost kernel: ACPI: Interpreter enabled
Mar  9 23:45:03 localhost kernel: ACPI: Using PIC for interrupt routing
Mar  9 23:45:03 localhost kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Mar  9 23:45:03 localhost kernel: PCI: Probing PCI hardware (bus 00)
>>>>> Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [05]
acpi_evaluate_referenc: [
Package] has zero elements (cffee9e0)
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [06] acpi_evaluate_referenc: [
Package] has zero elements (cffee9e0)
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [07] acpi_evaluate_referenc: [
Package] has zero elements (cffee9e0)
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [08] acpi_evaluate_referenc: [
Package] has zero elements (cffee9e0)
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [09] acpi_evaluate_referenc: [
Package] has zero elements (cffee9e0)
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [10] acpi_evaluate_referenc: [
Package] has zero elements (cffee9e0)
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: LNKA_STA
Mar  9 23:45:03 localhost kernel: [ACPI Debug] Integer: 000000000000000B
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: LNKA_STA
Mar  9 23:45:03 localhost kernel: [ACPI Debug] Integer: 000000000000000B
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: LNKA_STA
Mar  9 23:45:03 localhost kernel: [ACPI Debug] Integer: 000000000000000B
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: LNKA_CRS
Mar  9 23:45:03 localhost kernel: [ACPI Debug] Buffer: Length 06
Mar  9 23:45:03 localhost kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 
7 9 10 *11 14 15)
Mar  9 23:45:03 localhost kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 
7 9 10 11 14 15, disabled)
Mar  9 23:45:03 localhost kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7, dis
abled)
Mar  9 23:45:03 localhost kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6
 7 9 10 11 14 15)
Mar  9 23:45:03 localhost kernel: ACPI: Embedded Controller [EC0] (gpe 9)
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [17] acpi_evaluate_referenc: [
Package] has zero elements (cffee9e0)
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: PCI IDE Primary _STA
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: PCI IDE Primary _STA
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: USB_STA
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: USB_STA
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [18] acpi_evaluate_referenc: [
Package] has zero elements (cffee9c0)
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: AUD_STA
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: AUD_STA
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [19] acpi_evaluate_referenc: [
Package] has zero elements (cffee980)
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: MDM1_STA
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: MDM1_STA
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [20] acpi_evaluate_referenc: [
Package] has zero elements (cffee960)
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [21] acpi_evaluate_referenc: [
Package] has zero elements (cffe33c0)
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [22] acpi_evaluate_referenc: [
Package] has zero elements (cffe33a0)
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [23] acpi_evaluate_referenc: [
Package] has zero elements (cffe3380)
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [24] acpi_evaluate_referenc: [
Package] has zero elements (cffe3380)
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: VGA_STA
Mar  9 23:45:03 localhost kernel: [ACPI Debug] String: VGA_STA
Mar  9 23:45:03 localhost kernel: acpi_utils-0369 [25] acpi_evaluate_referenc: [
Package] has zero elements (cffe3340)
Mar  9 23:45:03 localhost kernel: ACPI: Power Resource [PFN0] (off)
Mar  9 23:45:03 localhost kernel: ACPI: Power Resource [PFN1] (off)
Mar  9 23:45:03 localhost kernel: block request queues:
Mar  9 23:45:03 localhost kernel:  128 requests per read queue
Mar  9 23:45:03 localhost kernel:  128 requests per write queue
Mar  9 23:45:03 localhost kernel:  8 requests per batch
Mar  9 23:45:03 localhost kernel:  enter congestion at 15
Mar  9 23:45:03 localhost kernel:  exit congestion at 17
Mar  9 23:45:03 localhost kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ
 10
Mar  9 23:45:03 localhost kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ
 5
Mar  9 23:45:03 localhost kernel: PCI: Using ACPI for IRQ routing
Mar  9 23:45:03 localhost kernel: PCI: if you experience problems, try using opt
ion 'pci=noacpi' or even 'acpi=off'
>>>>> Mar  9 23:45:03 localhost kernel: PCI: Cannot allocate resource region 4
of devi
ce 00:07.1
(00:07.1 is IDE interface, BTW)
>>>>> Mar  9 23:45:03 localhost kernel: SBF: ACPI BOOT descriptor is wrong
length (39)
Mar  9 23:45:03 localhost kernel: SBF: Simple Boot Flag extension found and enab
led.
Mar  9 23:45:03 localhost kernel: SBF: Setting boot flags 0x1
Mar  9 23:45:03 localhost kernel: cpufreq: Intel(R) SpeedStep(TM) for this chips
et not (yet) available.
Mar  9 23:45:03 localhost kernel: apm: BIOS version 1.2 Flags 0x03 (Driver versi
on 1.16ac)
Mar  9 23:45:03 localhost kernel: apm: overridden by ACPI.
Mar  9 23:45:03 localhost kernel: Enabling SEP on CPU 0
Mar  9 23:45:03 localhost kernel: aio_setup: sizeof(struct page) = 40
Mar  9 23:45:03 localhost kernel: Journalled Block Device driver loaded
Mar  9 23:45:03 localhost kernel: devfs: v1.22 (20021013) Richard Gooch (rgooch@
atnf.csiro.au)
Mar  9 23:45:03 localhost kernel: devfs: boot_options: 0x1
Mar  9 23:45:03 localhost kernel: Limiting direct PCI/PCI transfers.
Mar  9 23:45:03 localhost kernel: ACPI: AC Adapter [AC] (on-line)
Mar  9 23:45:03 localhost kernel: ACPI: Battery Slot [BAT0] (battery present)
Mar  9 23:45:03 localhost kernel: ACPI: Battery Slot [BAT1] (battery absent)
Mar  9 23:45:03 localhost kernel: ACPI: Lid Switch [LID]
Mar  9 23:45:03 localhost kernel: ACPI: Power Button (CM) [PWRB]
Mar  9 23:45:03 localhost kernel: ACPI: Sleep Button (CM) [SBTN]
Mar  9 23:45:03 localhost kernel: ACPI: Fan [FAN0] (on)
Mar  9 23:45:03 localhost kernel: ACPI: Fan [FAN1] (on)
Mar  9 23:45:03 localhost kernel: ACPI: Processor [CPU0] (supports C1 C2, 8 thro

>>>>>> Mar  9 23:45:03 localhost kernel: acpi_thermal-0373 [34]
acpi_thermal_get_trip_:
 Invalid passive threshold

Mar  9 23:45:03 localhost kernel: ACPI: Thermal Zone [THRM] (56 C)


