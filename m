Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWCFNuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWCFNuZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWCFNuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:50:24 -0500
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:17900 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S932297AbWCFNuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:50:23 -0500
Date: Mon, 6 Mar 2006 14:50:17 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, heiko.carstens@de.ibm.com,
       schwidefsky@de.ibm.com
Subject: Re: + s390-add-modalias-to-uevent-for-ccw-devices.patch added to -mm tree
Message-ID: <20060306135017.GA18874@wavehammer.waldi.eu.org>
Mail-Followup-To: Cornelia Huck <cornelia.huck@de.ibm.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com
References: <200603060714.k267E6gN021778@shell0.pdx.osdl.net> <20060306110416.1e14933f@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <20060306110416.1e14933f@gondolin.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2006 at 11:04:16AM +0100, Cornelia Huck wrote:
> Hm, didn't see this on lkml, but the patch looks fine.

And it does not work as expected. The uevent includes "MODALIAS=3D" but
the rest got lost in the buffer as it used a wrong offset. The attached
patch makes that really working.

Bastian

--=20
Lots of people drink from the wrong bottle sometimes.
		-- Edith Keeler, "The City on the Edge of Forever",
		   stardate unknown

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=diff
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 3494bff..ea4652b 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -79,7 +79,7 @@ ccw_uevent (struct device *dev, char **e
 {
 	struct ccw_device *cdev =3D to_ccwdev(dev);
 	int i =3D 0;
-	int length =3D 0;
+	int length =3D 0, tmp_length =3D 0;
=20
 	if (!cdev)
 		return -ENODEV;
@@ -120,8 +120,8 @@ ccw_uevent (struct device *dev, char **e
 	buffer +=3D length;
=20
 	envp[i++] =3D buffer;
-	length +=3D scnprintf(buffer, buffer_size - length, "MODALIAS=3D");
-	length +=3D modalias_print(cdev, buffer + length, buffer_size - length);
+	length +=3D tmp_length =3D scnprintf(buffer, buffer_size - length, "MODAL=
IAS=3D");
+	length +=3D modalias_print(cdev, buffer + tmp_length, buffer_size - lengt=
h);
 	if ((buffer_size - length <=3D 0) || (i >=3D num_envp))
 		return -ENOMEM;
=20

--5vNYLRcllDrimb99--

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEARECAAYFAkQMPhkACgkQnw66O/MvCNHl7wCfY3pItGdckqdgDMbIV/2we8NK
VYsAn1omoEWGPlWhrhfWP5VuTU45hXAN
=yZA+
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
