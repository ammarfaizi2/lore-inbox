Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbVJMIeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbVJMIeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 04:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbVJMIeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 04:34:17 -0400
Received: from god.demon.nl ([83.160.164.11]:8458 "EHLO god.dyndns.org")
	by vger.kernel.org with ESMTP id S1751564AbVJMIeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 04:34:16 -0400
Date: Thu, 13 Oct 2005 10:34:06 +0200
From: Henk <Henk.Vergonet@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] yealink driver: fix input patameter validations
Message-ID: <20051013083406.GA9791@god.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Yust a small patch that fixes a small parameter validation bug.
Please apply.

Best regards,

Henk

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

[PATCH] Buffer overflow patch for Yealink driver

  drivers/usb/input/map_to_7segment.h:
    This patch fixes the broken parameter validation in the char to seg7
    conversion. This could cause out-of-bounds memory references.

  MAINTAINERS:
    Yealink maintainer info now in sorted order.

  Documentation/input/yealink.txt:
    Added a Q&A section that answers some common questions.

Signed-off-by: Henk <Henk.Vergonet@gmail.com>

---

 Documentation/input/yealink.txt     |   25 +++++++++++++++++++------
 MAINTAINERS                         |   12 ++++++------
 drivers/usb/input/map_to_7segment.h |    2 +-
 3 files changed, 26 insertions(+), 13 deletions(-)

006491df1a13f85ad245d1039dfdf20e49c394fd
diff --git a/Documentation/input/yealink.txt b/Documentation/input/yealink.txt
--- a/Documentation/input/yealink.txt
+++ b/Documentation/input/yealink.txt
@@ -2,7 +2,6 @@ Driver documentation for yealink usb-p1k
 
 0. Status
 ~~~~~~~~~
-
 The p1k is a relatively cheap usb 1.1 phone with:
   - keyboard		full support, yealink.ko / input event API
   - LCD			full support, yealink.ko / sysfs API
@@ -17,17 +16,31 @@ For vendor documentation see http://www.
 
 1. Compilation (stand alone version)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
 Currently only kernel 2.6.x.y versions are supported.
-In order to build the yealink.ko module do:
+In order to build the yealink.ko module do
 
   make
 
-If you encounter problems please check if in the MAKE_OPTS variable in
+If you encounter problems please check if in the MAKE_OPTS variable in 
 the Makefile is pointing to the location where your kernel sources
 are located, default /usr/src/linux.
 
 
+1.1 Troubleshooting
+~~~~~~~~~~~~~~~~~~~
+Q: Module yealink compiled and installed without any problem but phone
+   is not initialized and does not react to any actions.
+A: If you see something like:
+   hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone
+   in dmesg, it means that the hid driver has grabbed the device first. Try to
+   load module yealink before any other usb hid driver. Please see the
+   instructions provided by your distribution on module configuration.
+
+Q: Phone is working now (displays version and accepts keypad input) but I can't
+   find the sysfs files.
+A: The sysfs files are located on the particular usb endpoint. On most
+   distributions you can do: "find /sys/ -name get_icons" for a hint.
+
 
 2. keyboard features
 ~~~~~~~~~~~~~~~~~~~~
@@ -134,7 +147,7 @@ Writing to /sys/../lineX will set the co
   Will update the LCD with the current date & time.
 
 
-4.2 get_icons
+4.2 get_icons 
 ~~~~~~~~~~~~~
 Reading will return all available icon names and its current settings:
 
@@ -159,7 +172,7 @@ Reading will return all available icon n
      RINGTONE
 
 
-4.3 show/hide icons
+4.3 show/hide icons 
 ~~~~~~~~~~~~~~~~~~~
 Writing to these files will update the state of the icon.
 Only one icon at a time can be updated.
diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -116,12 +116,6 @@ M:	ajk@iehk.rwth-aachen.de
 L:	linux-hams@vger.kernel.org
 S:	Maintained
 
-YEALINK PHONE DRIVER
-P:	Henk Vergonet
-M:	Henk.Vergonet@gmail.com
-L:	usbb2k-api-dev@nongnu.org
-S:	Maintained
-
 8139CP 10/100 FAST ETHERNET DRIVER
 P:	Jeff Garzik
 M:	jgarzik@pobox.com
@@ -2841,6 +2835,12 @@ M:	jpr@f6fbb.org
 L:	linux-hams@vger.kernel.org
 S:	Maintained
 
+YEALINK PHONE DRIVER
+P:	Henk Vergonet
+M:	Henk.Vergonet@gmail.com
+L:	usbb2k-api-dev@nongnu.org
+S:	Maintained
+
 YMFPCI YAMAHA PCI SOUND (Use ALSA instead)
 P:	Pete Zaitcev
 M:	zaitcev@yahoo.com
diff --git a/drivers/usb/input/map_to_7segment.h b/drivers/usb/input/map_to_7segment.h
--- a/drivers/usb/input/map_to_7segment.h
+++ b/drivers/usb/input/map_to_7segment.h
@@ -79,7 +79,7 @@ struct seg7_conversion_map {
 
 static inline int map_to_seg7(struct seg7_conversion_map *map, int c)
 {
-	return c & 0x7f ? map->table[c] : -EINVAL;
+	return c >= 0 && c < sizeof(map->table) ? map->table[c] : -EINVAL;
 }
 
 #define SEG7_CONVERSION_MAP(_name, _map)	\

--8t9RHnE3ZwKMSgU+--
