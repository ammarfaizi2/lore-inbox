Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbUC2ReY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbUC2ReY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:34:24 -0500
Received: from fmr05.intel.com ([134.134.136.6]:6054 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262915AbUC2ReE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 12:34:04 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
Date: Mon, 29 Mar 2004 09:32:30 -0800
Message-ID: <37F890616C995246BE76B3E6B2DBE055202072@orsmsx403.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] [BKPATCH] ACPI for 2.6
Thread-Index: AcQTl3RbZqR8l+K3QOeT2j6BHf3BxQAQxHsgAHZFS1A=
From: "Moore, Robert" <robert.moore@intel.com>
To: "Manpreet Singh" <Manpreet.Singh@efi.com>,
       "Brown, Len" <len.brown@intel.com>,
       "Linus Torvalds" <torvalds@osdl.org>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "ACPI Developers" <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 29 Mar 2004 17:32:31.0885 (UTC) FILETIME=[D0C0EBD0:01C415B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What makes you think that *all* GPEs are disabled?

Here is the relevant code:

        /*
         * 1) Disable all runtime GPEs 
         * 2) Enable all wakeup GPEs
         */
        Status = AcpiHwLowLevelWrite (8, GpeRegisterInfo->WakeEnable,
                &GpeRegisterInfo->EnableAddress);

The "WakeEnable" field is setup such that only the WAKE GPEs are
enabled.

Unless you are saying that "WakeEnable" is not initialized correctly.

Please clarify.

Bob


-----Original Message-----
From: acpi-devel-admin@lists.sourceforge.net
[mailto:acpi-devel-admin@lists.sourceforge.net] On Behalf Of Manpreet
Singh
Sent: Saturday, March 27, 2004 1:19 AM
To: Brown, Len; Linus Torvalds
Cc: Kernel Mailing List; ACPI Developers
Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6

Hi Len,

This patch on 2.6.5-rc2 certainly helps with a "spurious" interrupt
problem
that I was seeing on a 2.6.4 kernel. It seems that we don't initialize
GPEs
unless they are needed for a resume.

But, in the function call "acpi_hw_prepare_gpes_for_sleep", it seems
that
currently *all* GPEs get disabled, some of which I would consider wake
up
events, like the PME enable bit that enables an S3 resume using a magic
packet. That doesn't allow wake on LAN to work properly. Is there way to
pick/specify the wake up events or does it come from the BIOS tables?

Also, if I have the console on a serial port, I don't get the console
back
after an S3 resume.

Actually, I am new to the ACPI list. If this is not the right place for
these
queries, please let me know.

Thanks,
Manpreet.


-----Original Message-----
From: acpi-devel-admin@lists.sourceforge.net
[mailto:acpi-devel-admin@lists.sourceforge.net]On Behalf Of Len Brown
Sent: Friday, March 26, 2004 4:59 PM
To: Linus Torvalds
Cc: Kernel Mailing List; ACPI Developers
Subject: [ACPI] [BKPATCH] ACPI for 2.6


Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.5

	Three significant interrupt fixes.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2
.6.5/
acpi-20040326-2.6.5.diff.gz

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






-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Acpi-devel mailing list
Acpi-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=ick
_______________________________________________
Acpi-devel mailing list
Acpi-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/acpi-devel
