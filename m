Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVALRgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVALRgs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 12:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVALRgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 12:36:48 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:43244 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261269AbVALRgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 12:36:36 -0500
Subject: [BK PATCH] SCSI updates for 2.6.11-rc1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 11:36:17 -0600
Message-Id: <1105551377.5577.24.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically the dump of the scsi-misc-2.6 tree accumulated to
date.  I'll begin on the scsi-rc-fixes-2.6 and scsi-misc-2.6 trees now.

It's mainly cleanups and some transport class work, with a driver update
for sym2.

The patch is available from:

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is:

Adrian Bunk:
  o SCSI aic7xxx: kill kernel 2.2 #ifdef's

Christoph Hellwig:
  o gdth: cleanup compat clutter

Dave Boutcher:
  o ibmvscsi: fix abort and reset error path
  o ibmvscsi: fix dangling pointer reference
  o ibmvscsi: fix loop exit condition
  o ibmvscsi: limit size of I/O requests, updated

James Bottomley:
  o FC Transport updates - additional fc host attributes
  o SCSI: add starget_for_each_device
  o Fix exploitable hole in sg_scsi_ioctl
  o fix SPI transport class to do DV for broken Western Digital drives
  o SCSI: update ipr to use the change_queue_depth API

Jens Axboe:
  o gdth buggy page mapping

Jesper Juhl:
  o clean out old cruft from FD MCS driver

Jesse Barnes:
  o use mmiowb in qla1280.c

Matthew Wilcox:
  o Misc zalon fixes
  o Remove lasi700.h
  o sym2 version 2.1.18n

Mike Christie:
  o export print_sense_internal

Mike Miller:
  o cciss update to version 2.6.4

Randy Dunlap:
  o gdth: reduce large on-stack locals

Tom Coughlan:
  o aacraid: remove aac_handle_aif

Tony Battersby:
  o fix read capacity for large disks when CONFIG_LBD=n

Willem Riede:
  o osst: add sysfs support
  o osst: error handling updates
  o osst: remove typedefs

And the diffstat:

 b/Documentation/cciss.txt                |    3 
 b/drivers/block/cciss.c                  |   17 
 b/drivers/block/scsi_ioctl.c             |    3 
 b/drivers/scsi/aacraid/commsup.c         |   27 
 b/drivers/scsi/aic7xxx/aic7770_osm.c     |   12 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.h     |    2 
 b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |   91 --
 b/drivers/scsi/aic7xxx/aic7xxx_pci.c     |    4 
 b/drivers/scsi/constants.c               |   24 
 b/drivers/scsi/fd_mcs.c                  |   58 -
 b/drivers/scsi/gdth.c                    |  954 +++++++------------------------
 b/drivers/scsi/gdth_kcompat.h            |   21 
 b/drivers/scsi/gdth_proc.c               |  287 +++------
 b/drivers/scsi/gdth_proc.h               |    6 
 b/drivers/scsi/ibmvscsi/ibmvscsi.c       |  142 +++-
 b/drivers/scsi/ibmvscsi/ibmvscsi.h       |    1 
 b/drivers/scsi/ipr.c                     |   28 
 b/drivers/scsi/lasi700.c                 |   22 
 b/drivers/scsi/osst.c                    |  851 +++++++++++++++++----------
 b/drivers/scsi/osst.h                    |   15 
 b/drivers/scsi/qla1280.c                 |   22 
 b/drivers/scsi/scsi.c                    |   22 
 b/drivers/scsi/scsi_lib.c                |   18 
 b/drivers/scsi/scsi_transport_fc.c       |   36 -
 b/drivers/scsi/scsi_transport_spi.c      |   91 ++
 b/drivers/scsi/sd.c                      |    7 
 b/drivers/scsi/sym53c8xx_2/sym_conf.h    |    8 
 b/drivers/scsi/sym53c8xx_2/sym_defs.h    |   34 -
 b/drivers/scsi/sym53c8xx_2/sym_fw.c      |    4 
 b/drivers/scsi/sym53c8xx_2/sym_glue.c    |   83 --
 b/drivers/scsi/sym53c8xx_2/sym_glue.h    |   34 -
 b/drivers/scsi/sym53c8xx_2/sym_hipd.c    |  469 ++++++---------
 b/drivers/scsi/sym53c8xx_2/sym_hipd.h    |   72 --
 b/drivers/scsi/sym53c8xx_2/sym_malloc.c  |    2 
 b/drivers/scsi/sym53c8xx_2/sym_misc.c    |   98 ---
 b/drivers/scsi/sym53c8xx_2/sym_nvram.c   |   39 +
 b/drivers/scsi/sym53c8xx_2/sym_nvram.h   |    6 
 b/drivers/scsi/sym53c8xx_comm.h          |    2 
 b/drivers/scsi/zalon.c                   |   21 
 b/include/linux/pci_ids.h                |    2 
 b/include/scsi/scsi_dbg.h                |    3 
 b/include/scsi/scsi_device.h             |    2 
 b/include/scsi/scsi_transport_fc.h       |   22 
 drivers/scsi/fd_mcs.h                    |   37 -
 drivers/scsi/lasi700.h                   |   49 -
 45 files changed, 1559 insertions(+), 2192 deletions(-)

James


