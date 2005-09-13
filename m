Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVIMCpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVIMCpB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 22:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVIMCpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 22:45:01 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:50636 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932259AbVIMCpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 22:45:00 -0400
Subject: [GIT PATCH] scsi merge for 2.6.13
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 21:44:48 -0500
Message-Id: <1126579489.4825.5.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should be the final round of changes before we close down into bug
fix mode.  There will be a few extra driver updates in some of the -rc
stages (there's at least aacraid and zfcp still going through the
process).

The patch is available here [URL checked this time]

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-for-linus-2.6.git

The short change log is:

adam radford:
  o 3ware 9000: handle use_sg != 0 for emulated commands

Alan Stern:
  o Fix module removal/device add race
  o fix callers of scsi_remove_device() who already hold the scan muted
  o add missing scan mutex to scsi_scan_target()

Andrew Vasquez:
  o lpfc: use wwn_to_u64() transport helper
  o qla2xxx: use wwn_to_u64() transport helper
  o fc_transport: Generalize WWN to u64 interger conversions

Christoph Hellwig:
  o SAS transport class

Douglas Gilbert:
  o permit READ DEFECT DATA in block/scsi_ioctl
  o sg: do not set VM_IO flag on mmap-ed pages

James Bottomley:
  o Alter the scsi_add_device() API to conform to what users expect
  o SAS transport class: fixup prototype of sas_host_setup
  o core: fix leakage of scsi_cmnd's
  o core: fix leakage of scsi_cmnd's

Mike Christie:
  o set error value when failing commands in prep_fn

Neil Brown:
  o fix possible deadlock in scsi_lib.c

Tejun Heo:
  o scsi: Error handler description document

The diffstat is:

 Documentation/scsi/00-INDEX       |    2 
 Documentation/scsi/scsi_eh.txt    |  479 ++++++++++++++++++++++
 drivers/block/scsi_ioctl.c        |    1 
 drivers/ieee1394/sbp2.c           |    8 
 drivers/scsi/3w-9xxx.c            |   30 +
 drivers/scsi/Kconfig              |    7 
 drivers/scsi/Makefile             |    1 
 drivers/scsi/lpfc/lpfc_attr.c     |   22 -
 drivers/scsi/lpfc/lpfc_hbadisc.c  |    7 
 drivers/scsi/lpfc/lpfc_hw.h       |   17 
 drivers/scsi/lpfc/lpfc_init.c     |    7 
 drivers/scsi/qla2xxx/qla_attr.c   |   18 
 drivers/scsi/qla2xxx/qla_init.c   |    4 
 drivers/scsi/scsi_lib.c           |  138 ++++--
 drivers/scsi/scsi_priv.h          |    1 
 drivers/scsi/scsi_scan.c          |   88 ++--
 drivers/scsi/scsi_sysfs.c         |   28 -
 drivers/scsi/scsi_transport_sas.c |  820 ++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sg.c                 |    4 
 include/scsi/scsi_device.h        |    4 
 include/scsi/scsi_transport_fc.h  |    8 
 include/scsi/scsi_transport_sas.h |  100 ++++
 22 files changed, 1648 insertions(+), 146 deletions(-)

James


