Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUFDTjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUFDTjT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbUFDTjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:39:19 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:14052 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S265902AbUFDTjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:39:16 -0400
Date: Fri, 4 Jun 2004 15:39:11 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, "David A. Desrosiers" <desrod@gnu-designs.com>
Subject: USBDEVFS_RESET deadlocks USB bus.
Message-ID: <20040604193911.GA3261@babylon.d2dc.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>,
	"David A. Desrosiers" <desrod@gnu-designs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Starting at 2.6.7-rc1 or so (that is when we first noticed it) the new
pilot-link libusb back end started deadlocking the entire USB bus that
the palm device was on.

I have finally tracked it down to happening when we make the
USBDEVFS_RESET ioctl, we never return from it and from that point on the
bus in question is completely dead, no processing is done, no
notifications of devices being plugged in or unplugged.

This is still happening in 2.6.7-rc2-mm1.

It seems to happen with both the UHCI and OHCI back ends, so it is
probably above that.

Given that there were heavy locking changes, I suspect that the case in
question got screwed up somehow.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

Perl =3D=3D Being
  -- Descartes (paraphrased).

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAwM/fRFMAi+ZaeAERAg5XAKCzzBoqNuUNyrDd1M9OU5ZubLhhVgCgiXjb
fgR3OAPhcay4zNo+5Lt2vcU=
=3+hd
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
