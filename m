Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWGKUxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWGKUxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWGKUxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:53:11 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:26859 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1751302AbWGKUxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:53:10 -0400
Message-ID: <44B40FB4.8020900@bootc.net>
Date: Tue, 11 Jul 2006 21:53:08 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       ben-linux@fluff.org, rpurdie@rpsys.net,
       Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [PATCH] net48xx LED cleanups
References: <44B40F2C.1050309@bootc.net>
In-Reply-To: <44B40F2C.1050309@bootc.net>
Content-Type: multipart/mixed;
 boundary="------------000809090908010405070603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000809090908010405070603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chris Boot wrote:
> Add the DRVNAME define to remove the two separate references of the 
> driver name by string, and move the .driver.owner into the existing 
> .driver sub-structure (or whatever it's called).
> 
> Signed-off-by: Chris Boot <bootc@bootc.net>

Never trust Thunderbird. Attached.

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/

--------------000809090908010405070603
Content-Type: text/x-patch;
 name="net48xx-led-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net48xx-led-cleanup.patch"

diff --git a/drivers/leds/leds-net48xx.c b/drivers/leds/leds-net48xx.c
index 35ee52f..713c4a8 100644
--- a/drivers/leds/leds-net48xx.c
+++ b/drivers/leds/leds-net48xx.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <linux/scx200_gpio.h>
 
+#define DRVNAME "net48xx-led"
 #define NET48XX_ERROR_LED_GPIO	20
 
 static struct platform_device *pdev;
@@ -66,13 +67,13 @@ static int net48xx_led_remove(struct pla
 }
 
 static struct platform_driver net48xx_led_driver = {
-	.driver.owner	= THIS_MODULE,
 	.probe		= net48xx_led_probe,
 	.remove		= net48xx_led_remove,
 	.suspend	= net48xx_led_suspend,
 	.resume		= net48xx_led_resume,
 	.driver		= {
-		.name = "net48xx-led",
+		.name		= DRVNAME,
+		.owner		= THIS_MODULE,
 	},
 };
 
@@ -89,7 +90,7 @@ static int __init net48xx_led_init(void)
 	if (ret < 0)
 		goto out;
 
-	pdev = platform_device_register_simple("net48xx-led", -1, NULL, 0);
+	pdev = platform_device_register_simple(DRVNAME, -1, NULL, 0);
 	if (IS_ERR(pdev)) {
 		ret = PTR_ERR(pdev);
 		platform_driver_unregister(&net48xx_led_driver);

--------------000809090908010405070603--
