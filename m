Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTBOPxO>; Sat, 15 Feb 2003 10:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTBOPxO>; Sat, 15 Feb 2003 10:53:14 -0500
Received: from mx.laposte.net ([213.30.181.7]:52388 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id <S262258AbTBOPxN>;
	Sat, 15 Feb 2003 10:53:13 -0500
Subject: [2.5] EHCI HID keyboard not unloaded at reboot time ?
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-users@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZIW6GuCYRFYpYzeDlw66"
Organization: 
Message-Id: <1045324980.1767.28.camel@rousalka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 15 Feb 2003 17:03:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZIW6GuCYRFYpYzeDlw66
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[ Please CC me any replies, I don't follow the list closely ]

Hi,

	This is a question related to :
http://bugzilla.kernel.org/show_bug.cgi?id=3D9

	Basically I have a usb keyboard plugged on an external USB2 hub. Using
a monolithic ehci/hid kernel I can get it to work in 2.5. It's also used
in usb1 mode by the bios and the bootloader.

	However when I shut down or reboot from 2.5, I loose keyboard support
in the bios/bootloader/linux 2.4 (used to loose it in linux 2.5 also but
recent ehci enhancements enable 2.5 to recover it). Nothing short of a
PSU stop (neither reset nor stop button works) will recover it.

	What happens is the usb subsystem is somehow not unloaded at
shutdown/reboot time. The bios and linux 2.4 then find a usb subsystem
already setup in usb2 mode, and since they only know usb1 handling, they
are unable to recover usb devices. This is a pain when you have like me
an usb-only input setup. It means crawling under the desk every shutdown
time to reach the PSU power button, and feel the hardware aging
prematurely (and I'm lucky to *have* a PSU power button, I imagine some
other poor souls may have to unplug it to get the same effect).

	I say the usb subsystem is somehow not unloaded because=20
1. when I request a shutdown the keyboard is still active after the =AB
Power Down =BB message (this mobo wants acpi to shutdown properly so this
is easy to check with a acpi-less kernel)
2. I sprinkled the ehci unloading function whith printks some time ago
and it was never called.
3. the usb2 hub has a led to show if it's in usb1 or usb2 mode, and it
stays on after the reboot (when cold-booting in uhci 2.4 it stays of)

	Now I'm wondering if someone didn't decided at some time that
shutdown=3Dsuspend and input devices should stay on in suspend mode so
people can resume their system, ie maybe it's a design mistake instead
of a simple bug.

	Can anyone shed some light/advice on this problem ? It's driving me
nuts.

	Regards,

--=20
Nicolas Mailhot

--=-ZIW6GuCYRFYpYzeDlw66
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+TmS0I2bVKDsp8g0RAoRUAKDHki0cS1wPxrwW3CdKjXjvyTDD2gCfWS7T
8t+FTJJSSmYXUd+L1M3iFbE=
=yl1Q
-----END PGP SIGNATURE-----

--=-ZIW6GuCYRFYpYzeDlw66--

