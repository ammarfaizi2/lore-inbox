Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161363AbWGJG7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161363AbWGJG7z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 02:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161362AbWGJG7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 02:59:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:33436 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161358AbWGJG7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 02:59:54 -0400
X-IronPort-AV: i="4.06,222,1149490800"; 
   d="scan'208"; a="95524670:sNHT95986695"
From: Len Brown <len.brown@intel.com>
Organization: Intel Open Source Technology Center
To: torvalds@osdl.org
Subject: [GIT PATCH] ACPI for 2.6.18-rc1
Date: Mon, 10 Jul 2006 03:01:58 -0400
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200606230437.50845.len.brown@intel.com> <200606300220.39405.len.brown@intel.com> <200607011730.24361.len.brown@intel.com>
In-Reply-To: <200607011730.24361.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607100301.58861.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This will restore the ACPI_DOCK driver, plus other fixes below.

thanks!

-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.18/acpi-release-20060707-2.6.18-rc1.diff.gz

 drivers/acpi/Kconfig               |    9 
 drivers/acpi/Makefile              |    1 
 drivers/acpi/ac.c                  |    2 
 drivers/acpi/battery.c             |    6 
 drivers/acpi/bus.c                 |    4 
 drivers/acpi/button.c              |    4 
 drivers/acpi/cm_sbs.c              |   46 -
 drivers/acpi/dispatcher/dsinit.c   |   10 
 drivers/acpi/dispatcher/dsmethod.c |   23 
 drivers/acpi/dispatcher/dswexec.c  |    4 
 drivers/acpi/dock.c                |  739 +++++++++++++++++++++++++
 drivers/acpi/ec.c                  |    2 
 drivers/acpi/event.c               |    2 
 drivers/acpi/events/evregion.c     |   44 -
 drivers/acpi/events/evxface.c      |   44 -
 drivers/acpi/events/evxfregn.c     |   13 
 drivers/acpi/executer/exconfig.c   |    1 
 drivers/acpi/executer/exconvrt.c   |    3 
 drivers/acpi/executer/exmutex.c    |    4 
 drivers/acpi/executer/exsystem.c   |    8 
 drivers/acpi/fan.c                 |    2 
 drivers/acpi/hotkey.c              |   10 
 drivers/acpi/namespace/nsalloc.c   |   13 
 drivers/acpi/osl.c                 |   30 -
 drivers/acpi/parser/psutils.c      |    2 
 drivers/acpi/pci_link.c            |    7 
 drivers/acpi/power.c               |    2 
 drivers/acpi/processor_core.c      |    2 
 drivers/acpi/processor_idle.c      |    2 
 drivers/acpi/scan.c                |   23 
 drivers/acpi/sleep/proc.c          |    6 
 drivers/acpi/system.c              |    6 
 drivers/acpi/tables/tbget.c        |   12 
 drivers/acpi/tables/tbinstal.c     |   21 
 drivers/acpi/tables/tbrsdt.c       |   27 
 drivers/acpi/tables/tbxface.c      |   32 -
 drivers/acpi/thermal.c             |   10 
 drivers/acpi/utilities/utalloc.c   |    2 
 drivers/acpi/utilities/utdebug.c   |    4 
 drivers/acpi/utilities/utdelete.c  |   13 
 drivers/acpi/utilities/utmisc.c    |   25 
 drivers/acpi/utilities/utmutex.c   |    8 
 drivers/acpi/utilities/utstate.c   |    7 
 drivers/pci/hotplug/Kconfig        |    2 
 include/acpi/acconfig.h            |    2 
 include/acpi/acinterp.h            |   10 
 include/acpi/aclocal.h             |    4 
 include/acpi/acmacros.h            |    8 
 include/acpi/acpi_bus.h            |    2 
 include/acpi/acpi_drivers.h        |   17 
 include/acpi/acresrc.h             |    8 
 include/acpi/platform/aclinux.h    |   27 
 52 files changed, 1085 insertions(+), 230 deletions(-)

through these commits:

Andi Kleen:
      ACPI: delete some defaults from ACPI Kconfig

Andrew Morton:
      ACPI: SBS: fix initialization, sem2mutex

Arjan van de Ven:
      ACPI: add 'const' to several ACPI file_operations

Bob Moore:
      ACPI: ACPICA 20060707

Len Brown:
      ACPI: acpi_os_get_thread_id() returns current
      Revert "Revert "ACPI: dock driver""
      ACPI: ACPI_DOCK Kconfig
      ACPI: "Device `[%s]' is not power manageable" make message debug only
      ACPI: acpi_os_allocate() fixes

with this log:

commit c0dc250e89cb8af77c5689b36eda851158e8573e
Merge: 0f12b15... e21c1ca...
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jul 10 02:39:47 2006 -0400

    Pull acpi_os_allocate into test branch

commit 0f12b15ebcedce115a5d8e5ff741e49a7993f67c
Merge: 20b499a... f6dd922...
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jul 10 02:39:41 2006 -0400

    Pull acpica-20060707 into test branch

commit 20b499aa06edf59fa2d21f29d42d36586c6c058e
Merge: dece75b... ab8aa06...
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jul 10 02:39:36 2006 -0400

    Pull bugzilla-6687 into test branch

commit dece75b3a288fa49b3aab685543ec2f5c94b8cfc
Merge: 1a39ed5... 8d7bff6...
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jul 10 02:39:33 2006 -0400

    Pull dock into test branch

commit 1a39ed5888a8336ed2762d5b367195b14b878850
Merge: 1b045e5... d750803...
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jul 10 02:39:26 2006 -0400

    Pull trivial into test branch

commit 1b045e5d207fc65e6708e303c2ab4249bf619982
Merge: b3cf257... 8970bfe...
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jul 10 02:39:23 2006 -0400

    Pull battery into test branch

commit e21c1ca3f98529921c829a792dfdbfc5a5dc393b
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jul 10 01:35:51 2006 -0400

    ACPI: acpi_os_allocate() fixes
    
    Replace acpi_in_resume with a more general hack
    to check irqs_disabled() on any kmalloc() from ACPI.
    While setting (system_state != SYSTEM_RUNNING) on resume
    seemed more general, Andrew Morton preferred this approach.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3469
    
    Make acpi_os_allocate() into an inline function to
    allow /proc/slab_allocators to work.
    
    Delete some memset() that could fault on allocation failure.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8970bfe706345223d39d33bfce5f8b29750ab716
Author: Andrew Morton <akpm@osdl.org>
Date:   Mon Jul 10 02:34:45 2006 -0400

    ACPI: SBS: fix initialization, sem2mutex
    
    cm_sbs_sem is being downed (via acpi_ac_init->acpi_lock_ac_dir) before it is
    initialised, with grave results.
    
    - Make it a mutex
    
    - Initialise it
    
    - Make it static
    
    - Clean other stuff up.
    
    Thanks to Paul Drynoff <pauldrynoff@gmail.com> for reporting and testing.
    
    Cc: Rich Townsend <rhdt@bartol.udel.edu>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d75080328affb4b268da430b7074cc8139cc662a
Author: Arjan van de Ven <arjan@infradead.org>
Date:   Tue Jul 4 13:06:00 2006 -0400

    ACPI: add 'const' to several ACPI file_operations
    
    Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e26a2b8f68dca28c734d857517788e3b40b8691d
Author: Andi Kleen <ak@suse.de>
Date:   Thu Jul 6 12:14:00 2006 -0400

    ACPI: delete some defaults from ACPI Kconfig
    
    No need for video to be always in
    No need for ACPI dock driver to be always in
    No need for smart battery driver to be always in
    
    Signed-off-by: Andi Kleen <ak@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit af4f949c6b4ffa5119aad980626e5b04daca961b
Author: Len Brown <len.brown@intel.com>
Date:   Sun Jul 9 16:33:26 2006 -0400

    ACPI: "Device `[%s]' is not power manageable" make message debug only
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8d7bff6c0896feba2fbd5ce37062c212aee13870
Author: Len Brown <len.brown@intel.com>
Date:   Sun Jul 9 22:09:57 2006 -0400

    ACPI: ACPI_DOCK Kconfig
    
    HOTPLUG_PCI_ACPI depends on ACPI_DOCK
    ACPI_IBM_DOCK depends on ACPI_DOCK=n
    ACPI_DOCK is EXPERIMENTAL, though that doesn't seem to mean much
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c8f7a62cdde461914c6457d5f4362538ed810bf4
Author: Len Brown <len.brown@intel.com>
Date:   Sun Jul 9 17:22:28 2006 -0400

    Revert "Revert "ACPI: dock driver""
    
    This reverts 953969ddf5b049361ed1e8471cc43dc4134d2a6f commit.

commit ab8aa06a5c0b75974fb1949365cbb20a15cedf14
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jul 7 20:11:07 2006 -0400

    ACPI: acpi_os_get_thread_id() returns current
    
    Linux mutexes and the debug code that that reference
    acpi_os_get_thread_id() are happy with 0.
    But the AML mutexes in exmutex.c expect a unique non-zero
    number for each thread - as they track this thread_id
    to permit the mutex re-entrancy defined by the ACPI spec.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=6687
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f6dd9221dddb3550e60d32aee688588ec208312c
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Jul 7 20:44:38 2006 -0400

    ACPI: ACPICA 20060707
    
    Added the ACPI_PACKED_POINTERS_NOT_SUPPORTED macro to
    support C compilers that do not allow the initialization
    of address pointers within packed structures - even though
    the hardware itself may support misaligned transfers. Some
    of the debug data structures are packed by default to
    minimize size.
    
    Added an error message for the case where
    acpi_os_get_thread_id() returns zero. A non-zero value is
    required by the core ACPICA code to ensure the proper
    operation of AML mutexes and recursive control methods.
    
    The DSDT is now the only ACPI table that determines whether
    the AML interpreter is in 32-bit or 64-bit mode. Not really
    a functional change, but the hooks for per-table 32/64
    switching have been removed from the code. A clarification
    to the ACPI specification is forthcoming in ACPI 3.0B.
    
    Fixed a possible leak of an Owner ID in the error
    path of tbinstal.c acpi_tb_init_table_descriptor() and
    migrated all table OwnerID deletion to a single place in
    acpi_tb_uninstall_table() to correct possible leaks when using
    the acpi_tb_delete_tables_by_type() interface (with assistance
    from Lance Ortiz.)
    
    Fixed a problem with Serialized control methods where the
    semaphore associated with the method could be over-signaled
    after multiple method invocations.
    
    Fixed two issues with the locking of the internal
    namespace data structure. Both the Unload() operator and
    acpi_unload_table() interface now lock the namespace during
    the namespace deletion associated with the table unload
    (with assistance from Linn Crosetto.)
    
    Fixed problem reports (Valery Podrezov) integrated: -
    Eliminate unnecessary memory allocation for CreateXxxxField
    http://bugzilla.kernel.org/show_bug.cgi?id=5426
    
    Fixed problem reports (Fiodor Suietov) integrated: -
    Incomplete cleanup branches in AcpiTbGetTableRsdt (BZ 369)
    - On Address Space handler deletion, needless deactivation
    call (BZ 374) - AcpiRemoveAddressSpaceHandler: validate
    Device handle parameter (BZ 375) - Possible memory leak,
    Notify sub-objects of Processor, Power, ThermalZone (BZ
    376) - AcpiRemoveAddressSpaceHandler: validate Handler
    parameter (BZ 378) - Minimum Length of RSDT should be
    validated (BZ 379) - AcpiRemoveNotifyHandler: return
    AE_NOT_EXIST if Processor Obj has no Handler (BZ (380)
    - AcpiUnloadTable: return AE_NOT_EXIST if no table of
    specified type loaded (BZ 381)
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
