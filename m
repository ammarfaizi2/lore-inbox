Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTDIWTS (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263912AbTDIWSB (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:18:01 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:35230 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263880AbTDIWRl convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:17:41 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10499274993464@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.67
In-Reply-To: <10499274991641@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Apr 2003 15:31:39 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1133.1.3, 2003/04/08 02:49:21-07:00, azarah@gentoo.org

[PATCH] i2c: Fix w83781d sensor to use Milli-Volt for in_* in sysfs

I did the w83781d sysfs update as per the old spec, which was not
milli-volt.  This patch should fix it.


 drivers/i2c/chips/w83781d.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Apr  9 15:16:04 2003
+++ b/drivers/i2c/chips/w83781d.c	Wed Apr  9 15:16:04 2003
@@ -364,7 +364,7 @@
 	 \
 	w83781d_update_client(client); \
 	 \
-	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
+	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] * 10)); \
 }
 show_in_reg(in);
 show_in_reg(in_min);
@@ -378,7 +378,7 @@
 	u32 val; \
 	 \
 	val = simple_strtoul(buf, NULL, 10); \
-	data->in_##reg[nr] = IN_TO_REG(val); \
+	data->in_##reg[nr] = (IN_TO_REG(val) / 10); \
 	w83781d_write_value(client, W83781D_REG_IN_##REG(nr), data->in_##reg[nr]); \
 	 \
 	return count; \

