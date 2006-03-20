Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbWCTP7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbWCTP7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965672AbWCTP7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:59:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51352 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965208AbWCTPRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:17:30 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Manu Abraham <manu@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 119/141] V4L/DVB (3392): Do a RESYNC for all cards
Date: Mon, 20 Mar 2006 12:08:57 -0300
Message-id: <20060320150856.PS934510000119@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Abraham <manu@linuxtv.org>
Date: 1141009777 -0300

After a FIFO corruptions occurrs (generally due to buffer overflow), FIFO
contents needs to be discarted.

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
index f5bfcd2..b8eab69 100644
--- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -813,14 +813,14 @@ static int dvb_bt8xx_probe(struct bttv_s
 		card->gpio_mode = 0x0400c060;
 		/* should be: BT878_A_GAIN=0,BT878_A_PWRDN,BT878_DA_DPM,BT878_DA_SBR,
 			      BT878_DA_IOM=1,BT878_DA_APP to enable serial highspeed mode. */
-		card->op_sync_orin = 0;
-		card->irq_err_ignore = 0;
+		card->op_sync_orin = BT878_RISC_SYNC_MASK;
+		card->irq_err_ignore = BT878_AFBUS | BT878_AFDSR;
 		break;
 
 	case BTTV_BOARD_DVICO_DVBT_LITE:
 		card->gpio_mode = 0x0400C060;
-		card->op_sync_orin = 0;
-		card->irq_err_ignore = 0;
+		card->op_sync_orin = BT878_RISC_SYNC_MASK;
+		card->irq_err_ignore = BT878_AFBUS | BT878_AFDSR;
 		/* 26, 15, 14, 6, 5
 		 * A_PWRDN  DA_DPM DA_SBR DA_IOM_DA
 		 * DA_APP(parallel) */
@@ -835,15 +835,15 @@ static int dvb_bt8xx_probe(struct bttv_s
 	case BTTV_BOARD_NEBULA_DIGITV:
 	case BTTV_BOARD_AVDVBT_761:
 		card->gpio_mode = (1 << 26) | (1 << 14) | (1 << 5);
-		card->op_sync_orin = 0;
-		card->irq_err_ignore = 0;
+		card->op_sync_orin = BT878_RISC_SYNC_MASK;
+		card->irq_err_ignore = BT878_AFBUS | BT878_AFDSR;
 		/* A_PWRDN DA_SBR DA_APP (high speed serial) */
 		break;
 
 	case BTTV_BOARD_AVDVBT_771: //case 0x07711461:
 		card->gpio_mode = 0x0400402B;
 		card->op_sync_orin = BT878_RISC_SYNC_MASK;
-		card->irq_err_ignore = 0;
+		card->irq_err_ignore = BT878_AFBUS | BT878_AFDSR;
 		/* A_PWRDN DA_SBR  DA_APP[0] PKTP=10 RISC_ENABLE FIFO_ENABLE*/
 		break;
 
@@ -867,8 +867,8 @@ static int dvb_bt8xx_probe(struct bttv_s
 
 	case BTTV_BOARD_PC_HDTV:
 		card->gpio_mode = 0x0100EC7B;
-		card->op_sync_orin = 0;
-		card->irq_err_ignore = 0;
+		card->op_sync_orin = BT878_RISC_SYNC_MASK;
+		card->irq_err_ignore = BT878_AFBUS | BT878_AFDSR;
 		break;
 
 	default:

