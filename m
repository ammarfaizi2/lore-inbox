Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbSJHXUz>; Tue, 8 Oct 2002 19:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbSJHXUJ>; Tue, 8 Oct 2002 19:20:09 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:55561 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261502AbSJHXSh>;
	Tue, 8 Oct 2002 19:18:37 -0400
Date: Tue, 8 Oct 2002 16:20:32 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB and driver core changes for 2.5.41
Message-ID: <20021008232032.GH11337@kroah.com>
References: <20021008231511.GA11337@kroah.com> <20021008231557.GB11337@kroah.com> <20021008231646.GC11337@kroah.com> <20021008231747.GD11337@kroah.com> <20021008231832.GE11337@kroah.com> <20021008231903.GF11337@kroah.com> <20021008231957.GG11337@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008231957.GG11337@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.573.92.18 -> 1.573.92.19
#	drivers/usb/core/driverfs.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/08	greg@kroah.com	1.573.92.19
# USB: add device speed driverfs file.
# --------------------------------------------
#
diff -Nru a/drivers/usb/core/driverfs.c b/drivers/usb/core/driverfs.c
--- a/drivers/usb/core/driverfs.c	Tue Oct  8 15:53:35 2002
+++ b/drivers/usb/core/driverfs.c	Tue Oct  8 15:53:35 2002
@@ -99,6 +99,34 @@
 }
 static DEVICE_ATTR(serial,S_IRUGO,show_serial,NULL);
 
+static ssize_t
+show_speed (struct device *dev, char *buf, size_t count, loff_t off)
+{
+	struct usb_device *udev;
+	char *speed;
+
+	if (off)
+		return 0;
+	udev = to_usb_device (dev);
+
+	switch (udev->speed) {
+	case USB_SPEED_LOW:
+		speed = "1.5";
+		break;
+	case USB_SPEED_UNKNOWN:
+	case USB_SPEED_FULL:
+		speed = "12";
+		break;
+	case USB_SPEED_HIGH:
+		speed = "480";
+		break;
+	default:
+		speed = "unknown";
+	}
+	return sprintf (buf, "%s\n", speed);
+}
+static DEVICE_ATTR(speed, S_IRUGO, show_speed, NULL);
+
 /* Descriptor fields */
 #define usb_descriptor_attr(field, format_string)			\
 static ssize_t								\
@@ -136,6 +164,7 @@
 	device_create_file (dev, &dev_attr_bDeviceClass);
 	device_create_file (dev, &dev_attr_bDeviceSubClass);
 	device_create_file (dev, &dev_attr_bDeviceProtocol);
+	device_create_file (dev, &dev_attr_speed);
 
 	if (udev->descriptor.iManufacturer)
 		device_create_file (dev, &dev_attr_manufacturer);
