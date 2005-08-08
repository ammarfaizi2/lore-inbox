Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVHHT5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVHHT5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 15:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVHHT5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 15:57:51 -0400
Received: from kirby.webscope.com ([204.141.84.57]:9870 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932250AbVHHT5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 15:57:50 -0400
Message-ID: <42F7B8FB.30904@m1k.net>
Date: Mon, 08 Aug 2005 15:56:43 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, mkrufky@linuxtv.org
Subject: [PATCH] resubmit: Remove experimental tda9887 code from lgdt330x.c
Content-Type: multipart/mixed;
 boundary="------------050106040702030606030506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050106040702030606030506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew-

I've already sent this patch to you on LKML, but it is possible that it 
may have gotten lost, as I sent this patch in the middle of a thread, 
entitled:

Re: [PATCH] DVB: lgdt330x frontend: some bug fixes & add lgdt3303 support


This patch removes some experimental tda9887 code from lgdt330x.c (where 
is does NOT belong) that was unintentionally included by a previous patch.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>


-- 
Michael Krufky



--------------050106040702030606030506
Content-Type: text/plain;
 name="lgdt330x-remove-tda9887.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lgdt330x-remove-tda9887.patch"

 linux/drivers/media/dvb/frontends/lgdt330x.c |   35 -------------------
 1 files changed, 35 deletions(-)

diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt330x.c linux/drivers/media/dvb/frontends/lgdt330x.c
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt330x.c	2005-08-08 09:46:25.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt330x.c	2005-08-08 09:48:24.000000000 +0000
@@ -172,38 +172,6 @@
 	}
 }
 
-#ifdef MUTE_TDA9887
-static int i2c_write_ntsc_demod (struct lgdt330x_state* state, u8 buf[2])
-{
-	struct i2c_msg msg =
-		{ .addr = 0x43,
-		  .flags = 0, 
-		  .buf = buf,
-		  .len = 2 };
-	int err;
-
-	if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
-			printk(KERN_WARNING "lgdt330x: %s error (addr %02x <- %02x, err = %i)\n", __FUNCTION__, msg.buf[0], msg.buf[1], err);
-		if (err < 0)
-			return err;
-		else
-			return -EREMOTEIO;
-	}
-	return 0;
-}
-
-static void fiddle_with_ntsc_if_demod(struct lgdt330x_state* state)
-{
-	// Experimental code
-	u8 buf0[] = {0x00, 0x20};
-	u8 buf1[] = {0x01, 0x00};
-	u8 buf2[] = {0x02, 0x00};
-
-	i2c_write_ntsc_demod(state, buf0);
-	i2c_write_ntsc_demod(state, buf1);
-	i2c_write_ntsc_demod(state, buf2);
-}
-#endif
 
 static int lgdt330x_init(struct dvb_frontend* fe)
 {
@@ -267,9 +235,6 @@
 		chip_name = "LGDT3303";
 		err = i2c_write_demod_bytes(state, lgdt3303_init_data, 
 									sizeof(lgdt3303_init_data));
-#ifdef MUTE_TDA9887
-		fiddle_with_ntsc_if_demod(state);
-#endif
   		break;
 	default:
 		chip_name = "undefined";

--------------050106040702030606030506--

