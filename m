Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbUCNGE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 01:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbUCNGE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 01:04:27 -0500
Received: from fmr05.intel.com ([134.134.136.6]:2522 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S263306AbUCNGCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 01:02:41 -0500
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1079244088.2173.134.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Mar 2004 01:01:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.26

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.26/acpi-20040311-2.4.26.diff.gz

This will update the following files:

 Documentation/kernel-parameters.txt |    4 +
 arch/i386/kernel/acpi.c             |    3 
 drivers/acpi/dispatcher/dsmethod.c  |   85 ++++++++++++++++--------
 drivers/acpi/events/evgpe.c         |    5 +
 drivers/acpi/executer/excreate.c    |   20 +++--
 drivers/acpi/executer/exmutex.c     |   28 ++++---
 drivers/acpi/namespace/nsaccess.c   |   30 ++++++--
 drivers/acpi/namespace/nsalloc.c    |    7 +
 drivers/acpi/namespace/nseval.c     |   15 +++-
 drivers/acpi/osl.c                  |   36 ++++++++++
 drivers/acpi/parser/psparse.c       |   44 +++++++++++-
 drivers/acpi/parser/psscope.c       |    9 --
 drivers/acpi/system.c               |    3 
 drivers/acpi/utilities/uteval.c     |   56 +++++++++++++++
 drivers/acpi/utilities/utglobal.c   |   28 ++++---
 include/acpi/acconfig.h             |    6 +
 include/acpi/acglobal.h             |   11 ++-
 include/acpi/acmacros.h             |    3 
 include/acpi/acobject.h             |    7 +
 include/acpi/actypes.h              |    5 -
 include/acpi/acutils.h              |    6 +
 include/acpi/amlcode.h              |   14 ++-
 include/asm-i386/acpi.h             |   51 +++++++-------
 include/asm-x86_64/acpi.h           |   59 +++++++---------
 24 files changed, 379 insertions(+), 156 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/03/13 1.1063.46.83)
   [ACPI] add boot parameters "acpi_osi=" and "acpi_serialize"
     acpi_osi= will disable the _OSI method -- which by default
   	tells the BIOS to behave as if Windows is the OS.
     acpi_serialize is for debugging AE_ALREADY_EXISTS failures
   

<len.brown@intel.com> (04/03/13 1.1063.46.82)
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

<len.brown@intel.com> (04/03/13 1.1063.46.81)
   [ACPI] SMP poweroff (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=1141

<len.brown@intel.com> (04/03/05 1.1063.46.80)
   [ACPI] global lock macro fixes (Paul Menage, Luming Yu)
     http://bugzilla.kernel.org/show_bug.cgi?id=1669

<len.brown@intel.com> (04/03/05 1.1063.46.79)
   [ACPI] acpi_wakeup_address - print only when broken




