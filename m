Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTICUyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264462AbTICUyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:54:52 -0400
Received: from [165.165.196.100] ([165.165.196.100]:51946 "EHLO nosferatu.lan")
	by vger.kernel.org with ESMTP id S264456AbTICUyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:54:50 -0400
Subject: [PATCH 2.6] Fix conversion from milli volts in store_in_reg() for
	w83781d.c
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Greg KH <greg@kroah.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
In-Reply-To: <20030616184149.GC25585@kroah.com>
References: <3ED8067E.1050503@paradyne.com>
	 <20030601143808.GA30177@earth.solarsys.private>
	 <20030602172040.GC4992@kroah.com>
	 <20030605023922.GA8943@earth.solarsys.private>
	 <20030605194734.GA6238@kroah.com>
	 <1055136870.5280.196.camel@workshop.saharacpt.lan>
	 <20030610054107.GA22719@earth.solarsys.private>
	 <1055401021.5280.3143.camel@workshop.saharacpt.lan>
	 <20030613023651.GA1401@earth.solarsys.private>
	 <1055571995.12868.5.camel@nosferatu.lan> <20030616184149.GC25585@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gMznR/U9KbmxIv+fiLqy"
Message-Id: <1062622452.5275.38.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 22:54:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gMznR/U9KbmxIv+fiLqy
Content-Type: multipart/mixed; boundary="=-Z81tH3ml32m7pkZtYya3"


--=-Z81tH3ml32m7pkZtYya3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

I am not sure if it was a later patch from me that fixed in_* to display
milli volts in sysfs, or if it was a patch from Jan Dittmer, but the
conversion in the store_in_*() functions is wrong, and cause something
like:

----------------------------
nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
3632
nosferatu patch # echo '3700' > /sys/bus/i2c/devices/1-0290/in_max2
nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
400
nosferatu patch # echo '3640' > /sys/bus/i2c/devices/1-0290/in_max2
nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
400
nosferatu patch # echo '3632' > /sys/bus/i2c/devices/1-0290/in_max2
nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
400
nosferatu patch #
-----------------------------

I think Andrey also noticed this (if I did not smoke too much Weedbix
this morning ;) - if so, please verify that this fixes it ... it does
here at least.

Anyhow, patch is attached and should apply to 2.6.0-test4-bk5.


Regards,

--=20

Martin Schlemmer




--=-Z81tH3ml32m7pkZtYya3
Content-Disposition: attachment; filename=w83781d-fixup-in_store.patch
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=w83781d-fixup-in_store.patch; charset=ISO-8859-1

LS0tIDEvZHJpdmVycy9pMmMvY2hpcHMvdzgzNzgxZC5jCTIwMDMtMDktMDMgMjI6NDI6MDIuMTk5
MTY1Mjk2ICswMjAwDQorKysgMi9kcml2ZXJzL2kyYy9jaGlwcy93ODM3ODFkLmMJMjAwMy0wOS0w
MyAyMjozNTowMi4zNzg5ODc2NjQgKzAyMDANCkBAIC0zNzgsOCArMzc4LDggQEAgc3RhdGljIHNz
aXplX3Qgc3RvcmVfaW5fIyNyZWcgKHN0cnVjdCBkZQ0KIAlzdHJ1Y3QgdzgzNzgxZF9kYXRhICpk
YXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7IFwNCiAJdTMyIHZhbDsgXA0KIAkgXA0K
LQl2YWwgPSBzaW1wbGVfc3RydG91bChidWYsIE5VTEwsIDEwKTsgXA0KLQlkYXRhLT5pbl8jI3Jl
Z1tucl0gPSAoSU5fVE9fUkVHKHZhbCkgLyAxMCk7IFwNCisJdmFsID0gc2ltcGxlX3N0cnRvdWwo
YnVmLCBOVUxMLCAxMCkgLyAxMDsgXA0KKwlkYXRhLT5pbl8jI3JlZ1tucl0gPSBJTl9UT19SRUco
dmFsKTsgXA0KIAl3ODM3ODFkX3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNzgxRF9SRUdfSU5fIyNS
RUcobnIpLCBkYXRhLT5pbl8jI3JlZ1tucl0pOyBcDQogCSBcDQogCXJldHVybiBjb3VudDsgXA0K


--=-Z81tH3ml32m7pkZtYya3--

--=-gMznR/U9KbmxIv+fiLqy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/VlT0qburzKaJYLYRAuXGAJ4xm35gn9auuFHwidGyNWtybgm4BQCfZC17
r7h/IdUcP9zfvPIa3LWQAxA=
=cbQ8
-----END PGP SIGNATURE-----

--=-gMznR/U9KbmxIv+fiLqy--

