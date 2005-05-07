Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVEGAza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVEGAza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 20:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVEGAz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 20:55:29 -0400
Received: from mail.dif.dk ([193.138.115.101]:15572 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261420AbVEGAyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 20:54:31 -0400
Date: Sat, 7 May 2005 02:58:14 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: Ed Okerson <eokerson@quicknet.net>, akpm@osdl.org
Subject: [PATCH] kfree cleanups (remove redundant NULL checks) in drivers/telephony/
 (actually ixj.c only)
Message-ID: <Pine.LNX.4.62.0505070254180.2384@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes redundant checks for NULL pointer before kfree() in 
drivers/telephony/


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/telephony/ixj.c |   48 +++++++++++++++++-------------------------------
 1 files changed, 17 insertions(+), 31 deletions(-)

diff -upr linux-2.6.12-rc3-mm3-orig/drivers/telephony/ixj.c linux-2.6.12-rc3-mm3/drivers/telephony/ixj.c
--- linux-2.6.12-rc3-mm3-orig/drivers/telephony/ixj.c	2005-05-06 23:21:17.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/telephony/ixj.c	2005-05-07 02:53:15.000000000 +0200
@@ -329,10 +329,8 @@ static IXJ *ixj_alloc()
 
 static void ixj_fsk_free(IXJ *j)
 {
-	if(j->fskdata != NULL) {
-		kfree(j->fskdata);
-		j->fskdata = NULL;
-	}
+	kfree(j->fskdata);
+	j->fskdata = NULL;
 }
 
 static void ixj_fsk_alloc(IXJ *j)
@@ -3869,11 +3867,9 @@ static int set_rec_codec(IXJ *j, int rat
 	default:
 		j->rec_frame_size = 0;
 		j->rec_mode = -1;
-		if (j->read_buffer) {
-			kfree(j->read_buffer);
-			j->read_buffer = NULL;
-			j->read_buffer_size = 0;
-		}
+		kfree(j->read_buffer);
+		j->read_buffer = NULL;
+		j->read_buffer_size = 0;
 		retval = 1;
 		break;
 	}
@@ -3994,11 +3990,9 @@ static void ixj_record_stop(IXJ *j)
 	if(ixjdebug & 0x0002)
 		printk("IXJ %d Stopping Record Codec %d at %ld\n", j->board, j->rec_codec, jiffies);
 
-	if (j->read_buffer) {
-		kfree(j->read_buffer);
-		j->read_buffer = NULL;
-		j->read_buffer_size = 0;
-	}
+	kfree(j->read_buffer);
+	j->read_buffer = NULL;
+	j->read_buffer_size = 0;
 	if (j->rec_mode > -1) {
 		ixj_WriteDSPCommand(0x5120, j);
 		j->rec_mode = -1;
@@ -4451,11 +4445,9 @@ static int set_play_codec(IXJ *j, int ra
 	default:
 		j->play_frame_size = 0;
 		j->play_mode = -1;
-		if (j->write_buffer) {
-			kfree(j->write_buffer);
-			j->write_buffer = NULL;
-			j->write_buffer_size = 0;
-		}
+		kfree(j->write_buffer);
+		j->write_buffer = NULL;
+		j->write_buffer_size = 0;
 		retval = 1;
 		break;
 	}
@@ -4581,11 +4573,9 @@ static void ixj_play_stop(IXJ *j)
 	if(ixjdebug & 0x0002)
 		printk("IXJ %d Stopping Play Codec %d at %ld\n", j->board, j->play_codec, jiffies);
 
-	if (j->write_buffer) {
-		kfree(j->write_buffer);
-		j->write_buffer = NULL;
-		j->write_buffer_size = 0;
-	}
+	kfree(j->write_buffer);
+	j->write_buffer = NULL;
+	j->write_buffer_size = 0;
 	if (j->play_mode > -1) {
 		ixj_WriteDSPCommand(0x5221, j);	/* Stop playback and flush buffers.  8022 reference page 9-40 */
 
@@ -5810,9 +5800,7 @@ static void ixj_cpt_stop(IXJ *j)
 		ixj_play_tone(j, 0);
 		j->tone_state = j->tone_cadence_state = 0;
 		if (j->cadence_t) {
-			if (j->cadence_t->ce) {
-				kfree(j->cadence_t->ce);
-			}
+			kfree(j->cadence_t->ce);
 			kfree(j->cadence_t);
 			j->cadence_t = NULL;
 		}
@@ -7497,10 +7485,8 @@ static void cleanup(void)
 					printk(KERN_INFO "IXJ: Releasing XILINX address for /dev/phone%d\n", cnt);
 				release_region(j->XILINXbase, 4);
 			}
-			if (j->read_buffer)
-				kfree(j->read_buffer);
-			if (j->write_buffer)
-				kfree(j->write_buffer);
+			kfree(j->read_buffer);
+			kfree(j->write_buffer);
 			if (j->dev)
 				pnp_device_detach(j->dev);
 			if (ixjdebug & 0x0002)



