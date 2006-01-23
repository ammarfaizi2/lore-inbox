Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWAWU1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWAWU1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWAWU1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:27:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28613 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964933AbWAWU1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:27:30 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 03/16] Add probe check for the tda9840.
Date: Mon, 23 Jan 2006 18:24:43 -0200
Message-id: <20060123202443.PS65514700003@infradead.org>
In-Reply-To: <20060123202404.PS66974000000@infradead.org>
References: <20060123202404.PS66974000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>

- Add probe check for the tda9840 to prevent misdetection of a Micronas
  dpl3518a as a tda9840.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/tvaudio.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

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

