Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261849AbTCLTCx>; Wed, 12 Mar 2003 14:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261853AbTCLTCx>; Wed, 12 Mar 2003 14:02:53 -0500
Received: from fmr02.intel.com ([192.55.52.25]:49398 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261849AbTCLTCT>; Wed, 12 Mar 2003 14:02:19 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A1E6@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] 2.4 ACPI update
Date: Wed, 12 Mar 2003 11:12:43 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I'd like to try again to get you to merge in the latest ACPI change into
2.4. I know it's a big patch but the identical code has been in 2.5 all
along. BitKeeper has been a big help in allowing me to maintain such a
big patch for so long, but the fact is that getting this in 2.4 would
make my life and other maintainers' lives much easier.

The ACPI code in 2.4 is very old and buggy. Even though the current code
is not flawless, it is much much improved. Its inclusion would not
affect anything at all for people who don't explicitly configure in ACPI
support.

	bk pull http://linux-acpi.bkbits.net/linux-2.4-acpi

Please let me know what you think. :-)

Thanks -- Regards -- Andy

This will update the following files:

 arch/i386/kernel/acpitable.c            |  554 ----
 arch/i386/kernel/acpitable.h            |  260 --
 drivers/acpi/acpi_bus.h                 |  314 --
 drivers/acpi/acpi_drivers.h             |  348 --
 drivers/acpi/debugger/Makefile          |   11 
 drivers/acpi/debugger/dbcmds.c          | 1114 ---------
 drivers/acpi/debugger/dbdisasm.c        |  715 -----
 drivers/acpi/debugger/dbdisply.c        |  859 -------
 drivers/acpi/debugger/dbexec.c          |  405 ---
 drivers/acpi/debugger/dbfileio.c        |  399 ---
 drivers/acpi/debugger/dbhistry.c        |  189 -
 drivers/acpi/debugger/dbinput.c         |  892 -------
 drivers/acpi/debugger/dbstats.c         |  459 ---
 drivers/acpi/debugger/dbutils.c         |  380 ---
 drivers/acpi/debugger/dbxface.c         |  388 ---
 drivers/acpi/driver.c                   |  217 -
 drivers/acpi/include/acconfig.h         |  188 -
 drivers/acpi/include/acdebug.h          |  430 ---
 drivers/acpi/include/acdisasm.h         |  361 --
 drivers/acpi/include/acdispat.h         |  494 ----
 drivers/acpi/include/acevents.h         |  221 -
 drivers/acpi/include/acexcep.h          |  283 --
 drivers/acpi/include/acglobal.h         |  298 --
 drivers/acpi/include/achware.h          |  154 -
 drivers/acpi/include/acinterp.h         |  717 -----
 drivers/acpi/include/aclocal.h          |  953 -------
 drivers/acpi/include/acmacros.h         |  578 ----
 drivers/acpi/include/acnamesp.h         |  489 ----
 drivers/acpi/include/acobject.h         |  473 ---
 drivers/acpi/include/acoutput.h         |  166 -
 drivers/acpi/include/acparser.h         |  328 --
 drivers/acpi/include/acpi.h             |   50 
 drivers/acpi/include/acpiosxf.h         |  337 --
 drivers/acpi/include/acpixf.h           |  391 ---
 drivers/acpi/include/acresrc.h          |  366 ---
 drivers/acpi/include/acstruct.h         |  183 -
 drivers/acpi/include/actables.h         |  218 -
 drivers/acpi/include/actbl.h            |  208 -
 drivers/acpi/include/actbl1.h           |  117 
 drivers/acpi/include/actbl2.h           |  182 -
 drivers/acpi/include/actbl71.h          |  144 -
 drivers/acpi/include/actypes.h          | 1189 ---------
 drivers/acpi/include/acutils.h          |  815 ------
 drivers/acpi/include/amlcode.h          |  477 ---
 drivers/acpi/include/amlresrc.h         |  310 --
 drivers/acpi/include/platform/acenv.h   |  344 --
 drivers/acpi/include/platform/acgcc.h   |   40 
 drivers/acpi/include/platform/aclinux.h |   72 
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
 Documentation/kernel-parameters.txt     |   12 
 MAINTAINERS                             |    6 
 arch/i386/config.in                     |   10 
 arch/i386/kernel/Makefile               |    4 
 arch/i386/kernel/acpi.c                 |  654 +++++
 arch/i386/kernel/acpi_wakeup.S          |  139 +
 arch/i386/kernel/io_apic.c              |  169 +
 arch/i386/kernel/mpparse.c              |  489 +++-
 arch/i386/kernel/pci-irq.c              |    2 
 arch/i386/kernel/pci-pc.c               |   55 
 arch/i386/kernel/setup.c                |   61 
 drivers/acpi/Config.in                  |  109 
 drivers/acpi/Makefile                   |   79 
 drivers/acpi/ac.c                       |  380 ++-
 drivers/acpi/acpi_bus.h                 |  362 ++
 drivers/acpi/acpi_drivers.h             |  354 ++
 drivers/acpi/acpi_ksyms.c               |  161 -
 drivers/acpi/battery.c                  |  883 +++++++
 drivers/acpi/blacklist.c                |  149 +
 drivers/acpi/bus.c                      | 2361 ++++++++++++++++++-
 drivers/acpi/button.c                   |  534 ++++
 drivers/acpi/debugger/Makefile          |    3 
 drivers/acpi/debugger/dbcmds.c          |  302 +-
 drivers/acpi/debugger/dbdisply.c        |  277 +-
 drivers/acpi/debugger/dbexec.c          |   91 
 drivers/acpi/debugger/dbfileio.c        |  118 
 drivers/acpi/debugger/dbhistry.c        |   40 
 drivers/acpi/debugger/dbinput.c         |  168 -
 drivers/acpi/debugger/dbstats.c         |  123 -
 drivers/acpi/debugger/dbutils.c         |   82 
 drivers/acpi/debugger/dbxface.c         |  187 +
 drivers/acpi/dispatcher/Makefile        |    3 
 drivers/acpi/dispatcher/dsfield.c       |  563 ++--
 drivers/acpi/dispatcher/dsinit.c        |  333 ++
 drivers/acpi/dispatcher/dsmethod.c      |  286 +-
 drivers/acpi/dispatcher/dsmthdat.c      |  784 ++----
 drivers/acpi/dispatcher/dsobject.c      | 1203 ++++-----
 drivers/acpi/dispatcher/dsopcode.c      | 1223 +++++-----
 drivers/acpi/dispatcher/dsutils.c       |  786 ++----
 drivers/acpi/dispatcher/dswexec.c       |  369 +--
 drivers/acpi/dispatcher/dswload.c       | 1031 +++++---
 drivers/acpi/dispatcher/dswscope.c      |  158 -
 drivers/acpi/dispatcher/dswstate.c      |  537 ++--
 drivers/acpi/ec.c                       | 1218 ++++++++-
 drivers/acpi/events/Makefile            |    3 
 drivers/acpi/events/evevent.c           | 1711 ++++----------
 drivers/acpi/events/evgpe.c             | 1593 ++++++++-----
 drivers/acpi/events/evgpeblk.c          |  545 ++++
 drivers/acpi/events/evmisc.c            |  728 +++--
 drivers/acpi/events/evregion.c          |  370 +--
 drivers/acpi/events/evrgnini.c          |  434 +--
 drivers/acpi/events/evsci.c             |  281 --
 drivers/acpi/events/evxface.c           |  478 ++-
 drivers/acpi/events/evxfevnt.c          |  458 +--
 drivers/acpi/events/evxfregn.c          |  184 -
 drivers/acpi/executer/Makefile          |    3 
 drivers/acpi/executer/exconfig.c        |  591 +++-
 drivers/acpi/executer/exconvrt.c        |  675 ++---
 drivers/acpi/executer/excreate.c        |  508 ++--
 drivers/acpi/executer/exdump.c          | 1109 ++++-----
 drivers/acpi/executer/exfield.c         |  746 ++----
 drivers/acpi/executer/exfldio.c         | 1134 +++++----
 drivers/acpi/executer/exmisc.c          |  551 ++--
 drivers/acpi/executer/exmutex.c         |  270 +-
 drivers/acpi/executer/exnames.c         |  254 +-
 drivers/acpi/executer/exoparg1.c        |  848 +++---
 drivers/acpi/executer/exoparg2.c        |  386 +--
 drivers/acpi/executer/exoparg3.c        |  164 -
 drivers/acpi/executer/exoparg6.c        |  121 
 drivers/acpi/executer/exprep.c          |  488 ++--
 drivers/acpi/executer/exregion.c        |  474 ++-
 drivers/acpi/executer/exresnte.c        |  233 -
 drivers/acpi/executer/exresolv.c        |  590 ++--
 drivers/acpi/executer/exresop.c         |  577 ++--
 drivers/acpi/executer/exstore.c         |  605 +---
 drivers/acpi/executer/exstoren.c        |  314 +-
 drivers/acpi/executer/exstorob.c        |  189 -
 drivers/acpi/executer/exsystem.c        |  210 -
 drivers/acpi/executer/exutils.c         |  419 +--
 drivers/acpi/fan.c                      |  332 ++
 drivers/acpi/hardware/Makefile          |    3 
 drivers/acpi/hardware/hwacpi.c          |  346 +-
 drivers/acpi/hardware/hwgpe.c           |  738 +++---
 drivers/acpi/hardware/hwregs.c          | 1254 ++++------
 drivers/acpi/hardware/hwsleep.c         |  570 +++-
 drivers/acpi/hardware/hwtimer.c         |  184 -
 drivers/acpi/include/acconfig.h         |  260 +-
 drivers/acpi/include/acdebug.h          |  510 ++--
 drivers/acpi/include/acdisasm.h         |  375 +++
 drivers/acpi/include/acdispat.h         |  511 ++--
 drivers/acpi/include/acevents.h         |  190 -
 drivers/acpi/include/acexcep.h          |   85 
 drivers/acpi/include/acglobal.h         |  434 ++-
 drivers/acpi/include/achware.h          |  122 -
 drivers/acpi/include/acinterp.h         |  929 +++----
 drivers/acpi/include/aclocal.h          | 1348 +++++------
 drivers/acpi/include/acmacros.h         |  574 ++--
 drivers/acpi/include/acnamesp.h         |  568 ++--
 drivers/acpi/include/acobject.h         |  870 +++----
 drivers/acpi/include/acoutput.h         |  126 -
 drivers/acpi/include/acparser.h         |  303 +-
 drivers/acpi/include/acpi.h             |    7 
 drivers/acpi/include/acpiosxf.h         |  306 +-
 drivers/acpi/include/acpixf.h           |  357 +-
 drivers/acpi/include/acresrc.h          |  592 ++--
 drivers/acpi/include/acstruct.h         |  276 +-
 drivers/acpi/include/actables.h         |  234 +
 drivers/acpi/include/actbl.h            |  235 -
 drivers/acpi/include/actbl1.h           |  236 -
 drivers/acpi/include/actbl2.h           |  316 +-
 drivers/acpi/include/actbl71.h          |  163 -
 drivers/acpi/include/actypes.h          | 1535 ++++++------
 drivers/acpi/include/acutils.h          |  951 ++++---
 drivers/acpi/include/amlcode.h          |  156 -
 drivers/acpi/include/amlresrc.h         | 1144 +++++----
 drivers/acpi/include/platform/acenv.h   |  234 +
 drivers/acpi/include/platform/acgcc.h   |  151 -
 drivers/acpi/include/platform/aclinux.h |   46 
 drivers/acpi/namespace/Makefile         |    3 
 drivers/acpi/namespace/nsaccess.c       |  677 ++---
 drivers/acpi/namespace/nsalloc.c        |  481 ++-
 drivers/acpi/namespace/nsdump.c         |  817 +++---
 drivers/acpi/namespace/nsdumpdv.c       |  211 +
 drivers/acpi/namespace/nseval.c         |  416 +--
 drivers/acpi/namespace/nsinit.c         |  363 +-
 drivers/acpi/namespace/nsload.c         |  427 +--
 drivers/acpi/namespace/nsnames.c        |  368 +--
 drivers/acpi/namespace/nsobject.c       |  560 ++--
 drivers/acpi/namespace/nsparse.c        |  241 +
 drivers/acpi/namespace/nssearch.c       |  316 +-
 drivers/acpi/namespace/nsutils.c        |  753 +++---
 drivers/acpi/namespace/nswalk.c         |  148 -
 drivers/acpi/namespace/nsxfeval.c       | 1002 +++++++-
 drivers/acpi/namespace/nsxfname.c       |  201 -
 drivers/acpi/namespace/nsxfobj.c        |  666 +----
 drivers/acpi/numa.c                     |  189 +
 drivers/acpi/osl.c                      | 1404 +++++++++--
 drivers/acpi/parser/Makefile            |    3 
 drivers/acpi/parser/psargs.c            |  857 +++----
 drivers/acpi/parser/psopcode.c          |  705 ++---
 drivers/acpi/parser/psparse.c           | 1076 ++++----
 drivers/acpi/parser/psscope.c           |  144 -
 drivers/acpi/parser/pstree.c            |  160 -
 drivers/acpi/parser/psutils.c           |  223 +
 drivers/acpi/parser/pswalk.c            |  172 -
 drivers/acpi/parser/psxface.c           |  140 -
 drivers/acpi/pci_bind.c                 |  335 ++
 drivers/acpi/pci_irq.c                  |  453 +++
 drivers/acpi/pci_link.c                 |  801 +++++-
 drivers/acpi/pci_root.c                 |  380 ++-
 drivers/acpi/power.c                    |  648 +++++
 drivers/acpi/processor.c                | 2437 +++++++++++++++++++-
 drivers/acpi/resources/Makefile         |    3 
 drivers/acpi/resources/rsaddr.c         |  652 ++---
 drivers/acpi/resources/rscalc.c         |  404 +--
 drivers/acpi/resources/rscreate.c       |  720 ++---
 drivers/acpi/resources/rsdump.c         |  517 ++--
 drivers/acpi/resources/rsio.c           |  404 +--
 drivers/acpi/resources/rsirq.c          |  430 +--
 drivers/acpi/resources/rslist.c         |  277 +-
 drivers/acpi/resources/rsmemory.c       |  446 +--
 drivers/acpi/resources/rsmisc.c         |  505 ++--
 drivers/acpi/resources/rsutils.c        |  444 +--
 drivers/acpi/resources/rsxface.c        |  312 +-
 drivers/acpi/system.c                   | 1352 ++++++++++-
 drivers/acpi/tables.c                   |  642 ++++-
 drivers/acpi/tables/Makefile            |    3 
 drivers/acpi/tables/tbconvrt.c          |  818 ++----
 drivers/acpi/tables/tbget.c             |  974 ++-----
 drivers/acpi/tables/tbgetall.c          |  414 ++-
 drivers/acpi/tables/tbinstal.c          |  391 +--
 drivers/acpi/tables/tbrsdt.c            |  425 +++
 drivers/acpi/tables/tbutils.c           |  323 --
 drivers/acpi/tables/tbxface.c           |  301 +-
 drivers/acpi/tables/tbxfroot.c          |  703 +++--
 drivers/acpi/thermal.c                  | 1449 +++++++++++
 drivers/acpi/toshiba_acpi.c             |  783 +++++-
 drivers/acpi/utilities/Makefile         |    3 
 drivers/acpi/utilities/utalloc.c        | 1184 +++++----
 drivers/acpi/utilities/utcopy.c         |  776 +++---
 drivers/acpi/utilities/utdebug.c        |  366 +--
 drivers/acpi/utilities/utdelete.c       |  306 +-
 drivers/acpi/utilities/uteval.c         |  659 ++---
 drivers/acpi/utilities/utglobal.c       |  883 +++----
 drivers/acpi/utilities/utinit.c         |  216 -
 drivers/acpi/utilities/utmath.c         |  170 -
 drivers/acpi/utilities/utmisc.c         | 1180 ++++++---
 drivers/acpi/utilities/utobject.c       |  511 ++--
 drivers/acpi/utilities/utxface.c        |  329 +-
 drivers/acpi/utils.c                    |  447 +++
 drivers/hotplug/Makefile                |    4 
 drivers/hotplug/acpiphp.h               |    4 
 drivers/hotplug/acpiphp_glue.c          |   46 
 include/acpi/acconfig.h                 |  235 +
 include/acpi/acdebug.h                  |  512 ++++
 include/acpi/acdispat.h                 |  537 ++++
 include/acpi/acevents.h                 |  290 ++
 include/acpi/acexcep.h                  |  326 ++
 include/acpi/acglobal.h                 |  358 ++
 include/acpi/achware.h                  |  211 +
 include/acpi/acinterp.h                 |  760 ++++++
 include/acpi/aclocal.h                  | 1043 ++++++++
 include/acpi/acmacros.h                 |  621 ++++-
 include/acpi/acnamesp.h                 |  532 ++++
 include/acpi/acobject.h                 |  516 ++++
 include/acpi/acoutput.h                 |  209 +
 include/acpi/acparser.h                 |  371 ++-
 include/acpi/acpi.h                     |   93 
 include/acpi/acpi_bus.h                 |  314 ++
 include/acpi/acpi_drivers.h             |  348 ++
 include/acpi/acpiosxf.h                 |  396 +++
 include/acpi/acpixf.h                   |  459 +++
 include/acpi/acresrc.h                  |  415 +++
 include/acpi/acstruct.h                 |  226 +
 include/acpi/actables.h                 |  261 ++
 include/acpi/actbl.h                    |  253 +-
 include/acpi/actbl1.h                   |  160 +
 include/acpi/actbl2.h                   |  225 +
 include/acpi/actbl71.h                  |  144 +
 include/acpi/actypes.h                  | 1236 ++++++++++
 include/acpi/acutils.h                  |  860 ++++++-
 include/acpi/amlcode.h                  |  586 ++++
 include/acpi/amlresrc.h                 |  310 ++
 include/acpi/platform/acenv.h           |  389 +++
 include/acpi/platform/acgcc.h           |   83 
 include/acpi/platform/aclinux.h         |  120 
 include/asm-i386/acpi.h                 |  168 +
 include/asm-i386/fixmap.h               |    7 
 include/asm-i386/io_apic.h              |    7 
 include/asm-i386/mpspec.h               |   14 
 include/asm-i386/pci.h                  |    5 
 include/asm-i386/save_state.h           |  212 +
 include/linux/acpi.h                    |  611 +++--
 init/main.c                             |    8 
 333 files changed, 70896 insertions(+), 70009 deletions(-)

through these ChangeSets:

<agrover@groveronline.com> (03/03/05 1.962)
   ACPI: Re-enable building w/o CONFIG_PCI (Pavel Machek)

<agrover@groveronline.com> (03/02/28 1.960)
   ACPI: update to 20030228

<agrover@groveronline.com> (03/02/26 1.959)
   ACPI: Map in entire table before doing the checksum (John Stultz)

<agrover@groveronline.com> (03/02/26 1.958)
   ACPI: Add mem= kernel parameters to allow user to specify reserved
and ACPI
   DATA regions (Pavel Machek)

<agrover@groveronline.com> (03/02/26 1.957)
   ACPI: Fix derive_pci_id (Ducrot Bruno, Alvaro Lopez)

<agrover@groveronline.com> (03/02/19 1.956)
   ACPI: Oops, remove 2.5-ism

<agrover@groveronline.com> (03/02/19 1.955)
   ACPI: Revert a change that allowed P_BLK lengths to be 4 or 5. This
is causing
   us to think that some systems support C2 when they really don't.

<agrover@groveronline.com> (03/02/19 1.954)
   ACPI: Do not count processor objects for non-present CPUs

<agrover@groveronline.com> (03/02/19 1.953)
   ACPI: Backport Toshiba driver changes from 2.5 (John Belmonte)

<agrover@groveronline.com> (03/02/18 1.951)
   ACPI: Change license from GPL to dual GPL and BSD-style

<agrover@groveronline.com> (03/02/18 1.950)
   ACPI: misc sync-ups

<agrover@groveronline.com> (03/02/18 1.949)
   ACPI: Misc interpreter improvements

<agrover@groveronline.com> (03/02/18 1.948)
   ACPI: Fix printk output (Jochen Hein)

<agrover@groveronline.com> (03/02/18 1.947)
   ACPI: Decrease size of override's static array, add a define for the
length,
     and print a msg if used

<agrover@groveronline.com> (03/02/18 1.946)
   ACPI: Add ability to override predefined object values (Ducrot Bruno)

<agrover@groveronline.com> (03/02/18 1.945)
   ACPI: Support translation attribute (Bjorn Helgaas)

<agrover@groveronline.com> (03/02/18 1.944)
   ACPI: Eliminate use of acpi_gpl_gpe_number_info (Matthew Wilcox)

<agrover@groveronline.com> (03/02/18 1.943)
   ACPI: Port mochel's makefile improvements

<agrover@groveronline.com> (03/02/18 1.942)
   ACPI: change includes of ACPI headers for new location

<agrover@groveronline.com> (03/02/18 1.941)
   ACPI: update NUMA maintainer email

<agrover@groveronline.com> (03/02/14 1.940)
   ACPI: *really* fix ISO SCI override support (thanks again to John
Stultz)

<agrover@groveronline.com> (03/02/14 1.939)
   ACPI: Factor common code out of an if/else

<agrover@groveronline.com> (03/02/14 1.938)
   ACPI: Properly handle an ISO reassigning the ACPI interrupt. Big
thanks to
   John Stultz.

<agrover@groveronline.com> (03/02/14 1.937)
   ACPI: Use extended IRQ resource type when setting IRQs on link
devices to more
   than IRQ 15 (Juan Quintela)

<agrover@groveronline.com> (03/02/12 1.936)
   ACPI: Reduce errorlevel of a debug message (Matthew Wilcox)

<agrover@groveronline.com> (03/02/06 1.935)
   ACPI: Fix compilation on IA64 (Matthew Wilcox)

<agrover@groveronline.com> (03/02/04 1.934)
   ACPI: optimize for size

<agrover@groveronline.com> (03/01/25 1.933)
   ACPI: Fix missing declaration for s4bios support

<agrover@groveronline.com> (03/01/25 1.932)
   ACPI: Fix accidentally reverted file

<agrover@groveronline.com> (03/01/23 1.884.34.7)
   ACPI: Update to 20030122

<agrover@groveronline.com> (03/01/21 1.884.34.6)
   ACPI: Handle P_BLK lengths shorter than 6 more gracefully

<agrover@groveronline.com> (03/01/20 1.884.34.5)
   ACPI: Move drivers/acpi/include directory to include/acpi

<agrover@groveronline.com> (03/01/20 1.884.34.4)
   ACPI: S4BIOS support (Ducrot Bruno)

<agrover@groveronline.com> (03/01/15 1.884.34.3)
   ACPI: Boot functions don't use cmdline, so don't pass it

<agrover@groveronline.com> (03/01/15 1.884.34.2)
   ACPI: Fix acpiphp_glue.c for latest ACPI struct changes (Sergio
Visinoni)

<agrover@groveronline.com> (03/01/09 1.884.18.8)
   ACPI: Update version to 20030109

<agrover@groveronline.com> (03/01/08 1.884.18.7)
   ACPI: Eliminate spawning of thread from timer callback. Use
schedule_work for
     all cases. Thanks to Ingo Oeser, Andrew Morton, and Pavel Machek
for their
     wisdom.

<agrover@groveronline.com> (03/01/07 1.884.18.6)
   ACPI: Express state of lid in words, not a number

<agrover@groveronline.com> (03/01/07 1.884.18.5)
   ACPI: Make button functions static (Pavel Machek)

<agrover@groveronline.com> (03/01/07 1.884.18.4)
   ACPI: Expose lid state to userspace (Zdenek OGAR Skalak)

<agrover@groveronline.com> (03/01/07 1.884.18.3)
   ACPI: Fix for now-dynamic nature of mp_irqs array (Joerg Prante)

<agrover@groveronline.com> (03/01/07 1.884.18.2)
   ACPI: Switch from typedefs to explicit "struct" and "union" usage

<agrover@groveronline.com> (02/12/17 1.884.3.5)
   ACPI: More cosmetic changes to make the code more Linux-like

<agrover@groveronline.com> (02/12/17 1.884.3.4)
   ACPI: remove non-Linux revision on files, and make types more
Linux-like

<agrover@groveronline.com> (02/12/16 1.811.3.3)
   ACPI: Fix oops on module insert/remove (Matthew Tippett)

<agrover@groveronline.com> (02/12/12 1.811.3.2)
   ACPI: update to 20021212
    - remove NATIVE_CHAR typedef
    - remove ACPI_{GET,VALID}_ADDRESS macros
    - fix memory corruption in deletion of a static AML buffer
    - fix fault caused by 0-length AML
    - fix user-buffer overwrite/corruption of buffer is too small
    - fix buffer-to-string conversion

<agrover@groveronline.com> (02/12/12 1.757.12.14)
   ACPI: Get fid of progress dots if not in debug mode

<agrover@groveronline.com> (02/12/06 1.757.12.13)
   ACPI: Fix check of schedule_task()'s return value (Ducrot Bruno)

<agrover@groveronline.com> (02/12/05 1.757.12.12)
   ACPI: Never return a value from the PCI device's Interrupt Line field
if
     it might be bogus -- return 0 instead.

<agrover@groveronline.com> (02/12/05 1.757.12.11)
   ACPI: Interpreter update to 20021205
     Prefix more contants with ACPI_
     Fixed a problem causing DSDT image corruption
     Fixed a problem if a method was called in an object declaration
     Fixed a problem in the string copy routine
     Broke out some code into new files
     Eliminate spurious unused variables warning w.r.t. ACPI_MODULE_NAME
     Remove unneeded file

<agrover@groveronline.com> (02/12/02 1.757.12.9)
   ACPI: Remove incorrect comment

<agrover@groveronline.com> (02/11/22 1.757.13.22)
   ACPI: Fix IRQ assignment on Tiger (JI Lee)

<agrover@groveronline.com> (02/11/22 1.757.13.21)
   ACPI: Update to 20021122
     Fixed a problem with RefOf and named fields
     Fixed a protection fault involving Packages with Null/nested
packages
     Fixed GPE initialization to handle a pathological case

<agrover@groveronline.com> (02/11/20 1.757.13.20)
   ACPI: Add ec_read and ec_write

<agrover@groveronline.com> (02/11/15 1.757.13.18)
   ACPI: Interpreter fixes
     Fixed memory leak in method argument resolution
     Fixed Index() operator to work properly with a target operand
     Fixed attempted double delete in the Index() code
     Code size improvements
     Improved debug/error messages and levels
     Fixed a problem with premature deletion of a buffer object

<agrover@groveronline.com> (02/11/15 1.757.13.17)
   ACPI: fix debug print levels, and use down() instead of
down_interruptible(),
     and some whitespace.

<agrover@groveronline.com> (02/11/11 1.757.13.15)
   ACPI: Do not compile code for EC unloading, because it cannot be
unloaded atm

<agrover@groveronline.com> (02/11/11 1.757.13.14)
   ACPI: Handle module unload/reload properly w.r.t. /proc

<agrover@groveronline.com> (02/11/11 1.757.13.13)
   ACPI: Interpreter update to 20021111. Add support for SMBus OpRegions

<agrover@groveronline.com> (02/11/08 1.757.13.12)
   ACPI: Correctly init device struct, permissing proper
unloading/reloading
         (John Cagle)

<agrover@groveronline.com> (02/11/07 1.757.13.11)
   ACPI: Interpreter update to fix mutex wait problem
   This changes the timeout param around the interpreter to a u16, so
that
   ACPI_WAIT_FOREVER is equivalent to 0xFFFF, the value ASL expects to
   mean "wait forever".

<agrover@groveronline.com> (02/11/04 1.757.14.4)
   ACPI: Turn down debug messages to a tolerable level (Ernst Herzberg)

<agrover@groveronline.com> (02/11/01 1.757.14.3)
   ACPI: Oops, 2.4.x doesn't have in_atomic()

<agrover@groveronline.com> (02/11/01 1.757.14.2)
   ACPI: Interpreter update to (20021101)
   - Fix namespace ordering issue, which was causing massice breakage
   - Tweak error messages

<agrover@groveronline.com> (02/10/31 1.749.3.13)
   ACPI: Ensure we con't try to sleep when we shouldn't

<agrover@groveronline.com> (02/10/31 1.749.3.12)
   ACPI:
   - Clean up debug-only code
   - Fix typo
   - Correct walking of namespace, to prevent disappearance of processor
and
     thermal zone objects
   - Fix button add calls to have the right handle (i.e. none)
   - Prevent spurious cpufreq error

<agrover@groveronline.com> (02/10/24 1.749.3.11)
   ACPI: Try #2 at fixing the bridge swizzle (Kai Germaschewski)

<agrover@groveronline.com> (02/10/23 1.749.3.10)
   ACPI: Add support for GPE1 block defined with no GPE0 block

<agrover@groveronline.com> (02/10/23 1.749.3.9)
   ACPI: Use dev->devfn instead of bridge->devfn to determine the pin
when
         trying to derive a device's irq from its parent (Ville Syrjala)

<agrover@groveronline.com> (02/10/23 1.749.3.8)
   ACPI: Remove too-broad blacklist entries

<agrover@groveronline.com> (02/10/22 1.749.3.7)
   ACPI: Rename acpi_power_off to acpi_power_off_device (Pavel Machek)

<agrover@groveronline.com> (02/10/22 1.749.3.6)
   ACPI: Add needed exports for ACPI-based PCI Hot Plug (J.I. Lee)

<agrover@groveronline.com> (02/10/22 1.749.3.5)
   ACPI: Restore ARB_DIS bit after return from S1

<agrover@groveronline.com> (02/10/22 1.749.3.4)
   ACPI: EC update
    - Move call to acpi_ec_query out of the interrupt handler. This will
      ensure that we do not try to acquire the Global Lock at interrupt
      level.
    - Get the handle for the ECDT.

<agrover@groveronline.com> (02/10/22 1.749.3.3)
   ACPI: Interpreter update to 200201022 release
    - Change Scope support to work with more machines
    - remove old code
    - change some defines

<agrover@groveronline.com> (02/10/22 1.749.3.2)
   ACPI: Eliminate use of TARGET_CPUS from ACPI code

<agrover@groveronline.com> (02/10/02 1.676.8.12)
   ACPI: Interpreter update to 200201002
   - Fix problem where a store/copy of a string did not set string
length properly.
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
   ACPI: Replace ACPI_DEBUG with ACPI_DEBUG_OUTPUT in a few places we
missed
   (Dominik Brodowski)

<agrover@groveronline.com> (02/09/19 1.661.2.5)
   ACPI: change a non-critical debug message to a more appropriate level

<agrover@groveronline.com> (02/09/18 1.661.2.4)
   ACPI: Make ACPI's use of fixmap use its own fixmap region, instead of
the
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
   - Print something to let the user know ACPI is being used for ACPI
PCI
     routing.

<agrover@groveronline.com> (02/09/11 1.587.1.23)
   ACPI: Add a cmdline switch to disable ACPI PCI config (Andi Kleen)

<agrover@groveronline.com> (02/09/11 1.587.1.22)
   ACPI: New blacklist entries (Andi Kleen)

<agrover@groveronline.com> (02/09/10 1.587.1.21)
   ACPI: Blacklist improvements
   1) Split blacklist code out into a separate file.
   2) Move checking the blacklist to very early. Previously, we would
use ACPI
   tables, and then halfway through init, check the blacklist -- too
late.
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

