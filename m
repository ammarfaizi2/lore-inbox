Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266694AbUBGJLQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 04:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUBGJLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 04:11:16 -0500
Received: from fmr04.intel.com ([143.183.121.6]:52377 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266694AbUBGJKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 04:10:53 -0500
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1076145027.8682.34.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Feb 2004 04:10:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.6.3

	ACPI cpufreq related updates from Dominik, Asus and Toshiba
	model specific updates from Karol and John, misc IA64
	ACPI tweaks from Jes Sorensen etc.  All but Toshiba
	and Asus have been through -mm.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.3/acpi-20040116-2.6.3.diff.gz

This will update the following files:

 CREDITS                             |    5 
 arch/i386/kernel/acpi/boot.c        |   20 
 arch/i386/kernel/cpu/cpufreq/acpi.c |  766 ++++-----------------
 arch/ia64/kernel/acpi.c             |   22 
 arch/ia64/kernel/iosapic.c          |    2 
 arch/x86_64/kernel/acpi/boot.c      |   20 
 drivers/acpi/asus_acpi.c            |  753 +++++++++++++--------
 drivers/acpi/dispatcher/dsmthdat.c  |    5 
 drivers/acpi/numa.c                 |   28 
 drivers/acpi/pci_irq.c              |   12 
 drivers/acpi/processor.c            |  853 ++++++++++++++++++++----
 drivers/acpi/tables.c               |   28 
 drivers/acpi/toshiba_acpi.c         |   81 +-
 drivers/cpufreq/cpufreq.c           |    2 
 include/acpi/processor.h            |   30 
 include/asm-ia64/iosapic.h          |    3 
 include/linux/acpi.h                |    4 
 17 files changed, 1509 insertions(+), 1125 deletions(-)

through these ChangeSets:

<sziwan@hell.org.pl> (04/02/06 1.1493.1.16)
   [PATCH] acpi4asus update from Karol 'sziwan' Kozimor
   
   The attached patch updates the acpi4asus driver to 0.27 through the
   following changes:
   - add support for M1300A, S5200N, L8400L,
   - remove WLED support for certain models, since it is not controlled
by
     AML,
   - add LCD backlight switching for L2E / L3H,
   - C99 initializers,
   - generic LED handlers,
   - the output of ASYM method to provide battery state information
(might be
     more accurate under certain conditions) in /proc/acpi/asus/info,
   - fix several oddities, various clean-ups and other minor changes.
   
   The patch itself is quite big, which is mostly due to the C99
initializers
   and the fact that diff doesn't like moving code around.
   
   This has been compile-tested in various configurations, the
substantive
   changes were discussed on the acpi4asus mailing list.
   
   The code should apply to current bk (both for 2.4 and 2.6). The patch
is
   also available here:
   http://hell.org.pl/~sziwan/asus/acpi4asus-0.26-0.27.diff
   
   Thanks to all the contributors (notably Pontus Fuchs) to this
release.

<john@neggie.net> (04/02/05 1.1493.1.15)
   [PATCH] toshiba_acpi 0.17 from John Belmonte
   
   Fix remote chance of invalid buffer access in write_video.
   Support alternate HCI method path (recent "Phoenix BIOS" Toshiba's).
   Signal more proc-write errors.
   On proc-reads, report errors via printk instead of proc output.
   Add log level and driver name prefix to all printk's.
   Add missing __init and __exit function attributes.
   Be explicit about vars for which code relies on zero-init of BSS.

<len.brown@intel.com> (04/02/05 1.1493.1.14)
   [ACPI] fix IA64 build warning
   from Martin Hicks

<linux@dominikbrodowski.de> (04/01/30 1.1493.1.12)
   [ACPI] make # of performance states dynamic
   
   from Dominik Brodowski

<linux@dominikbrodowski.de> (04/01/30 1.1493.1.11)
   [ACPI] add _PDC support
   
   Add support for _PDC to the ACPI processor "Performance States
library" 
   (perflib). If this field is empty, a bogus entry is passed to the
_PDC
   method so that the default (io) access is returned again. This patch
   is partly based on David Moore's patch to
   arch/i386/kernel/cpu/cpufreq/acpi.c, sent to the cpufreq mailing list
on
   June 24th, 2003.

<linux@dominikbrodowski.de> (04/01/30 1.1493.1.10)
   [ACPI] Abstract the registration method between low-level drivers
   and the ACPI Processor P-States driver.
   
   from Dominik Brodowski

<linux@dominikbrodowski.de> (04/01/30 1.1493.1.9)
   [ACPI] Move the /proc/acpi/processor/./performance output to
   drivers/acpi/processor.c -- it's the same for all lowlevel drivers.
   
   By doing so, the lowlevel drivers no longer need
   to have access to struct acpi_processor.
   
   from Dominik Brodowski

<linux@dominikbrodowski.de> (04/01/30 1.1493.1.8)
   [ACPI] Move the _PSS and _PCT access to drivers/acpi/processor.c
     so that it can be used by various low-level drivers
     (centrino, acpi-io, powernow-k{7,8}, ...)
     from Dominik Brodowski

<len.brown@intel.com> (04/01/30 1.1491.1.15)
   [ACPI] proposed fix for AML parameter passing from Bob Moore
     http://bugzilla.kernel.org/show_bug.cgi?id=1766

<len.brown@intel.com> (04/01/29 1.1491.1.14)
   [ACPI] quiet numa boot -- from Jes Sorensen

<len.brown@intel.com> (04/01/29 1.1491.1.13)
   fix build error from undefined NR_IRQ_VECTORS

<linux@dominikbrodowski.de> (04/01/28 1.1491.1.12)
   [ACPI] more acpi-cpufreq fixups from Dominik Brodowski
   
   Fix a horribly wrong memcpy instruction in cpufreq_update_policy
which
   caused it to oops.

<linux@dominikbrodowski.de> (04/01/28 1.1493.1.5)
   [ACPI] acpi-cpufreq fixups from Dominik Brodowski
   
   - remove unnecessary usage of flags.performance
   - remove double check of _PPC in acpi-cpufreq driver as it's handled
in
     drivers/acpi/processor.c already
   - remove unneeded EXPORT_SYMBOL
   - allocation of memory only for probed CPUs
   - add unregistration function to the core
   - fix OOPS when PST has core_frequency values of zero
   - fix cpufreq_get() output
   - fix /proc/acpi/processor/*/performance write support [deprecated]

<linux@dominikbrodowski.de> (04/01/28 1.1491.1.11)
   [ACPI] update _PPC handling -- from Dominik Brodowski
   
   updates the _PPC handling. It is handled as a CPUfreq
   policy notifier which adjusts the maximum CPU speed
   according to the current platform limit.

<linux@dominikbrodowski.de> (04/01/28 1.1491.1.10)
   [ACPI] remove unnecessary check in acpi-cpufreq driver
   from Dominik Brodowski
   
   The acpi cpufreq driver includes a test at startup which detects
whether
   ACPI P-States are supported on any CPU, and whether transitions work.
   However, this test is faulty: it is only run _after_ the acpi driver
is
   registered, causing race situations. Also, it doesn't save anything
_as_ the
   driver is already registered. So, it can safely be removed.

<linux@dominikbrodowski.de> (04/01/28 1.1491.1.9)
   [ACPI] update passive cooling algorithm
   	from Dominik Brodowski
   
   The current algorithm used by Linux ACPI for passive thermal
management has
   two shortcomings:
   
   - if increasing the CPU processing power as a thermal situation goes
away,
     throttling states are decreased later than performance states. This
is
     not wise -- it should be the opposite ordering of going "up".
   
   - only if the ACPI CPUfreq driver is used, performance states are
used.
     A generalized approach would offer passive cooling even if the ACPI
     P-States cpufreq driver cannot be used (faulty BIOS, FixedHW
access, etc.)

<jes@wildopensource.com> (04/01/27 1.1491.1.8)
   [ACPI] Check for overflow when parsing MADT entries
   from Jes Sorensen

<len.brown@intel.com> (04/01/27 1.1500.1.2)
   [ACPI] add Bruno Ducrot to CREDITS





