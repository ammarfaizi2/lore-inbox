Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263929AbTJOS1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbTJOS1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:27:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:54193 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263931AbTJOS0N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:26:13 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10662411472283@kroah.com>
Subject: Re: [PATCH] More i2c driver fixes for 2.6.0-test7
In-Reply-To: <10662411473410@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 15 Oct 2003 11:05:47 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1347.1.2, 2003/10/13 12:31:27-07:00, kronos@kronoz.cjb.net

[PATCH] I2C: sensors/w83781d.c creates useless sysfs entries

Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz> ha scritto:
> here is a trivial fix for Winbond sensor driver, which currently creates
> useless entries in sys/bus/i2c due to missing braces after if statements
> - author probably forgot about the macro expansion.

IMHO it's better to fix the macro:


 drivers/i2c/chips/w83781d.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Oct 15 10:57:59 2003
+++ b/drivers/i2c/chips/w83781d.c	Wed Oct 15 10:57:59 2003
@@ -422,9 +422,11 @@
 sysfs_in_offsets(8);
 
 #define device_create_file_in(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_in_input##offset); \
 device_create_file(&client->dev, &dev_attr_in_min##offset); \
-device_create_file(&client->dev, &dev_attr_in_max##offset);
+device_create_file(&client->dev, &dev_attr_in_max##offset); \
+} while (0);
 
 #define show_fan_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \

