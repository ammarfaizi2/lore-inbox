Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbUCKRBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 12:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUCKRBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 12:01:45 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:61159 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261573AbUCKRBX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 12:01:23 -0500
Subject: [BKPATCH] SCSI update for 2.6.4
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 Mar 2004 12:01:13 -0500
Message-Id: <1079024474.1887.35.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This represents my current accumulation of SCSI patches since the 2.6.3
tree went -rc.

It is basically driver fixes except for these two features:

- Large disc support (this has been floating around for a while, so it
was time to merge it)
- The addition of transport attributes.  These are effectively sysfs
class libraries which drivers may be coded to make use of.  They have no
impact at all to the mid-layer (and are separately compilable).

The update is at

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is:

<michaelc:cs.wisc.edu>:
  o add missing free sgtable in scsi_init_io error path

<naveenb:cisco.com>:
  o New SCSI host_byte status code

<paul:kungfoocoder.org>:
  o SCSI: megaraid /proc dir fix

Andrew Morton:
  o ini9100u build fix

Aristeu Sergio Rozanski Filho:
  o qlogic_cs: use own MODULE_ macros
  o qlogicfas: finish to convert to new scsi driver
  o qlogicfas: move common definitions to qlogicfas.h
  o qlogicfas: support multiple cards
  o qlogicfas: disable irqs on exit
  o qlogicfas: begin to convert qlogicfas to new driver
  o qlogicfas: use qlogicfas_name instead qinfo
  o qlogicfas: kill QL_USE_IRQ
  o qlogic_cs: don't call qlogic_release on fail
  o qlogic_cs: use own detect and release functions
  o qlogicfas: force can_queue
  o qlogic_cs: use scsi_host_put
  o qlogic_cs: use a static string as name
  o qlogic_cs: don't release region
  o qlogicfas: use a static string as name

Brian King:
  o SCSI Midlayer initiated START_UNIT
  o SCSI: Recognize device type 0x0C

Dave Jones:
  o USB 6-in-1 card reader blacklist addition
  o sort SCSI blacklist

James Bottomley:
  o MPT Fusion driver 3.01.00 update
  o Make the SCSI mempool allocations variable
  o CONFIG_SCSI_AIC7XXX Kconfig bug
  o fix Kconfig select problem with SCSI_SPI_ATTRS
  o SCSI: implement transport attributes for 53c700
  o SCSI: Make SPI transport attributes mutable
  o Add full complement of SPI transport attributes
  o Add SCSI transport attributes
  o Add SCSI lots of disk support
  o SCSI: mptfusion update to 3.00.04

Jamie Lenehan:
  o dc395x [5/5] - version update
  o dc395x [4/5] - debugging cleanup
  o dc395x [3/5] - remove old debugging stuff
  o dc395x [2/5] - sg list handling cleanups
  o dc395x [1/5] - formatting cleanups

Jeremy Higdon:
  o SCSI: remove some SGI devices from the device list

Kai Mäkisara:
  o SCSI tape sysfs name fixes

Kurt Garloff:
  o SCSI sysfs host name support

Randy Dunlap:
  o buslogic init. section fix

And the diffstats are:

 Documentation/scsi/st.txt             |   19 
 drivers/message/fusion/Kconfig        |   51 
 drivers/message/fusion/Makefile       |    8 
 drivers/message/fusion/isense.c       |    4 
 drivers/message/fusion/linux_compat.h |   88 
 drivers/message/fusion/lsi/mpi.h      |  146 +
 drivers/message/fusion/lsi/mpi_cnfg.h |  596 ++++++
 drivers/message/fusion/lsi/mpi_fc.h   |    9 
 drivers/message/fusion/lsi/mpi_inb.h  |  220 ++
 drivers/message/fusion/lsi/mpi_init.h |   52 
 drivers/message/fusion/lsi/mpi_ioc.h  |   94 -
 drivers/message/fusion/lsi/mpi_lan.h  |    6 
 drivers/message/fusion/lsi/mpi_raid.h |   17 
 drivers/message/fusion/lsi/mpi_sas.h  |  181 +
 drivers/message/fusion/lsi/mpi_targ.h |   14 
 drivers/message/fusion/lsi/mpi_tool.h |  305 +++
 drivers/message/fusion/lsi/mpi_type.h |    6 
 drivers/message/fusion/mptbase.c      |  686 ++++---
 drivers/message/fusion/mptbase.h      |   72 
 drivers/message/fusion/mptctl.c       |  358 ++-
 drivers/message/fusion/mptctl.h       |   34 
 drivers/message/fusion/mptlan.c       |    9 
 drivers/message/fusion/mptscsih.c     | 2121 ++++++++++++----------
 drivers/message/fusion/mptscsih.h     |   13 
 drivers/message/fusion/scsi3.h        |    2 
 drivers/scsi/53c700.c                 |  196 +-
 drivers/scsi/53c700.h                 |   14 
 drivers/scsi/BusLogic.c               |    2 
 drivers/scsi/Kconfig                  |   22 
 drivers/scsi/Makefile                 |   16 
 drivers/scsi/aic7xxx/Kconfig.aic79xx  |    2 
 drivers/scsi/aic7xxx/Kconfig.aic7xxx  |    2 
 drivers/scsi/constants.c              |    2 
 drivers/scsi/dc395x.c                 | 3165
+++++++++++-----------------------
 drivers/scsi/dc395x.h                 |   10 
 drivers/scsi/hosts.c                  |    6 
 drivers/scsi/ini9100u.c               |   11 
 drivers/scsi/megaraid.c               |   11 
 drivers/scsi/pcmcia/qlogic_stub.c     |  104 -
 drivers/scsi/qlogicfas.c              |  370 +--
 drivers/scsi/qlogicfas.h              |  124 +
 drivers/scsi/scsi.c                   |    2 
 drivers/scsi/scsi_devinfo.c           |  114 -
 drivers/scsi/scsi_error.c             |  125 +
 drivers/scsi/scsi_lib.c               |   38 
 drivers/scsi/scsi_priv.h              |    1 
 drivers/scsi/scsi_scan.c              |   24 
 drivers/scsi/scsi_sysfs.c             |   48 
 drivers/scsi/scsi_transport_fc.c      |  104 +
 drivers/scsi/scsi_transport_spi.c     |  302 +++
 drivers/scsi/sd.c                     |   52 
 drivers/scsi/st.c                     |   40 
 drivers/scsi/st.h                     |    2 
 include/scsi/scsi.h                   |    8 
 include/scsi/scsi_device.h            |    8 
 include/scsi/scsi_host.h              |    2 
 include/scsi/scsi_transport.h         |   41 
 include/scsi/scsi_transport_fc.h      |   38 
 include/scsi/scsi_transport_spi.h     |   79 
 59 files changed, 5950 insertions(+), 4246 deletions(-)

James


