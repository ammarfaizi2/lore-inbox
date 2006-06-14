Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWFNXQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWFNXQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWFNXQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:16:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:37584 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965019AbWFNXQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:16:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=APmNt69VMzTOFSpOHyJtCxIdNA2fTrAhtE+kaEYilxQEISwc11410T2HQxXCprICbMQRXROpOnewt1PiWJ5CuSTV3YGWcAJWXiFSBVaj+z4sk6htfFG6Bnrd1N/ImAsiWlf461I+oOdFQ4QqyvYnprTfXJ+Y0hK3JSkYQvza1aU=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] I-Force joystick - remove some pointless casts
Date: Thu, 15 Jun 2006 01:16:58 +0200
User-Agent: KMail/1.9.3
Cc: akpm@osdl.org, vojtech@ucw.cz, deneux@ifrance.com, jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606150116.59425.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 'private' member of struct input_dev is a void*, so no need to cast it 
when assigning it to a struct iforce* variable.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/input/joystick/iforce/iforce-main.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.17-rc6-mm2-orig/drivers/input/joystick/iforce/iforce-main.c	2006-06-12 18:37:13.000000000 +0200
+++ linux-2.6.17-rc6-mm2/drivers/input/joystick/iforce/iforce-main.c	2006-06-15 00:53:17.000000000 +0200
@@ -84,7 +84,7 @@ static struct iforce_device iforce_devic
 
 static int iforce_playback(struct input_dev *dev, int effect_id, int value)
 {
-	struct iforce* iforce = (struct iforce*)(dev->private);
+	struct iforce* iforce = dev->private;
 	if (value > 0) {
 		set_bit(FF_CORE_SHOULD_PLAY, iforce->core_effects[effect_id].flags);
 	}
@@ -98,7 +98,7 @@ static int iforce_playback(struct input_
 
 static void iforce_set_gain(struct input_dev *dev, u16 gain)
 {
-	struct iforce* iforce = (struct iforce*)(dev->private);
+	struct iforce* iforce = dev->private;
 	unsigned char data[3];
 	data[0] = gain >> 9;
 	iforce_send_packet(iforce, FF_CMD_GAIN, data);
@@ -106,7 +106,7 @@ static void iforce_set_gain(struct input
 
 static void iforce_set_autocenter(struct input_dev *dev, u16 magnitude)
 {
-	struct iforce* iforce = (struct iforce*)(dev->private);
+	struct iforce* iforce = dev->private;
 	unsigned char data[3];
 	data[0] = 0x03;
 	data[1] = magnitude >> 9;
@@ -123,7 +123,7 @@ static void iforce_set_autocenter(struct
  */
 static int iforce_upload_effect(struct input_dev *dev, struct ff_effect *effect, struct ff_effect *old)
 {
-	struct iforce* iforce = (struct iforce*)(dev->private);
+	struct iforce* iforce = dev->private;
 	int ret;
 
 	if (!old) {
@@ -171,7 +171,7 @@ static int iforce_upload_effect(struct i
  */
 static int iforce_erase_effect(struct input_dev *dev, int effect_id)
 {
-	struct iforce* iforce = (struct iforce*)(dev->private);
+	struct iforce* iforce = dev->private;
 	int err = 0;
 	struct iforce_core_effect* core_effect;
 
