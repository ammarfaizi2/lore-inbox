Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbTCYBcM>; Mon, 24 Mar 2003 20:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbTCYBaP>; Mon, 24 Mar 2003 20:30:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:24336 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261339AbTCYB2H>;
	Mon, 24 Mar 2003 20:28:07 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.66
In-reply-to: <10485563231250@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Mar 2003 17:38 -0800
Message-id: <10485563243428@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.985.1.2, 2003/03/23 00:06:48-08:00, greg@kroah.com

i2c: fix up drivers/video/matrox/i2c-matroxfb.c due to previous i2c changes


 drivers/video/matrox/i2c-matroxfb.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)


diff -Nru a/drivers/video/matrox/i2c-matroxfb.c b/drivers/video/matrox/i2c-matroxfb.c
--- a/drivers/video/matrox/i2c-matroxfb.c	Mon Mar 24 17:27:08 2003
+++ b/drivers/video/matrox/i2c-matroxfb.c	Mon Mar 24 17:27:08 2003
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

