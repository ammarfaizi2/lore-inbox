Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbTIVXtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTIVXrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:47:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:10913 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262637AbTIVXaz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:30:55 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734181829@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734181751@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:18 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1153.123.2, 2003/09/04 11:28:46-07:00, azarah@gentoo.org

[PATCH] I2C: Fix conversion from milli volts in store_in_reg() for w83781d.c

I am not sure if it was a later patch from me that fixed in_* to display
milli volts in sysfs, or if it was a patch from Jan Dittmer, but the
conversion in the store_in_*() functions is wrong, and cause something
like:


 drivers/i2c/chips/w83781d.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Sep 22 16:16:19 2003
+++ b/drivers/i2c/chips/w83781d.c	Mon Sep 22 16:16:19 2003
@@ -378,8 +378,8 @@
 	struct w83781d_data *data = i2c_get_clientdata(client); \
 	u32 val; \
 	 \
-	val = simple_strtoul(buf, NULL, 10); \
-	data->in_##reg[nr] = (IN_TO_REG(val) / 10); \
+	val = simple_strtoul(buf, NULL, 10) / 10; \
+	data->in_##reg[nr] = IN_TO_REG(val); \
 	w83781d_write_value(client, W83781D_REG_IN_##REG(nr), data->in_##reg[nr]); \
 	 \
 	return count; \

