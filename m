Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbTIYFM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 01:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTIYFM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 01:12:58 -0400
Received: from adsl-68-73-156-198.dsl.ipltin.ameritech.net ([68.73.156.198]:46244
	"EHLO coreip.homeip.net") by vger.kernel.org with ESMTP
	id S261696AbTIYFM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 01:12:56 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Dan <overridex@punkass.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6: joydev is too eager claiming input devices
Date: Thu, 25 Sep 2003 00:12:46 -0500
User-Agent: KMail/1.5.3
References: <1064459037.19555.3.camel@nazgul.overridex.net>
In-Reply-To: <1064459037.19555.3.camel@nazgul.overridex.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309250012.48522.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 September 2003 10:03 pm, Dan wrote:
> This patch seems to have broken my Logitech Wingman Action usb gamepad,
> it shows as connected but isn't claimed by joydev... another joystick I
> have (saitek cyborg usb gold) works fine, and the logitech worked in
> previous 2.5/6.x kernels so I'm guessing this patch is to blame, I'm on
> 2.6.0-test5-mm1, is there any info from the joystick I can provide you
> with to fix it?  I'm not sure where to look, thanks -Dan
>

Could you please try the following patch (it is incremental against the 
previous one and should apply to the -mm)

--- 2.6.0-test4/drivers/input/joydev.c	2003-09-25 00:06:52.000000000 -0500
+++ linux-2.6.0-test4/drivers/input/joydev.c	2003-09-25 00:02:17.000000000 -0500
@@ -499,7 +499,28 @@
 		.evbit = { BIT(EV_ABS) },
 		.absbit = { BIT(ABS_RX), BIT(ABS_RY) },
 	}, /* magellan and some others report only MISC buttons but we can identify 
-	      them by using special axis auch as RX/RY, ABS_WHEEL or ABS_THROTTLE */
+	      them by using special axis auch as RX/RY, HATnX/HATnY, ABS_WHEEL or 
+	      ABS_THROTTLE */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.evbit = { BIT(EV_ABS) },
+		.absbit = { BIT(ABS_HAT0X), BIT(ABS_HAT0Y) },
+	},
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.evbit = { BIT(EV_ABS) },
+		.absbit = { BIT(ABS_HAT1X), BIT(ABS_HAT1Y) },
+	},
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.evbit = { BIT(EV_ABS) },
+		.absbit = { BIT(ABS_HAT2X), BIT(ABS_HAT2Y) },
+	},
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.evbit = { BIT(EV_ABS) },
+		.absbit = { BIT(ABS_HAT3X), BIT(ABS_HAT3Y) },
+	},
 	{
 		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
 		.evbit = { BIT(EV_ABS) },
