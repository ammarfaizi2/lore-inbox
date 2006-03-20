Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965566AbWCTPvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965566AbWCTPvn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965560AbWCTPvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:51:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28642 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966672AbWCTPTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:19:45 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Curt Meyers <cmeyers@boilerbots.com>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 100/141] V4L/DVB (3366): Kworld ATSC110: initialize the
	tuner for analog mode on module load
Date: Mon, 20 Mar 2006 12:08:53 -0300
Message-id: <20060320150853.PS668448000100@infradead.org>
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

From: Curt Meyers <cmeyers@boilerbots.com>
Date: 1141009719 -0300

- Enable the tuv1236 tuner on the Kworld-ATSC110 card so that the
  tuner can be identified when tuners.ko loads.
- With this change it is no longer necessary to remove and reload
  the tuner module in order to get the tuv1236 identified.
- This code was copied from the ATI HDTV Wonder init routine (in cx88-cards.c)
  which also uses the TUV1236D.

Signed-off-by: Curt Meyers <cmeyers@boilerbots.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 99cefdd..e1145a8 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -3549,6 +3549,18 @@ int saa7134_board_init2(struct saa7134_d
 		i2c_transfer(&dev->i2c_adap, &msg, 1);
 		}
 		break;
+	case SAA7134_BOARD_KWORLD_ATSC110:
+		{
+			/* enable tuner */
+			int i;
+			u8 buffer [] = { 0x10,0x12,0x13,0x04,0x16,0x00,0x14,0x04,0x017,0x00 };
+			dev->i2c_client.addr = 0x0a;
+			for (i = 0; i < 5; i++)
+				if (2 != i2c_master_send(&dev->i2c_client,&buffer[i*2],2))
+					printk(KERN_WARNING "%s: Unable to enable tuner(%i).\n",
+					       dev->name, i);
+		}
+		break;
 	}
 	return 0;
 }

