Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933857AbWKTCXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933857AbWKTCXr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933867AbWKTCXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:23:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35089 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933857AbWKTCXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:23:43 -0500
Date: Mon, 20 Nov 2006 03:23:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/aic7xxx/: make functions static
Message-ID: <20061120022342.GE31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlesly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/aic7xxx/aic79xx_osm.c  |    6 ++++--
 drivers/scsi/aic7xxx/aic79xx_osm.h  |    2 --
 drivers/scsi/aic7xxx/aic7xxx.h      |    5 -----
 drivers/scsi/aic7xxx/aic7xxx_core.c |    2 +-
 4 files changed, 5 insertions(+), 10 deletions(-)

--- a/drivers/scsi/aic7xxx/aic79xx_osm.c~drivers-scsi-aic7xxx-possible-cleanups-2
+++ a/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -363,6 +363,8 @@ static int ahd_linux_run_command(struct 
 				 struct scsi_cmnd *);
 static void ahd_linux_setup_tag_info_global(char *p);
 static int  aic79xx_setup(char *c);
+static void ahd_freeze_simq(struct ahd_softc *ahd);
+static void ahd_release_simq(struct ahd_softc *ahd);
 
 static int ahd_linux_unit;
 
@@ -2024,13 +2026,13 @@ ahd_linux_queue_cmd_complete(struct ahd_
 	cmd->scsi_done(cmd);
 }
 
-void
+static void
 ahd_freeze_simq(struct ahd_softc *ahd)
 {
 	scsi_block_requests(ahd->platform_data->host);
 }
 
-void
+static void
 ahd_release_simq(struct ahd_softc *ahd)
 {
 	scsi_unblock_requests(ahd->platform_data->host);
--- a/drivers/scsi/aic7xxx/aic79xx_osm.h~drivers-scsi-aic7xxx-possible-cleanups-2
+++ a/drivers/scsi/aic7xxx/aic79xx_osm.h
@@ -731,8 +727,6 @@ int	ahd_platform_alloc(struct ahd_softc 
 void	ahd_platform_free(struct ahd_softc *ahd);
 void	ahd_platform_init(struct ahd_softc *ahd);
 void	ahd_platform_freeze_devq(struct ahd_softc *ahd, struct scb *scb);
-void	ahd_freeze_simq(struct ahd_softc *ahd);
-void	ahd_release_simq(struct ahd_softc *ahd);
 
 static inline void
 ahd_freeze_scb(struct scb *scb)
--- linux-2.6.19-rc5-mm2/drivers/scsi/aic7xxx/aic7xxx.h.old	2006-11-20 00:47:20.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/scsi/aic7xxx/aic7xxx.h	2006-11-20 00:47:27.000000000 +0100
@@ -1278,11 +1278,6 @@
 	AHC_QUEUE_TAGGED
 } ahc_queue_alg;
 
-void			ahc_set_tags(struct ahc_softc *ahc,
-				     struct scsi_cmnd *cmd,
-				     struct ahc_devinfo *devinfo,
-				     ahc_queue_alg alg);
-
 /**************************** Target Mode *************************************/
 #ifdef AHC_TARGET_MODE
 void		ahc_send_lstate_events(struct ahc_softc *,
--- linux-2.6.19-rc5-mm2/drivers/scsi/aic7xxx/aic7xxx_core.c.old	2006-11-20 00:47:34.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/scsi/aic7xxx/aic7xxx_core.c	2006-11-20 00:47:45.000000000 +0100
@@ -2073,7 +2073,7 @@
 /*
  * Update the current state of tagged queuing for a given target.
  */
-void
+static void
 ahc_set_tags(struct ahc_softc *ahc, struct scsi_cmnd *cmd,
 	     struct ahc_devinfo *devinfo, ahc_queue_alg alg)
 {

