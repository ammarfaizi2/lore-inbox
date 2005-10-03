Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVJCOmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVJCOmM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbVJCOmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:42:12 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:29154 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750892AbVJCOmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:42:11 -0400
Subject: [GIT PATCH] SCSI Bug fixes for 2.6.14-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 09:41:55 -0500
Message-Id: <1128350515.5733.4.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the set of bugfixes (plus new drivers) I have pending.  The
aacraid update is the one that was delayed in review.

The update is here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-for-linus-2.6.git

The short changelog is:

adam radford:
  o 3ware 9000: Add support for 9550SX controllers

Andrew Morton:
  o lpfc build fix

Andrew Vasquez:
  o qla2xxx: fix remote port timeout with qla2xxx driver

Christoph Hellwig:
  o sas: fix remote phy removal

James Bottomley:
  o Legacy MegaRAID: Fix READ CAPACITY
  o aic7xxx/aic79xx: fix module removal path not to panic
  o fix potential panic with proc on module removal
  o allow REPORT LUN scanning even for LUN 0 PQ of 3

Mark Haverkamp:
  o aacraid: remove aac_insert_entry
  o aacraid: fib size math fix
  o aacraid: initialization timeout
  o aacraid: error return checking
  o aacraid: handle AIF hotplug events (update)
  o aacraid: aacraid: AIF preallocation (update)
  o aacraid: Greater than 2TB capacity support

Sreenivas Bagalkote:
  o MegaRAID SAS RAID: new driver

And the diffstat

 drivers/scsi/3w-9xxx.c                 |   55 
 drivers/scsi/3w-9xxx.h                 |   17 
 drivers/scsi/Makefile                  |    1 
 drivers/scsi/aacraid/aachba.c          |  283 ++-
 drivers/scsi/aacraid/aacraid.h         |   17 
 drivers/scsi/aacraid/comminit.c        |   17 
 drivers/scsi/aacraid/commsup.c         |  581 +++++-
 drivers/scsi/aacraid/linit.c           |   12 
 drivers/scsi/aic7xxx/aic7770_osm.c     |    3 
 drivers/scsi/aic7xxx/aic79xx_osm.c     |    8 
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c |    3 
 drivers/scsi/aic7xxx/aic7xxx_osm.c     |    8 
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |    3 
 drivers/scsi/hosts.c                   |    2 
 drivers/scsi/lpfc/lpfc_attr.c          |    8 
 drivers/scsi/lpfc/lpfc_hbadisc.c       |    4 
 drivers/scsi/lpfc/lpfc_hw.h            |    4 
 drivers/scsi/lpfc/lpfc_init.c          |    6 
 drivers/scsi/megaraid.c                |   68 
 drivers/scsi/megaraid/Kconfig.megaraid |    9 
 drivers/scsi/megaraid/Makefile         |    1 
 drivers/scsi/megaraid/megaraid_sas.c   | 2805 +++++++++++++++++++++++++++++++++
 drivers/scsi/megaraid/megaraid_sas.h   | 1142 +++++++++++++
 drivers/scsi/qla2xxx/qla_rscn.c        |    2 
 drivers/scsi/scsi_scan.c               |   96 -
 drivers/scsi/scsi_transport_sas.c      |    9 
 include/linux/pci_ids.h                |    2 
 include/scsi/scsi_device.h             |    1 
 28 files changed, 4858 insertions(+), 309 deletions(-)

James


