Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268314AbUIQGG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268314AbUIQGG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 02:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268335AbUIQGG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 02:06:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:63144 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268314AbUIQGGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 02:06:52 -0400
Subject: [PATCH] pmac: don't add =?ISO-8859-1?Q?=22=B0C=22?= suffix in sys
	for adt746x driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>, Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-PSWIef/hT9OJPX0ZLg+i"
Message-Id: <1095401127.5105.73.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 17 Sep 2004 16:05:28 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PSWIef/hT9OJPX0ZLg+i
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

The adt746x driver currently adds a "°C" suffix to temperatures exposed
via sysfs, and I don't like that. First, we all agree that any other unit
here makes no sense (do we ? do we ? yes of course :) and I don't like
having anything but numbers in there, and finally it's more consistent
with what the g5 driver does.

And finally, the _REAL_ reason is that this is not a low ASCII character
and so has nothing to do in the kernel sources or in /sys :)

Unfortunately, generating a patch here is nasty because of that (my mailer
is rightfully complaining about the non-ASCII char on text import) so you
might have to apply by hand...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

(attached, evolution will really not let me paste that bit in)



--=-PSWIef/hT9OJPX0ZLg+i
Content-Disposition: attachment; filename=adt.diff
Content-Type: text/x-patch; name=adt.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

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

--=-PSWIef/hT9OJPX0ZLg+i--

