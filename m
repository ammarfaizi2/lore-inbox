Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVBGS6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVBGS6c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 13:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVBGS6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 13:58:31 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:18079 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261240AbVBGS5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 13:57:36 -0500
Subject: [PATCH] Filesystem linking protections
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-17S9+R1ZLjzhTNZoPY4G"
Date: Mon, 07 Feb 2005 19:57:06 +0100
Message-Id: <1107802626.3754.224.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-17S9+R1ZLjzhTNZoPY4G
Content-Type: multipart/mixed; boundary="=-QGHcKKnW7XXns99ul4SU"


--=-QGHcKKnW7XXns99ul4SU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

This patch adds two checks to do_follow_link() and sys_link(), for
prevent users to follow (untrusted) symlinks owned by other users in
world-writable +t directories (i.e. /tmp), unless the owner of the
symlink is the owner of the directory, users will also not be able to
hardlink to files they do not own.

The direct advantage of this pretty simple patch is that /tmp races will
be prevented.

Results reported by the Collision Regression Test Suite with patch
applied:
 (...)
 Symlink restrictions                     : Not vulnerable
 Hardlinking restrictions                 : Not vulnerable
 (...)
Results with patch *not applied*:
 (...)
 Symlink restrictions                     : Vulnerable
 Hardlinking restrictions                 : Vulnerable
 (...)

This patch is based on grSecurity linking protections, but first
implemented by the OpenWall patch.

I propose it's merging, as the overhead is *minimal* (if there's any
overhead), because the modified functions get called only once when
following a symlink or creating a hardlink.

The patch can be also downloaded from:
http://pearls.tuxedo-es.org/patches/linking-protections-2.6.11-rc3.patch

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]


--=-QGHcKKnW7XXns99ul4SU
Content-Disposition: attachment; filename=linking-protections-2.6.11-rc3.patch
Content-Type: text/x-patch; name=linking-protections-2.6.11-rc3.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: base64

ZGlmZiAtTnVyIGxpbnV4LTIuNi4xMS1yYzMvZnMvbmFtZWkuYyBsaW51eC0yLjYuMTEtcmMzLnNs
aW5rL2ZzL25hbWVpLmMNCi0tLSBsaW51eC0yLjYuMTEtcmMzL2ZzL25hbWVpLmMJMjAwNS0wMi0w
NiAyMTo0MDo0MS4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC0yLjYuMTEtcmMzLnNsaW5rL2Zz
L25hbWVpLmMJMjAwNS0wMi0wNyAxOToxNToyMi42OTA2ODkyNzIgKzAxMDANCkBAIC01MTksNiAr
NTE5LDE5IEBADQogCWVyciA9IHNlY3VyaXR5X2lub2RlX2ZvbGxvd19saW5rKGRlbnRyeSwgbmQp
Ow0KIAlpZiAoZXJyKQ0KIAkJZ290byBsb29wOw0KKw0KKwkvKiBQcmV2ZW50IHVzZXJzIHRvIGZv
bGxvdyBzeW1saW5rcyBvd25lZCBieSBvdGhlciB1c2VycyBpbg0KKwkgKiB3b3JsZC13cml0YWJs
ZSArdCBkaXJlY3RvcmllcywgdW5sZXNzIHRoZSBvd25lciBvZiB0aGUNCisJICogc3ltbGluayBp
cyB0aGUgb3duZXIgb2YgdGhlIGRpcmVjdG9yeS4NCisJICovDQorCWlmIChTX0lTTE5LKGRlbnRy
eS0+ZF9pbm9kZS0+aV9tb2RlKSAmJg0KKwkgICAgKGRlbnRyeS0+ZF9wYXJlbnQtPmRfaW5vZGUt
PmlfbW9kZSAmIFNfSVNWVFgpIA0KKwkgICAgJiYgKGRlbnRyeS0+ZF9wYXJlbnQtPmRfaW5vZGUt
PmlfdWlkICE9IGRlbnRyeS0+ZF9pbm9kZS0+aV91aWQpICYmDQorCSAgICAoZGVudHJ5LT5kX3Bh
cmVudC0+ZF9pbm9kZS0+aV9tb2RlICYgU19JV09USCkgJiYgKGN1cnJlbnQtPmZzdWlkICE9IGRl
bnRyeS0+ZF9pbm9kZS0+aV91aWQpKSB7DQorCQllcnIgPSAtRUFDQ0VTOw0KKwkJZ290byBsb29w
Ow0KKwl9DQorCQkJDQogCWN1cnJlbnQtPmxpbmtfY291bnQrKzsNCiAJY3VycmVudC0+dG90YWxf
bGlua19jb3VudCsrOw0KIAluZC0+ZGVwdGgrKzsNCkBAIC0xOTg1LDcgKzE5OTgsMjIgQEANCiAJ
bmV3X2RlbnRyeSA9IGxvb2t1cF9jcmVhdGUoJm5kLCAwKTsNCiAJZXJyb3IgPSBQVFJfRVJSKG5l
d19kZW50cnkpOw0KIAlpZiAoIUlTX0VSUihuZXdfZGVudHJ5KSkgew0KLQkJZXJyb3IgPSB2ZnNf
bGluayhvbGRfbmQuZGVudHJ5LCBuZC5kZW50cnktPmRfaW5vZGUsIG5ld19kZW50cnkpOw0KKwkJ
ZXJyb3IgPSAwOw0KKwkJDQorCQkvKiBDaGVjayB0aGF0IHRoZSB1c2VyIHdobyBpcyB0cnlpbmcg
dG8gbWFrZSB0aGUgaGFyZGxpbmsgb3ducw0KKwkJICogdGhlIHRhcmdldCBmaWxlIGJlaW5nIGxp
bmtlZCAoREFDLT5Ab2xkX25kLmRlbnRyeS0+ZF9pbm9kZSkgKi8NCisJCWlmIChjdXJyZW50LT5m
c3VpZCAhPSBvbGRfbmQuZGVudHJ5LT5kX2lub2RlLT5pX3VpZCAmJiANCisJCSghU19JU1JFRyhv
bGRfbmQuZGVudHJ5LT5kX2lub2RlLT5pX21vZGUpIHx8IChvbGRfbmQuZGVudHJ5LT5kX2lub2Rl
LT5pX21vZGUgJiBTX0lTVUlEKSB8fCANCisJCSgob2xkX25kLmRlbnRyeS0+ZF9pbm9kZS0+aV9t
b2RlICYgKFNfSVNHSUQgfCBTX0lYR1JQKSkgPT0gKFNfSVNHSUQgfCBTX0lYR1JQKSkgfHwNCisJ
ICAgICAJKGdlbmVyaWNfcGVybWlzc2lvbihvbGRfbmQuZGVudHJ5LT5kX2lub2RlLCBNQVlfUkVB
RCB8IE1BWV9XUklURSwgTlVMTCkpKSAmJg0KKwkgICAgCSFjYXBhYmxlKENBUF9GT1dORVIpICYm
IGN1cnJlbnQtPnVpZCkgew0KKwkJZXJyb3IgPSAtRVBFUk07DQorCQl9DQorCQkNCisJCS8qIElm
IEBlcnJvciBpcyBlbXB0eSwgdGhlbiB3ZSBhcHBseSB0aGUgKm5vcm1hbCogYmVoYXZpb3IgKi8N
CisJCWlmICghZXJyb3IpDQorCQkJZXJyb3IgPSB2ZnNfbGluayhvbGRfbmQuZGVudHJ5LCBuZC5k
ZW50cnktPmRfaW5vZGUsIG5ld19kZW50cnkpOw0KKwkJDQogCQlkcHV0KG5ld19kZW50cnkpOw0K
IAl9DQogCXVwKCZuZC5kZW50cnktPmRfaW5vZGUtPmlfc2VtKTsNCg==


--=-QGHcKKnW7XXns99ul4SU--

--=-17S9+R1ZLjzhTNZoPY4G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCB7oBDcEopW8rLewRAhCSAJ4hAqYKAxV1FyU0aEjj6lOKafJmRACfTHoq
HbaFZ1ZNEBpVS9+IVLe2qBs=
=q4UY
-----END PGP SIGNATURE-----

--=-17S9+R1ZLjzhTNZoPY4G--

