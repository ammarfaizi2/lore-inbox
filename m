Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTJAFap (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 01:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTJAFap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 01:30:45 -0400
Received: from fmr04.intel.com ([143.183.121.6]:31114 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261923AbTJAFal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 01:30:41 -0400
Subject: [BK PATCH] ACPI 20030918
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0D56318@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0D56318@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1064986198.2574.190.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Oct 2003 01:29:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a

        bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.6.0

With this batch, 2.6 includes all the ACPI updates in 2.4.

Folks w/o BK, a plain patch is available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.0-test6

thanks,
-Len

This will update the following files:

 MAINTAINERS                         |   10
 arch/i386/Kconfig                   |    4
 arch/i386/kernel/acpi/boot.c        |   30 --
 arch/i386/kernel/cpu/cpufreq/acpi.c |   16 -
 arch/i386/kernel/dmi_scan.c         |   33 --
 arch/i386/kernel/mpparse.c          |   69 ++---
 arch/i386/kernel/setup.c            |   16 -
 arch/ia64/kernel/acpi.c             |    2
 arch/x86_64/kernel/setup.c          |    2
 drivers/acpi/Kconfig                |  152 ++++++------
 drivers/acpi/Makefile               |    2
 drivers/acpi/asus_acpi.c            |  293 +++++++++++++-----------
 drivers/acpi/bus.c                  |    3
 drivers/acpi/dispatcher/dsfield.c   |   42 +--
 drivers/acpi/dispatcher/dsinit.c    |    4
 drivers/acpi/dispatcher/dsopcode.c  |   35 +-
 drivers/acpi/dispatcher/dsutils.c   |  114 +++++----
 drivers/acpi/dispatcher/dswload.c   |   18 +
 drivers/acpi/dispatcher/dswscope.c  |   11
 drivers/acpi/dispatcher/dswstate.c  |   30 +-
 drivers/acpi/ec.c                   |    7
 drivers/acpi/events/evregion.c      |    6
 drivers/acpi/executer/excreate.c    |    8
 drivers/acpi/executer/exfldio.c     |   36 ++
 drivers/acpi/namespace/nsdump.c     |    4
 drivers/acpi/namespace/nssearch.c   |    8
 drivers/acpi/namespace/nsutils.c    |    9
 drivers/acpi/parser/psparse.c       |   31 +-
 drivers/acpi/pci_irq.c              |    3
 drivers/acpi/pci_link.c             |   90 +++++--
 drivers/acpi/tables.c               |   15 -
 include/acpi/acconfig.h             |    4
 include/acpi/acdisasm.h             |    4
 include/acpi/acstruct.h             |    3
 include/asm-i386/acpi.h             |   38 ++-
 include/linux/acpi.h                |   16 +
 init/do_mounts.c                    |    2
 init/do_mounts.h                    |   11
 38 files changed, 657 insertions(+), 524 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (03/09/30 1.1383)
   [ACPI] deal with lack of acpi prt entries gracefully (Jesse Barnes)

<len.brown@intel.com> (03/09/30 1.1382)
   [ACPI] build fix: remove 2nd __exit from asus_acpi.c

<len.brown@intel.com> (03/09/30 1.1381)
   [ACPI] acpi4asus-0.25-0.26.diff (Karol Kozimor)

<len.brown@intel.com> (03/09/30 1.1380)
   [ACPI] acpi4asus-0.24a-0.25-2.6.0-test (Karol Kozimor)

<len.brown@intel.com> (03/09/30 1.1267.30.14)
   [ACPI] GV3 IO port is 16-bits (Venkatesh Pallipadi)

<len.brown@intel.com> (03/09/30 1.1267.30.13)
   [ACPI] acpi_pci_link_allocate() should stick with irq.active if set.
(Andrew de Quincey)
   Fixes OSDL #1186 "broken USB" and others

<len.brown@intel.com> (03/09/30 1.1267.30.12)
   [ACPI] add CONFIG_ACPI_RELAXED_AML to config menu

<len.brown@intel.com> (03/09/30 1.1267.30.11)
   [ACPI] CONFIG_ACPI is no longer necessary to enable HT (from 2.4.23)
   if (CONFIG_ACPI || CONFIG_SMP) CONFIG_ACPI_BOOT=y

<len.brown@intel.com> (03/09/29 1.1267.30.10)
   [ACPI] ACPI Component Architecture 20030918 (Bob Moore)

   Found and fixed a longstanding problem with the late execution of
   the various deferred AML opcodes (such as Operation Regions,
   Buffer Fields, Buffers, and Packages)...
   This fixes the "region size computed incorrectly" problem.

   Fixed several 64-bit issues with prototypes, casting and data types.

   Removed duplicate prototype from acdisasm.h

<len.brown@intel.com> (03/09/29 1.1267.30.9)
   [ACPI] CONFIG_ACPI_RELAXED_AML from 2.4
   http://bugzilla.kernel.org/show_bug.cgi?id=1248

<len.brown@intel.com> (03/09/25 1.1267.30.8)
   [ACPI] For ThinkPad -- carry on in face of ECDT probe failure (Andi
Kleen)

<len.brown@intel.com> (03/09/23 1.1267.30.7)
   [ACPI] remove __initdata from acpi_disabled for module use (Andi
Kleen)

<len.brown@intel.com> (03/09/19 1.1267.30.6)
   [ACPI] fix IO-APIC mode SCI storm due to sharing with PCI device
(David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=1165

<len.brown@intel.com> (03/09/18 1.1267.30.5)
   [ACPI] acpi_disabled is used after __initdata is freed.
   fixes random battery module loading problem -- SuSE bug #30477 (Andi
Kleen)

<len.brown@intel.com> (03/09/18 1.1267.30.4)
   [ACPI] Fix IO-APIC mode SCI interrupt storm on Tyan
   http://bugzilla.kernel.org/show_bug.cgi?id=774

<len.brown@intel.com> (03/09/18 1.1267.30.3)
   [ACPI] avoid alloc_bootmem() for accessing ACPI tables
   some platforms use ACPI tables to find memory (Jesse Barnes)

<len.brown@intel.com> (03/09/18 1.1267.29.7)
   ACPI_CA_VERSION                 0x20030916

<len.brown@intel.com> (03/09/18 1.1267.29.6)
   remove ASUS A7V BIOS version 1011 from blacklist (Eric Valette)

<len.brown@intel.com> (03/09/18 1.1267.29.5)
   IBM ThinkPAD T30/T40 oops (David Shaohua Li)
   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=98849

<len.brown@intel.com> (03/09/18 1.1267.29.4)
   Extended IRQ resource type for nForce (Andrew de Quincey)

<len.brown@intel.com> (03/09/18 1.1267.29.3)
   [ACPI] Handle systems that specify non-ACPI-compliant SCI over-rides
(Jun Nakajima)

<len.brown@intel.com> (03/09/18 1.1267.29.2)
   Handle BIOS with _CRS that fails (Jun Nakajima)

<len.brown@intel.com> (03/09/15 1.1130.1.2)
   sync 2.4.22 changes into 2.6
   Note that this restores CONFIG_ACPI_HT_ONLY as a sub-set of
CONFIG_ACPI rather than a dependency.


