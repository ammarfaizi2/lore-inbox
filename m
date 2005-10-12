Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVJLT0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVJLT0u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 15:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVJLT0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 15:26:50 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:3772 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1750745AbVJLT0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 15:26:50 -0400
Date: Wed, 12 Oct 2005 21:26:39 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, torvalds@osdl.org,
       akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.14-rc4-git] s390, ccw - export modalias
Message-ID: <20051012192639.GA25481@wavehammer.waldi.eu.org>
Mail-Followup-To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch exports modalias for ccw devices.

Signed-off-by: Bastian Blank <waldi@debian.org>

---

 drivers/s390/cio/device.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -252,6 +252,23 @@ cutype_show (struct device *dev, struct=20
 }
=20
 static ssize_t
+modalias_show (struct device *dev, struct device_attribute *attr, char *bu=
f)
+{
+	struct ccw_device *cdev =3D to_ccwdev(dev);
+	struct ccw_device_id *id =3D &(cdev->id);
+	int ret;
+
+	ret =3D sprintf(buf, "ccw:t%04Xm%02x",
+			id->cu_type, id->cu_model);
+	if (id->dev_type !=3D 0)
+		ret +=3D sprintf(buf + ret, "dt%04Xdm%02X\n",
+				id->dev_type, id->dev_model);
+	else
+		ret +=3D sprintf(buf + ret, "dtdm\n");
+	return ret;
+}
+
+static ssize_t
 online_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct ccw_device *cdev =3D to_ccwdev(dev);
@@ -448,6 +465,7 @@ static DEVICE_ATTR(chpids, 0444, chpids_
 static DEVICE_ATTR(pimpampom, 0444, pimpampom_show, NULL);
 static DEVICE_ATTR(devtype, 0444, devtype_show, NULL);
 static DEVICE_ATTR(cutype, 0444, cutype_show, NULL);
+static DEVICE_ATTR(modalias, 0444, modalias_show, NULL);
 static DEVICE_ATTR(online, 0644, online_show, online_store);
 extern struct device_attribute dev_attr_cmb_enable;
 static DEVICE_ATTR(availability, 0444, available_show, NULL);
@@ -471,6 +489,7 @@ subchannel_add_files (struct device *dev
 static struct attribute * ccwdev_attrs[] =3D {
 	&dev_attr_devtype.attr,
 	&dev_attr_cutype.attr,
+	&dev_attr_modalias.attr,
 	&dev_attr_online.attr,
 	&dev_attr_cmb_enable.attr,
 	&dev_attr_availability.attr,

--=20
Spock: The odds of surviving another attack are 13562190123 to 1, Captain.

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEARECAAYFAkNNY28ACgkQnw66O/MvCNHP5gCfcAVL99Pel6aovnJwIs2+tmZ4
tlAAnjjPxXabGJ0o4yHRJXK4yv1hVdbb
=q8fJ
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
