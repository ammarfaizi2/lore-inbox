Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131200AbRAFRet>; Sat, 6 Jan 2001 12:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131047AbRAFRei>; Sat, 6 Jan 2001 12:34:38 -0500
Received: from enst.enst.fr ([137.194.2.16]:41654 "HELO enst.enst.fr")
	by vger.kernel.org with SMTP id <S130794AbRAFReb>;
	Sat, 6 Jan 2001 12:34:31 -0500
Date: Sat, 6 Jan 2001 18:34:17 +0100
From: Nicolas Mailhot <Nicolas.Mailhot@email.enst.fr>
To: mdharm-usb@one-eyed-alien.net
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        jerdfelt@valinux.com
Subject: [PATCH] USB Mass Storage and SCSI
Message-ID: <20010106183417.A25047@rousalka.maisel2.rezel.enst.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AWniW0JNca5xppdA"
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AWniW0JNca5xppdA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi,

 Here is a patchlet to stop people searching for the
mysteriously hidden USB Mass Storage driver (in case they
didn't make the connection with SCSI at once like me).

 Seems to work, and anyway I don't see how I could have
messed up this one:)

-- 
Nicolas Mailhot
--AWniW0JNca5xppdA
Content-Type: application/octet-stream; charset=us-ascii
Content-Disposition: attachment; filename="USBMassStorageConfig.patch"

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

--AWniW0JNca5xppdA--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
