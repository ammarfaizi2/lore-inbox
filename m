Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWAKQBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWAKQBK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 11:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbWAKQBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 11:01:09 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:14013 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751517AbWAKQBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 11:01:07 -0500
Subject: [PATCH] acpi: remove function tracing macros
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 11 Jan 2006 18:01:04 +0200
Message-Id: <1136995264.9293.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch removes function tracing macro usage from drivers/acpi/. In
particular, ACPI_FUNCTION_TRACE are ACPI_FUNCTION_NAME removed completely
and return_VALUE, return_PTR, and return_ACPI_STATUS are converted with
proper use of return.

I have not included the actual patch in this mail because it is 600 KB in
size. You can find the patch here:

http://www.cs.helsinki.fi/u/penberg/linux/acpi-remove-function-tracing-macros.patch

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 drivers/acpi/ac.c                   |   60 ++------
 drivers/acpi/acpi_memhotplug.c      |  100 ++++---------
 drivers/acpi/battery.c              |  106 +++++---------
 drivers/acpi/bus.c                  |  118 ++++++----------
 drivers/acpi/button.c               |   64 +++-----
 drivers/acpi/container.c            |   40 +----
 drivers/acpi/debug.c                |   16 --
 drivers/acpi/dispatcher/dsfield.c   |   54 ++-----
 drivers/acpi/dispatcher/dsinit.c    |    6 
 drivers/acpi/dispatcher/dsmethod.c  |   52 ++-----
 drivers/acpi/dispatcher/dsmthdat.c  |   75 +++-------
 drivers/acpi/dispatcher/dsobject.c  |   42 ++---
 drivers/acpi/dispatcher/dsopcode.c  |   78 +++-------
 drivers/acpi/dispatcher/dsutils.c   |   58 ++-----
 drivers/acpi/dispatcher/dswexec.c   |   38 ++---
 drivers/acpi/dispatcher/dswload.c   |   34 +---
 drivers/acpi/dispatcher/dswscope.c  |   16 --
 drivers/acpi/dispatcher/dswstate.c  |   70 ++-------
 drivers/acpi/ec.c                   |  166 ++++++++--------------
 drivers/acpi/event.c                |   16 --
 drivers/acpi/events/evevent.c       |   22 ---
 drivers/acpi/events/evgpe.c         |   70 +++------
 drivers/acpi/events/evgpeblk.c      |   82 +++--------
 drivers/acpi/events/evmisc.c        |   30 +---
 drivers/acpi/events/evregion.c      |   68 +++------
 drivers/acpi/events/evrgnini.c      |   54 ++-----
 drivers/acpi/events/evsci.c         |   16 --
 drivers/acpi/events/evxface.c       |   62 +++-----
 drivers/acpi/events/evxfevnt.c      |   98 ++++---------
 drivers/acpi/events/evxfregn.c      |   16 --
 drivers/acpi/executer/exconfig.c    |   56 +++----
 drivers/acpi/executer/exconvrt.c    |   48 ++----
 drivers/acpi/executer/excreate.c    |   48 ++----
 drivers/acpi/executer/exdump.c      |   18 --
 drivers/acpi/executer/exfield.c     |   36 ++--
 drivers/acpi/executer/exfldio.c     |   62 +++-----
 drivers/acpi/executer/exmisc.c      |   34 +---
 drivers/acpi/executer/exmutex.c     |   32 +---
 drivers/acpi/executer/exnames.c     |   18 --
 drivers/acpi/executer/exoparg1.c    |   29 ---
 drivers/acpi/executer/exoparg2.c    |   22 ---
 drivers/acpi/executer/exoparg3.c    |   10 -
 drivers/acpi/executer/exoparg6.c    |    5 
 drivers/acpi/executer/exprep.c      |   36 +---
 drivers/acpi/executer/exregion.c    |   32 +---
 drivers/acpi/executer/exresnte.c    |   22 +--
 drivers/acpi/executer/exresolv.c    |   38 ++---
 drivers/acpi/executer/exresop.c     |   54 +++----
 drivers/acpi/executer/exstore.c     |   42 ++---
 drivers/acpi/executer/exstoren.c    |   14 -
 drivers/acpi/executer/exstorob.c    |   12 -
 drivers/acpi/executer/exsystem.c    |   38 +----
 drivers/acpi/executer/exutils.c     |   28 ---
 drivers/acpi/fan.c                  |   52 ++-----
 drivers/acpi/hardware/hwacpi.c      |   32 +---
 drivers/acpi/hardware/hwgpe.c       |   18 --
 drivers/acpi/hardware/hwregs.c      |   48 ++----
 drivers/acpi/hardware/hwsleep.c     |   70 +++------
 drivers/acpi/hardware/hwtimer.c     |   20 --
 drivers/acpi/hotkey.c               |  114 ++++-----------
 drivers/acpi/motherboard.c          |    6 
 drivers/acpi/namespace/nsaccess.c   |   22 +--
 drivers/acpi/namespace/nsalloc.c    |   36 +---
 drivers/acpi/namespace/nsdump.c     |   20 --
 drivers/acpi/namespace/nsdumpdv.c   |    4 
 drivers/acpi/namespace/nseval.c     |   42 ++---
 drivers/acpi/namespace/nsinit.c     |   24 +--
 drivers/acpi/namespace/nsload.c     |   42 ++---
 drivers/acpi/namespace/nsnames.c    |   18 --
 drivers/acpi/namespace/nsobject.c   |   32 +---
 drivers/acpi/namespace/nsparse.c    |   18 --
 drivers/acpi/namespace/nssearch.c   |   32 +---
 drivers/acpi/namespace/nsutils.c    |   67 ++-------
 drivers/acpi/namespace/nswalk.c     |   16 --
 drivers/acpi/namespace/nsxfeval.c   |   38 ++---
 drivers/acpi/namespace/nsxfname.c   |    2 
 drivers/acpi/numa.c                 |    2 
 drivers/acpi/osl.c                  |   50 ++----
 drivers/acpi/parser/psargs.c        |   44 ++----
 drivers/acpi/parser/psloop.c        |   33 ++--
 drivers/acpi/parser/psopcode.c      |    2 
 drivers/acpi/parser/psparse.c       |   20 --
 drivers/acpi/parser/psscope.c       |   22 ---
 drivers/acpi/parser/pstree.c        |    8 -
 drivers/acpi/parser/psutils.c       |    6 
 drivers/acpi/parser/pswalk.c        |    6 
 drivers/acpi/parser/psxface.c       |   16 --
 drivers/acpi/pci_bind.c             |   42 ++---
 drivers/acpi/pci_irq.c              |   79 ++++------
 drivers/acpi/pci_link.c             |  120 ++++++----------
 drivers/acpi/pci_root.c             |   28 +--
 drivers/acpi/power.c                |  137 +++++++-----------
 drivers/acpi/processor_core.c       |  120 +++++-----------
 drivers/acpi/processor_idle.c       |   82 ++++-------
 drivers/acpi/processor_perflib.c    |   98 +++++--------
 drivers/acpi/processor_thermal.c    |   42 ++---
 drivers/acpi/processor_throttling.c |   48 ++----
 drivers/acpi/resources/rsaddr.c     |   44 +-----
 drivers/acpi/resources/rscalc.c     |   16 --
 drivers/acpi/resources/rscreate.c   |   42 ++---
 drivers/acpi/resources/rsdump.c     |   30 ----
 drivers/acpi/resources/rsio.c       |   26 ---
 drivers/acpi/resources/rsirq.c      |   22 ---
 drivers/acpi/resources/rslist.c     |   16 --
 drivers/acpi/resources/rsmemory.c   |   24 ---
 drivers/acpi/resources/rsmisc.c     |   36 +---
 drivers/acpi/resources/rsutils.c    |   32 +---
 drivers/acpi/resources/rsxface.c    |   38 +----
 drivers/acpi/scan.c                 |  104 ++++----------
 drivers/acpi/sleep/proc.c           |   12 -
 drivers/acpi/sleep/wakeup.c         |    5 
 drivers/acpi/system.c               |   22 ---
 drivers/acpi/tables/tbconvrt.c      |   18 --
 drivers/acpi/tables/tbget.c         |   54 ++-----
 drivers/acpi/tables/tbgetall.c      |   38 ++---
 drivers/acpi/tables/tbinstal.c      |   44 ++----
 drivers/acpi/tables/tbrsdt.c        |   26 +--
 drivers/acpi/tables/tbutils.c       |   14 -
 drivers/acpi/tables/tbxface.c       |   52 ++-----
 drivers/acpi/tables/tbxfroot.c      |   58 +++----
 drivers/acpi/thermal.c              |  188 +++++++++----------------
 drivers/acpi/utilities/utalloc.c    |   44 +-----
 drivers/acpi/utilities/utcache.c    |   10 -
 drivers/acpi/utilities/utcopy.c     |   50 ++----
 drivers/acpi/utilities/utdelete.c   |   34 +---
 drivers/acpi/utilities/uteval.c     |   60 +++-----
 drivers/acpi/utilities/utglobal.c   |    6 
 drivers/acpi/utilities/utinit.c     |   10 -
 drivers/acpi/utilities/utmath.c     |   24 +--
 drivers/acpi/utilities/utmisc.c     |   52 ++-----
 drivers/acpi/utilities/utmutex.c    |   26 ---
 drivers/acpi/utilities/utobject.c   |   55 ++-----
 drivers/acpi/utilities/utstate.c    |   40 +----
 drivers/acpi/utilities/utxface.c    |   50 ++----
 drivers/acpi/utils.c                |   58 +++----
 drivers/acpi/video.c                |  262 ++++++++++++------------------------
 136 files changed, 2103 insertions(+), 3878 deletions(-)

