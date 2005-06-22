Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbVFVG5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVFVG5L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVFVGqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:46:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:19612 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262783AbVFVFWA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:00 -0400
Cc: grant_lkml@dodo.com.au
Subject: [PATCH] I2C: driver adm1021: remove die_code
In-Reply-To: <11194174653972@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:45 -0700
Message-Id: <1119417465463@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: driver adm1021: remove die_code

This patch removes die_code from adm1021 as nothing within the
driver uses it.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6afe15595031bb9801af6207feed0bafc25b6e6b
tree 144126d9d5e1808e91e46007e5b990bf9b1f1bbc
parent be8992c249e42398ee905450688c135ab761674c
author Grant Coady <grant_lkml@dodo.com.au> Tue, 17 May 2005 17:16:02 +1000
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:58 -0700

 drivers/i2c/chips/adm1021.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c
+++ b/drivers/i2c/chips/adm1021.c
@@ -102,8 +102,6 @@ struct adm1021_data {
 	u8	remote_temp_hyst;
 	u8	remote_temp_input;
 	u8	alarms;
-	/* special values for ADM1021 only */
-	u8	die_code;
         /* Special values for ADM1023 only */
 	u8	remote_temp_prec;
 	u8	remote_temp_os_prec;
@@ -155,7 +153,6 @@ static ssize_t show_##value(struct devic
 	return sprintf(buf, "%d\n", data->value);			\
 }
 show2(alarms);
-show2(die_code);
 
 #define set(value, reg)	\
 static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
@@ -182,7 +179,6 @@ static DEVICE_ATTR(temp2_max, S_IWUSR | 
 static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_remote_temp_hyst, set_remote_temp_hyst);
 static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote_temp_input, NULL);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
-static DEVICE_ATTR(die_code, S_IRUGO, show_die_code, NULL);
 
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
@@ -306,8 +302,6 @@ static int adm1021_detect(struct i2c_ada
 	device_create_file(&new_client->dev, &dev_attr_temp2_min);
 	device_create_file(&new_client->dev, &dev_attr_temp2_input);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
-	if (data->type == adm1021)
-		device_create_file(&new_client->dev, &dev_attr_die_code);
 
 	return 0;
 
@@ -370,8 +364,6 @@ static struct adm1021_data *adm1021_upda
 		data->remote_temp_max = adm1021_read_value(client, ADM1021_REG_REMOTE_TOS_R);
 		data->remote_temp_hyst = adm1021_read_value(client, ADM1021_REG_REMOTE_THYST_R);
 		data->alarms = adm1021_read_value(client, ADM1021_REG_STATUS) & 0x7c;
-		if (data->type == adm1021)
-			data->die_code = adm1021_read_value(client, ADM1021_REG_DIE_CODE);
 		if (data->type == adm1023) {
 			data->remote_temp_prec = adm1021_read_value(client, ADM1021_REG_REM_TEMP_PREC);
 			data->remote_temp_os_prec = adm1021_read_value(client, ADM1021_REG_REM_TOS_PREC);

