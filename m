Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265001AbUFRGnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbUFRGnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 02:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbUFRGnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 02:43:08 -0400
Received: from fmr02.intel.com ([192.55.52.25]:42414 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S265001AbUFRGm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 02:42:29 -0400
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1087540933.4487.212.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 Jun 2004 02:42:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.7

Signed-off-by: Len Brown <len.brown@intel.com>

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.7/acpi-20040326-2.6.7.diff.gz

This will update the following files:

 arch/i386/kernel/acpi/boot.c |   33 ++++
 arch/i386/kernel/dmi_scan.c  |   18 +-
 arch/i386/kernel/mpparse.c   |  119 +++++------------
 arch/i386/pci/acpi.c         |   31 +++-
 arch/ia64/kernel/acpi.c      |   23 +--
 arch/ia64/kernel/iosapic.c   |  209 +++++++++++--------------------
 arch/ia64/pci/pci.c          |   16 +-
 arch/x86_64/kernel/mpparse.c |  112 +++++-----------
 drivers/acpi/Kconfig         |    2 
 drivers/acpi/pci_irq.c       |  119 +++++------------
 drivers/acpi/pci_link.c      |   26 ---
 drivers/acpi/pci_root.c      |   49 +++++++
 drivers/acpi/tables.c        |    6 
 drivers/acpi/thermal.c       |    7 +
 drivers/serial/8250_acpi.c   |   22 ---
 drivers/serial/8250_hcdp.c   |   12 -
 include/acpi/acpi_drivers.h  |    2 
 include/asm-i386/mpspec.h    |    2 
 include/asm-ia64/iosapic.h   |    1 
 include/asm-x86_64/mpspec.h  |    2 
 include/linux/acpi.h         |    4 
 21 files changed, 361 insertions(+), 454 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/06/18 1.1608.11.12)
   [ACPI] handle SCI override to nth IOAPIC
   http://bugzilla.kernel.org/show_bug.cgi?id=2835

<len.brown@intel.com> (04/06/17 1.1608.11.11)
   [ACPI] avoid spurious interrupts on VIA
   http://bugzilla.kernel.org/show_bug.cgi?id=2243

<len.brown@intel.com> (04/06/17 1.1728.2.1)
   [ACPI] fix passive cooling mode indicator (Luming Yu)
   http://bugzilla.kernel.org/show_bug.cgi?id=1770

<len.brown@intel.com> (04/06/17 1.1608.11.10)
   [ACPI] PCI bus numbering workaround for ServerWorks
   from David Shaohua Li
   http://bugzilla.kernel.org/show_bug.cgi?id=1662

<len.brown@intel.com> (04/06/17 1.1722.18.6)
   [ACPI] Fix a lockup which Sid Boyce <sboyce@blueyonder.co.uk>
   discovered with IOAPIC disabled.
   
   The problem was that drivers/serial/8250_acpi.c found COM1 in the
ACPI
   namespace and called acpi_register_gsi() to set up its IRQ.  ACPI
tells us
   that the COM1 IRQ is edge triggered, active high, but
acpi_register_gsi()
   was ignoring the edge_level argument, so it blindly set the COM1 IRQ
to be
   level-triggered.
   
   Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
   Signed-off-by: Andrew Morton <akpm@osdl.org

<len.brown@intel.com> (04/06/17 1.1722.18.5)
   [ACPI] delete "__init" from x86_64 version of mp_find_ioapic() 
   Signed-off-by: Arnd Bergmann <arnd@arndb.de>
   Signed-off-by: Andrew Morton <akpm@osdl.or

<len.brown@intel.com> (04/06/17 1.1722.18.4)
   [ACPI] mp_find_ioapic() oops from mp_register_gsi() on device resume
   Signed-off-by: Andrew Morton <akpm@osdl.org>

<len.brown@intel.com> (04/06/17 1.1722.18.3)
   [ACPI] *** Warning: "acpi_register_gsi" [drivers/serial/8250_acpi.ko]
undefined!
   
   Signed-off-by: Andrew Morton <akpm@osdl.org>

<len.brown@intel.com> (04/06/03 1.1608.11.9)
   [ACPI] acpi=force overrides blacklist pci=noacpi or acpi=noirq (Andi
Kleen)

<len.brown@intel.com> (04/06/03 1.1722.18.2)
   [ACPI] fix !CONFIG_PCI build (Bjorn Helgaas)

<len.brown@intel.com> (04/05/25 1.1722.18.1)
   [ACPI] PCI IRQ update (Bjorn Helgaas)
   http://bugme.osdl.org/show_bug.cgi?id=2574
   
   mp_parse_prt() and iosapic_parse_prt() used to allocate all
   IRQs, whether devices needed them or not.  Some devices
   failed because the this method enabled unused PCI Interrupt
   Link Devices, which disrupted active link devices.
   
   Now the PRT knowledge is pulled out of the arch
   code and the IRQ allocation and IO-APIC programming
   is done by pci_enable_device().
   This is also a step toward allowing the addition
   of new root bridges and PRTs at run-time.
   
   The architecture supplies
   
    unsigned int
    acpi_register_gsi(u32 gsi, int edge_level, int active_high_low)
   
   which is called by acpi_pci_irq_enable().  ACPI supplies
   all the information from the PRT, and the arch sets up
   the routing and returns the IRQ it allocated.

<len.brown@intel.com> (04/05/22 1.1608.11.8)
   Kconfig typo fix from Jochen Voss




