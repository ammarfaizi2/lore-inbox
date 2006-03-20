Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965668AbWCTQAD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965668AbWCTQAD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965673AbWCTP7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:59:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50328 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966512AbWCTPRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:17:24 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 006/141] V4L/DVB (3403): Add probe check for the tda9840.
Date: Mon, 20 Mar 2006 12:08:38 -0300
Message-id: <20060320150838.PS082799000006@infradead.org>
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

From: Hans Verkuil <hverkuil@xs4all.nl>
Date: 1138016860 -0200

- Add probe check for the tda9840 to prevent misdetection of a Micronas
  dpl3518a as a tda9840.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
diff --git a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
index 6d03b9b..c8e5ad0 100644
--- a/drivers/media/video/tvaudio.c
+++ b/drivers/media/video/tvaudio.c
@@ -390,6 +390,14 @@ static void tda9840_setmode(struct CHIPS
 		chip_write(chip, TDA9840_SW, t);
 }
 
+static int tda9840_checkit(struct CHIPSTATE *chip)
+{
+	int rc;
+	rc = chip_read(chip);
+	/* lower 5 bits should be 0 */
+	return ((rc & 0x1f) == 0) ? 1 : 0;
+}
+
 /* ---------------------------------------------------------------------- */
 /* audio chip descriptions - defines+functions for tda985x                */
 
@@ -1264,6 +1272,7 @@ static struct CHIPDESC chiplist[] = {
 		.addr_hi    = I2C_TDA9840 >> 1,
 		.registers  = 5,
 
+		.checkit    = tda9840_checkit,
 		.getmode    = tda9840_getmode,
 		.setmode    = tda9840_setmode,
 		.checkmode  = generic_checkmode,

