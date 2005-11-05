Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVKESOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVKESOU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVKESOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:14:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36625 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932139AbVKESOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:14:17 -0500
Date: Sat, 5 Nov 2005 18:14:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert arch/xtensa/
Message-ID: <20051105181412.GD14419@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105181122.GD12228@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105181122.GD12228@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform drivers to use struct platform_driver

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

--- a/arch/xtensa/platform-iss/network.c
+++ b/arch/xtensa/platform-iss/network.c
@@ -648,9 +648,10 @@ void iss_net_user_timer_expire(unsigned 
 }
 
 
-static struct device_driver iss_net_driver = {
-	.name  = DRIVER_NAME,
-	.bus   = &platform_bus_type,
+static struct platform_driver iss_net_driver = {
+	.driver = {
+		.name  = DRIVER_NAME,
+	},
 };
 
 static int driver_registered;
@@ -701,7 +702,7 @@ static int iss_net_configure(int index, 
 	/* sysfs register */
 
 	if (!driver_registered) {
-		driver_register(&iss_net_driver);
+		platform_driver_register(&iss_net_driver);
 		driver_registered = 1;
 	}
 


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
