Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUF0RfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUF0RfI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 13:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUF0RfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 13:35:07 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:17852 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264206AbUF0RdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 13:33:13 -0400
Subject: [BK PATCH] SCSI updates to 2.6.7
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 27 Jun 2004 12:33:06 -0500
Message-Id: <1088357587.1747.67.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the set of patches (barring uncovered bug fixes) that I'd like
to get in before the current kernel goes -rc

The patch is mainly bugfixes, clean ups and janatorial stuff.  It also
includes the deprecation of the drivers/scsi/hosts.h file---all current
in-tree drivers have been converted to get this from
include/scsi/scsi_hosts.h instead.  To take advantage of our new page
allocation routine that favours clustering, I've turned it on in the two
drivers I can verify that it makes quite a difference.

The major API update is the addition of the flexible timeout
infrastructure which, hopefully, will help Adaptec to get their current
out of tree updates into a mergeable condition.

I'm afraid we have another qlogic firmware update skewing the diffstats
again...

The patch is available from:

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is:

Alan Cox:
  o Further aacraid work

Alan Stern:
  o (as333) BLIST flag for non-lockable devices

Andrew Morton:
  o mptbase.c build fix

Andrew Vasquez:
  o qla2xxx: Remove qla_os.h
  o [18/18] qla2xxx: Update driver version
  o [17/18] qla2xxx: Bus reset handler fixes
  o [16/18] qla2xxx: 23xx/63xx firmware updates
  o [15/18] qla2xxx: SRB handling cleanup and fixes
  o [14/18] qla2xxx: Use proper include files
  o [13/18] qla2xxx: Remove TRUE/FALSE usage
  o [12/18] qla2xxx: Extend firmware dump support
  o [11/18] qla2xxx: Misc. fixes
  o [10/18] qla2xxx: Additional tape handling fixes
  o [9/18]  qla2xxx: Tape command handling fixes
  o [8/18]  qla2xxx: Remove dead code
  o [7/18]  qla2xxx: Tape command handling fixes
  o [6/18]  qla2xxx: Initialization fixes
  o [5/18]  qla2xxx: Add module parameter permissions
  o [4/18]  qla2xxx: ISR RISC paused fixes
  o [3/18]  qla2xxx: PCI DMA mappings rework
  o qla2xxx: remove unnecessary command direction determination
  o [2/18]  qla2xxx: Correct residual counts
  o [1/18]  qla2xxx: Add wmb() to critical paths

Arjan van de Ven:
  o final hosts.h usage removal

Brian King:
  o ipr bump version to 2.0.10
  o ipr only tcq cancel all
  o ipr abort hang fix

Christoph Hellwig:
  o some tmscsim consolidation
  o MPT Fusion driver 3.01.09 update
  o avoid obsolete APIs in atp870u
  o avoid obsolete APIs in fdomain
  o avoid obsolete APIs in sr
  o wd33c93 update
  o wd7000 updates
  o avoiding obsolete scsi APIs in dc395
  o switch scsi core and sd to <scsi/*.h> headers

Douglas Gilbert:
  o More advansys fixes

Guennadi Liakhovetski:
  o kill obsolete typedefs and wrappers from tmscsim
  o tmscsim: host_lock use in LLD
  o tmscsim: init / exit cleanup

James Bottomley:
  o ncr53c8xx turn on clustering
  o Fix up fdomain after mismerge
  o fix aic7xxx probing
  o advansys: add warning and convert #includes
  o HSV100 is verified as supporting REPORT LUNs
  o [patch-kj] kernel_thread() audit drivers/scsi/aacraid/rx.c
  o SCSI Flexible timout intfrastructure
  o Enable clustering in the 53c700 driver

Jeremy Higdon:
  o SCSI whitelist changes

Joel Soete:
  o Make ncr53c8xx respect clustering

Mark Haverkamp:
  o aacraid 32bit app ioctl compat patch (Updated)

Matthew Wilcox:
  o ncr53c8xx updates

Maximilian Attems:
  o kernel_thread() audit drivers/scsi/aacraid/sa.c
  o [patch-kj] kernel_thread() audit drivers/scsi/aacraid/rkt.c

Randy Dunlap:
  o fdomain screwup

The diffstats are:

 b/Documentation/scsi/scsi_mid_low_api.txt |   27 
 b/drivers/block/cciss_scsi.c              |    2 
 b/drivers/fc4/fc.c                        |    2 
 b/drivers/ieee1394/sbp2.c                 |    2 
 b/drivers/message/fusion/linux_compat.h   |   10 
 b/drivers/message/fusion/mptbase.c        | 1156 --
 b/drivers/message/fusion/mptbase.h        |   72 
 b/drivers/message/fusion/mptctl.c         |  171 
 b/drivers/message/fusion/mptlan.c         |   16 
 b/drivers/message/fusion/mptscsih.c       |  365 
 b/drivers/net/fc/iph5526.c                |    2 
 b/drivers/scsi/53c700.c                   |    2 
 b/drivers/scsi/Kconfig                    |    2 
 b/drivers/scsi/Makefile                   |    9 
 b/drivers/scsi/NCR_Q720.c                 |    6 
 b/drivers/scsi/aacraid/README             |   18 
 b/drivers/scsi/aacraid/TODO               |    2 
 b/drivers/scsi/aacraid/aachba.c           |  118 
 b/drivers/scsi/aacraid/aacraid.h          |   73 
 b/drivers/scsi/aacraid/commctrl.c         |  121 
 b/drivers/scsi/aacraid/comminit.c         |   11 
 b/drivers/scsi/aacraid/linit.c            |   79 
 b/drivers/scsi/aacraid/rkt.c              |   81 
 b/drivers/scsi/aacraid/rx.c               |   83 
 b/drivers/scsi/aacraid/sa.c               |   34 
 b/drivers/scsi/advansys.c                 |  126 
 b/drivers/scsi/advansys.h                 |    8 
 b/drivers/scsi/aha152x.c                  |    2 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.c      |   13 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.h      |    2 
 b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c  |    3 
 b/drivers/scsi/arm/acornscsi.c            |    2 
 b/drivers/scsi/arm/arxescsi.c             |    2 
 b/drivers/scsi/arm/cumana_1.c             |    2 
 b/drivers/scsi/arm/cumana_2.c             |    2 
 b/drivers/scsi/arm/ecoscsi.c              |    2 
 b/drivers/scsi/arm/eesox.c                |    2 
 b/drivers/scsi/arm/fas216.c               |    2 
 b/drivers/scsi/arm/oak.c                  |    2 
 b/drivers/scsi/arm/powertec.c             |    2 
 b/drivers/scsi/atp870u.c                  |   80 
 b/drivers/scsi/atp870u.h                  |   23 
 b/drivers/scsi/constants.c                |    9 
 b/drivers/scsi/dc395x.c                   |   55 
 b/drivers/scsi/fdomain.c                  |   45 
 b/drivers/scsi/fdomain.h                  |   24 
 b/drivers/scsi/gdth.c                     |    2 
 b/drivers/scsi/hosts.c                    |    4 
 b/drivers/scsi/hosts.h                    |    2 
 b/drivers/scsi/ipr.c                      |   20 
 b/drivers/scsi/ipr.h                      |    6 
 b/drivers/scsi/ncr53c8xx.c                | 1442 +-
 b/drivers/scsi/ncr53c8xx.h                |   53 
 b/drivers/scsi/pcmcia/fdomain_stub.c      |   12 
 b/drivers/scsi/pcmcia/nsp_cs.c            |    2 
 b/drivers/scsi/qla2xxx/Makefile           |    2 
 b/drivers/scsi/qla2xxx/ql2100.c           |    1 
 b/drivers/scsi/qla2xxx/ql2200.c           |    1 
 b/drivers/scsi/qla2xxx/ql2300.c           |    1 
 b/drivers/scsi/qla2xxx/ql2300_fw.c        |14098 ++++++++++++++--------------
 b/drivers/scsi/qla2xxx/ql2322.c           |    1 
 b/drivers/scsi/qla2xxx/ql2322_fw.c        |14646 +++++++++++++++---------------
 b/drivers/scsi/qla2xxx/ql6312.c           |    1 
 b/drivers/scsi/qla2xxx/ql6312_fw.c        |12858 +++++++++++++-------------
 b/drivers/scsi/qla2xxx/ql6322.c           |    1 
 b/drivers/scsi/qla2xxx/ql6322_fw.c        |13500 +++++++++++++--------------
 b/drivers/scsi/qla2xxx/qla_dbg.c          |   22 
 b/drivers/scsi/qla2xxx/qla_dbg.h          |    6 
 b/drivers/scsi/qla2xxx/qla_def.h          |   42 
 b/drivers/scsi/qla2xxx/qla_gbl.h          |    7 
 b/drivers/scsi/qla2xxx/qla_gs.c           |    2 
 b/drivers/scsi/qla2xxx/qla_init.c         |  136 
 b/drivers/scsi/qla2xxx/qla_inline.h       |    4 
 b/drivers/scsi/qla2xxx/qla_iocb.c         |  109 
 b/drivers/scsi/qla2xxx/qla_isr.c          |   65 
 b/drivers/scsi/qla2xxx/qla_mbx.c          |   76 
 b/drivers/scsi/qla2xxx/qla_os.c           |  349 
 b/drivers/scsi/qla2xxx/qla_rscn.c         |    6 
 b/drivers/scsi/qla2xxx/qla_sup.c          |    4 
 b/drivers/scsi/qla2xxx/qla_version.h      |    4 
 b/drivers/scsi/scsi.c                     |   24 
 b/drivers/scsi/scsi_devinfo.c             |   16 
 b/drivers/scsi/scsi_error.c               |   28 
 b/drivers/scsi/scsi_ioctl.c               |   14 
 b/drivers/scsi/scsi_lib.c                 |   12 
 b/drivers/scsi/scsi_priv.h                |    1 
 b/drivers/scsi/scsi_proc.c                |    3 
 b/drivers/scsi/scsi_scan.c                |    7 
 b/drivers/scsi/scsi_syms.c                |   19 
 b/drivers/scsi/scsi_sysfs.c               |    3 
 b/drivers/scsi/scsicam.c                  |    5 
 b/drivers/scsi/scsiiom.c                  |  399 
 b/drivers/scsi/sd.c                       |   20 
 b/drivers/scsi/sr.c                       |   23 
 b/drivers/scsi/sr.h                       |    6 
 b/drivers/scsi/sr_ioctl.c                 |   36 
 b/drivers/scsi/sr_vendor.c                |   20 
 b/drivers/scsi/sym53c8xx_comm.h           |  703 -
 b/drivers/scsi/sym53c8xx_defs.h           |  710 -
 b/drivers/scsi/tmscsim.c                  |  803 -
 b/drivers/scsi/tmscsim.h                  |  276 
 b/drivers/scsi/wd33c93.c                  |   98 
 b/drivers/scsi/wd33c93.h                  |   21 
 b/drivers/scsi/wd7000.c                   |  179 
 b/drivers/scsi/zalon.c                    |   42 
 b/drivers/usb/image/hpusbscsi.c           |    2 
 b/drivers/usb/image/microtek.c            |    2 
 b/include/scsi/scsi_devinfo.h             |    1 
 b/include/scsi/scsi_host.h                |   20 
 drivers/scsi/qla2xxx/qla_os.h             |   94 
 110 files changed, 30983 insertions(+), 32961 deletions(-)

James


