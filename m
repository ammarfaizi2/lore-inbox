Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262963AbTCWIFZ>; Sun, 23 Mar 2003 03:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262958AbTCWIFZ>; Sun, 23 Mar 2003 03:05:25 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62475 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262962AbTCWIEW>;
	Sun, 23 Mar 2003 03:04:22 -0500
Date: Sun, 23 Mar 2003 00:15:15 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH] Yet more i2c driver changes for 2.5.65
Message-ID: <20030323081515.GI26145@kroah.com>
References: <20030323080719.GD26145@kroah.com> <20030323081431.GF26145@kroah.com> <20030323081445.GG26145@kroah.com> <20030323081456.GH26145@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323081456.GH26145@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.987, 2003/03/23 00:06:48-08:00, greg@kroah.com

i2c: fix up drivers/video/matrox/i2c-matroxfb.c due to previous i2c changes


diff -Nru a/drivers/video/matrox/i2c-matroxfb.c b/drivers/video/matrox/i2c-matroxfb.c
--- a/drivers/video/matrox/i2c-matroxfb.c	Sun Mar 23 00:10:43 2003
+++ b/drivers/video/matrox/i2c-matroxfb.c	Sun Mar 23 00:10:43 2003
@@ -111,7 +111,8 @@
 	b->mask.data = data;
 	b->mask.clock = clock;
 	b->adapter = matrox_i2c_adapter_template;
-	sprintf(b->adapter.name, name, minor(minfo->fbcon.node));
+	snprintf(b->adapter.dev.name, DEVICE_NAME_SIZE, name,
+		minor(minfo->fbcon.node));
 	b->adapter.data = b;
 	b->adapter.algo_data = &b->bac;
 	b->bac = matrox_i2c_algo_template;
@@ -159,22 +160,22 @@
 	switch (ACCESS_FBINFO(chip)) {
 		case MGA_2064:
 		case MGA_2164:
-			err = i2c_bus_reg(&m2info->ddc1, minfo, DDC1B_DATA, DDC1B_CLK, "DDC:fb%u #0 on i2c-matroxfb");
+			err = i2c_bus_reg(&m2info->ddc1, minfo, DDC1B_DATA, DDC1B_CLK, "DDC:fb%u #0");
 			break;
 		default:
-			err = i2c_bus_reg(&m2info->ddc1, minfo, DDC1_DATA, DDC1_CLK, "DDC:fb%u #0 on i2c-matroxfb");
+			err = i2c_bus_reg(&m2info->ddc1, minfo, DDC1_DATA, DDC1_CLK, "DDC:fb%u #0");
 			break;
 	}
 	if (err)
 		goto fail_ddc1;
 	if (ACCESS_FBINFO(devflags.dualhead)) {
-		err = i2c_bus_reg(&m2info->ddc2, minfo, DDC2_DATA, DDC2_CLK, "DDC:fb%u #1 on i2c-matroxfb");
+		err = i2c_bus_reg(&m2info->ddc2, minfo, DDC2_DATA, DDC2_CLK, "DDC:fb%u #1");
 		if (err == -ENODEV) {
 			printk(KERN_INFO "i2c-matroxfb: VGA->TV plug detected, DDC unavailable.\n");
 		} else if (err)
 			printk(KERN_INFO "i2c-matroxfb: Could not register secondary output i2c bus. Continuing anyway.\n");
 		/* Register maven bus even on G450/G550 */
-		err = i2c_bus_reg(&m2info->maven, minfo, MAT_DATA, MAT_CLK, "MAVEN:fb%u on i2c-matroxfb");
+		err = i2c_bus_reg(&m2info->maven, minfo, MAT_DATA, MAT_CLK, "MAVEN:fb%u");
 		if (err)
 			printk(KERN_INFO "i2c-matroxfb: Could not register Maven i2c bus. Continuing anyway.\n");
 	}
