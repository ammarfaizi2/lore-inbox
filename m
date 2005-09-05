Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbVIEV31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbVIEV31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVIEV3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:29:15 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:38735 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932590AbVIEV3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:29:08 -0400
Date: Mon, 05 Sep 2005 18:26:16 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 14/24] V4L: tveeprom patch was not complete. Completing
 it.
Message-ID: <431cb7f8.nUWA5qQ+v12ssoC0%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f8.SmbXs/qGlBGYUNs6E8YGPZEqNajvGv7i3pAyE/ZknW4BzQi1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f8.SmbXs/qGlBGYUNs6E8YGPZEqNajvGv7i3pAyE/ZknW4BzQi1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f8.SmbXs/qGlBGYUNs6E8YGPZEqNajvGv7i3pAyE/ZknW4BzQi1
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-14-patch.diff"

- tveeprom patch was not complete. Completing it.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/bttv-cards.c      |    2 +-
 linux/drivers/media/video/cx88/cx88-cards.c |    2 +-
 linux/include/media/tveeprom.h              |    8 ++++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff -u /tmp/dst.380 linux/drivers/media/video/bttv-cards.c
--- /tmp/dst.380	2005-09-05 11:42:58.000000000 -0300
+++ linux/drivers/media/video/bttv-cards.c	2005-09-05 11:42:58.000000000 -0300
@@ -3062,7 +3062,7 @@
 {
 	struct tveeprom tv;
 
-	tveeprom_hauppauge_analog(&tv, eeprom_data);
+	tveeprom_hauppauge_analog(&btv->i2c_client, &tv, eeprom_data);
 	btv->tuner_type = tv.tuner_type;
 	btv->has_radio  = tv.has_radio;
 }
diff -u /tmp/dst.380 linux/drivers/media/video/cx88/cx88-cards.c
--- /tmp/dst.380	2005-09-05 11:42:58.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-cards.c	2005-09-05 11:42:58.000000000 -0300
@@ -945,7 +945,7 @@
 {
 	struct tveeprom tv;
 
-	tveeprom_hauppauge_analog(&tv, eeprom_data);
+	tveeprom_hauppauge_analog(&core->i2c_client, &tv, eeprom_data);
 	core->tuner_type = tv.tuner_type;
 	core->has_radio  = tv.has_radio;
 }
diff -u /tmp/dst.380 linux/include/media/tveeprom.h
--- /tmp/dst.380	2005-09-05 11:42:59.000000000 -0300
+++ linux/include/media/tveeprom.h	2005-09-05 11:42:59.000000000 -0300
@@ -3,15 +3,19 @@
 
 struct tveeprom {
 	u32 has_radio;
+	u32 has_ir;     /* 0: no IR, 1: IR present, 2: unknown */
 
 	u32 tuner_type;
 	u32 tuner_formats;
 
+	u32 tuner2_type;
+	u32 tuner2_formats;
+
 	u32 digitizer;
 	u32 digitizer_formats;
 
 	u32 audio_processor;
-	/* a_p_fmts? */
+	u32 decoder_processor;
 
 	u32 model;
 	u32 revision;
@@ -19,7 +23,7 @@
 	char rev_str[5];
 };
 
-void tveeprom_hauppauge_analog(struct tveeprom *tvee,
+void tveeprom_hauppauge_analog(struct i2c_client *c, struct tveeprom *tvee,
 			       unsigned char *eeprom_data);
 
 int tveeprom_read(struct i2c_client *c, unsigned char *eedata, int len);

--=_431cb7f8.SmbXs/qGlBGYUNs6E8YGPZEqNajvGv7i3pAyE/ZknW4BzQi1--
