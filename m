Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUESUgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUESUgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 16:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUESUgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 16:36:22 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:17809 "EHLO
	mailfe04.swip.net") by vger.kernel.org with ESMTP id S264538AbUESUfy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 16:35:54 -0400
X-T2-Posting-ID: mzHRUpvOlCbvaGn327Befg==
Date: Wed, 19 May 2004 22:33:21 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Olaf Hering <olh@suse.de>, Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BK PATCH] USB changes for 2.6.6
Message-ID: <20040519203321.GA20979@linux.nu>
References: <20040514224516.GA16814@kroah.com> <20040515113251.GA27011@suse.de> <Pine.LNX.4.58.0405151034500.10718@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405151034500.10718@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 15, 2004 at 10:37:10AM -0700, Linus Torvalds wrote:
> Replace all "led" with "cytherm". The code was crap, and would never have
> compiled with debugging on anyway. 

I fixed my crappy code. :)

--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="cytherm.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN linux-2.6.6/drivers/usb/misc/cytherm.c linux-2.6.6-cytherm/driver=
s/usb/misc/cytherm.c
--- linux-2.6.6/drivers/usb/misc/cytherm.c	2004-05-10 04:33:19.000000000 +0=
200
+++ linux-2.6.6-cytherm/drivers/usb/misc/cytherm.c	2004-05-19 22:23:58.0000=
00000 +0200
@@ -122,12 +122,12 @@
 	retval =3D vendor_command(cytherm->udev, WRITE_RAM, BRIGHTNESS,=20
 				cytherm->brightness, buffer, 8);
 	if (retval)
-		dev_dbg(&led->udev->dev, "retval =3D %d\n", retval);
+		dev_dbg(&cytherm->udev->dev, "retval =3D %d\n", retval);
 	/* Inform =B5C that we have changed the brightness setting */
 	retval =3D vendor_command(cytherm->udev, WRITE_RAM, BRIGHTNESS_SEM,
 				0x01, buffer, 8);
 	if (retval)
-		dev_dbg(&led->udev->dev, "retval =3D %d\n", retval);
+		dev_dbg(&cytherm->udev->dev, "retval =3D %d\n", retval);
   =20
 	kfree(buffer);
   =20
@@ -161,13 +161,13 @@
 	/* read temperature */
 	retval =3D vendor_command(cytherm->udev, READ_RAM, TEMP, 0, buffer, 8);
 	if (retval)
-		dev_dbg(&led->udev->dev, "retval =3D %d\n", retval);
+		dev_dbg(&cytherm->udev->dev, "retval =3D %d\n", retval);
 	temp =3D buffer[1];
   =20
 	/* read sign */
 	retval =3D vendor_command(cytherm->udev, READ_RAM, SIGN, 0, buffer, 8);
 	if (retval)
-		dev_dbg(&led->udev->dev, "retval =3D %d\n", retval);
+		dev_dbg(&cytherm->udev->dev, "retval =3D %d\n", retval);
 	sign =3D buffer[1];
=20
 	kfree(buffer);
@@ -205,7 +205,7 @@
 	/* check button */
 	retval =3D vendor_command(cytherm->udev, READ_RAM, BUTTON, 0, buffer, 8);
 	if (retval)
-		dev_dbg(&led->udev->dev, "retval =3D %d\n", retval);
+		dev_dbg(&cytherm->udev->dev, "retval =3D %d\n", retval);
   =20
 	retval =3D buffer[1];
=20
@@ -242,7 +242,7 @@
=20
 	retval =3D vendor_command(cytherm->udev, READ_PORT, 0, 0, buffer, 8);
 	if (retval)
-		dev_dbg(&led->udev->dev, "retval =3D %d\n", retval);
+		dev_dbg(&cytherm->udev->dev, "retval =3D %d\n", retval);
=20
 	retval =3D buffer[1];
=20
@@ -277,7 +277,7 @@
 	retval =3D vendor_command(cytherm->udev, WRITE_PORT, 0,
 				tmp, buffer, 8);
 	if (retval)
-		dev_dbg(&led->udev->dev, "retval =3D %d\n", retval);
+		dev_dbg(&cytherm->udev->dev, "retval =3D %d\n", retval);
=20
 	kfree(buffer);
=20
@@ -302,7 +302,7 @@
=20
 	retval =3D vendor_command(cytherm->udev, READ_PORT, 1, 0, buffer, 8);
 	if (retval)
-		dev_dbg(&led->udev->dev, "retval =3D %d\n", retval);
+		dev_dbg(&cytherm->udev->dev, "retval =3D %d\n", retval);
   =20
 	retval =3D buffer[1];
=20
@@ -337,7 +337,7 @@
 	retval =3D vendor_command(cytherm->udev, WRITE_PORT, 1,
 				tmp, buffer, 8);
 	if (retval)
-		dev_dbg(&led->udev->dev, "retval =3D %d\n", retval);
+		dev_dbg(&cytherm->udev->dev, "retval =3D %d\n", retval);
=20
 	kfree(buffer);
=20

--huq684BweRXVnRxX--
