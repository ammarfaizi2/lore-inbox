Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263793AbUECQxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUECQxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 12:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263794AbUECQxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 12:53:07 -0400
Received: from fmr11.intel.com ([192.55.52.31]:31136 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S263793AbUECQwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 12:52:55 -0400
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1083603151.593.3.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 May 2004 12:52:31 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.6

	A couple of key interrupt configuration fixes in this patch.
thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.6/acpi-20040326-2.6.6.diff.gz

This will update the following files:

 Documentation/kernel-parameters.txt |   14 +
 arch/i386/kernel/acpi/boot.c        |   19 +-
 arch/i386/kernel/dmi_scan.c         |  147 ++++++++---------
 arch/i386/kernel/io_apic.c          |   18 --
 arch/i386/kernel/mpparse.c          |   40 +---
 arch/i386/kernel/setup.c            |   13 +
 arch/i386/mach-default/setup.c      |    4 
 arch/i386/mach-es7000/setup.c       |    7 
 arch/i386/mach-voyager/setup.c      |    4 
 arch/i386/pci/acpi.c                |    1 
 arch/i386/pci/irq.c                 |    5 
 arch/x86_64/kernel/Makefile         |    2 
 arch/x86_64/kernel/i8259.c          |    4 
 arch/x86_64/kernel/io_apic.c        |   16 -
 arch/x86_64/kernel/mpparse.c        |   37 +---
 arch/x86_64/kernel/setup.c          |   10 -
 drivers/acpi/ac.c                   |    3 
 drivers/acpi/asus_acpi.c            |  121 ++++++++------
 drivers/acpi/battery.c              |   15 +
 drivers/acpi/button.c               |   37 ++++
 drivers/acpi/fan.c                  |    3 
 drivers/acpi/osl.c                  |   27 +--
 drivers/acpi/pci_irq.c              |    2 
 drivers/acpi/pci_link.c             |  199 ++++++++++++------------
 drivers/acpi/pci_root.c             |   10 +
 drivers/acpi/processor.c            |   12 +
 drivers/acpi/scan.c                 |   16 +
 drivers/acpi/thermal.c              |    7 
 drivers/acpi/toshiba_acpi.c         |    5 
 include/acpi/acpiosxf.h             |    6 
 include/asm-i386/acpi.h             |   16 +
 include/asm-ia64/acpi.h             |    1 
 include/asm-x86_64/acpi.h           |   16 +
 include/linux/acpi.h                |    1 
 34 files changed, 495 insertions(+), 343 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/05/03 1.1371.707.20)
   [ACPI] export symbols to button module

<len.brown@intel.com> (04/05/01 1.1371.707.19)
   [ACPI] PCI Interrupt Link fixes
   Handle BIOS that reference disabled PCI Interrupt Link Devices
   http://bugme.osdl.org/show_bug.cgi?id=1581
   
   Clean up VIA _CRS = 0 BIOS workaround
   
   Handle BIOS returning _CRS outside _PRS
   http://bugme.osdl.org/show_bug.cgi?id=2567
   
   delete now unused _SRS retry code
   disable redundant console messages

<len.brown@intel.com> (04/04/28 1.1371.707.18)
   [ACPI] button build fix

<len.brown@intel.com> (04/04/28 1.1371.707.17)
   [ACPI] fix build warning in dmi_scan

<len.brown@intel.com> (04/04/28 1.1371.707.16)
   [ACPI] support button driver unload (Luming Yu)
   http://bugzilla.kernel.org/show_bug.cgi?id=2281

<len.brown@intel.com> (04/04/28 1.1371.707.15)
   [ACPI] toshiba_acpi driver if acpi_disabled (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=2465

<len.brown@intel.com> (04/04/28 1.1371.707.14)
   [ACPI] rmmod ACPI modules vs /proc
   from Anil S Keshavamurthy and David Shaohua Li
   http://bugzilla.kernel.org/show_bug.cgi?id=2457

<len.brown@intel.com> (04/04/28 1.1371.707.13)
   [ACPI] pci-link may not always be SHARED (SuSE via Luming Yu)
   http://bugzilla.kernel.org/show_bug.cgi?id=2404

<len.brown@intel.com> (04/04/28 1.1371.707.12)
   [ACPI] battery "charged" instead of "unknown" (Luming Yu)
   http://bugzilla.kernel.org/show_bug.cgi?id=1863

<sziwan@hell.org.pl> (04/04/28 1.1371.707.11)
   [PATCH] acpi4asus 0.28 (Karol 'sziwan' Kozimor)
   - Added support for Samsung P30
   - Fixed an oops triggered by non-standard hardware (Samsung P30)
   - Added support for L4400L and M6800N
   
   The patch also removes some superfluous data. It doesn't include the
   copy_from_user() conversion, it will be released as a separate patch.

<akpm@osdl.org> (04/04/28 1.1371.707.10)
   [PATCH] acpi build fix
   setup.c:608: `acpi_skip_timer_override' undeclared

<len.brown@intel.com> (04/04/24 1.1371.749.3)
   ACPI irq->gsi naming (Bjorn Helgaas)

<len.brown@intel.com> (04/04/24 1.1371.707.9)
   [ACPI] No IRQ known... - using IRQ 255 (Bjarni Rúnar Einarsson)
   http://bugzilla.kernel.org/show_bug.cgi?id=2148

<len.brown@intel.com> (04/04/23 1.1371.707.8)
   [ACPI] workaround for nForce2 BIOS bug: XT-PIC timer in IOAPIC mode 
   "acpi_skip_timer_override" boot parameter
   dmi_scan for common platforms, may be replaced with PCI-ID in future.
   http://bugzilla.kernel.org/show_bug.cgi?id=1203

<len.brown@intel.com> (04/04/23 1.1371.707.7)
   [ACPI] Workaround "_BBN 0" BIOS bug
   enhance "pci=noacpi" to skip ACPI PCI configuration and interrupt
config
   add "acpi=noirq" to skip just ACPI interrupt config (David Shaohua
Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=1662

<len.brown@intel.com> (04/04/22 1.1371.707.6)
   [ACPI] allow IRQ2 to be used in ACPI/IOAPIC mode
   http://bugzilla.kernel.org/show_bug.cgi?id=2564

<len.brown@intel.com> (04/04/22 1.1371.707.5)
   [ACPI] if acpi_os_name= is used, print what it finds

<len.brown@intel.com> (04/04/20 1.1371.707.4)
   ACPI] Delete IRQ2 "cascade" in ACPI IOAPIC mode
   no such concept exists in ACPI, frees IRQ2 for use.

<len.brown@intel.com> (04/04/20 1.1371.707.3)
   [ACPI] enhance intr-src-override parsing to handle ES7000
   http://bugme.osdl.org/show_bug.cgi?id=2520

<len.brown@intel.com> (04/04/16 1.1371.707.2)
   [ACPI] enable 440GX PIRQ router workaround

<len.brown@intel.com> (04/04/14 1.1371.707.1)
   [ACPI] fix x86_64 mis-merge




