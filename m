Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131592AbRAGNFK>; Sun, 7 Jan 2001 08:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131775AbRAGNFA>; Sun, 7 Jan 2001 08:05:00 -0500
Received: from enst.enst.fr ([137.194.2.16]:61906 "HELO enst.enst.fr")
	by vger.kernel.org with SMTP id <S131592AbRAGNEp>;
	Sun, 7 Jan 2001 08:04:45 -0500
Date: Sun, 7 Jan 2001 14:04:40 +0100
From: Nicolas Mailhot <Nicolas.Mailhot@email.enst.fr>
To: mdharm-usb@one-eyed-alien.net
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        jerdfelt@valinux.com
Subject: [Patch] [linux-2.4.0] drivers/usb/Config.in
Message-ID: <20010107140440.E1468@rousalka.maisel2.rezel.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Re-send without the mime stuff, sorry about this one]

Hi,

 Here is a patchlet to stop people searching for the
mysteriously hidden USB Mass Storage driver (in case they
didn't make the connection with SCSI at once like me).

 Seems to work, and anyway I don't see how I could have
messed up this one:)

 Regards,

--- linux-2.4.0/drivers/usb/Config.in	Tue Nov 28 03:10:35 2000
+++ linux-2.4.0-nim1/drivers/usb/Config.in	Sat Jan  6 18:04:26 2001
@@ -28,10 +28,14 @@
    comment 'USB Device Class drivers'
    dep_tristate '  USB Audio support' CONFIG_USB_AUDIO $CONFIG_USB $CONFIG_SOUND
    dep_tristate '  USB Bluetooth support (EXPERIMENTAL)' CONFIG_USB_BLUETOOTH $CONFIG_USB $CONFIG_EXPERIMENTAL
-   dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_USB $CONFIG_SCSI
-   if [ "$CONFIG_USB_STORAGE" != "n" ]; then
-      bool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG
-      bool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM
+   if [ "$CONFIG_SCSI" = "n" ]; then
+      comment '  SCSI support is needed for USB Mass Storage'
+   else
+      dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_USB $CONFIG_SCSI
+      if [ "$CONFIG_USB_STORAGE" != "n" ]; then
+         bool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG
+         bool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM
+      fi
    fi
    dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_USB
    dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB


-- 
Nicolas Mailhot

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
