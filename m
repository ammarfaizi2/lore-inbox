Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWCTPW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWCTPW7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbWCTPW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:22:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57058 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964939AbWCTPWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:22:52 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 129/141] V4L/DVB (3400): Fixes for Lifeview Trio non fatal
	bugs
Date: Mon, 20 Mar 2006 12:08:58 -0300
Message-id: <20060320150858.PS550021000129@infradead.org>
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

From: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Date: 1141085287 -0300

- Init message was sent to wrong slave address 
- Deleted outdated comment

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index f156650..ea2fa0d 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2624,7 +2624,7 @@ struct saa7134_board saa7134_boards[] = 
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
 		.gpiomask	= 0x00200000,
-		.mpeg           = SAA7134_MPEG_DVB,	/* FIXME: DVB not implemented yet */
+		.mpeg           = SAA7134_MPEG_DVB,
 		.inputs         = {{
 			.name = name_tv,	/* Analog broadcast/cable TV */
 			.vmux = 1,
@@ -3549,6 +3549,12 @@ int saa7134_board_init2(struct saa7134_d
 		}
 		break;
 	case SAA7134_BOARD_FLYDVB_TRIO:
+		{
+		u8 data[] = { 0x3c, 0x33, 0x62};
+		struct i2c_msg msg = {.addr=0x09, .flags=0, .buf=data, .len = sizeof(data)};
+		i2c_transfer(&dev->i2c_adap, &msg, 1);
+		}
+		break;
 	case SAA7134_BOARD_ADS_DUO_CARDBUS_PTV331:
 		/* make the tda10046 find its eeprom */
 		{

