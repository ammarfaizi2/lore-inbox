Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbTKRU7H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 15:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTKRU7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 15:59:07 -0500
Received: from fmr04.intel.com ([143.183.121.6]:56754 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263785AbTKRU7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 15:59:00 -0500
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1069189083.2970.540.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 Nov 2003 15:58:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.23

	Asside from the fixes we discussed, I found some of
	the ACPI related x86_64 code in need of sync from i386,
	so I did that and iterated to fix a few broken build configs.
	Of my standard set, !CONFIG_PCI is still broken,
	but probably nobody cares.  the pci=noacpi code is
	updated from 2.6, but both trees needs some cleaning...

	It would be good to get some feedback from those with
	x86_64 hardware, since I don't currently have any.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.23-rc1/acpi-20031002-2.4.23-rc1.diff.gz

This will update the following files:


 Documentation/kernel-parameters.txt |    9 +
 MAINTAINERS                         |    4 
 arch/i386/kernel/acpi.c             |   58 ++++++-
 arch/i386/kernel/dmi_scan.c         |    1 
 arch/i386/kernel/io_apic.c          |   10 -
 arch/i386/kernel/mpparse.c          |    4 
 arch/i386/kernel/setup.c            |    6 
 arch/x86_64/kernel/Makefile         |    2 
 arch/x86_64/kernel/acpi.c           |   98 ++++++++++---
 arch/x86_64/kernel/e820.c           |   10 +
 arch/x86_64/kernel/io_apic.c        |   20 +-
 arch/x86_64/kernel/mpparse.c        |    8 -
 arch/x86_64/kernel/pci-pc.c         |    8 +
 arch/x86_64/kernel/setup.c          |    4 
 drivers/acpi/bus.c                  |    4 
 drivers/acpi/pci_link.c             |  180 ++++++++++++++++++++----
 drivers/acpi/system.c               |    9 +
 include/acpi/acpi_bus.h             |    1 
 include/asm-i386/acpi.h             |   29 +--
 include/asm-i386/io_apic.h          |   23 ++-
 include/asm-x86_64/acpi.h           |   28 +--
 include/asm-x86_64/apic.h           |   13 -
 include/asm-x86_64/io_apic.h        |   21 ++
 23 files changed, 412 insertions(+), 138 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (03/11/18 1.1193.1.10)
   "pci=noacpi" use pci_disable_acpi() instead of touching use_acpi_pci
directly

<len.brown@intel.com> (03/11/18 1.1063.44.51)
   [ACPI] sync some i386 ACPI build fixes into x86_64 to fix
!CONFIG_ACPI build

<len.brown@intel.com> (03/11/18 1.1193.1.8)
   x86_64 build fix from previous cset

<len.brown@intel.com> (03/11/18 1.1063.44.50)
   i386 build fix from previous cset

<len.brown@intel.com> (03/11/18 1.1193.1.6)
   2.4.23 build x86_64 build fixes

<len.brown@intel.com> (03/11/18 1.1063.44.49)
   [ACPI] fix x86_64 !CONFIG_ACPI build

<len.brown@intel.com> (03/11/18 1.1063.44.48)
   [ACPI] Maintainer: Andy Grover -> Len Brown

<len.brown@intel.com> (03/11/18 1.1063.44.47)
   [ACPI] fix x86_64 build errors

<len.brown@intel.com> (03/11/18 1.1063.44.46)
   [ACPI] 
     Re-enable IRQ balacning if IOAPIC mode
     http://bugzilla.kernel.org/show_bug.cgi?id=1440
   
     Also allow IRQ balancing in PIC mode if "acpi_irq_balance"
     http://bugzilla.kernel.org/show_bug.cgi?id=1391

<len.brown@intel.com> (03/11/18 1.1063.44.45)
   [ACPI ] pci=acpi ineffective fix from i386 2.6 (Thomas Schlichter)
   http://bugzilla.kernel.org/show_bug.cgi?id=1219

<len.brown@intel.com> (03/11/18 1.1063.44.44)
   [ACPI] "acpi_pic_sci=edge" in case platform requires Edge Triggered
SCI
   http://bugzilla.kernel.org/show_bug.cgi?id=1390

<len.brown@intel.com> (03/11/18 1.1063.44.43)
   [ACPI] print_IO_APIC() only after it is actually programmed
   http://bugzilla.kernel.org/show_bug.cgi?id=1177

<len.brown@intel.com> (03/11/17 1.1063.44.42)
   [ACPI] fix ACPI/legacy interrupt sharing issue ala 2.6
   http://bugzilla.kernel.org/show_bug.cgi?id=1283

<len.brown@intel.com> (03/11/17 1.1063.44.41)
   [ACPI] fix poweroff failure ala 2.6 (Ducrot Bruno)
   http://bugzilla.kernel.org/show_bug.cgi?id=1456

<len.brown@intel.com> (03/11/07 1.1063.44.40)
   [ACPI] In ACPI mode, delay print_IO_APIC() to make its output valid.
   http://bugzilla.kernel.org/show_bug.cgi?id=1177

<len.brown@intel.com> (03/11/07 1.1063.44.39)
   [ACPI] If ACPI is disabled by DMI BIOS date, then
   turn it off completely, including table parsing for HT.
   This avoids a crash due to ancient garbled tables.
   acpi=force is available to over-ride this default.
   http://bugzilla.kernel.org/show_bug.cgi?id=1434

<len.brown@intel.com> (03/10/30 1.1063.44.38)
   [ACPI] fix CONFIG_HOTPLUG_PCI_ACPI config (Xose Vazquez Perez)




