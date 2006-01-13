Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422881AbWAMT6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422881AbWAMT6f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422879AbWAMT6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:58:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:47764 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422866AbWAMTub convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:31 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add usb_serial_bus_type probe and remove methods
In-Reply-To: <11371818114002@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:11 -0800
Message-Id: <11371818111878@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add usb_serial_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ac33bc3d54936d364c1f979e50f43dfa3f9a13c1
tree 22ea930b8b2a642d0e6efeaa069a111a0b16d0a6
parent ff2dae79773658eaaab731663ddca9f7975430eb
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:43:11 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:09 -0800

 drivers/usb/serial/bus.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index 664139a..e9f9f4b 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -37,11 +37,6 @@ static int usb_serial_device_match (stru
 	return 0;
 }
 
-struct bus_type usb_serial_bus_type = {
-	.name =		"usb-serial",
-	.match =	usb_serial_device_match,
-};
-
 static int usb_serial_device_probe (struct device *dev)
 {
 	struct usb_serial_driver *driver;
@@ -109,14 +104,18 @@ exit:
 	return retval;
 }
 
+struct bus_type usb_serial_bus_type = {
+	.name =		"usb-serial",
+	.match =	usb_serial_device_match,
+	.probe =	usb_serial_device_probe,
+	.remove =	usb_serial_device_remove,
+};
+
 int usb_serial_bus_register(struct usb_serial_driver *driver)
 {
 	int retval;
 
 	driver->driver.bus = &usb_serial_bus_type;
-	driver->driver.probe = usb_serial_device_probe;
-	driver->driver.remove = usb_serial_device_remove;
-
 	retval = driver_register(&driver->driver);
 
 	return retval;

