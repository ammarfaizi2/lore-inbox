Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754544AbWKMMXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544AbWKMMXf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbWKMMXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:23:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17361 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754544AbWKMMXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:23:32 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Jean Delvare <khali@linux-fr.org>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 7/8] V4L/DVB (4817): Fix uses of "&&" where "&" was intended
Date: Mon, 13 Nov 2006 10:18:44 -0200
Message-id: <20061113121844.PS4890100007@infradead.org>
In-Reply-To: <20061113121504.PS7687690000@infradead.org>
References: <20061113121504.PS7687690000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jean Delvare <khali@linux-fr.org>

Fix uses of "&&" where "&" was intended in bttv-cards.c and tveeprom.c

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/bt8xx/bttv-cards.c |    2 +-
 drivers/media/video/tveeprom.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/bt8xx/bttv-cards.c b/drivers/media/video/bt8xx/bttv-cards.c
index a84903e..21ebe8f 100644
--- a/drivers/media/video/bt8xx/bttv-cards.c
+++ b/drivers/media/video/bt8xx/bttv-cards.c
@@ -4001,7 +4001,7 @@ static void __devinit init_PXC200(struct
  *      - sleep 1ms
  *      - write 0x0E
  *     read from GPIO_DATA into buf (uint_32)
- *      - if ( buf>>18 & 0x01 ) || ( buf>>19 && 0x01 != 0 )
+ *      - if ( buf>>18 & 0x01 ) || ( buf>>19 & 0x01 != 0 )
  *                error. ERROR_CPLD_Check_Failed.
  */
 /* ----------------------------------------------------------------------- */
diff --git a/drivers/media/video/tveeprom.c b/drivers/media/video/tveeprom.c
index e6baaee..6b9ef73 100644
--- a/drivers/media/video/tveeprom.c
+++ b/drivers/media/video/tveeprom.c
@@ -468,7 +468,7 @@ void tveeprom_hauppauge_analog(struct i2
 				(eeprom_data[i+6] << 8) +
 				(eeprom_data[i+7] << 16);
 
-				if ( (eeprom_data[i + 8] && 0xf0) &&
+				if ( (eeprom_data[i + 8] & 0xf0) &&
 					(tvee->serial_number < 0xffffff) ) {
 					tvee->MAC_address[0] = 0x00;
 					tvee->MAC_address[1] = 0x0D;

