Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbRAKAsU>; Wed, 10 Jan 2001 19:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130893AbRAKAsJ>; Wed, 10 Jan 2001 19:48:09 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:20237 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S129868AbRAKAsB>;
	Wed, 10 Jan 2001 19:48:01 -0500
Date: Wed, 10 Jan 2001 16:44:51 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: f5ibh <f5ibh@db0bm.ampr.org>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB Config fix for 2.2.19-pre7
Message-ID: <20010110164451.A16985@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010110002639.B26680@wirex.com>; from greg@wirex.com on Wed, Jan 10, 2001 at 12:26:39AM -0800
X-Operating-System: Linux 2.2.16-immunix (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's a fix for the USB Config for 2.2.19-pre7.  I messed up and took
out the HID devices in the patch I sent you for 2.2.19-pre6.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-Config-2.2.19-pre7.diff"

diff -Naur -X dontdiff linux-2.2.19-pre7/drivers/usb/Config.in linux-2.2.19-pre7-greg/drivers/usb/Config.in
--- linux-2.2.19-pre7/drivers/usb/Config.in	Wed Jan 10 15:43:28 2001
+++ linux-2.2.19-pre7-greg/drivers/usb/Config.in	Wed Jan 10 16:14:04 2001
@@ -36,16 +36,23 @@
    dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB
 
    comment 'USB Human Interface Devices (HID)'
-   if [ "$CONFIG_INPUT" = "n" ]; then
-      comment '  Input core support is needed for USB HID'
-   else
-      dep_tristate '  USB Human Interface Device (full HID) support' CONFIG_USB_HID $CONFIG_USB $CONFIG_INPUT
-      if [ "$CONFIG_USB_HID" != "y" ]; then
-         dep_tristate '  USB HIDBP Keyboard (basic) support' CONFIG_USB_KBD $CONFIG_USB $CONFIG_INPUT
-         dep_tristate '  USB HIDBP Mouse (basic) support' CONFIG_USB_MOUSE $CONFIG_USB $CONFIG_INPUT
-      fi
-      dep_tristate '  Wacom Intuos/Graphire tablet support' CONFIG_USB_WACOM $CONFIG_USB $CONFIG_INPUT
+   dep_tristate '  USB Human Interface Device (full HID) support' CONFIG_USB_HID $CONFIG_USB
+   if [ "$CONFIG_USB_HID" != "y" ]; then
+      dep_tristate '  USB HIDBP Keyboard (basic) support' CONFIG_USB_KBD $CONFIG_USB
+      dep_tristate '  USB HIDBP Mouse (basic) support' CONFIG_USB_MOUSE $CONFIG_USB
    fi
+   if [ "$CONFIG_VT" = "y" ]; then
+      dep_tristate '  Keyboard support' CONFIG_INPUT_KEYBDEV $CONFIG_USB $CONFIG_USB_HID
+   fi
+   dep_tristate '  Mouse support' CONFIG_INPUT_MOUSEDEV $CONFIG_USB $CONFIG_USB_HID
+   if [ "$CONFIG_INPUT_MOUSEDEV" != "n" ]; then
+      int '   Horizontal screen resolution' CONFIG_INPUT_MOUSEDEV_SCREEN_X 1024
+      int '   Vertical screen resolution' CONFIG_INPUT_MOUSEDEV_SCREEN_Y 768
+   fi
+   dep_tristate '  Joystick support' CONFIG_INPUT_JOYDEV $CONFIG_USB $CONFIG_USB_HID
+   dep_tristate '  Logitech WingMan Force joystick support' CONFIG_USB_WMFORCE $CONFIG_USB $CONFIG_USB_HID
+   dep_tristate '  Wacom Intuos/Graphire tablet support' CONFIG_USB_WACOM $CONFIG_USB $CONFIG_USB_HID
+   dep_tristate '  Event interface support' CONFIG_INPUT_EVDEV $CONFIG_USB $CONFIG_USB_HID
 
    comment 'USB Imaging devices'
    dep_tristate '  USB Kodak DC-2xx Camera support' CONFIG_USB_DC2XX $CONFIG_USB

--NzB8fVQJ5HfG6fxh--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
