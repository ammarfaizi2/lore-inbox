Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVDJNXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVDJNXH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 09:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVDJNXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 09:23:07 -0400
Received: from host0254.naumen.ru ([195.64.216.254]:5069 "EHLO
	naumen.office0.naumen.ru") by vger.kernel.org with ESMTP
	id S261495AbVDJNW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 09:22:58 -0400
From: "Viktor A. Danilov" <__die@mail.ru>
Organization: LVDA
To: linux-kernel@vger.kernel.org, bwheadley@earthlink.net, chris@crud.net
Subject: PROBLEM: AIPTEK input doesn`t register `device` & `driver` section in sysfs (/sys/class/input/event#)
Date: Sun, 10 Apr 2005 19:21:28 +0600
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Message-Id: <200504101921.28777.__die@mail.ru>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YhSWCKe1BZh94Hk"
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_YhSWCKe1BZh94Hk
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


PROBLEM: aiptek input doesn`t register `device` & `driver` section in sysfs (/sys/class/input/event#)
REASON: `dev` - field not filled...
SOLUTION: in linux/drivers/usb/input/aiptek.c write
	aiptek->inputdev.dev = &intf->dev;
before calling 
	input_register_device(&aiptek->inputdev);

PATCH:

--- linux/drivers/usb/input/aiptek.c.orig       2005-03-09 13:12:31.000000000 +0500
+++ linux/drivers/usb/input/aiptek.c    2005-04-10 18:39:59.000000000 +0600
@@ -2139,8 +2140,9 @@
        aiptek->inputdev.id.bustype = BUS_USB;
        aiptek->inputdev.id.vendor = le16_to_cpu(usbdev->descriptor.idVendor);
        aiptek->inputdev.id.product = le16_to_cpu(usbdev->descriptor.idProduct);
        aiptek->inputdev.id.version = le16_to_cpu(usbdev->descriptor.bcdDevice);
+      aiptek->inputdev.dev = &intf->dev;

        aiptek->usbdev = usbdev;
        aiptek->ifnum = intf->altsetting[0].desc.bInterfaceNumber;
        aiptek->inDelay = 0;



LINUX_VERSION:

vdanilov@viktor:/usr/src/linux/scripts$ ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux viktor 2.6.11.5-C2H5OH #1 Fri Mar 25 15:29:27 YEKT 2005 i686 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15
util-linux             2.12h
mount                  2.12h
module-init-tools      3.1
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.5
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.4
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   056
Modules Loaded         i830 drm pcmcia smbfs pcspkr snd_intel8x0m aiptek usbhid uhci_hcd intel_agp agpgart 8139too crc32 yenta_socket rsrc_nonstatic pcmcia_core ehci_hcd snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc nls_koi8_r vfat fat eeprom evdev i2c_sensor i2c_i801 i2c_core ide_cd cdrom usbkbd usbcore psmouse speedstep_centrino freq_table




--Boundary-00=_YhSWCKe1BZh94Hk
Content-Type: text/x-diff;
  charset="koi8-r";
  name="aiptek.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="aiptek.c.diff"

--- linux/drivers/usb/input/aiptek.c.orig	2005-03-09 13:12:31.000000000 +0500
+++ linux/drivers/usb/input/aiptek.c	2005-04-10 18:39:59.000000000 +0600
@@ -2139,8 +2140,9 @@
 	aiptek->inputdev.id.bustype = BUS_USB;
 	aiptek->inputdev.id.vendor = le16_to_cpu(usbdev->descriptor.idVendor);
 	aiptek->inputdev.id.product = le16_to_cpu(usbdev->descriptor.idProduct);
 	aiptek->inputdev.id.version = le16_to_cpu(usbdev->descriptor.bcdDevice);
+	aiptek->inputdev.dev = &intf->dev;
 
 	aiptek->usbdev = usbdev;
 	aiptek->ifnum = intf->altsetting[0].desc.bInterfaceNumber;
 	aiptek->inDelay = 0;

--Boundary-00=_YhSWCKe1BZh94Hk--
