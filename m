Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314128AbSDLUsg>; Fri, 12 Apr 2002 16:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314141AbSDLUsf>; Fri, 12 Apr 2002 16:48:35 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:50024 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S314128AbSDLUse>; Fri, 12 Apr 2002 16:48:34 -0400
Date: Fri, 12 Apr 2002 22:48:32 +0200
From: Kurt Garloff <kurt@garloff.de>
To: David Brownell <dbrownell@users.sourceforge.net>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: usbnet: prolific fails reset
Message-ID: <20020412224832.D1832@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ey/N+yb7u/X9mFhi
Content-Type: multipart/mixed; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

got a USB network cable and was happy to see that it's supported by usbnet.
Good job, thanks!
usb0: register usbnet 001/004, Prolific PL-2301/PL-2302

However:
Upon ifconfig,
usb-uhci.c: interrupt, status 3, frame# 922
usb0: open reset fail (-32) usbnet 001/004, Prolific PL-2301/PL-2302

The ifconfig fails to up the interface, consequently.

Attached patch prevents the driver from returning the reset failure.
Guess what: The networking worked just fine then.
Probably the real solution is different ...

Patch is against 2.4.16.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Description: usbnet-ignore-failed-reset-2416.diff
Content-Disposition: attachment; filename="usbnet-ignore-failed-reset-2418.diff"
Content-Transfer-Encoding: quoted-printable

--- linux/drivers/usb/usbnet.c~	Tue Dec 18 12:45:53 2001
+++ linux/drivers/usb/usbnet.c	Thu Apr 11 20:02:51 2002
@@ -1487,7 +1487,7 @@
 			retval,
 			dev->udev->bus->busnum, dev->udev->devnum,
 			info->description);
-		goto done;
+		//goto done;
 	}
=20
 	// insist peer be connected

--vni90+aGYgRvsTuO--

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8t0ggxmLh6hyYd04RAkczAKCxt+60hulW57NECk6L7VtW32oTEACfUv6X
tLSYkwaghRIMkRX6ptU4NkA=
=Bu2I
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
