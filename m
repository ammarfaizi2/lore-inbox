Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271194AbTHLWg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 18:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271195AbTHLWg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 18:36:26 -0400
Received: from fmr06.intel.com ([134.134.136.7]:38083 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S271194AbTHLWgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 18:36:23 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [BK PATCH] ACPI Updates for 2.4
Date: Tue, 12 Aug 2003 15:36:18 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EECD@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BK PATCH] ACPI Updates for 2.4
Thread-Index: AcNhIh6tqhDB9ALlQL+3mq2ndINPFQ==
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Aug 2003 22:36:18.0758 (UTC) FILETIME=[25CE8660:01C36122]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, here's a bunch of ACPI updates.

bk pull http://linux-acpi.bkbits.net/linux-acpi-2.4

This includes a rework of the ACPI config and cmdline options. It now
supports DMI-based blacklisting, and cmdline options have been
simplified to "acpi=off", "acpi=ht" (use ACPI for CPU enum only) and
"acpi=force" (to override the blacklist.)

It also includes some PCI IRQ routing changes, that seem to help some
people's systems work better.

Please apply.

Thanks -- Regards -- Andy

This will update the following files:

 arch/i386/kernel/acpitable.c        |  553 ------------------------
 arch/i386/kernel/acpitable.h        |  260 -----------
 Documentation/Configure.help        |   41 -
 Documentation/kernel-parameters.txt |   18 
 Makefile                            |    2 
 arch/i386/kernel/Makefile           |    1 
 arch/i386/kernel/acpi.c             |   50 +-
 arch/i386/kernel/dmi_scan.c         |  394 ++++++++++++++---
 arch/i386/kernel/io_apic.c          |   14 
 arch/i386/kernel/mpparse.c          |   37 +
 arch/i386/kernel/setup.c            |   99 ++--
 arch/i386/kernel/smpboot.c          |    2 
 drivers/Makefile                    |    2 
 drivers/acpi/Config.in              |   68 +-
 drivers/acpi/Makefile               |    7 
 drivers/acpi/bus.c                  |    2 
 drivers/acpi/executer/exutils.c     |    2 
 drivers/acpi/hardware/hwregs.c      |   21 
 drivers/acpi/osl.c                  |   26 -
 drivers/acpi/pci_irq.c              |   15 
 drivers/acpi/pci_link.c             |  100 ++--
 drivers/acpi/processor.c            |    1 
 drivers/acpi/tables.c               |  120 ++---
 drivers/acpi/tables/tbconvrt.c      |    6 
 drivers/acpi/tables/tbget.c         |    4 
 drivers/acpi/tables/tbinstal.c      |   42 +
 drivers/acpi/tables/tbrsdt.c        |    2 
 drivers/acpi/tables/tbxfroot.c      |    6 
 drivers/acpi/toshiba_acpi.c         |    3 
 drivers/acpi/utilities/utglobal.c   |    6 
 include/acpi/acconfig.h             |    2 
 include/acpi/acpi_drivers.h         |    2 
 include/acpi/platform/acenv.h       |    6 
 include/asm-i386/acpi.h             |   26 -
 include/asm-i386/io_apic.h          |    2 
 init/do_mounts.c                    |   12 
 36 files changed, 779 insertions(+), 1175 deletions(-)

through these ChangeSets:

<agrover@groveronline.com> (03/07/29 1.1027)
   ACPI: Allow irqs > 15 to use interrupt semantics other than PCI's
standard
   active-low, level trigger. Make other changes as required for this.
(Andrew de
   Quincey)

<agrover@groveronline.com> (03/07/29 1.1026)
   ACPI: Trivial changes that don't deserve their own changeset

<agrover@groveronline.com> (03/07/29 1.1025)
   ACPI: If notify handler fails to be removed properly, don't just
return, but
   clean up other resources too (Daniele Bellucci)

<len.brown@intel.com> (03/07/29 1.1018.1.3)
   minor cleanup of previous cset

<len.brown@intel.com> (03/07/29 1.1018.1.1)
   rename CONFIG_ACPI_BOOT to CONFIG_ACPI_HT; "acpi=boot" to "acpi=ht"
   Allow acpi=ht, or CONFIG_ACPI_HT to enable HT on systems w/o an MPS
table.
   

<agrover@groveronline.com> (03/07/28 1.1022)
   ACPI: toshiba_acpi update (John Belmonte)

<agrover@groveronline.com> (03/07/28 1.1021)
   ACPI: Better blacklist messages (Jasper Spaans)

<lenb@dhcppc3.> (03/07/23 1.1016.1.1)
   ACPI: update acpi=boot code post testing

<lenb@dhcppc3.> (03/07/22 1.1003.38.2)
   CONFIG_ACPI_BOOT is now a sub-set of CONFIG_ACPI.  It enables just
boot-time config via ACPI --
   useful for enabling HT w/o loading the AML interpreter.
   
   When full CONFIG_ACPI is selected, cmdline "acpi=boot" runs the same
sub-set.
   deleted acpitable.c, deleted broken "noht" cmdline option.

<agrover@groveronline.com> (03/07/17 1.1015)
   ACPI: fix intr enable for IA64 (davidm)

<agrover@groveronline.com> (03/07/17 1.1014)
   ACPI: Fix spinlock warnings (Bjorn Helgaas)

<lenb@dhcppc3.> (03/07/15 1.1002.2.3)
   ACPI: DMI blacklist from UnitedLinux, plus "acpi=oldboot" scheme,
re-named "acpi=cpu"

<agrover@groveronline.com> (03/07/14 1.1003.32.6)
   ACPI: Dynamically allocate SDT list (suggested by Andi Kleen)

<agrover@groveronline.com> (03/07/13 1.1003.32.5)
   ACPI: Parse SSDTs in order discovered, as opposed to reverse order
(Hrvoje Habjanic)

<agrover@groveronline.com> (03/07/13 1.1003.32.4)
   ACPI: Fixes from FreeBSD and NetBSD. (Frank van der Linden, Thomas
Klausner,
   Nate Lawson)

<agrover@groveronline.com> (03/07/13 1.1003.32.3)
   ACPI: DTRT regarding the watchdog during long stalls (Andrew Morton)

<agrover@groveronline.com> (03/07/13 1.1002.7.2)
   ACPI: Make things compile on gcc 3.3

<agrover@groveronline.com> (03/07/13 1.1002.7.1)
   ACPI: Make mp_bus_id_to_pci_bus initialization moderately more
correct

<lenb@dhcppc6.> (03/06/26 1.1002.2.2)
   update kernel-parameters.txt with current acpi and acpismp
parameters.


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

