Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbVKVVLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbVKVVLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbVKVVKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:10:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965208AbVKVVKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:10:17 -0500
Date: Tue, 22 Nov 2005 13:08:55 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, Greg KH <greg@kroah.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jean Delvare <khali@linux-fr.org>
Subject: [patch 22/23] hwmon: Fix lm78 VID conversion
Message-ID: <20051122210855.GW28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="hwmon-lm78-fix-vid.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fix the lm78 VID reading, which I accidentally broke while making
this driver use the common vid_from_reg function rather than
reimplementing its own in 2.6.14-rc1.

I'm not proud of it, trust me.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/hwmon/lm78.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.2.orig/drivers/hwmon/lm78.c
+++ linux-2.6.14.2/drivers/hwmon/lm78.c
@@ -451,7 +451,7 @@ static DEVICE_ATTR(fan3_div, S_IRUGO, sh
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(82, data->vid));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, 82));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 

--
