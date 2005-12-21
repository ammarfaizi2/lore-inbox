Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVLULhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVLULhX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVLULhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:37:23 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:47551 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932374AbVLULhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:37:22 -0500
Date: Wed, 21 Dec 2005 12:37:43 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] conditionally #ifdef-out unused DiB3000M-C/P functions
Message-ID: <20051221113742.GA5611@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc6-marc-g3e1ec1f4
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following tiny patch removes the two DiB3000M-C/P functions

int dibusb_dib3000mc_tuner_attach()
int dibusb_dib3000mc_frontend_attach()

that are not needed in case the module is not compiled. The modules a800 as well
as nova-t-usb2 select DVB_DIB3000MB in Kconfig thus the functions will be
enabled due to the module being compiled.

Regards,
	Marc

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dibusb-remove-dibusb_dib3000-funcs-if-not-CONFIG_DVB_USB_DIBUSB_MC.patch"
Content-Transfer-Encoding: quoted-printable

*** dibusb-common.c-orig	2005-12-21 11:04:49.000000000 +0100
--- dibusb-common.c	2005-12-21 11:05:32.000000000 +0100
*************** int dibusb_read_eeprom_byte(struct dvb_u
*** 168,173 ****
--- 168,174 ----
  }
  EXPORT_SYMBOL(dibusb_read_eeprom_byte);
 =20
+ #ifdef CONFIG_DVB_USB_DIBUSB_MC
  int dibusb_dib3000mc_frontend_attach(struct dvb_usb_device *d)
  {
  	struct dib3000_config demod_cfg;
*************** int dibusb_dib3000mc_tuner_attach (struc
*** 193,198 ****
--- 194,200 ----
  	return 0;
  }
  EXPORT_SYMBOL(dibusb_dib3000mc_tuner_attach);
+ #endif
 =20
  /*
   * common remote control stuff

--J/dobhs11T7y2rNN--

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDqT6GXs/lvTQwq/URAlJ+AJ9UDw4i9WqWzQs1p1XLv8N97k933ACeKZC4
vSIPpfgxTGq2KfqrZG22Chc=
=rkZN
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
