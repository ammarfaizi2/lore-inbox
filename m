Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbTEXACv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 20:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264207AbTEXACv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 20:02:51 -0400
Received: from fmr01.intel.com ([192.55.52.18]:48886 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264206AbTEXACq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 20:02:46 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
x-mimeole: Produced By Microsoft Exchange V6.0.6375.0
Subject: [BK PATCH] ACPI updates
Date: Fri, 23 May 2003 17:15:50 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E96ED1@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BK PATCH] ACPI updates
Thread-Index: AcMhiZ9DUWavaArJSEmVfbhmEmy4jA==
From: "Grover, Andrew" <andrew.grover@intel.com>
To: <torvalds@transmeta.com>
Cc: <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 May 2003 00:15:51.0007 (UTC) FILETIME=[A215A6F0:01C32189]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

More ACPI updates. It's been a while since the last ACPI merge so there
are some older changesets still in this tree, as well. New fixes include
fixes for PCI IRQ init, a workaround for noncompliant Compaq BIOSes, and
of course interpreter fixes.

Sourceforge isn't taking uploads atm, so I guess the equivalent patches
will go up Tuesday.

Thanks -- Andy

Please pull from:  http://linux-acpi.bkbits.net/linux-acpi

This will update the following files:

 arch/i386/kernel/mpparse.c         |    6 
 drivers/acpi/dispatcher/dsinit.c   |    4 
 drivers/acpi/dispatcher/dsmethod.c |    2 
 drivers/acpi/dispatcher/dsobject.c |    3 
 drivers/acpi/dispatcher/dsopcode.c |    6 
 drivers/acpi/dispatcher/dswexec.c  |   11 
 drivers/acpi/ec.c                  |   22 -
 drivers/acpi/events/evgpe.c        |    4 
 drivers/acpi/events/evgpeblk.c     |   14 
 drivers/acpi/events/evmisc.c       |   24 -
 drivers/acpi/events/evregion.c     |  353 ++++++++++-----------
 drivers/acpi/events/evrgnini.c     |  168 +++++-----
 drivers/acpi/events/evxface.c      |   62 ++-
 drivers/acpi/events/evxfevnt.c     |    4 
 drivers/acpi/events/evxfregn.c     |   96 +++--
 drivers/acpi/executer/exconfig.c   |    8 
 drivers/acpi/executer/exdump.c     |   38 +-
 drivers/acpi/hardware/hwgpe.c      |   24 -
 drivers/acpi/hardware/hwregs.c     |  120 +++----
 drivers/acpi/hardware/hwtimer.c    |    2 
 drivers/acpi/namespace/nsalloc.c   |   40 ++
 drivers/acpi/namespace/nsdumpdv.c  |   14 
 drivers/acpi/namespace/nsload.c    |   18 -
 drivers/acpi/namespace/nsparse.c   |    3 
 drivers/acpi/namespace/nssearch.c  |   11 
 drivers/acpi/namespace/nsutils.c   |   27 -
 drivers/acpi/namespace/nsxfeval.c  |   33 +-
 drivers/acpi/namespace/nsxfname.c  |  141 +++++---
 drivers/acpi/osl.c                 |    4 
 drivers/acpi/parser/psargs.c       |    5 
 drivers/acpi/parser/pswalk.c       |    2 
 drivers/acpi/parser/psxface.c      |    2 
 drivers/acpi/resources/rsxface.c   |   12 
 drivers/acpi/scan.c                |   77 ++--
 drivers/acpi/tables/tbconvrt.c     |  114 +++++--
 drivers/acpi/tables/tbget.c        |   14 
 drivers/acpi/tables/tbgetall.c     |    2 
 drivers/acpi/tables/tbinstal.c     |  195 ++++--------
 drivers/acpi/tables/tbutils.c      |   17 -
 drivers/acpi/tables/tbxface.c      |   20 -
 drivers/acpi/toshiba_acpi.c        |   15 
 drivers/acpi/utilities/utcopy.c    |   20 -
 drivers/acpi/utilities/utdelete.c  |   71 +---
 drivers/acpi/utilities/uteval.c    |  180 +++++++++--
 drivers/acpi/utilities/utglobal.c  |   36 +-
 drivers/acpi/utilities/utmisc.c    |   46 +-
 drivers/acpi/utilities/utobject.c  |   20 -
 drivers/acpi/utilities/utxface.c   |   64 ++-
 include/acpi/acconfig.h            |   11 
 include/acpi/acdebug.h             |   17 -
 include/acpi/acdisasm.h            |  406 +++++++++++++++++++++++++
 include/acpi/acevents.h            |    2 
 include/acpi/acexcep.h             |    6 
 include/acpi/acglobal.h            |   20 -
 include/acpi/achware.h             |    6 
 include/acpi/aclocal.h             |   29 -
 include/acpi/acmacros.h            |   20 -
 include/acpi/acnamesp.h            |    5 
 include/acpi/acobject.h            |   12 
 include/acpi/acpi_bus.h            |    1 
 include/acpi/acpiosxf.h            |    4 
 include/acpi/acpixf.h              |    4 
 include/acpi/actables.h            |   10 
 include/acpi/actypes.h             |   50 ++-
 include/acpi/acutils.h             |    2 
 include/acpi/amlresrc.h            |  329 ++++++++++++++++++++
 66 files changed, 2049 insertions(+), 1059 deletions(-)

through these ChangeSets:

<agrover@groveronline.com> (03/05/23 1.1221)
   ACPI: Allow multiple compatible IDs for PnP purposes

<agrover@groveronline.com> (03/05/23 1.1220)
   ACPI: update to 20030522
   
   Found and fixed a reported problem where an AE_NOT_FOUND error
occurred occasionally
   during _BST evaluation.  This turned out to be an Owner ID allocation
issue where a
   called method did not get a new ID assigned to it.  Eventually,
(after 64k calls), the
   Owner ID UINT16 would wraparound so that the ID would be the same as
the caller's and the
   called method would delete the caller's namespace.
   
   Implemented extended error reporting for control methods that are
aborted due to a
   run-time exception.  Output includes the exact AML instruction that
caused the method
   abort, a dump of the method locals and arguments at the time of the
abort, and a trace of
   all nested control method calls.
   
   Modified the interpreter to allow the creation of buffers of zero
length from the AML
   code. Implemented new code to ensure that no attempt is made to
actually allocate a
   memory buffer (of length zero), only a buffer object with a NULL
buffer pointer and
   length zero.  A warning is no longer issued when the AML attempts to
create a zero-length
   buffer.
   
   Implemented a workaround for the "leading asterisk problem" in _HIDs,
_UIDs, and _CIDs.
   One leading asterisk is automatically removed if present in all HID,
UID, and CID
   strings.
   
   Implemented full support for _CID methods that return a package of
multiple CIDs.  The
   AcpiGetObjectInfo interface now returns a device _HID, _UID, and _CID
list if present.
   This required a change to the external interface to pass an
ACPI_BUFFER object as a
   parameter, since the _CID list is of variable length.
   
   Fixed a problem with the new AE_SAME_HANDLER exception where handler
initialization code
   did not know about this exception.

<agrover@groveronline.com> (03/05/21 1.1184.3.2)
   ACPI: Do not reinit ACPI irq entry in ioapic (thanks to Stian Jordet)

<agrover@groveronline.com> (03/05/19 1.1127.2.22)
   ACPI: Update Toshiba driver to 0.15 (John Belmonte)
   - workaround sporadic problem with hotkey ceasing to work
   - cleanups

<agrover@groveronline.com> (03/05/16 1.1063.36.2)
   ACPI: Return only proper values (0 or 1) from our interrupt handler
   (Andrew Morton)

<agrover@groveronline.com> (03/05/12 1.1063.23.4)
   ACPI: Interpreter update to 20030509
   Changed the subsystem initialization sequence to hold off
installation of
   address space handlers until the hardware has been initialized and
the
   system has entered ACPI mode.  This is because the installation of
space
   handlers can cause _REG methods to be run.  Previously, the _REG
methods
   could potentially be run before ACPI mode was enabled.
   
   Fixed some memory leak issues related to address space handler and
notify
   handler installation.  There were some problems with the reference
count
   mechanism caused by the fact that the handler objects are shared
across
   several namespace objects.
   
   Fixed a reported problem where reference counts within the namespace
were
   not properly updated when named objects created by method execution
were
   deleted.
   
   Fixed a reported problem where multiple SSDTs caused a deletion issue
   during subsystem termination.  Restructured the table data structures
   to simplify the linked lists and the related code.
   
   Fixed a problem where the table ID associated with secondary tables
(SSDTs)
   was not being propagated into the namespace objects created by those
   tables.  This would only present a problem for tables that are
unloaded
   at run-time, however.
   
   Updated AcpiOsReadable and AcpiOsWritable to use the ACPI_SIZE type
as
   the length parameter (instead of UINT32).
   
   Solved a long-standing problem where an ALREADY_EXISTS error appears
on
   various systems.  This problem could happen when there are multiple
   PCI_Config operation regions under a single PCI root bus.  This
doesnt
   happen very frequently, but there are some systems that do this in
the
   ASL.
   
   Fixed a reported problem where the internal DeleteNode function was
   incorrectly handling the case where a namespace node was the first in
   the parents child list, and had additional peers (not the only child,
   but first in the list of children.)

<agrover@groveronline.com> (03/05/12 1.1063.23.3)
   ACPI: Allow ":" in OS override string (Ducrot Bruno)

<agrover@groveronline.com> (03/05/12 1.1063.23.2)
   ACPI: kobject fix (Greg KH)
   Here's a small patch that fixes the logic of the kobject creation and
   registration in the acpi code (since we use kobject_init(), we need
to
   use kobject_add(), not kobject_register() to add the kobject to the
   kernel systems).

<agrover@groveronline.com> (03/04/24 1.1042.45.4)
   ACPI: Update to 20030424
   - Remove an unused parameter from lowlevel read/write functions
   - FADT initialization cleanups


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

