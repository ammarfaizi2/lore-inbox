Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbUCWKDB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUCWKDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:03:01 -0500
Received: from fmr06.intel.com ([134.134.136.7]:40072 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262420AbUCWKC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:02:56 -0500
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1080036132.21687.310.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Mar 2004 05:02:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.5

	A couple of key fixes in this batch.
	Sync x86_64 up to i386.
	SCI trigger/polarity fix
	yenta interrupt fix
	toshiba panic on 4G/4G fix
	etc.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.5/acpi-20040311-2.6.5.diff.gz

This will update the following files:

 arch/x86_64/kernel/acpi/boot.c      |  619 ------------------------
 Documentation/kernel-parameters.txt |    6 
 arch/i386/kernel/acpi/boot.c        |  172 +++++-
 arch/i386/kernel/dmi_scan.c         |   15 
 arch/i386/kernel/mpparse.c          |  158 +-----
 arch/i386/kernel/setup.c            |   34 +
 arch/ia64/kernel/acpi.c             |    2 
 arch/x86_64/kernel/Makefile         |    1 
 arch/x86_64/kernel/acpi/Makefile    |    2 
 arch/x86_64/kernel/mpparse.c        |   77 --
 arch/x86_64/kernel/setup.c          |   25 
 drivers/acpi/Kconfig                |    1 
 drivers/acpi/bus.c                  |   40 -
 drivers/acpi/numa.c                 |   11 
 drivers/acpi/pci_irq.c              |   14 
 drivers/acpi/processor.c            |    4 
 drivers/acpi/toshiba_acpi.c         |   55 +-
 drivers/char/sonypi.h               |    1 
 include/acpi/acpi_bus.h             |    2 
 include/asm-i386/acpi.h             |    6 
 include/asm-i386/mpspec.h           |   11 
 include/asm-ia64/acpi.h             |    2 
 include/asm-x86_64/acpi.h           |    3 
 include/asm-x86_64/mpspec.h         |    2 
 24 files changed, 335 insertions(+), 928 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/03/23 1.1608.1.52)
   [ACPI] share i386/kernel/acpi/boot.c with x86_64

<len.brown@intel.com> (04/03/23 1.1608.1.51)
   [ACPI] toshiba_acpi 0.18 from John Belmonte
     add missing copyin

<len.brown@intel.com> (04/03/22 1.1608.1.50)
   [ACPI] delete POWER_OF_TWO array (Pavel Machek)

<len.brown@intel.com> (04/03/22 1.1608.1.49)
   [ACPI] ACPI SCI shall be level/low unless explicit over-ride
   http://bugzilla.kernel.org/show_bug.cgi?id=1622
   add "acpi_sci=edge" and "acpi_sci=high" manual over-ride

<len.brown@intel.com> (04/03/21 1.1608.1.48)
   [ACPI] fix interrupts behind yenta cardbus bridge (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=1564

<bjorn.helgaas@hp.com> (04/03/21 1.1608.1.47)
   [PATCH] clean up ACPI GSI/IRQ conversions (i386 part)
   
   Add "acpi_gsi_to_irq()" as a generic replacement for
"acpi_irq_to_vector()".
   This converts from an ACPI global system interrupt number to a Linux
IRQ.
   Also, convert i386-specific terminology to use GSI when appropriate.

<len.brown@intel.com> (04/03/21 1.1608.1.46)
   [ACPI] create disable_acpi()

<len.brown@intel.com> (04/03/18 1.1608.1.45)
   [ACPI] numa.c build fix (Luming Yu)
   http://bugzilla.kernel.org/show_bug.cgi?id=2131

<len.brown@intel.com> (04/03/17 1.1608.1.44)
   [ACPI] check "maxcpus=N" early -- same as NR_CPUS check.
   http://bugzilla.kernel.org/show_bug.cgi?id=2317
   
   When the BIOS enumerates physical processors before logical,
   maxcpus=N/2 will now effectively disable HT.
   
   This can be verified by boot messages warning that HT is off:
   eg. "maxcpus=2" on a 2xHT system:
   
   Total of 2 processors activated (11141.12 BogoMIPS).
   WARNING: No sibling found for CPU 0.
   WARNING: No sibling found for CPU 1.




