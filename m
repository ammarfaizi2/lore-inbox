Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270280AbRIEE4b>; Wed, 5 Sep 2001 00:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270299AbRIEE4W>; Wed, 5 Sep 2001 00:56:22 -0400
Received: from ns1.yggdrasil.com ([209.249.10.20]:7634 "EHLO ns1.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S270280AbRIEE4H>;
	Wed, 5 Sep 2001 00:56:07 -0400
Date: Tue, 4 Sep 2001 21:55:53 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: dag@brattli.net, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Cc: bhards@bigpond.net.au, bvermeul@devel.blackstar.nl
Subject: PATCH: linux-2.4.10-pre4/drivers/net/irda/irda-usb.c incorrectly matched to other USB devices
Message-ID: <20010904215553.A23814@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.4.10-pre4/drivers/net/irda/irda-usb.c was missing a
match flag in its array of usb_device_id's, causing it to claim
and attempt to talk to at least one completely incompatible device:
the D-Link DWL-120 USB wireless ethernet adapter.  The hot plugging
code also uses this information, causing the irda-usb driver to be
helpfully autoloaded so that it can incorrectly claim this device
even if the module was not originally loaded.

	I have verified that, with this patch, the irda-usb driver
is no longer incorrectly loaded when a DWL-120 wireless ethernet
adapter is plugged in.

	To all the appropriate people: please apply this patch.  Thanks
in advance.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="irda.diff"

--- linux-2.4.10-pre4/drivers/net/irda/irda-usb.c	Sun Aug  5 13:12:40 2001
+++ linux/drivers/net/irda/irda-usb.c	Tue Sep  4 21:19:43 2001
@@ -76,7 +76,8 @@
 	{ USB_DEVICE(0x50f, 0x180), driver_info: IUC_SPEED_BUG | IUC_NO_WINDOW },
 	/* Extended Systems, Inc.,  XTNDAccess IrDA USB (ESI-9685) */
 	{ USB_DEVICE(0x8e9, 0x100), driver_info: IUC_SPEED_BUG | IUC_NO_WINDOW },
-	{ match_flags: USB_DEVICE_ID_MATCH_INT_CLASS,
+	{ match_flags: USB_DEVICE_ID_MATCH_INT_CLASS |
+	               USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	  bInterfaceClass: USB_CLASS_APP_SPEC,
 	  bInterfaceSubClass: USB_CLASS_IRDA,
 	  driver_info: IUC_DEFAULT, },

--OgqxwSJOaUobr8KG--
