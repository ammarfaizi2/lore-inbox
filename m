Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUC0AyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 19:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbUC0AyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 19:54:24 -0500
Received: from fmr10.intel.com ([192.55.52.30]:54984 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S261554AbUC0AyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 19:54:10 -0500
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1080348837.16211.28.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Mar 2004 19:53:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.26

	Three fixes, all interrupt related.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.26/acpi-20040326-2.4.26.diff.gz

This will update the following files:

 arch/i386/kernel/acpi.c           |   18 +
 arch/x86_64/kernel/acpi.c         |   18 +
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
 30 files changed, 548 insertions(+), 208 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/03/26 1.1063.46.91)
   [ACPI] Linux specific updates from ACPICA 20040326
   "acpi_wake_gpes_always_on" boot flag for old GPE behaviour

<len.brown@intel.com> (04/03/26 1.1063.46.90)
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

<len.brown@intel.com> (04/03/26 1.1063.46.89)
   [ACPI] proposed fix for non-identity-mapped SCI override
   http://bugme.osdl.org/show_bug.cgi?id=2366

<len.brown@intel.com> (04/03/25 1.1302.46.18)
   [ACPI] PCI interrupt link routing (Luming Yu)
   use _PRS to determine resource type for _SRS
   fixes HP Proliant servers
   http://bugzilla.kernel.org/show_bug.cgi?id=1590




