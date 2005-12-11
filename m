Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbVLKFQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbVLKFQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 00:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbVLKFQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 00:16:03 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:61008 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161082AbVLKFQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 00:16:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=R7ASQVrQC78JXopwBED1nGECNp5rG36gHaOkFWZDyUzJCew6yaKn5ZVDl76SxK7hTkFgKHUnjofe0w3902K0FIXum8OM29Fa3F4aXV3+N19XLbfSe/EiHiPZer9QARrBKe6ap5v6WYIKNYNR1JYGyiOBtaecTc9mordpc8NRK9Q=
Message-ID: <81083a450512102116o50d71fa0gbb53557f0e3d8748@mail.gmail.com>
Date: Sun, 11 Dec 2005 10:46:00 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: mitr@volny.cz, bero@arklinux.org, dtor@mail.ru, akpm@osdl.org
Subject: [PATCH] drivers/input/misc: Added Acer TravelMate 240 support to the wistron button interface
Cc: vojtech@suse.cz, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-laptop@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11475_11642492.1134278160943"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_11475_11642492.1134278160943
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch adds Acer TravelMate 240 support to the wistron button
interface. This means that the buttons on top of the
keyboard(including ones for Wifi and Bluetooth),  which hitherto did
not work, work now. I have tested it on my laptop and it seems to work
great.

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

------=_Part_11475_11642492.1134278160943
Content-Type: text/plain; name=acer_patch.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="acer_patch.txt"

diff -Naurp linux-2.6.15-rc5-vanilla/drivers/input/misc/wistron_btns.c linux-2.6.15-rc5/drivers/input/misc/wistron_btns.c
--- linux-2.6.15-rc5-vanilla/drivers/input/misc/wistron_btns.c	2005-12-10 23:40:19.000000000 +0530
+++ linux-2.6.15-rc5/drivers/input/misc/wistron_btns.c	2005-12-10 23:42:00.000000000 +0530
@@ -296,6 +296,16 @@ static struct key_entry keymap_acer_aspi
 	{ KE_END, 0 }
 };
 
+static struct key_entry keymap_acer_travelmate_240[] = {
+	{ KE_KEY, 0x31, KEY_MAIL },
+	{ KE_KEY, 0x36, KEY_WWW },
+	{ KE_KEY, 0x11, KEY_PROG1 },
+	{ KE_KEY, 0x12, KEY_PROG2 },
+	{ KE_BLUETOOTH, 0x44, 0 },
+	{ KE_WIFI, 0x30, 0 },
+	{ KE_END, 0 }
+};
+
 /*
  * If your machine is not here (which is currently rather likely), please send
  * a list of buttons and their key codes (reported when loading this module
@@ -320,6 +330,15 @@ static struct dmi_system_id dmi_ids[] = 
 		},
 		.driver_data = keymap_acer_aspire_1500
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer TravelMate 240",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 240"),
+		},
+		.driver_data = keymap_acer_travelmate_240
+	},
 	{ 0, }
 };
 




------=_Part_11475_11642492.1134278160943--
