Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVHQXno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVHQXno (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 19:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVHQXno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 19:43:44 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:59816 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1751332AbVHQXno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 19:43:44 -0400
Date: Wed, 17 Aug 2005 19:43:48 -0400
From: Michal Ostrowski <mostrows@watson.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: BUG? [PATCH] driver core: Add the ability to bind drivers to
 devices from userspace
Message-ID: <20050817194348.3fb5b3d0@brick.watson.ibm.com>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Wed__17_Aug_2005_19_43_48_-0400_nXG4Ln/KQX6C_7G3";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Wed__17_Aug_2005_19_43_48_-0400_nXG4Ln/KQX6C_7G3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


If a driver's probe function returns -ENXIO or -ENODEV,
driver_probe_device() will translate that to return 0 (comments argue it
is not an error).

Consequently driver_bind() will return 0 resulting in the write
system-call that initiated all of this in returning 0 as well.

If one uses "echo" to write to a "bind" attribute, echo will
continuously call write() trying to write to the attribute and always
get 0 as a result and thus find itself in a loop trying to do the write.

Perhaps the translation of -ENZIO to -ENODEV to success in
driver_probe_device() is not approriate here?

--=20
Michal Ostrowski

--Signature_Wed__17_Aug_2005_19_43_48_-0400_nXG4Ln/KQX6C_7G3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDA8u0DMDCqU5zPMARAqPNAJ0SzDRsKIvh+qyj9ua0QRbcHvkpkQCeLRBc
tEWrTrIsX1FMh7fh2RDo0vA=
=Ror9
-----END PGP SIGNATURE-----

--Signature_Wed__17_Aug_2005_19_43_48_-0400_nXG4Ln/KQX6C_7G3--
