Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUIUGgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUIUGgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 02:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUIUGgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 02:36:17 -0400
Received: from [195.167.234.212] ([195.167.234.212]:32666 "EHLO atchik.com")
	by vger.kernel.org with ESMTP id S267352AbUIUGgO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 02:36:14 -0400
Date: Tue, 21 Sep 2004 08:33:18 +0200
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pmac: don't add =?ISO-8859-15?B?IrBDIg==?= suffix in
 sys	for adt746x driver
Message-ID: <20040921083318.1bdddd72@pirandello>
In-Reply-To: <1095401127.5105.73.camel@gaston>
References: <1095401127.5105.73.camel@gaston>
X-Mailer: Sylpheed-Claws 0.9.12cvs102.2 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Atchik-MailScanner-Information: Please contact the ISP for more information
X-Atchik-MailScanner: Found to be clean
X-MailScanner-From: colin@colino.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Sep 2004 at 16h09, Benjamin Herrenschmidt wrote:

Hi, 

> The adt746x driver currently adds a "°C" suffix to temperatures
> exposed via sysfs, and I don't like that. First, we all agree that any
> other unit here makes no sense (do we ? do we ? yes of course :) and I
> don't like having anything but numbers in there, and finally it's more
> consistent with what the g5 driver does.
> 
> And finally, the _REAL_ reason is that this is not a low ASCII
> character and so has nothing to do in the kernel sources or in /sys :)

Fine with me!  (Patch may be broken too...)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Colin Leroy <colin@colino.net>
===== drivers/macintosh/therm_adt746x.c 1.4 vs edited =====
--- 1.4/drivers/macintosh/therm_adt746x.c	2004-05-29 17:26:34 +10:00
+++ edited/drivers/macintosh/therm_adt746x.c	2004-09-17 15:59:59 +10:00
@@ -417,11 +417,6 @@
  * choice but implement a bunch of them...
  *
  */
-#define BUILD_SHOW_FUNC_DEG(name, data)				\
-static ssize_t show_##name(struct device *dev, char *buf)	\
-{								\
-	return sprintf(buf, "%d°C\n", data);			\
-}
 #define BUILD_SHOW_FUNC_INT(name, data)				\
 static ssize_t show_##name(struct device *dev, char *buf)	\
 {								\
@@ -453,10 +448,10 @@
 	return n;						\
 }
 
-BUILD_SHOW_FUNC_DEG(cpu_temperature,	 (read_reg(thermostat, TEMP_REG[1])))
-BUILD_SHOW_FUNC_DEG(gpu_temperature,	 (read_reg(thermostat, TEMP_REG[2])))
-BUILD_SHOW_FUNC_DEG(cpu_limit,		 thermostat->limits[1])
-BUILD_SHOW_FUNC_DEG(gpu_limit,		 thermostat->limits[2])
+BUILD_SHOW_FUNC_INT(cpu_temperature,	 (read_reg(thermostat, TEMP_REG[1])))
+BUILD_SHOW_FUNC_INT(gpu_temperature,	 (read_reg(thermostat, TEMP_REG[2])))
+BUILD_SHOW_FUNC_INT(cpu_limit,		 thermostat->limits[1])
+BUILD_SHOW_FUNC_INT(gpu_limit,		 thermostat->limits[2])
 
 BUILD_SHOW_FUNC_INT(specified_fan_speed, fan_speed)
 BUILD_SHOW_FUNC_INT(cpu_fan_speed,	 (read_fan_speed(thermostat, FAN_SPEED[0])))
-- 
Colin
