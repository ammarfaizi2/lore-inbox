Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbVKWXsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVKWXsB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVKWXrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:47:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:30146 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751331AbVKWXqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:33 -0500
Date: Wed, 23 Nov 2005 15:44:26 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       khali@linux-fr.org
Subject: [patch 06/22] hwmon: Fix lm78 VID conversion
Message-ID: <20051123234426.GG527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="hwmon-lm78-fix-vid.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

Fix the lm78 VID reading, which I accidentally broke while making
this driver use the common vid_from_reg function rather than
reimplementing its own in 2.6.14-rc1.

I'm not proud of it, trust me.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/hwmon/lm78.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- usb-2.6.orig/drivers/hwmon/lm78.c
+++ usb-2.6/drivers/hwmon/lm78.c
@@ -451,7 +451,7 @@ static DEVICE_ATTR(fan3_div, S_IRUGO, sh
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(82, data->vid));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, 82));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 

--
