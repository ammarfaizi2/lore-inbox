Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbUKDHeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUKDHeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUKDHdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:33:38 -0500
Received: from mail.convergence.de ([212.227.36.84]:49319 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262119AbUKDH0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:26:09 -0500
Message-ID: <4189D95C.5000102@linuxtv.org>
Date: Thu, 04 Nov 2004 08:25:16 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Gerd Knorr <kraxel@bytesex.org>
Subject: [PATCH][V4L] keep tvaudio driver away from saa7146
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010800070407020003040806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010800070407020003040806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

the attached patch keeps the tvaudio i2c helper module away from any 
saa7146 based framegrabber. All saa7146 drivers have their dedicated i2c 
helper modules and don't work together with tvaudio, so keep it away 
alltogether. This will make mixed-card configurations work.

The patch was discussed and ack'ed by Gerd Knorr.

Please apply.

Thanks
Michael.


--------------010800070407020003040806
Content-Type: text/plain;
 name="tvaudio.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tvaudio.diff"

- [V4L] don't attach tvaudio module on saa7146 i2c busses

Signed-off-by: Michael Hunold <hunold@linuxtv.org>
Acked-by: Gerd Knorr <kraxel@bytesex.org>

diff -ura b/drivers/media/video/tvaudio.c linux-2.6.10-rc1-bk9-debug/drivers/media/video/tvaudio.c
--- b/drivers/media/video/tvaudio.c	2004-11-01 16:54:04.000000000 +0100
+++ linux-2.6.10-rc1-bk9-debug/drivers/media/video/tvaudio.c	2004-11-01 16:56:09.000000000 +0100
@@ -1497,6 +1497,10 @@
 
 static int chip_probe(struct i2c_adapter *adap)
 {
+	/* don't attach on saa7146 based cards,
+	   because dedicated drivers are used */
+	if ((adap->id & I2C_ALGO_SAA7146))
+		return 0;
 #ifdef I2C_CLASS_TV_ANALOG
 	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, chip_attach);

--------------010800070407020003040806--
