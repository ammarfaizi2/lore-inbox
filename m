Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbUCNGIr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 01:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbUCNGIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 01:08:47 -0500
Received: from fmr06.intel.com ([134.134.136.7]:46051 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263300AbUCNGIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 01:08:39 -0500
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1079244089.2174.137.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Mar 2004 01:08:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.5

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.5/acpi-20040311-2.6.5.diff.gz

This will update the following files:

 Documentation/kernel-parameters.txt |    4 +
 arch/i386/kernel/acpi/boot.c        |   24 ++----
 arch/i386/kernel/bootflag.c         |    2 
 drivers/acpi/dispatcher/dsmethod.c  |   85 ++++++++++++++++--------
 drivers/acpi/events/evgpe.c         |    5 +
 drivers/acpi/executer/excreate.c    |   20 +++--
 drivers/acpi/executer/exmutex.c     |   28 ++++---
 drivers/acpi/hardware/hwsleep.c     |    2 
 drivers/acpi/namespace/nsaccess.c   |   30 ++++++--
 drivers/acpi/namespace/nsalloc.c    |    7 +
 drivers/acpi/namespace/nseval.c     |   15 +++-
 drivers/acpi/osl.c                  |   36 ++++++++++
 drivers/acpi/parser/psparse.c       |   44 +++++++++++-
 drivers/acpi/parser/psscope.c       |    9 --
 drivers/acpi/power.c                |   12 +++
 drivers/acpi/sleep/poweroff.c       |    3 
 drivers/acpi/tables.c               |    7 +
 drivers/acpi/utilities/uteval.c     |   56 +++++++++++++++
 drivers/acpi/utilities/utglobal.c   |   28 ++++---
 include/acpi/acconfig.h             |    6 +
 include/acpi/acglobal.h             |   11 ++-
 include/acpi/acmacros.h             |    3 
 include/acpi/acobject.h             |    7 +
 include/acpi/acpixf.h               |    2 
 include/acpi/actypes.h              |    5 -
 include/acpi/acutils.h              |    6 +
 include/acpi/amlcode.h              |   14 ++-
 include/asm-i386/acpi.h             |   53 ++++++++------
 include/asm-x86_64/acpi.h           |    4 -
 include/asm-x86_64/system.h         |    7 -
 30 files changed, 385 insertions(+), 150 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/03/13 1.1608.1.43)
   [ACPI] add boot parameters "acpi_osi=" and "acpi_serialize"
     acpi_osi= will disable the _OSI method -- which by default
   	tells the BIOS to behave as if Windows is the OS.
     acpi_serialize is for debugging AE_ALREADY_EXISTS failures

<len.brown@intel.com> (04/03/13 1.1608.1.42)
   [ACPI] ACPICA 20040311 from Bob Moore
   
   Fixed a problem where errors occurring during the parse phase of
control
   method execution did not abort cleanly.  For example, objects created
   and installed in the namespace were not deleted.  This caused all
   subsequent invocations of the method to return the AE_ALREADY_EXISTS
   exception.
   
   Implemented a mechanism to force a control method to "Serialized"
   execution if the method attempts to create namespace objects.
   (The root of the AE_ALREADY_EXISTS problem.)
   
   Implemented support for the predefined _OSI "internal" control
method.
   Initial supported strings are "Linux", "Windows 2000", "Windows
2001",
   and "Windows 2001.1", and can be easily upgraded for new strings as
   necessary.  This feature allows Linux to execute
   the fully tested, "Windows" code path through the ASL code
   
   Global Lock Support:  Now allows multiple acquires and releases with
any
   internal thread.  Removed concept of "owning thread" for this special
   mutex.
   
   Fixed two functions that were inappropriately declaring large objects
on
   the CPU stack: ps_parse_loop() and ns_evaluate_relative().
   Reduces the stack usage during method execution considerably.
   
   Fixed a problem in the ACPI 2.0 FACS descriptor (actbl2.h) where the
   S4Bios_f field was incorrectly defined as UINT32 instead of
UINT32_BIT.
   
   Fixed a problem where acpi_ev_gpe_detect() would fault
   if there were no GPEs defined on the machine.
   
   Implemented two runtime options:  One to force all control method
   execution to "Serialized" to mimic Windows behavior, another to
disable
   _OSI support if it causes problems on a given machine.

<len.brown@intel.com> (04/03/13 1.1608.1.41)
   [ACPI] SMP poweroff (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=1141

<len.brown@intel.com> (04/03/10 1.1557.76.9)
   [ACPI] fix printk and build warning from previous csets

<len.brown@intel.com> (04/03/10 1.1557.76.8)
   Delete (void)func() casts considered cruft in Linux style.
   
   GCC's inability to warn when return values are ignored has
conditioned
   Linux programmers into thinking that this is actually normal.
   
   delete some #define's -- suggested by Matt Wilcox

<akpm@osdl.org> (04/03/06 1.1608.1.36)
   [PATCH] gcc-3.5: acpi build fix
   
   Current gcc requires that both the declaration and the definition of
   functions describe the same register conventions.

<len.brown@intel.com> (04/03/05 1.1557.76.7)
   [ACPI] global lock macro fixes (Paul Menage, Luming Yu)
     http://bugzilla.kernel.org/show_bug.cgi?id=1669

<len.brown@intel.com> (04/03/05 1.1557.76.6)
   [ACPI] comments

<len.brown@intel.com> (04/03/03 1.1608.1.33)
   asmlinkage acpi_enter_sleep_state_s4bios() - from Pavel Machek




