Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUDNWd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUDNWch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:32:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:29855 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261931AbUDNWYj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:24:39 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <1081981453446@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:13 -0700
Message-Id: <10819814533933@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.27, 2004/04/12 15:17:01-07:00, mhoffman@lightlink.com

[PATCH] I2C: fix asb100 bug

Hi nymisi, Greg:

* Nyeste Mihály <nymisi@freemail.hu> [2004-01-27 16:02:04 +0100]:
> Hi!
>
> I reported a bug of asb100 chip at:
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=1539
>
> The reply was the follow:
>
> "Is there a BIOS option you can disable, e.g. Asus "COP",
> "QFAN", or some such?  My guess is that the BIOS is
> somehow interfering with the asb100 driver.  Otherwise
> I don´t know how this could happen.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Yeah, I wrote that.

"You do that, you go to the box, you know.  Two minutes by
yourself, and you feel shame, you know." - Denis the goalie

Greg, please apply this fix (vs. 2.6.5):


 drivers/i2c/chips/asb100.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Wed Apr 14 15:12:31 2004
+++ b/drivers/i2c/chips/asb100.c	Wed Apr 14 15:12:31 2004
@@ -468,7 +468,7 @@
 		data->reg[nr] = TEMP_TO_REG(val); \
 		break; \
 	} \
-	asb100_write_value(client, ASB100_REG_TEMP_##REG(nr), \
+	asb100_write_value(client, ASB100_REG_TEMP_##REG(nr+1), \
 			data->reg[nr]); \
 	return count; \
 }

