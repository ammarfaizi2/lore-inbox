Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbUJaOsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbUJaOsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 09:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUJaOro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 09:47:44 -0500
Received: from baikonur.stro.at ([213.239.196.228]:45206 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261643AbUJaOpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 09:45:53 -0500
Date: Sun, 31 Oct 2004 15:45:24 +0100
From: maximilian attems <janitor@sternwelten.at>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Margit Schubert-While <margitsw@t-online.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, hvr@gnu.org,
       mcgrof@studorgs.rutgers.edu, kernel-janitors@lists.osdl.org,
       netdev@oss.sgi.com, Domen Puncer <domen@coderock.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 6/6] libata remove msleep_libata()
Message-ID: <20041031144524.GG28667@stro.at>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Margit Schubert-While <margitsw@t-online.de>,
	Nishanth Aravamudan <nacc@us.ibm.com>, hvr@gnu.org,
	mcgrof@studorgs.rutgers.edu, kernel-janitors@lists.osdl.org,
	netdev@oss.sgi.com, Domen Puncer <domen@coderock.org>,
	linux-kernel@vger.kernel.org
References: <20040923221303.GB13244@us.ibm.com> <20040923221303.GB13244@us.ibm.com> <5.1.0.14.2.20040924074745.00b1cd40@pop.t-online.de> <415CD9D9.2000607@pobox.com> <20041030222228.GB1456@stro.at> <41841886.2080609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41841886.2080609@pobox.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




remove msleep_libata(), now that msleep() is backported.
also remove duplicate msleep() definition.
delay.h is already included.

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.4.28-rc1-max/drivers/scsi/libata-core.c |   23 -----------------------
 linux-2.4.28-rc1-max/include/linux/libata.h     |    1 -
 2 files changed, 24 deletions(-)

diff -puN drivers/scsi/libata-core.c~remove-libata_msleep drivers/scsi/libata-core.c
--- linux-2.4.28-rc1/drivers/scsi/libata-core.c~remove-libata_msleep	2004-10-31 14:06:49.000000000 +0100
+++ linux-2.4.28-rc1-max/drivers/scsi/libata-core.c	2004-10-31 14:08:41.000000000 +0100
@@ -67,28 +67,6 @@ MODULE_DESCRIPTION("Library module for A
 MODULE_LICENSE("GPL");
 
 /**
- *	msleep - sleep for a number of milliseconds
- *	@msecs: number of milliseconds to sleep
- *
- *	Issues schedule_timeout call for the specified number
- *	of milliseconds.
- *
- *	LOCKING:
- *	None.
- */
-
-static void msleep(unsigned long msecs)
-{
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(msecs_to_jiffies(msecs) + 1);
-}
-
-void libata_msleep(unsigned long msecs)
-{
-	msleep(msecs);
-}
-
-/**
  *	ata_tf_load - send taskfile registers to host controller
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
@@ -3697,7 +3675,6 @@ EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_scsi_detect);
 EXPORT_SYMBOL_GPL(ata_add_to_probe_list);
-EXPORT_SYMBOL_GPL(libata_msleep);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
diff -puN include/linux/libata.h~remove-libata_msleep include/linux/libata.h
--- linux-2.4.28-rc1/include/linux/libata.h~remove-libata_msleep	2004-10-31 14:06:49.000000000 +0100
+++ linux-2.4.28-rc1-max/include/linux/libata.h	2004-10-31 14:09:08.000000000 +0100
@@ -416,7 +416,6 @@ extern void ata_qc_complete(struct ata_q
 extern void ata_eng_timeout(struct ata_port *ap);
 extern void ata_add_to_probe_list (struct ata_probe_ent *probe_ent);
 extern int ata_std_bios_param(Disk * disk, kdev_t dev, int *ip);
-extern void libata_msleep(unsigned long msecs);
 
 
 static inline unsigned int ata_tag_valid(unsigned int tag)
_
