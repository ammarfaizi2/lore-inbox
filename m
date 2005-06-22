Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVFVHJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVFVHJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVFVHHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:07:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:2204 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262778AbVFVFVy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:54 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Kill another macro abuse in via686a
In-Reply-To: <11194174651514@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:45 -0700
Message-Id: <11194174652790@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Kill another macro abuse in via686a

This patch kills another macro abuse in the via686a hardware monitoring
driver. Using a macro just to alias an array is quite useless, isn't it?

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 563db2fe9e0843da9d1d85d824f022be0ada4a3c
tree 2e5cec5b9e1d0cf34e2c03c65bc53d9784b287da
parent 057923f0f5ba346fc128ae0a1c3842d8c12bd7f0
author Jean Delvare <khali@linux-fr.org> Tue, 17 May 2005 22:38:57 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:59 -0700

 drivers/i2c/chips/via686a.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c
+++ b/drivers/i2c/chips/via686a.c
@@ -78,15 +78,10 @@ SENSORS_INSMOD_1(via686a);
 #define VIA686A_REG_FAN_MIN(nr)	(0x3a + (nr))
 #define VIA686A_REG_FAN(nr)	(0x28 + (nr))
 
-/* the following values are as speced by VIA: */
-static const u8 regtemp[] = { 0x20, 0x21, 0x1f };
-static const u8 regover[] = { 0x39, 0x3d, 0x1d };
-static const u8 reghyst[] = { 0x3a, 0x3e, 0x1e };
-
 /* temps numbered 1-3 */
-#define VIA686A_REG_TEMP(nr)		(regtemp[nr])
-#define VIA686A_REG_TEMP_OVER(nr)	(regover[nr])
-#define VIA686A_REG_TEMP_HYST(nr)	(reghyst[nr])
+static const u8 VIA686A_REG_TEMP[]	= { 0x20, 0x21, 0x1f };
+static const u8 VIA686A_REG_TEMP_OVER[]	= { 0x39, 0x3d, 0x1d };
+static const u8 VIA686A_REG_TEMP_HYST[]	= { 0x3a, 0x3e, 0x1e };
 /* bits 7-6 */
 #define VIA686A_REG_TEMP_LOW1	0x4b
 /* 2 = bits 5-4, 3 = bits 7-6 */
@@ -441,7 +436,8 @@ static ssize_t set_temp_over(struct devi
 
 	down(&data->update_lock);
 	data->temp_over[nr] = TEMP_TO_REG(val);
-	via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr), data->temp_over[nr]);
+	via686a_write_value(client, VIA686A_REG_TEMP_OVER[nr],
+			    data->temp_over[nr]);
 	up(&data->update_lock);
 	return count;
 }
@@ -453,7 +449,8 @@ static ssize_t set_temp_hyst(struct devi
 
 	down(&data->update_lock);
 	data->temp_hyst[nr] = TEMP_TO_REG(val);
-	via686a_write_value(client, VIA686A_REG_TEMP_HYST(nr), data->temp_hyst[nr]);
+	via686a_write_value(client, VIA686A_REG_TEMP_HYST[nr],
+			    data->temp_hyst[nr]);
 	up(&data->update_lock);
 	return count;
 }
@@ -763,13 +760,13 @@ static struct via686a_data *via686a_upda
 		}
 		for (i = 0; i <= 2; i++) {
 			data->temp[i] = via686a_read_value(client,
-						 VIA686A_REG_TEMP(i)) << 2;
+						 VIA686A_REG_TEMP[i]) << 2;
 			data->temp_over[i] =
 			    via686a_read_value(client,
-					       VIA686A_REG_TEMP_OVER(i));
+					       VIA686A_REG_TEMP_OVER[i]);
 			data->temp_hyst[i] =
 			    via686a_read_value(client,
-					       VIA686A_REG_TEMP_HYST(i));
+					       VIA686A_REG_TEMP_HYST[i]);
 		}
 		/* add in lower 2 bits
 		   temp1 uses bits 7-6 of VIA686A_REG_TEMP_LOW1

