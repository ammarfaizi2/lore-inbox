Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUASR7Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 12:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUASR7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 12:59:24 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:35495 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S261575AbUASR6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 12:58:44 -0500
Date: Mon, 19 Jan 2004 18:58:42 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
Subject: [solved] failing to force-claim USB interface
Message-ID: <20040119175842.GA8346@piper.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
References: <20040119164627.GA29146@piper.madduck.net> <20040119154633.GA3797@piper.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20040119164627.GA29146@piper.madduck.net> <20040119154633.GA3797@piper.madduck.net>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.1-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Martin F Krafft <krafft@ailab.ch> [2004.01.19.1646 +0100]:
>   struct usb_device *dev;
>   [...]
>   sprintf(path, "/proc/bus/usb/%s/%s", dev->bus->dirname, dev->filename);
>   int fd =3D open(path);
>   struct usbdevfs_ioctl command =3D { 0, USBDEVFS_DISCONNECT, 0 };
>   ioctl (fd, USBDEVFS_IOCTL, &command) < 0

I was using the wrong fd. The following works:

  struct usb_device *dev;
  [...]
  struct usb_device_handle udev =3D usb_open(dev);
  struct usbdevfs_ioctl command =3D { 0, USBDEVFS_DISCONNECT, 0 };
  ioctl(udev->fd, USBDEVFS_IOCTL, &command)

Now the only thing left to figure out is how the libusb library
expects us to do this, because struct usb_device_handle; is not
implemented in the exported interface.

I guess the solution is to implement the above functionality in
libusb itself.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
there are 3 types of guys -- the ones who hate nerds (all nerds, that
is; girls aren't let off the hook); the ones who are scared off by
girls who are slightly more intelligent than average; and the guys who
are also somewhat more intelligent than average, but are so shy that
they can't put 2 words together when they're within 20 feet of a girl.
                                     -- vikki roemer on debian-curiosa

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFADBrSIgvIgzMMSnURAtczAJ910QIxk+IJlOr6YQJIsMzwmTPHPACg3TyS
L1bV+YqQZb6i3/a7nreOZVw=
=KKtT
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
