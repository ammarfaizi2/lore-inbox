Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUC0A7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 19:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbUC0A7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 19:59:30 -0500
Received: from fmr99.intel.com ([192.55.52.32]:33154 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S261531AbUC0A70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 19:59:26 -0500
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1080349151.16211.33.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Mar 2004 19:59:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.5

	Three significant interrupt fixes.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.5/acpi-20040326-2.6.5.diff.gz

This will update the following files:

 arch/i386/kernel/acpi/boot.c      |   18 +
 drivers/acpi/ec.c                 |    4 
 drivers/acpi/events/evgpe.c       |   11 -
 drivers/acpi/events/evgpeblk.c    |  242 ++++++++++++++++++++++----
 drivers/acpi/events/evmisc.c      |   43 ++--
 drivers/acpi/events/evxfevnt.c    |   25 ++
 drivers/acpi/executer/excreate.c  |   16 +
 drivers/acpi/executer/exdump.c    |    1 
 drivers/acpi/executer/exresnte.c  |    5 
 drivers/acpi/executer/exstoren.c  |    1 
 drivers/acpi/hardware/hwgpe.c     |   98 ++++++----
 drivers/acpi/hardware/hwsleep.c   |   22 +-
 drivers/acpi/namespace/nsaccess.c |    9 
 drivers/acpi/namespace/nsdump.c   |    1 
 drivers/acpi/namespace/nseval.c   |    9 
 drivers/acpi/namespace/nssearch.c |    6 
 drivers/acpi/namespace/nsutils.c  |    2 
 drivers/acpi/namespace/nsxfeval.c |   26 +-
 drivers/acpi/osl.c                |   21 ++
 drivers/acpi/pci_link.c           |   18 +
 drivers/acpi/resources/rsaddr.c   |   13 -
 drivers/acpi/utilities/utglobal.c |   42 ++--
 drivers/acpi/utilities/utmisc.c   |    5 
 include/acpi/acconfig.h           |    2 
 include/acpi/acglobal.h           |    2 
 include/acpi/achware.h            |    4 
 include/acpi/aclocal.h            |    7 
 include/acpi/actypes.h            |   84 +++++----
 include/acpi/acutils.h            |    1 
 29 files changed, 537 insertions(+), 201 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/03/26 1.1608.1.56)
   [ACPI] Linux specific updates from ACPICA 20040326
   "acpi_wake_gpes_always_on" boot flag for old GPE behaviour

<len.brown@intel.com> (04/03/26 1.1608.1.55)
   [ACPI] ACPICA 20040326 from Bob Moore
   
   Implemented support for "wake" GPEs via interaction between
   GPEs and the _PRW methods.  Every GPE that is pointed to by
   one or more _PRWs is identified as a WAKE GPE and by default
   will no longer be enabled at runtime.  Previously, we were
   blindly enabling all GPEs with a corresponding _Lxx or _Exx
   method - but most of these turn out to be WAKE GPEs anyway.
   We believe this has been the cause of thousands of
   "spurious" GPEs on some systems.
   
   This new GPE behavior is can be reverted to the original
   behavior (enable ALL GPEs at runtime) via a runtime flag.
   
   Fixed a problem where aliased control methods could not
   access objects properly.  The proper scope within the
   namespace was not initialized (transferred to the target of
   the aliased method) before executing the target method.
   
   Fixed a potential race condition on internal object
   deletion on the return object in AcpiEvaluateObject. 
   
   Integrated a fix for resource descriptors where both
   _MEM and _MTP were being extracted instead of just _MEM.
   (i.e. bitmask was incorrectly too wide, 0x0F instead of 0x03.)
   
   Added a special case for ACPI_ROOT_OBJECT in AcpiUtGetNodeName,
   preventing a fault in some cases.
   
   Updated Notify() values for debug statements in evmisc.c
   
   Return proper status from AcpiUtMutexInitialize,
   not just simply AE_OK.

<len.brown@intel.com> (04/03/26 1.1608.1.54)
   [ACPI] proposed fix for non-identity-mapped SCI override
   http://bugme.osdl.org/show_bug.cgi?id=2366

<len.brown@intel.com> (04/03/25 1.1608.1.53)
   [ACPI] PCI interrupt link routing (Luming Yu)
   use _PRS to determine resource type for _SRS
   fixes HP Proliant servers
   http://bugzilla.kernel.org/show_bug.cgi?id=1590




