Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWDNVeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWDNVeq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWDNVeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:34:46 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:64474 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030187AbWDNVeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:34:44 -0400
Subject: [GIT PATCH] SCSI bug fixes for 2.6.17-rc1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 16:34:24 -0500
Message-Id: <1145050464.3520.62.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is mainly bug fixes, but there are one or two driver updates (as
appropriate for a -rc1) and the final removal of qlogicfc after davem
agreed.

The patch is available here

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

The short changelog is

adam radford:
  o 3ware 9000 disable local irqs during kmap_atomic

Brian King:
  o ipr: Bump version
  o ipr: printk macro cleanup/removal
  o ipr: Reset device cleanup
  o ipr: Simplify status area dumping
  o ipr: Fixup device type check
  o ipr: Disk remove path cleanup

Christoph Hellwig:
  o unify SCSI_IOCTL_SEND_COMMAND implementations

Dave C Boutcher:
  o ibmvscsi: prevent scsi commands being sent in invalid state

Douglas Gilbert:
  o sg: fix leak when dio setup fails

Eric Moore:
  o mptfusion - fix panic in mptsas_slave_configure

Hannes Reinecke:
  o aic79xx: target hotplug fixes
  o aic79xx bus reset update

James Bottomley:
  o scsi_transport_sas: don't scan a non-existent end device
  o add SCSI_UNKNOWN and LUN transfer limit restrictions
  o expose sas internal class for the domain transport
  o remove qlogicfc

James Smart:
  o FC transport: fixes for workq deadlocks

Kamezawa Hiroyuki:
  o for_each_possible_cpu: scsi

Mark Haverkamp:
  o aacraid: Show max channel and max id is sysfs
  o aacraid: Driver version update
  o aacraid: Fix parenthesis placement error
  o aacraid: Re-start helper thread if it dies
  o aacraid: Fix error in max_channel field
  o aacraid: Fix extra unregister_chrdev
  o aacraid: General driver cleanup
  o aacraid: Error path cleanup
  o aacraid: Add timeout for events
  o aacraid: Use scmd_ functions
  o aacraid: Track command ownership in driver

Matthew Wilcox:
  o sym2: Fix build when spinlock debugging is enabled
  o Version 2.2.3
  o Enable clustering and large transfers
  o Allow nvram settings to determine bus mode
  o Simplify error handling
  o Use SPI messages where possible
  o Disable sym2 driver queueing
  o Use pcibios_resource_to_bus()
  o Simplify error handling a bit
  o Mark div_10M array const
  o Change Kconfig option from IOMAPPED to MMIO

Mike Anderson:
  o sas transport: ref count update

Mike Christie:
  o fix sg leak when scsi_execute_async fails

Tejun Heo:
  o fix scsi_kill_request() busy count handling

Tomonori FUJITA:
  o ibmvscsi: remove drivers/scsi/ibmvscsi/srp.h
  o ibmvscsi: convert the ibmvscsi driver to use include/scsi/srp.h

And the diffstat:

/home/jejb/scsi-rc-fixes-2.6.: No such file or directory
jejb@titanic> diffstat ~/scsi-rc-fixes-2.6.diff 
 b/block/scsi_ioctl.c                  |  101 
 b/drivers/message/fusion/mptsas.c     |   10 
 b/drivers/scsi/3w-9xxx.c              |    9 
 b/drivers/scsi/Kconfig                |   24 
 b/drivers/scsi/Makefile               |    1 
 b/drivers/scsi/aacraid/aachba.c       |   94 
 b/drivers/scsi/aacraid/aacraid.h      |   11 
 b/drivers/scsi/aacraid/commctrl.c     |   12 
 b/drivers/scsi/aacraid/commsup.c      |   41 
 b/drivers/scsi/aacraid/linit.c        |   64 
 b/drivers/scsi/aacraid/rkt.c          |    4 
 b/drivers/scsi/aacraid/rx.c           |    4 
 b/drivers/scsi/aacraid/sa.c           |    2 
 b/drivers/scsi/aic7xxx/aic79xx.h      |    4 
 b/drivers/scsi/aic7xxx/aic79xx_core.c |  168 
 b/drivers/scsi/aic7xxx/aic79xx_osm.c  |    4 
 b/drivers/scsi/ibmvscsi/ibmvscsi.c    |  251 
 b/drivers/scsi/ibmvscsi/ibmvscsi.h    |    2 
 b/drivers/scsi/ibmvscsi/rpa_vscsi.c   |    1 
 b/drivers/scsi/ibmvscsi/viosrp.h      |   17 
 b/drivers/scsi/ipr.c                  |  122 
 b/drivers/scsi/ipr.h                  |   46 
 b/drivers/scsi/scsi.c                 |    5 
 b/drivers/scsi/scsi_devinfo.c         |    4 
 b/drivers/scsi/scsi_ioctl.c           |  176 
 b/drivers/scsi/scsi_lib.c             |   15 
 b/drivers/scsi/scsi_sas_internal.h    |   38 
 b/drivers/scsi/scsi_scan.c            |   19 
 b/drivers/scsi/scsi_transport_fc.c    |  464 +
 b/drivers/scsi/scsi_transport_sas.c   |   67 
 b/drivers/scsi/sg.c                   |    7 
 b/drivers/scsi/sym53c8xx_2/sym_defs.h |    2 
 b/drivers/scsi/sym53c8xx_2/sym_glue.c |  205 
 b/drivers/scsi/sym53c8xx_2/sym_glue.h |    2 
 b/drivers/scsi/sym53c8xx_2/sym_hipd.c |  113 
 b/drivers/scsi/sym53c8xx_2/sym_hipd.h |    2 
 b/include/linux/blkdev.h              |    4 
 b/include/scsi/scsi_devinfo.h         |    1 
 b/include/scsi/scsi_ioctl.h           |    2 
 b/include/scsi/scsi_transport_fc.h    |   41 
 drivers/scsi/ibmvscsi/srp.h           |  227 
 drivers/scsi/qlogicfc.c               | 2228 -------
 drivers/scsi/qlogicfc_asm.c           | 9751 ----------------------------------
 43 files changed, 1097 insertions(+), 13268 deletions(-)

James


