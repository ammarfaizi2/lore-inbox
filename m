Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbULAAPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbULAAPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbULAAPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:15:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:31972 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261175AbULAAOO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:14 -0500
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc2
In-Reply-To: <11018600193669@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Nov 2004 16:13:40 -0800
Message-Id: <11018600202097@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.11, 2004/11/29 15:42:04-08:00, khali@linux-fr.org

[PATCH] I2C: macintoch/therm_* drivers cleanups

This patch cleans the macintoch/therm_* drivers a bit. It removes
useless IDs, cleans names (no white space), some coding style fixes as
well, etc. It's exactly the same as what I posted yesterday as a
candidate fix to bug #3823:
http://bugzilla.kernel.org/show_bug.cgi?id=3823

Although it isn't the proper fix for that bug, as you underlined, this
still sounds like a sane set of cleanups for these drivers.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/macintosh/therm_adt746x.c    |   11 +++++------
 drivers/macintosh/therm_pm72.c       |    3 +--
 drivers/macintosh/therm_windtunnel.c |    8 ++++----
 3 files changed, 10 insertions(+), 12 deletions(-)


diff -Nru a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
--- a/drivers/macintosh/therm_adt746x.c	2004-11-30 16:00:32 -08:00
+++ b/drivers/macintosh/therm_adt746x.c	2004-11-30 16:00:32 -08:00
@@ -170,11 +170,11 @@
 }
 
 static struct i2c_driver thermostat_driver = {  
-	.name		="Apple Thermostat ADT746x",
-	.id		=0xDEAD7467,
-	.flags		=I2C_DF_NOTIFY,
-	.attach_adapter	=&attach_thermostat,
-	.detach_adapter	=&detach_thermostat,
+	.owner		= THIS_MODULE,
+	.name		= "therm_adt746x",
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= attach_thermostat,
+	.detach_adapter	= detach_thermostat,
 };
 
 static int read_fan_speed(struct thermostat *th, u8 addr)
@@ -381,7 +381,6 @@
 	th->clt.addr = addr;
 	th->clt.adapter = adapter;
 	th->clt.driver = &thermostat_driver;
-	th->clt.id = 0xDEAD7467;
 	strcpy(th->clt.name, "thermostat");
 
 	rc = read_reg(th, 0);
diff -Nru a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
--- a/drivers/macintosh/therm_pm72.c	2004-11-30 16:00:32 -08:00
+++ b/drivers/macintosh/therm_pm72.c	2004-11-30 16:00:32 -08:00
@@ -235,8 +235,8 @@
 
 static struct i2c_driver therm_pm72_driver =
 {
+	.owner		= THIS_MODULE,
 	.name		= "therm_pm72",
-	.id		= 0xDEADBEEF,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= therm_pm72_attach,
 	.detach_adapter	= therm_pm72_detach,
@@ -266,7 +266,6 @@
 	clt->addr = (id >> 1) & 0x7f;
 	clt->adapter = adap;
 	clt->driver = &therm_pm72_driver;
-	clt->id = 0xDEADBEEF;
 	strncpy(clt->name, name, I2C_NAME_SIZE-1);
 
 	if (i2c_attach_client(clt)) {
diff -Nru a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
--- a/drivers/macintosh/therm_windtunnel.c	2004-11-30 16:00:32 -08:00
+++ b/drivers/macintosh/therm_windtunnel.c	2004-11-30 16:00:32 -08:00
@@ -353,12 +353,12 @@
 }
 
 static struct i2c_driver g4fan_driver = {  
-	.name		= "Apple G4 Thermostat/Fan",
+	.owner		= THIS_MODULE,
+	.name		= "therm_windtunnel",
 	.id		= I2C_DRIVERID_G4FAN,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter = &do_attach,
-	.detach_client	= &do_detach,
-	.command	= NULL,
+	.attach_adapter = do_attach,
+	.detach_client	= do_detach,
 };
 
 static int

