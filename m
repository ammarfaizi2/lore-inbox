Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUFVRvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUFVRvx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265096AbUFVRvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:51:35 -0400
Received: from mail.kroah.org ([65.200.24.183]:54965 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265092AbUFVRnq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:46 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261132464@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:53 -0700
Message-Id: <10879261133956@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1826, 2004/06/22 09:25:34-07:00, khali@linux-fr.org

[PATCH] I2C: Drop out-of-date code in w83781d and w83627hf

Here is a simple patch which drops some out-of-date code in the w83781d
and w83627hf i2c chip drivers. These bits are left over from the times
when chip drivers were setting default limits at init.


Signed-off-by: Jean Delvare <khali at linux-fr dot org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/w83627hf.c |    5 +----
 drivers/i2c/chips/w83781d.c  |   11 ++---------
 2 files changed, 3 insertions(+), 13 deletions(-)


diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	Tue Jun 22 09:46:17 2004
+++ b/drivers/i2c/chips/w83627hf.c	Tue Jun 22 09:46:17 2004
@@ -1240,7 +1240,7 @@
 static void w83627hf_init_client(struct i2c_client *client)
 {
 	struct w83627hf_data *data = i2c_get_clientdata(client);
-	int vid = 0, i;
+	int i;
 	int type = data->type;
 	u8 tmp;
 
@@ -1283,9 +1283,6 @@
 		/* Convert VID to voltage based on default VRM */
 		data->vrm = DEFAULT_VRM;
 	}
-
-	if (type != w83697hf)
-		vid = vid_from_reg(vid, data->vrm);
 
 	tmp = w83627hf_read_value(client, W83781D_REG_SCFG1);
 	for (i = 1; i <= 3; i++) {
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Tue Jun 22 09:46:17 2004
+++ b/drivers/i2c/chips/w83781d.c	Tue Jun 22 09:46:17 2004
@@ -1491,7 +1491,7 @@
 w83781d_init_client(struct i2c_client *client)
 {
 	struct w83781d_data *data = i2c_get_clientdata(client);
-	int vid = 0, i, p;
+	int i, p;
 	int type = data->type;
 	u8 tmp;
 
@@ -1513,14 +1513,7 @@
 		w83781d_write_value(client, W83781D_REG_BEEP_INTS2, 0);
 	}
 
-	if (type != w83697hf) {
-		vid = w83781d_read_value(client, W83781D_REG_VID_FANDIV) & 0x0f;
-		vid |=
-		    (w83781d_read_value(client, W83781D_REG_CHIPID) & 0x01) <<
-		    4;
-		data->vrm = DEFAULT_VRM;
-		vid = vid_from_reg(vid, data->vrm);
-	}
+	data->vrm = 82;
 
 	if ((type != w83781d) && (type != as99127f)) {
 		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);

