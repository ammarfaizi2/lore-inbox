Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUHWT0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUHWT0b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUHWTYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:24:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:62915 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267180AbUHWSgm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:42 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860831280@kroah.com>
Date: Mon, 23 Aug 2004 11:34:44 -0700
Message-Id: <10932860841820@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.54.5, 2004/08/02 16:10:06-07:00, khali@linux-fr.org

[PATCH] I2C: Fix debug in w83781d driver

The trivial patch below fixes two debug prints in the w83781d driver
(one needless dereference and one debug print without device info).

Signed-off-by: Jean Delvare <khali at linux-fr dot org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/w83781d.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2004-08-23 11:07:20 -07:00
+++ b/drivers/i2c/chips/w83781d.c	2004-08-23 11:07:20 -07:00
@@ -815,8 +815,7 @@
 		data->sens[nr - 1] = val;
 		break;
 	default:
-		dev_err(&client->dev,
-		       "Invalid sensor type %ld; must be 1, 2, or %d\n",
+		dev_err(dev, "Invalid sensor type %ld; must be 1, 2, or %d\n",
 		       (long) val, W83781D_DEFAULT_BETA);
 		break;
 	}
@@ -1593,7 +1592,7 @@
 	if (time_after
 	    (jiffies - data->last_updated, (unsigned long) (HZ + HZ / 2))
 	    || time_before(jiffies, data->last_updated) || !data->valid) {
-		pr_debug("Starting device update\n");
+		dev_dbg(dev, "Starting device update\n");
 
 		for (i = 0; i <= 8; i++) {
 			if ((data->type == w83783s || data->type == w83697hf)

