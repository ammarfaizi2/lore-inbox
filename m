Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbSLJBsE>; Mon, 9 Dec 2002 20:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266553AbSLJBsE>; Mon, 9 Dec 2002 20:48:04 -0500
Received: from fmr01.intel.com ([192.55.52.18]:27349 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266552AbSLJBr6>;
	Mon, 9 Dec 2002 20:47:58 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A584@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Marcelo Tosatti (marcelo@conectiva.com.br)" 
	<marcelo@conectiva.com.br>
Cc: kernel list <linux-kernel@vger.kernel.org>, acpi-devel@sourceforge.net
Subject: [BK PATCH] 2.4 ACPI update, minimizing risk
Date: Mon, 9 Dec 2002 17:55:39 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This ACPI patch drops in the most recent ACPI interpreter code. It modifies
some other ACPI-specific code to get things compiling, but that is all.

I've tested it on my systems and haven't seen any regressions.

Thanks -- Regards -- Andy

Please do a

	bk pull http://linux-acpi.bkbits.net/linux-2.4-acpi-incr

This will update the following files:

 drivers/acpi/Makefile                   |    2 
 drivers/acpi/acpi_ksyms.c               |    9 
 drivers/acpi/dispatcher/dsfield.c       |  303 ++++--
 drivers/acpi/dispatcher/dsinit.c        |  220 ++++
 drivers/acpi/dispatcher/dsmethod.c      |  118 +-
 drivers/acpi/dispatcher/dsmthdat.c      |  492 ++++-------
 drivers/acpi/dispatcher/dsobject.c      |  849 ++++++++-----------
 drivers/acpi/dispatcher/dsopcode.c      |  871 ++++++++++---------
 drivers/acpi/dispatcher/dsutils.c       |  584 ++++---------
 drivers/acpi/dispatcher/dswexec.c       |  226 ++---
 drivers/acpi/dispatcher/dswload.c       |  561 ++++++++----
 drivers/acpi/dispatcher/dswscope.c      |   66 +
 drivers/acpi/dispatcher/dswstate.c      |  175 ++-
 drivers/acpi/driver.c                   |   45 -
 drivers/acpi/events/evevent.c           |  729 ++--------------
 drivers/acpi/events/evgpe.c             |  706 +++++++++++++++
 drivers/acpi/events/evmisc.c            |  334 +++++--
 drivers/acpi/events/evregion.c          |  174 ++-
 drivers/acpi/events/evrgnini.c          |  202 ++--
 drivers/acpi/events/evsci.c             |  185 ----
 drivers/acpi/events/evxface.c           |  232 ++---
 drivers/acpi/events/evxfevnt.c          |  285 ++----
 drivers/acpi/events/evxfregn.c          |   64 -
 drivers/acpi/executer/exconfig.c        |  388 ++++++--
 drivers/acpi/executer/exconvrt.c        |  347 +++----
 drivers/acpi/executer/excreate.c        |  258 +++--
 drivers/acpi/executer/exdump.c          |  795 +++++++----------
 drivers/acpi/executer/exfield.c         |  526 +++--------
 drivers/acpi/executer/exfldio.c         |  822 ++++++++++--------
 drivers/acpi/executer/exmisc.c          |  269 +++---
 drivers/acpi/executer/exmutex.c         |  136 ++-
 drivers/acpi/executer/exnames.c         |   96 --
 drivers/acpi/executer/exoparg1.c        |  584 ++++++-------
 drivers/acpi/executer/exoparg2.c        |  206 ++--
 drivers/acpi/executer/exoparg3.c        |   48 -
 drivers/acpi/executer/exoparg6.c        |   27 
 drivers/acpi/executer/exprep.c          |  294 +++---
 drivers/acpi/executer/exregion.c        |  202 +++-
 drivers/acpi/executer/exresnte.c        |  135 +--
 drivers/acpi/executer/exresolv.c        |  406 ++++-----
 drivers/acpi/executer/exresop.c         |  248 ++---
 drivers/acpi/executer/exstore.c         |  435 +++------
 drivers/acpi/executer/exstoren.c        |  196 ++--
 drivers/acpi/executer/exstorob.c        |   69 -
 drivers/acpi/executer/exsystem.c        |   66 -
 drivers/acpi/executer/exutils.c         |  205 +---
 drivers/acpi/hardware/hwacpi.c          |  270 +-----
 drivers/acpi/hardware/hwgpe.c           |  279 +++---
 drivers/acpi/hardware/hwregs.c          |  885 ++++++++------------
 drivers/acpi/hardware/hwsleep.c         |  273 ++++--
 drivers/acpi/hardware/hwtimer.c         |   85 -
 drivers/acpi/include/acconfig.h         |  145 +--
 drivers/acpi/include/acdebug.h          |  189 ++--
 drivers/acpi/include/acdispat.h         |  124 +-
 drivers/acpi/include/acevents.h         |   81 -
 drivers/acpi/include/acexcep.h          |   54 +
 drivers/acpi/include/acglobal.h         |  151 ++-
 drivers/acpi/include/achware.h          |   57 -
 drivers/acpi/include/acinterp.h         |  327 +++----
 drivers/acpi/include/aclocal.h          |  558 ++++++------
 drivers/acpi/include/acmacros.h         |  469 +++++-----
 drivers/acpi/include/acnamesp.h         |  183 ++--
 drivers/acpi/include/acobject.h         |  296 ++++--
 drivers/acpi/include/acoutput.h         |   95 --
 drivers/acpi/include/acparser.h         |   66 +
 drivers/acpi/include/acpi.h             |    4 
 drivers/acpi/include/acpiosxf.h         |   61 -
 drivers/acpi/include/acpixf.h           |   73 +
 drivers/acpi/include/acresrc.h          |  185 ++--
 drivers/acpi/include/acstruct.h         |   51 -
 drivers/acpi/include/actables.h         |   93 +-
 drivers/acpi/include/actbl.h            |   62 -
 drivers/acpi/include/actbl1.h           |   85 -
 drivers/acpi/include/actbl2.h           |   80 -
 drivers/acpi/include/actbl71.h          |    8 
 drivers/acpi/include/actypes.h          |  529 +++++++----
 drivers/acpi/include/acutils.h          |  230 ++++-
 drivers/acpi/include/amlcode.h          |  117 +-
 drivers/acpi/include/amlresrc.h         |  332 +++++++
 drivers/acpi/include/platform/acenv.h   |  195 ++--
 drivers/acpi/include/platform/acgcc.h   |  171 ---
 drivers/acpi/include/platform/aclinux.h |   34 
 drivers/acpi/namespace/nsaccess.c       |  435 ++++-----
 drivers/acpi/namespace/nsalloc.c        |  293 ++++--
 drivers/acpi/namespace/nsdump.c         |  531 +++++-------
 drivers/acpi/namespace/nsdumpdv.c       |  123 ++
 drivers/acpi/namespace/nseval.c         |  236 ++---
 drivers/acpi/namespace/nsinit.c         |  209 ++--
 drivers/acpi/namespace/nsload.c         |  286 +-----
 drivers/acpi/namespace/nsnames.c        |  230 ++---
 drivers/acpi/namespace/nsobject.c       |  362 +++++---
 drivers/acpi/namespace/nsparse.c        |  153 +++
 drivers/acpi/namespace/nssearch.c       |  166 +--
 drivers/acpi/namespace/nsutils.c        |  375 +++++---
 drivers/acpi/namespace/nswalk.c         |   32 
 drivers/acpi/namespace/nsxfeval.c       |  724 ++++++++++++++++
 drivers/acpi/namespace/nsxfname.c       |   91 +-
 drivers/acpi/namespace/nsxfobj.c        |  564 +-----------
 drivers/acpi/os.c                       |  532 +++++-------
 drivers/acpi/ospm/ac_adapter/ac.c       |   30 
 drivers/acpi/ospm/battery/bt.c          |   26 
 drivers/acpi/ospm/busmgr/bm.c           |   73 -
 drivers/acpi/ospm/busmgr/bmdriver.c     |   22 
 drivers/acpi/ospm/busmgr/bmnotify.c     |   12 
 drivers/acpi/ospm/busmgr/bmpm.c         |   18 
 drivers/acpi/ospm/busmgr/bmpower.c      |   34 
 drivers/acpi/ospm/busmgr/bmrequest.c    |    8 
 drivers/acpi/ospm/busmgr/bmsearch.c     |    9 
 drivers/acpi/ospm/busmgr/bmutils.c      |   24 
 drivers/acpi/ospm/button/bn.c           |   38 
 drivers/acpi/ospm/ec/ecgpe.c            |   12 
 drivers/acpi/ospm/ec/ecmain.c           |   34 
 drivers/acpi/ospm/ec/ecspace.c          |   16 
 drivers/acpi/ospm/ec/ectransx.c         |   22 
 drivers/acpi/ospm/processor/pr.c        |   24 
 drivers/acpi/ospm/processor/prperf.c    |   18 
 drivers/acpi/ospm/processor/prpower.c   |   60 -
 drivers/acpi/ospm/system/sm.c           |   26 
 drivers/acpi/ospm/system/sm_osl.c       |  124 --
 drivers/acpi/ospm/thermal/tz.c          |   25 
 drivers/acpi/ospm/thermal/tz_osl.c      |    5 
 drivers/acpi/ospm/thermal/tzpolicy.c    |   27 
 drivers/acpi/parser/psargs.c            |  453 ++++------
 drivers/acpi/parser/psopcode.c          |  341 +++----
 drivers/acpi/parser/psparse.c           |  766 +++++++++--------
 drivers/acpi/parser/psscope.c           |   18 
 drivers/acpi/parser/pstree.c            |   60 -
 drivers/acpi/parser/psutils.c           |  101 +-
 drivers/acpi/parser/pswalk.c            |   72 -
 drivers/acpi/parser/psxface.c           |   54 -
 drivers/acpi/resources/rsaddr.c         |  289 ++----
 drivers/acpi/resources/rscalc.c         |  180 +---
 drivers/acpi/resources/rscreate.c       |  430 ++++-----
 drivers/acpi/resources/rsdump.c         |  244 ++---
 drivers/acpi/resources/rsio.c           |  142 +--
 drivers/acpi/resources/rsirq.c          |  206 ++--
 drivers/acpi/resources/rslist.c         |  143 +--
 drivers/acpi/resources/rsmemory.c       |  172 +--
 drivers/acpi/resources/rsmisc.c         |  199 ++--
 drivers/acpi/resources/rsutils.c        |  214 +---
 drivers/acpi/resources/rsxface.c        |   43 
 drivers/acpi/tables/tbconvrt.c          |  562 +++++-------
 drivers/acpi/tables/tbget.c             |  780 +++++------------
 drivers/acpi/tables/tbgetall.c          |  296 ++++++
 drivers/acpi/tables/tbinstal.c          |  217 ++--
 drivers/acpi/tables/tbrsdt.c            |  297 ++++++
 drivers/acpi/tables/tbutils.c           |  199 ----
 drivers/acpi/tables/tbxface.c           |  127 +-
 drivers/acpi/tables/tbxfroot.c          |  495 ++++++-----
 drivers/acpi/utilities/utalloc.c        |  798 +++++++++++-------
 drivers/acpi/utilities/utcopy.c         |  412 ++++++---
 drivers/acpi/utilities/utdebug.c        |   68 -
 drivers/acpi/utilities/utdelete.c       |  172 +--
 drivers/acpi/utilities/uteval.c         |  379 ++++----
 drivers/acpi/utilities/utglobal.c       |  539 ++++++------
 drivers/acpi/utilities/utinit.c         |   96 --
 drivers/acpi/utilities/utmath.c         |   28 
 drivers/acpi/utilities/utmisc.c         |  708 ++++++++++++----
 drivers/acpi/utilities/utobject.c       |  277 ++++--
 drivers/acpi/utilities/utxface.c        |  195 +++-
 drivers/acpi/utils.c                    |  415 +++++++++
 include/asm-i386/acpi.h                 |  146 +++
 162 files changed, 21014 insertions(+), 17435 deletions(-)

through these ChangeSets:

<agrover@groveronline.com> (02/12/09 1.800)
   ACPI: Add include/asm-i386/acpi.h. We have moved arch-specific defines to
   asm/acpi, where they belong. IA64 people will need to do something
similar,
   like in 2.5.

<agrover@groveronline.com> (02/12/09 1.799)
   ACPI: Update OS functions for new core version

<agrover@groveronline.com> (02/12/09 1.798)
   ACPI: Fix ksyms

<agrover@groveronline.com> (02/12/09 1.797)
   ACPI: Modify driver.c to account for added core initialization call, and
   add a needed helper function.

<agrover@groveronline.com> (02/12/09 1.796)
   ACPI: Make trivial changes to OSPM files to get them to compile with new
   interpreter. This includes:
    - Adding ACPI_ in front of a lot of macros, that now have that in their
name
    - changing instances of MEMSET and MEMCPY to memset and memcpy
    - Fixing _COMPONENT flags
    - Removing workarounds for issues that have been fixed (e.g. Scope())
    - Removing GPE proc interface - unneeded

<agrover@groveronline.com> (02/12/09 1.795)
   ACPI: We no longer need -Wno-unused as a flag

<agrover@groveronline.com> (02/12/09 1.794)
   ACPI: Update ACPI AML interpreter to latest version, incorporating
numerous
     bug fixes, for a variety of horrendous bugs. Despite its size, this is
     a low-risk changeset.


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

