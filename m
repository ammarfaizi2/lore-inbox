Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVCaX2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVCaX2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVCaX0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:26:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:23008 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262058AbVCaXYD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:03 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Fix race condition in it87 driver
In-Reply-To: <11123113941998@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:15 -0800
Message-Id: <11123113953775@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2345, 2005/03/31 14:31:21-08:00, khali@linux-fr.org

[PATCH] I2C: Fix race condition in it87 driver

I noticed a race condition in the it87, affecting the IT8712F chip only.
The VRM value is currently initialized *after* creating the vrm and vid
sysfs files. This leaves a theorical room for reading from these files
and get an invalid value. It's not critical, but let's still fix it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/it87.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2005-03-31 15:16:31 -08:00
+++ b/drivers/i2c/chips/it87.c	2005-03-31 15:16:31 -08:00
@@ -889,9 +889,9 @@
 	}
 
 	if (data->type == it8712) {
+		data->vrm = i2c_which_vrm();
 		device_create_file_vrm(new_client);
 		device_create_file_vid(new_client);
-		data->vrm = i2c_which_vrm();
 	}
 
 	return 0;

