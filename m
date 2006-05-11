Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWEKTnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWEKTnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 15:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWEKTnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 15:43:41 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:8359 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750716AbWEKTnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 15:43:40 -0400
Subject: [GIT PATCH] scsi bug fixes for 2.6.17-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 11 May 2006 14:43:19 -0500
Message-Id: <1147376599.3638.24.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are basically assorted fixes (and a warning elimination for
Andrew).  The patch is available here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

The short changelog is:

<mdr:sgi.com>:
  o mptfc: race between mptfc_register_dev and mptfc_target_alloc

Adrian Bunk:
  o megaraid/megaraid_mm.c: fix a NULL pointer dereference

Andrew Morton:
  o megaraid: unused variable

Brian King:
  o scsi: Add IBM 2104-DU3 to blist

Denis Vlasenko:
  o aic7xxx: ahc_pci_write_config() fix

Eric Moore:
  o mptspi: revalidate negotiation parameters after host reset and
resume
  o fusion - bug fix stack overflow in mptbase
  o fusion - mptfc bug fix's to prevent deadlock situations
  o mptfusion: bug fix's for raid components adding/deleting

Eric Sesterhenn:
  o Overrun in drivers/scsi/sim710.c

James Bottomley:
  o Fix DVD burning issues

James Smart:
  o lpfc 8.1.6 : Fix Data Corruption in Bus Reset Path
  o lpfc 8.1.5 : Change version number to 8.1.5
  o lpfc 8.1.5 : Misc small fixes
  o lpfc 8.1.5 : Additional fixes to LOGO, PLOGI, and RSCN processing
  o lpfc 8.1.5 : Fix cleanup code in the lpfc_pci_probe_one() error code
path
  o lpfc 8.1.5 : Fixed FC protocol violation in handling of PRLO
  o lpfc 8.1.5 : Use asynchronous ABTS completion to speed up abort
completions
  o lpfc 8.1.5 : Fix Discovery processing for NPorts that hit nodev_tmo
during discovery

Jesper Juhl:
  o aic7xxx_osm_pci resource leak fix

Michael Reed:
  o qla2xxx: Correct eh_abort recovery logic

Roland Dreier:
  o srp.h: avoid padding of structs

Seokmann Ju:
  o megaraid_{mm,mbox}: fix a bug in reset handler

Tomonori FUJITA:
  o ibmvscsi: fix leak when failing to send srp event

Zach Brown:
  o qla2xxx: only free_irq() after request_irq() succeeds

And the diffstat:

 Documentation/scsi/ChangeLog.megaraid  |   25 ++++++
 drivers/message/fusion/mptbase.c       |   63 +++++++++------
 drivers/message/fusion/mptbase.h       |   10 --
 drivers/message/fusion/mptfc.c         |  134 ++++++++++++++++++++-------------
 drivers/message/fusion/mptsas.c        |   99 +++++++++++++++++-------
 drivers/message/fusion/mptscsih.c      |   50 ++++++------
 drivers/message/fusion/mptspi.c        |   68 ++++++++++++++++
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |    1 
 drivers/scsi/aic7xxx/aic7xxx_pci.c     |   12 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c       |   30 ++++---
 drivers/scsi/lpfc/lpfc_crtn.h          |    1 
 drivers/scsi/lpfc/lpfc_disc.h          |    1 
 drivers/scsi/lpfc/lpfc_els.c           |   95 +++++++++++++----------
 drivers/scsi/lpfc/lpfc_hbadisc.c       |   18 ++--
 drivers/scsi/lpfc/lpfc_hw.h            |    3 
 drivers/scsi/lpfc/lpfc_init.c          |   22 ++---
 drivers/scsi/lpfc/lpfc_mbox.c          |   33 --------
 drivers/scsi/lpfc/lpfc_nportdisc.c     |  134 +++++++++++++++++++++++----------
 drivers/scsi/lpfc/lpfc_scsi.c          |   68 ++++------------
 drivers/scsi/lpfc/lpfc_version.h       |    2 
 drivers/scsi/megaraid.c                |    1 
 drivers/scsi/megaraid/megaraid_mbox.c  |   59 ++++++++++----
 drivers/scsi/megaraid/megaraid_mbox.h  |    7 +
 drivers/scsi/megaraid/megaraid_mm.c    |    6 -
 drivers/scsi/qla2xxx/qla_os.c          |   19 ++--
 drivers/scsi/scsi_devinfo.c            |    2 
 drivers/scsi/scsi_lib.c                |   27 ++++--
 drivers/scsi/sim710.c                  |    2 
 include/scsi/srp.h                     |   23 ++++-
 29 files changed, 632 insertions(+), 383 deletions(-)

James


