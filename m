Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVCaXpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVCaXpp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVCaXjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:39:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:35040 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262107AbVCaXYK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:10 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Fix adm1021 alarms mask
In-Reply-To: <11123113902974@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:10 -0800
Message-Id: <1112311390426@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2326, 2005/03/31 14:06:28-08:00, khali@linux-fr.org

[PATCH] I2C: Fix adm1021 alarms mask

This patch fixes an incorrect bitmasking on the status register in the
adm1021 driver, which was causing high alarm on remote temperature to be
hidden.
This bug was found and reported by Jayakrishnan:
  http://bugzilla.kernel.org/show_bug.cgi?id=4285


Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/adm1021.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	2005-03-31 15:18:52 -08:00
+++ b/drivers/i2c/chips/adm1021.c	2005-03-31 15:18:52 -08:00
@@ -368,7 +368,7 @@
 		data->remote_temp_input = adm1021_read_value(client, ADM1021_REG_REMOTE_TEMP);
 		data->remote_temp_max = adm1021_read_value(client, ADM1021_REG_REMOTE_TOS_R);
 		data->remote_temp_hyst = adm1021_read_value(client, ADM1021_REG_REMOTE_THYST_R);
-		data->alarms = adm1021_read_value(client, ADM1021_REG_STATUS) & 0xec;
+		data->alarms = adm1021_read_value(client, ADM1021_REG_STATUS) & 0x7c;
 		if (data->type == adm1021)
 			data->die_code = adm1021_read_value(client, ADM1021_REG_DIE_CODE);
 		if (data->type == adm1023) {

