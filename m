Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVEJMIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVEJMIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 08:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVEJMIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 08:08:13 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:6830 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S261622AbVEJMIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 08:08:06 -0400
Date: Tue, 10 May 2005 14:08:04 +0200
To: Greg KH <greg@kroah.com>, Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: [PATCH] ds1337 driver works also with ds1339 chip
Message-ID: <20050510120804.GA2492@orphique>
References: <20050504061438.GD1439@orphique> <Ky47NT3d.1115201231.3150830.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ky47NT3d.1115201231.3150830.khali@localhost>
User-Agent: Mutt/1.5.9i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 12:07:11PM +0200, Jean Delvare wrote:
> > Chip is searched by bus number rather than its own proprietary id.
> 
> Yes, I think it makes much more sense (especially since the proprietary
> id was not known by anyone outside of the ds1337 driver).
> 
> I think I understand that ds1337_do_command() will be called from some
> other kernel driver. Why isn't it exported then? I'd expect:
> EXPORT_SYMBOL(ds1337_do_command);

RTC is hooked early in boot process. It should be available even sooner
than rootfs is mounted. Therefore RTC drivers are usualy compiled in
kernel. Anyway, exporting that function shouldn't hurt :)

> next to the end of the ds1337 driver. Maybe it would also make sense to
> have a ds1337.h header file declaring this function?

I'm not sure if adding yet another driver specific header is a good
idea. Perhaps we should consolidate I2C RTC drivers a bit more and
create common header for them?

> Additionally, I would welcome an additional patch documenting the fact
> that the ds1337 driver will work fine with the Dallas DS1339 real-time
> clock chip.

Document the fact that ds1337 driver works also with DS1339 real-time
clock chip.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

--- linux-omap/drivers/i2c/chips/Kconfig.orig	2005-05-10 13:51:44.417092640 +0200
+++ linux-omap/drivers/i2c/chips/Kconfig	2005-05-10 13:52:33.148684312 +0200
@@ -366,12 +366,12 @@
 	depends on I2C
 
 config SENSORS_DS1337
-	tristate "Dallas Semiconductor DS1337 Real Time Clock"
+	tristate "Dallas Semiconductor DS1337 and DS1339 Real Time Clock"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Dallas Semiconductor
-	  DS1337 real-time clock chips. 
+	  DS1337 and DS1339 real-time clock chips. 
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1337.
--- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-05-10 13:50:25.003165392 +0200
+++ linux-omap/drivers/i2c/chips/ds1337.c	2005-05-10 13:50:57.199270840 +0200
@@ -10,7 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Driver for Dallas Semiconductor DS1337 real time clock chip
+ * Driver for Dallas Semiconductor DS1337 and DS1339 real time clock chip
  */
 
 #include <linux/config.h>
