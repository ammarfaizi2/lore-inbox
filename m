Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVFVHEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVFVHEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVFVHAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:00:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:7068 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262780AbVFVFVz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:55 -0400
Cc: grant_lkml@dodo.com.au
Subject: [PATCH] I2C: adm9240 driver cleanup
In-Reply-To: <11194174641227@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:44 -0700
Message-Id: <11194174641411@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: adm9240 driver cleanup

This patch adds an info print of detected VRM stolen from Sebastian
Witt's atxp1 sriver.  ADM9240 already has vrm accessor removed.

Write no-op and whitespace fixes removed :)

Couple of comments changed, tested on 2.6.11.9.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8e8f9289cc5b781d583d5aed935abf060207bbd3
tree d058803efab6b2f359ca750ec50e73681da3ce8d
parent 937df8df907ce63b0f7e19adf6e3cdef1687fac3
author Grant Coady <grant_lkml@dodo.com.au> Fri, 13 May 2005 20:26:10 +1000
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:57 -0700

 drivers/i2c/chips/adm9240.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/chips/adm9240.c b/drivers/i2c/chips/adm9240.c
--- a/drivers/i2c/chips/adm9240.c
+++ b/drivers/i2c/chips/adm9240.c
@@ -165,7 +165,7 @@ struct adm9240_data {
 	s8 temp_high;		/* rw	temp1_max */
 	s8 temp_hyst;		/* rw	temp1_max_hyst */
 	u16 alarms;		/* ro	alarms */
-	u8 aout;		/* rw	analog_out */
+	u8 aout;		/* rw	aout_output */
 	u8 vid;			/* ro	vid */
 	u8 vrm;			/* --	vrm set on startup, no accessor */
 };
@@ -192,7 +192,7 @@ static ssize_t show_##value(struct devic
 }
 show_temp(temp_high, 1000);
 show_temp(temp_hyst, 1000);
-show_temp(temp, 500);
+show_temp(temp, 500); /* 0.5'C per bit */
 
 #define set_temp(value, reg)					\
 static ssize_t set_##value(struct device *dev, const char *buf,	\
@@ -630,6 +630,9 @@ static void adm9240_init_client(struct i
 
 	data->vrm = i2c_which_vrm(); /* need this to report vid as mV */
 
+	dev_info(&client->dev, "Using VRM: %d.%d\n", data->vrm / 10,
+			data->vrm % 10);
+
 	if (conf & 1) { /* measurement cycle running: report state */
 
 		dev_info(&client->dev, "status: config 0x%02x mode %u\n",

