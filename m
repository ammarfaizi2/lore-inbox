Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSLBTWn>; Mon, 2 Dec 2002 14:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264889AbSLBTWn>; Mon, 2 Dec 2002 14:22:43 -0500
Received: from fmr01.intel.com ([192.55.52.18]:46564 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S264875AbSLBTWd>;
	Mon, 2 Dec 2002 14:22:33 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A560@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Marcelo Tosatti (marcelo@conectiva.com.br)" 
	<marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net
Subject: [BK PATCH] ACPI updates
Date: Mon, 2 Dec 2002 11:29:52 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Now that 2.4.20 is out, I'd like to work with you on getting the ACPI code
into 2.4.21-pre as soon as possible. This code has been continually tested
by the 500+ people on the acpi-devel mailing list, and has been merged with
2.5.x as improvements have been made.

I feel we have done due diligence to minimize any issues and early inclusion
in the prepatch series will give us time to address any that are reported.

You may want to refer to:
(sorry for the URL line breakage)

http://linux-acpi.bkbits.net:8080/linux-2.4-acpi/user=agrover/ChangeSet@-6M?
nav=!-|index.html|stats|!+|index.html

Except for the very earliest changeset, these are all the incremental
improvements we have been making over the last year. I count 69 substantive
changesets.

the bk url is: http://linux-acpi.bkbits.net/linux-2.4-acpi

Regards -- Andy

This will update the following files:

 arch/i386/kernel/acpitable.c            |  554 ----
 arch/i386/kernel/acpitable.h            |  260 --
 drivers/acpi/debugger/Makefile          |   11 
 drivers/acpi/debugger/dbcmds.c          | 1114 ---------
 drivers/acpi/debugger/dbdisasm.c        |  715 ------
 drivers/acpi/debugger/dbdisply.c        |  859 -------
 drivers/acpi/debugger/dbexec.c          |  405 ---
 drivers/acpi/debugger/dbfileio.c        |  399 ---
 drivers/acpi/debugger/dbhistry.c        |  189 -
 drivers/acpi/debugger/dbinput.c         |  892 -------
 drivers/acpi/debugger/dbstats.c         |  459 ---
 drivers/acpi/debugger/dbutils.c         |  380 ---
 drivers/acpi/debugger/dbxface.c         |  388 ---
 drivers/acpi/driver.c                   |  217 -
 drivers/acpi/kdb/README.txt             |   34 
 drivers/acpi/kdb/kdbm_acpi.c            |   54 
 drivers/acpi/os.c                       |  920 -------
 drivers/acpi/ospm/Makefile              |   22 
 drivers/acpi/ospm/ac_adapter/Makefile   |    6 
 drivers/acpi/ospm/ac_adapter/ac.c       |  398 ---
 drivers/acpi/ospm/ac_adapter/ac_osl.c   |  257 --
 drivers/acpi/ospm/battery/Makefile      |    6 
 drivers/acpi/ospm/battery/bt.c          |  654 -----
 drivers/acpi/ospm/battery/bt_osl.c      |  443 ---
 drivers/acpi/ospm/busmgr/Makefile       |    8 
 drivers/acpi/ospm/busmgr/bm.c           | 1146 ---------
 drivers/acpi/ospm/busmgr/bm_osl.c       |  390 ---
 drivers/acpi/ospm/busmgr/bmdriver.c     |  469 ---
 drivers/acpi/ospm/busmgr/bmnotify.c     |  312 --
 drivers/acpi/ospm/busmgr/bmpm.c         |  442 ---
 drivers/acpi/ospm/busmgr/bmpower.c      |  664 -----
 drivers/acpi/ospm/busmgr/bmrequest.c    |  164 -
 drivers/acpi/ospm/busmgr/bmsearch.c     |  192 -
 drivers/acpi/ospm/busmgr/bmutils.c      |  611 -----
 drivers/acpi/ospm/button/Makefile       |    6 
 drivers/acpi/ospm/button/bn.c           |  507 ----
 drivers/acpi/ospm/button/bn_osl.c       |  311 --
 drivers/acpi/ospm/ec/Makefile           |    6 
 drivers/acpi/ospm/ec/ec_osl.c           |   91 
 drivers/acpi/ospm/ec/ecgpe.c            |  249 --
 drivers/acpi/ospm/ec/ecmain.c           |  498 ----
 drivers/acpi/ospm/ec/ecspace.c          |  192 -
 drivers/acpi/ospm/ec/ectransx.c         |  343 --
 drivers/acpi/ospm/include/ac.h          |  102 
 drivers/acpi/ospm/include/bm.h          |  583 ----
 drivers/acpi/ospm/include/bmpower.h     |   75 
 drivers/acpi/ospm/include/bn.h          |  122 -
 drivers/acpi/ospm/include/bt.h          |  164 -
 drivers/acpi/ospm/include/ec.h          |  202 -
 drivers/acpi/ospm/include/pr.h          |  265 --
 drivers/acpi/ospm/include/sm.h          |   91 
 drivers/acpi/ospm/include/tz.h          |  252 --
 drivers/acpi/ospm/processor/Makefile    |    6 
 drivers/acpi/ospm/processor/pr.c        |  497 ----
 drivers/acpi/ospm/processor/pr_osl.c    |  344 --
 drivers/acpi/ospm/processor/prperf.c    |  456 ---
 drivers/acpi/ospm/processor/prpower.c   |  665 -----
 drivers/acpi/ospm/system/Makefile       |    6 
 drivers/acpi/ospm/system/sm.c           |  373 ---
 drivers/acpi/ospm/system/sm_osl.c       |  922 -------
 drivers/acpi/ospm/thermal/Makefile      |    6 
 drivers/acpi/ospm/thermal/tz.c          |  642 -----
 drivers/acpi/ospm/thermal/tz_osl.c      |  398 ---
 drivers/acpi/ospm/thermal/tzpolicy.c    |  578 ----
 Documentation/Configure.help            |   24 
 MAINTAINERS                             |    6 
 arch/i386/config.in                     |   10 
 arch/i386/kernel/Makefile               |    4 
 arch/i386/kernel/acpi.c                 |  634 +++++
 arch/i386/kernel/acpi_wakeup.S          |  139 +
 arch/i386/kernel/io_apic.c              |  169 +
 arch/i386/kernel/mpparse.c              |  418 +++
 arch/i386/kernel/pci-irq.c              |    2 
 arch/i386/kernel/pci-pc.c               |   55 
 arch/i386/kernel/setup.c                |   53 
 drivers/acpi/Config.in                  |  109 
 drivers/acpi/Makefile                   |   73 
 drivers/acpi/ac.c                       |  372 +++
 drivers/acpi/acpi_bus.h                 |  341 ++
 drivers/acpi/acpi_drivers.h             |  347 ++
 drivers/acpi/acpi_ksyms.c               |  156 -
 drivers/acpi/battery.c                  |  851 +++++++
 drivers/acpi/blacklist.c                |  147 +
 drivers/acpi/bus.c                      | 2327 ++++++++++++++++++-
 drivers/acpi/button.c                   |  464 +++
 drivers/acpi/debugger/Makefile          |    3 
 drivers/acpi/debugger/dbcmds.c          |  302 +-
 drivers/acpi/debugger/dbdisply.c        |  277 +-
 drivers/acpi/debugger/dbexec.c          |   91 
 drivers/acpi/debugger/dbfileio.c        |  118 -
 drivers/acpi/debugger/dbhistry.c        |   40 
 drivers/acpi/debugger/dbinput.c         |  168 -
 drivers/acpi/debugger/dbstats.c         |  123 -
 drivers/acpi/debugger/dbutils.c         |   82 
 drivers/acpi/debugger/dbxface.c         |  187 +
 drivers/acpi/dispatcher/Makefile        |    3 
 drivers/acpi/dispatcher/dsfield.c       |  339 +-
 drivers/acpi/dispatcher/dsmethod.c      |  122 -
 drivers/acpi/dispatcher/dsmthdat.c      |  518 +---
 drivers/acpi/dispatcher/dsobject.c      |  794 +++---
 drivers/acpi/dispatcher/dsopcode.c      |  879 ++++---
 drivers/acpi/dispatcher/dsutils.c       |  610 +----
 drivers/acpi/dispatcher/dswexec.c       |  230 +
 drivers/acpi/dispatcher/dswload.c       |  799 ++++--
 drivers/acpi/dispatcher/dswscope.c      |   72 
 drivers/acpi/dispatcher/dswstate.c      |  173 -
 drivers/acpi/ec.c                       | 1115 ++++++++-
 drivers/acpi/events/Makefile            |    3 
 drivers/acpi/events/evevent.c           |  923 ++++---
 drivers/acpi/events/evmisc.c            |  414 ++-
 drivers/acpi/events/evregion.c          |  176 -
 drivers/acpi/events/evrgnini.c          |  206 +
 drivers/acpi/events/evsci.c             |  185 -
 drivers/acpi/events/evxface.c           |  240 +-
 drivers/acpi/events/evxfevnt.c          |  304 --
 drivers/acpi/events/evxfregn.c          |   68 
 drivers/acpi/executer/Makefile          |    3 
 drivers/acpi/executer/exconfig.c        |  402 ++-
 drivers/acpi/executer/exconvrt.c        |  429 +--
 drivers/acpi/executer/excreate.c        |  276 +-
 drivers/acpi/executer/exdump.c          |  857 +++----
 drivers/acpi/executer/exfield.c         |  616 +----
 drivers/acpi/executer/exfldio.c         |  854 ++++---
 drivers/acpi/executer/exmisc.c          |  367 +--
 drivers/acpi/executer/exmutex.c         |  142 -
 drivers/acpi/executer/exnames.c         |   98 
 drivers/acpi/executer/exoparg1.c        |  644 ++---
 drivers/acpi/executer/exoparg2.c        |  226 +
 drivers/acpi/executer/exoparg3.c        |   50 
 drivers/acpi/executer/exoparg6.c        |   27 
 drivers/acpi/executer/exprep.c          |  318 +-
 drivers/acpi/executer/exregion.c        |  204 +
 drivers/acpi/executer/exresnte.c        |  147 -
 drivers/acpi/executer/exresolv.c        |  438 +--
 drivers/acpi/executer/exresop.c         |  394 +--
 drivers/acpi/executer/exstore.c         |  461 +--
 drivers/acpi/executer/exstoren.c        |  202 -
 drivers/acpi/executer/exstorob.c        |   66 
 drivers/acpi/executer/exsystem.c        |   70 
 drivers/acpi/executer/exutils.c         |  269 --
 drivers/acpi/fan.c                      |  324 ++
 drivers/acpi/hardware/Makefile          |    3 
 drivers/acpi/hardware/hwacpi.c          |  272 --
 drivers/acpi/hardware/hwgpe.c           |  281 +-
 drivers/acpi/hardware/hwregs.c          |  884 +++----
 drivers/acpi/hardware/hwsleep.c         |  273 +-
 drivers/acpi/hardware/hwtimer.c         |   85 
 drivers/acpi/include/acconfig.h         |  180 -
 drivers/acpi/include/acdebug.h          |  191 -
 drivers/acpi/include/acdisasm.h         |  375 +++
 drivers/acpi/include/acdispat.h         |  128 -
 drivers/acpi/include/acevents.h         |   85 
 drivers/acpi/include/acexcep.h          |   62 
 drivers/acpi/include/acglobal.h         |  164 -
 drivers/acpi/include/achware.h          |   57 
 drivers/acpi/include/acinterp.h         |  335 +-
 drivers/acpi/include/aclocal.h          |  572 ++--
 drivers/acpi/include/acmacros.h         |  471 ++--
 drivers/acpi/include/acnamesp.h         |  170 -
 drivers/acpi/include/acobject.h         |  300 +-
 drivers/acpi/include/acoutput.h         |   65 
 drivers/acpi/include/acparser.h         |   74 
 drivers/acpi/include/acpi.h             |    4 
 drivers/acpi/include/acpiosxf.h         |  100 
 drivers/acpi/include/acpixf.h           |   75 
 drivers/acpi/include/acresrc.h          |  187 -
 drivers/acpi/include/acstruct.h         |   47 
 drivers/acpi/include/actables.h         |   93 
 drivers/acpi/include/actbl.h            |   62 
 drivers/acpi/include/actbl1.h           |   85 
 drivers/acpi/include/actbl2.h           |   82 
 drivers/acpi/include/actbl71.h          |    8 
 drivers/acpi/include/actypes.h          |  582 ++--
 drivers/acpi/include/acutils.h          |  232 +
 drivers/acpi/include/amlcode.h          |  123 -
 drivers/acpi/include/amlresrc.h         |  668 ++++-
 drivers/acpi/include/platform/acenv.h   |  199 +
 drivers/acpi/include/platform/acgcc.h   |  139 -
 drivers/acpi/include/platform/aclinux.h |   27 
 drivers/acpi/namespace/Makefile         |    3 
 drivers/acpi/namespace/nsaccess.c       |  505 ++--
 drivers/acpi/namespace/nsalloc.c        |  315 +-
 drivers/acpi/namespace/nsdump.c         |  632 ++---
 drivers/acpi/namespace/nsdumpdv.c       |  131 +
 drivers/acpi/namespace/nseval.c         |  242 --
 drivers/acpi/namespace/nsinit.c         |  206 +
 drivers/acpi/namespace/nsload.c         |  188 -
 drivers/acpi/namespace/nsnames.c        |  234 -
 drivers/acpi/namespace/nsobject.c       |  412 ++-
 drivers/acpi/namespace/nssearch.c       |  184 -
 drivers/acpi/namespace/nsutils.c        |  306 +-
 drivers/acpi/namespace/nswalk.c         |   32 
 drivers/acpi/namespace/nsxfeval.c       |  746 ++++++
 drivers/acpi/namespace/nsxfname.c       |   91 
 drivers/acpi/namespace/nsxfobj.c        |  568 ----
 drivers/acpi/numa.c                     |  187 +
 drivers/acpi/osl.c                      | 1070 ++++++++-
 drivers/acpi/parser/Makefile            |    3 
 drivers/acpi/parser/psargs.c            |  643 ++---
 drivers/acpi/parser/psopcode.c          |  625 ++---
 drivers/acpi/parser/psparse.c           |  876 +++----
 drivers/acpi/parser/psscope.c           |   18 
 drivers/acpi/parser/pstree.c            |   62 
 drivers/acpi/parser/psutils.c           |  101 
 drivers/acpi/parser/pswalk.c            |   72 
 drivers/acpi/parser/psxface.c           |   56 
 drivers/acpi/pci_bind.c                 |  311 ++
 drivers/acpi/pci_irq.c                  |  413 +++
 drivers/acpi/pci_link.c                 |  585 ++++
 drivers/acpi/pci_root.c                 |  348 ++
 drivers/acpi/power.c                    |  636 +++++
 drivers/acpi/processor.c                | 2352 +++++++++++++++++++-
 drivers/acpi/resources/Makefile         |    3 
 drivers/acpi/resources/rsaddr.c         |  289 +-
 drivers/acpi/resources/rscalc.c         |  178 -
 drivers/acpi/resources/rscreate.c       |  518 ++--
 drivers/acpi/resources/rsdump.c         |  250 +-
 drivers/acpi/resources/rsio.c           |  142 -
 drivers/acpi/resources/rsirq.c          |  206 -
 drivers/acpi/resources/rslist.c         |  143 -
 drivers/acpi/resources/rsmemory.c       |  172 -
 drivers/acpi/resources/rsmisc.c         |  199 -
 drivers/acpi/resources/rsutils.c        |  195 -
 drivers/acpi/resources/rsxface.c        |   43 
 drivers/acpi/system.c                   | 1096 +++++++++
 drivers/acpi/tables.c                   |  593 ++++-
 drivers/acpi/tables/Makefile            |    3 
 drivers/acpi/tables/tbconvrt.c          |  582 +---
 drivers/acpi/tables/tbget.c             |  796 ++----
 drivers/acpi/tables/tbgetall.c          |  302 ++
 drivers/acpi/tables/tbinstal.c          |  221 -
 drivers/acpi/tables/tbrsdt.c            |  303 ++
 drivers/acpi/tables/tbutils.c           |  211 -
 drivers/acpi/tables/tbxface.c           |  129 -
 drivers/acpi/tables/tbxfroot.c          |  479 ++--
 drivers/acpi/thermal.c                  | 1437 +++++++++++-
 drivers/acpi/toshiba_acpi.c             |  570 ++++
 drivers/acpi/utilities/Makefile         |    3 
 drivers/acpi/utilities/utalloc.c        |  798 ++++--
 drivers/acpi/utilities/utcopy.c         |  411 ++-
 drivers/acpi/utilities/utdebug.c        |   76 
 drivers/acpi/utilities/utdelete.c       |  172 -
 drivers/acpi/utilities/uteval.c         |  171 +
 drivers/acpi/utilities/utglobal.c       |  568 ++--
 drivers/acpi/utilities/utinit.c         |  102 
 drivers/acpi/utilities/utmath.c         |   28 
 drivers/acpi/utilities/utmisc.c         |  697 ++++-
 drivers/acpi/utilities/utobject.c       |  287 +-
 drivers/acpi/utilities/utxface.c        |  197 +
 drivers/acpi/utils.c                    |  415 +++
 include/asm-i386/acpi.h                 |  146 +
 include/asm-i386/fixmap.h               |    7 
 include/asm-i386/io_apic.h              |    7 
 include/asm-i386/mpspec.h               |   14 
 include/asm-i386/pci.h                  |    5 
 include/linux/acpi.h                    |  572 +++-
 init/main.c                             |    8 
 257 files changed, 39734 insertions(+), 42038 deletions(-)

through these ChangeSets:

<agrover@groveronline.com> (02/11/22 1.771.1.22)
   ACPI: Fix IRQ assignment on Tiger (JI Lee)

<agrover@groveronline.com> (02/11/22 1.771.1.21)
   ACPI: Update to 20021122
     Fixed a problem with RefOf and named fields
     Fixed a protection fault involving Packages with Null/nested packages
     Fixed GPE initialization to handle a pathological case

<agrover@groveronline.com> (02/11/20 1.771.1.20)
   ACPI: Add ec_read and ec_write

<agrover@groveronline.com> (02/11/15 1.771.1.18)
   ACPI: Interpreter fixes
     Fixed memory leak in method argument resolution
     Fixed Index() operator to work properly with a target operand
     Fixed attempted double delete in the Index() code
     Code size improvements
     Improved debug/error messages and levels
     Fixed a problem with premature deletion of a buffer object

<agrover@groveronline.com> (02/11/15 1.771.1.17)
   ACPI: fix debug print levels, and use down() instead of
down_interruptible(),
     and some whitespace.

<agrover@groveronline.com> (02/11/11 1.771.1.15)
   ACPI: Do not compile code for EC unloading, because it cannot be unloaded
atm

<agrover@groveronline.com> (02/11/11 1.771.1.14)
   ACPI: Handle module unload/reload properly w.r.t. /proc

<agrover@groveronline.com> (02/11/11 1.771.1.13)
   ACPI: Interpreter update to 20021111. Add support for SMBus OpRegions

<agrover@groveronline.com> (02/11/08 1.771.1.12)
   ACPI: Correctly init device struct, permissing proper unloading/reloading
         (John Cagle)

<agrover@groveronline.com> (02/11/07 1.771.1.11)
   ACPI: Interpreter update to fix mutex wait problem
   This changes the timeout param around the interpreter to a u16, so that
   ACPI_WAIT_FOREVER is equivalent to 0xFFFF, the value ASL expects to
   mean "wait forever".

<agrover@groveronline.com> (02/11/04 1.771.2.4)
   ACPI: Turn down debug messages to a tolerable level (Ernst Herzberg)

<agrover@groveronline.com> (02/11/01 1.771.2.3)
   ACPI: Oops, 2.4.x doesn't have in_atomic()

<agrover@groveronline.com> (02/11/01 1.771.2.2)
   ACPI: Interpreter update to (20021101)
   - Fix namespace ordering issue, which was causing massice breakage
   - Tweak error messages

<agrover@groveronline.com> (02/10/31 1.749.2.15)
   ACPI: Ensure we con't try to sleep when we shouldn't

<agrover@groveronline.com> (02/10/31 1.749.2.14)
   ACPI:
   - Clean up debug-only code
   - Fix typo
   - Correct walking of namespace, to prevent disappearance of processor and
     thermal zone objects
   - Fix button add calls to have the right handle (i.e. none)
   - Prevent spurious cpufreq error

<agrover@groveronline.com> (02/10/24 1.749.2.13)
   ACPI: Try #2 at fixing the bridge swizzle (Kai Germaschewski)

<agrover@groveronline.com> (02/10/23 1.749.2.12)
   ACPI: Add support for GPE1 block defined with no GPE0 block

<agrover@groveronline.com> (02/10/23 1.749.2.11)
   ACPI: Use dev->devfn instead of bridge->devfn to determine the pin when
         trying to derive a device's irq from its parent (Ville Syrjala)

<agrover@groveronline.com> (02/10/23 1.749.2.10)
   ACPI: Remove too-broad blacklist entries

<agrover@groveronline.com> (02/10/22 1.749.2.9)
   ACPI: Rename acpi_power_off to acpi_power_off_device (Pavel Machek)

<agrover@groveronline.com> (02/10/22 1.749.2.8)
   ACPI: Add needed exports for ACPI-based PCI Hot Plug (J.I. Lee)

<agrover@groveronline.com> (02/10/22 1.749.2.7)
   ACPI: Restore ARB_DIS bit after return from S1

<agrover@groveronline.com> (02/10/22 1.749.2.6)
   ACPI: EC update
    - Move call to acpi_ec_query out of the interrupt handler. This will
      ensure that we do not try to acquire the Global Lock at interrupt
      level.
    - Get the handle for the ECDT.

<agrover@groveronline.com> (02/10/22 1.749.2.5)
   ACPI: Interpreter update to 200201022 release
    - Change Scope support to work with more machines
    - remove old code
    - change some defines

<agrover@groveronline.com> (02/10/22 1.749.2.4)
   ACPI: Eliminate use of TARGET_CPUS from ACPI code

<agrover@groveronline.com> (02/10/02 1.676.8.12)
   ACPI: Interpreter update to 200201002
   - Fix problem where a store/copy of a string did not set string length
properly.
   - Fix ToString operator
   - Fix CopyObject not updating internal node type
   - Fix a memory leak during implicit operand source conversion
   - Enhanced error messages for namespace lookup problems
   - Revamped Alias support

<agrover@groveronline.com> (02/10/01 1.676.8.11)
   ACPI: Init thermal driver timer before it is used (Knut Neumann)

<agrover@groveronline.com> (02/10/01 1.676.8.10)
   ACPI: Fix MADT parsing error (Bjoern A. Zeeb)

<agrover@groveronline.com> (02/10/01 1.676.8.9)
   ACPI: get ifdefs right in HT_ONLY case

<agrover@groveronline.com> (02/10/01 1.676.8.8)
   ACPI: Fix thermal management (Pavel Machek)
   Make thermal trip points R/W (Pavel Machek)
   Allow handling negative celsius values (Kochi Takayoshi)

<agrover@groveronline.com> (02/10/01 1.676.8.7)
   ACPI: IA64 Improvements (David Mosberger)

<agrover@groveronline.com> (02/10/01 1.676.8.6)
   Fix reversed logic in blacklist code (Sergio Monteiro Basto)

<agrover@groveronline.com> (02/09/27 1.676.8.4)
   ACPI: Add support for HPET tables (Andi Kleen)

<agrover@groveronline.com> (02/09/27 1.676.8.3)
   ACPI: Make the ACPI SCI interrupt get the right polarity
   when it is explicitly overridden in the MADT

<agrover@groveronline.com> (02/09/20 1.661.3.23)
   ACPI: Replace ACPI_DEBUG with ACPI_DEBUG_OUTPUT in a few places we missed
   (Dominik Brodowski)

<agrover@groveronline.com> (02/09/19 1.661.2.5)
   ACPI: change a non-critical debug message to a more appropriate level

<agrover@groveronline.com> (02/09/18 1.661.2.4)
   ACPI: Make ACPI's use of fixmap use its own fixmap region, instead of the
   IOAPICs, since that will not be present on UP systems.

<agrover@groveronline.com> (02/09/18 1.661.2.3)
   ACPI: Ensure that the ACPI SCI (system control interrupt) is set to
   active lov, level trigger.

<agrover@groveronline.com> (02/09/18 1.661.2.2)
   ACPI: Interpreter update to 20020918

<agrover@groveronline.com> (02/09/12 1.631.6.2)
   ACPI: Print the DSDT stats on boot, just like the other ACPI tables.

<agrover@groveronline.com> (02/09/11 1.587.1.24)
   ACPI:
   - Use the early table mapping code from acpitable.c (Andi Kleen)
   - Print something to let the user know ACPI is being used for ACPI PCI
     routing.

<agrover@groveronline.com> (02/09/11 1.587.1.23)
   ACPI: Add a cmdline switch to disable ACPI PCI config (Andi Kleen)

<agrover@groveronline.com> (02/09/11 1.587.1.22)
   ACPI: New blacklist entries (Andi Kleen)

<agrover@groveronline.com> (02/09/10 1.587.1.21)
   ACPI: Blacklist improvements
   1) Split blacklist code out into a separate file.
   2) Move checking the blacklist to very early. Previously, we would use
ACPI
   tables, and then halfway through init, check the blacklist -- too late.
   Now, it's early enough to completely fall-back to non-ACPI.
   3) Some FACP -> FADT cleanups, too.

<agrover@groveronline.com> (02/09/09 1.587.1.20)
   ACPI: Fix possible sleeping at interrupt context (Matthew Wilcox)

<agrover@groveronline.com> (02/09/09 1.587.1.19)
   ACPI: Do not compile functions not used in HT_ONLY mode

<agrover@groveronline.com> (02/09/09 1.587.1.18)
   Toshiba ACPI Extras driver by John Belmonte

<agrover@groveronline.com> (02/09/04 1.587.1.17)
   ACPI: When using CONFIG_ACPI_HT_ONLY, do not configure IOAPIC and
   LAPIC NMIs.

<agrover@groveronline.com> (02/09/04 1.587.1.16)
   ACPI: remove unused kdb and debugger directories

<agrover@groveronline.com> (02/09/04 1.587.1.15)
   ACPI: Remove unused functions in osl.c (Kochi Takayoshi)

<agrover@groveronline.com> (02/09/03 1.587.1.14)
   Ensure that the ACPI interrupt has the proper trigger and polarity

<agrover@groveronline.com> (02/09/03 1.587.1.13)
   from 2.5: fix ACPI Config.in breakage (C. Hellwig)

<agrover@groveronline.com> (02/08/30 1.587.1.12)
   ACPI trivial fixes (Kochi Takayoshi)

<agrover@groveronline.com> (02/08/29 1.587.1.11)
   fix conditional (Giridhar Pemmasani)

<agrover@groveronline.com> (02/08/29 1.587.1.10)
   ACPI interpreter updates

<agrover@groveronline.com> (02/08/23 1.587.1.8)
   New file for SLIT/SRAT support (Kochi Takayoshi)

<agrover@groveronline.com> (02/08/23 1.587.1.7)
   Add support for SLIT/SRAT parsing (Kochi Takayoshi)

<agrover@groveronline.com> (02/08/21 1.587.1.6)
   Remove no-longer needed files

<agrover@groveronline.com> (02/08/21 1.587.1.4)
   update for core release version 20020815

<agrover@groveronline.com> (02/08/20 1.587.1.3)
   make "acpi=off" disable table parsing as well as interpreter init

<agrover@groveronline.com> (02/08/20 1.587.1.2)
   remove no-longer applicable comment

<agrover@groveronline.com> (02/08/14 1.555.49.8)
   Fix ACPI table parsing (Bjorn Helgaas)

<agrover@groveronline.com> (02/08/14 1.555.49.7)
   Export acpi_get_firmware_table (Matthew Wilcox)

<agrover@groveronline.com> (02/08/14 1.555.49.6)
   By Herbert Nachtnebel:
    1) Allow differently-ordered trip points
    2) Change acpi_thermal_check to always call acpi_thermal_active
       (to allow that function to turn off active cooling if it wants)
    3) Properly activate active cooling devices

<agrover@groveronline.com> (02/08/14 1.555.49.5)
   This changeset adds ACPI support to 3 main areas:
   1) IOAPIC detection/configuration
   2) CPU detection
   3) PCI IRQ routing
   
   Also included in this changeset is some i386-specific ACPI code, and
   a mod to i386's main config.in, making ACPI no longer experimental.

<agrover@groveronline.com> (02/08/14 1.555.49.4)
   Add ACPI driver files

<agrover@groveronline.com> (02/08/14 1.555.49.3)
   ACPI interpreter update to latest (20020725)

<agrover@groveronline.com> (02/08/14 1.555.49.2)
   Delete acpitable.[ch] since they are no longer needed

<agrover@groveronline.com> (02/08/14 1.555.49.1)
   Remove old ACPI drivers


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

