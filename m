Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVCaXpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVCaXpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVCaXk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:40:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:37856 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262110AbVCaXYK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:10 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Make master_xfer debug messages more useful
In-Reply-To: <1112311390987@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:10 -0800
Message-Id: <1112311390208@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2328, 2005/03/31 14:07:05-08:00, khali@linux-fr.org

[PATCH] I2C: Make master_xfer debug messages more useful

While working on the recent saa7110 mess, I found that the debug message
displayed when calling master_xfer wasn't as useful as it could be. Here
is a patch improving this.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/i2c-core.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2005-03-31 15:18:36 -08:00
+++ b/drivers/i2c/i2c-core.c	2005-03-31 15:18:36 -08:00
@@ -587,7 +587,13 @@
 	int ret;
 
 	if (adap->algo->master_xfer) {
- 	 	dev_dbg(&adap->dev, "master_xfer: with %d msgs.\n", num);
+#ifdef DEBUG
+		for (ret = 0; ret < num; ret++) {
+			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, "
+				"len=%d\n", ret, msgs[ret].flags & I2C_M_RD ?
+				'R' : 'W', msgs[ret].addr, msgs[ret].len);
+		}
+#endif
 
 		down(&adap->bus_lock);
 		ret = adap->algo->master_xfer(adap,msgs,num);

