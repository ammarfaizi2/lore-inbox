Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVATInS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVATInS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 03:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVATInS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 03:43:18 -0500
Received: from dea.vocord.ru ([217.67.177.50]:64706 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262078AbVATInF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 03:43:05 -0500
Subject: Re: kobject_uevent.c moved to kernel connector.
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050119230518.GA5569@kroah.com>
References: <1101286481.18807.66.camel@uganda>
	 <1101287606.18807.75.camel@uganda> <20041124222857.GG3584@kroah.com>
	 <1102504677.3363.55.camel@uganda> <20041221204101.GA9831@kroah.com>
	 <1103707272.3432.6.camel@uganda>
	 <20041225180241.38ffb9d8@zanzibar.2ka.mipt.ru>
	 <20050104060211.50c2bf47@zanzibar.2ka.mipt.ru>
	 <20050112190615.GC10885@kroah.com>
	 <20050113011519.6e087fb4@zanzibar.2ka.mipt.ru>
	 <20050119230518.GA5569@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-72KOgeQLzt26371oQaWu"
Organization: MIPT
Date: Thu, 20 Jan 2005 11:48:26 +0300
Message-Id: <1106210906.5264.46.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 20 Jan 2005 08:42:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-72KOgeQLzt26371oQaWu
Content-Type: multipart/mixed; boundary="=-jr2duQgflPUgiqAC7TEh"


--=-jr2duQgflPUgiqAC7TEh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-19 at 15:05 -0800, Greg KH wrote:
> On Thu, Jan 13, 2005 at 01:15:19AM +0300, Evgeniy Polyakov wrote:
> > --- include/linux/connector.h~	2005-01-13 00:21:55.000000000 +0300
> > +++ include/linux/connector.h	2005-01-13 00:53:21.000000000 +0300
> > @@ -24,6 +24,9 @@
> > =20
> >  #include <asm/types.h>
> > =20
> > +#define CONN_IDX_KOBJECT_UEVENT		0xabcd
> > +#define CONN_VAL_KOBJECT_UEVENT		0x0000
> > +
> >  #define CONNECTOR_MAX_MSG_SIZE 	1024
> > =20
> >  struct cb_id
> > --- linux-2.6/drivers/connector/connector.c.orig	2005-01-13 00:21:23.00=
0000000 +0300
> > +++ linux-2.6/drivers/connector/connector.c	2005-01-13 00:32:48.0000000=
00 +0300
> > @@ -46,6 +46,8 @@
> > =20
> >  static struct cn_dev cdev;
> > =20
> > +int cn_already_initialized =3D 0;
>=20
> <snip>
>=20
> Hm, this patch needs to be rediffed, now that I've accepted the
> connector code, right?  The connector.c change seems to already be in
> your last connector patch, and the .h change is there with a different
> #define spelling, causing the uevent code to need to be changed.
>=20
> Care to redo it?

Sure. Patch attached.=20

Thank you.

> thanks,
>=20
> greg k-h

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-jr2duQgflPUgiqAC7TEh
Content-Disposition: attachment; filename=kobject_connector.patch
Content-Type: text/x-patch; name=kobject_connector.patch; charset=KOI8-R
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi9saWIva29iamVjdF91ZXZlbnQuYy5vcmlnCTIwMDUtMDEtMTMgMDA6NDU6
NTUuMDAwMDAwMDAwICswMzAwDQorKysgbGludXgtMi42L2xpYi9rb2JqZWN0X3VldmVudC5jCTIw
MDUtMDEtMTMgMDA6MzQ6MDUuMDAwMDAwMDAwICswMzAwDQpAQCAtMTIsNiArMTIsNyBAQA0KICAq
CUtheSBTaWV2ZXJzCQk8a2F5LnNpZXZlcnNAdnJmeS5vcmc+DQogICoJQXJqYW4gdmFuIGRlIFZl
bgk8YXJqYW52QHJlZGhhdC5jb20+DQogICoJR3JlZyBLcm9haC1IYXJ0bWFuCTxncmVnQGtyb2Fo
LmNvbT4NCisgKglFdmdlbml5IFBvbHlha292IAk8am9obnBvbEAya2EubWlwdC5ydT4NCiAgKi8N
CiANCiAjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4NCkBAIC0yMSw2ICsyMiw3IEBADQogI2lu
Y2x1ZGUgPGxpbnV4L3N0cmluZy5oPg0KICNpbmNsdWRlIDxsaW51eC9rb2JqZWN0X3VldmVudC5o
Pg0KICNpbmNsdWRlIDxsaW51eC9rb2JqZWN0Lmg+DQorI2luY2x1ZGUgPGxpbnV4L2Nvbm5lY3Rv
ci5oPg0KICNpbmNsdWRlIDxuZXQvc29jay5oPg0KIA0KICNkZWZpbmUgQlVGRkVSX1NJWkUJMTAy
NAkvKiBidWZmZXIgZm9yIHRoZSBob3RwbHVnIGVudiAqLw0KQEAgLTUzLDYgKzU1LDY4IEBADQog
I2lmZGVmIENPTkZJR19LT0JKRUNUX1VFVkVOVA0KIHN0YXRpYyBzdHJ1Y3Qgc29jayAqdWV2ZW50
X3NvY2s7DQogDQorI2lmZGVmIENPTkZJR19DT05ORUNUT1INCitzdGF0aWMgc3RydWN0IGNiX2lk
IHVpZCA9IHtDTl9JRFhfS09CSkVDVF9VRVZFTlQsIENOX1ZBTF9LT0JKRUNUX1VFVkVOVH07DQor
c3RhdGljIHZvaWQga29iamVjdF91ZXZlbnRfY29ubmVjdG9yX2NhbGxiYWNrKHZvaWQgKmRhdGEp
DQorew0KK30NCisNCitzdGF0aWMgdm9pZCBrb2JqZWN0X3VldmVudF9zZW5kX2Nvbm5lY3Rvcihj
b25zdCBjaGFyICpzaWduYWwsIGNvbnN0IGNoYXIgKm9iaiwgY2hhciAqKmVudnAsIGludCBnZnBf
bWFzaykNCit7DQorCWlmIChjbl9hbHJlYWR5X2luaXRpYWxpemVkKSB7DQorCQlpbnQgc2l6ZTsN
CisJCXN0cnVjdCBjbl9tc2cgKm1zZzsNCisJCXN0YXRpYyBpbnQgdWV2ZW50X2Nvbm5lY3Rvcl9p
bml0aWFsaXplZDsNCisJCQ0KKwkJaWYgKCF1ZXZlbnRfY29ubmVjdG9yX2luaXRpYWxpemVkKSB7
DQorCQkJY25fYWRkX2NhbGxiYWNrKCZ1aWQsICJrb2JqZWN0X3VldmVudCIsIGtvYmplY3RfdWV2
ZW50X2Nvbm5lY3Rvcl9jYWxsYmFjayk7DQorCQkJdWV2ZW50X2Nvbm5lY3Rvcl9pbml0aWFsaXpl
ZCA9IDE7DQorCQl9DQorDQorDQorCQlzaXplID0gc3RybGVuKHNpZ25hbCkgKyBzdHJsZW4ob2Jq
KSArIDIgKyBCVUZGRVJfU0laRSArIHNpemVvZigqbXNnKTsNCisJCW1zZyA9IGttYWxsb2Moc2l6
ZSwgZ2ZwX21hc2spOw0KKwkJaWYgKG1zZykgew0KKwkJCXU4ICpwb3M7DQorCQkJaW50IGxlbjsN
CisNCisJCQltc2ctPmxlbiA9IHNpemUgLSBzaXplb2YoKm1zZyk7DQorDQorCQkJbWVtY3B5KCZt
c2ctPmlkLCAmdWlkLCBzaXplb2YobXNnLT5pZCkpOw0KKwkJCQ0KKwkJCXNpemUgLT0gc2l6ZW9m
KCptc2cpOw0KKw0KKwkJCXBvcyA9ICh1OCAqKShtc2cgKyAxKTsNCisJCQkNCisJCQlsZW4gPSBz
bnByaW50Zihwb3MsIHNpemUsICIlc0AlcyIsIHNpZ25hbCwgb2JqKTsNCisJCQlsZW4rKzsNCisJ
CQlzaXplIC09IGxlbjsNCisJCQlwb3MgKz0gbGVuOw0KKwkJCQ0KKwkJCWlmIChlbnZwKSB7DQor
CQkJCWludCBpOw0KKw0KKwkJCQlmb3IgKGkgPSAyOyBlbnZwW2ldOyBpKyspIHsNCisJCQkJCWxl
biA9IHN0cmxlbihlbnZwW2ldKSArIDE7DQorCQkJCQlzbnByaW50Zihwb3MsIHNpemUsICIlcyIs
IGVudnBbaV0pOw0KKwkJCQkJc2l6ZSAtPSBsZW47DQorCQkJCQlwb3MgKz0gbGVuOw0KKwkJCQl9
DQorCQkJfQ0KKw0KKwkJCWNuX25ldGxpbmtfc2VuZChtc2csIDApOw0KKw0KKwkJCWtmcmVlKG1z
Zyk7DQorCQl9DQorCX0NCit9DQorI2Vsc2UNCitzdGF0aWMgdm9pZCBrb2JqZWN0X3VldmVudF9z
ZW5kX2Nvbm5lY3Rvcihjb25zdCBjaGFyICpzaWduYWwsIGNvbnN0IGNoYXIgKm9iaiwgY2hhciAq
KmVudnAsIGludCBnZnBfbWFzaykNCit7DQorfQ0KKyNlbmRpZg0KKw0KKw0KIC8qKg0KICAqIHNl
bmRfdWV2ZW50IC0gbm90aWZ5IHVzZXJzcGFjZSBieSBzZW5kaW5nIGV2ZW50IHRyb3VnaCBuZXRs
aW5rIHNvY2tldA0KICAqDQpAQCAtOTMsNiArMTU3LDggQEANCiAJCX0NCiAJfQ0KIA0KKwlrb2Jq
ZWN0X3VldmVudF9zZW5kX2Nvbm5lY3RvcihzaWduYWwsIG9iaiwgZW52cCwgZ2ZwX21hc2spOw0K
Kw0KIAlyZXR1cm4gbmV0bGlua19icm9hZGNhc3QodWV2ZW50X3NvY2ssIHNrYiwgMCwgMSwgZ2Zw
X21hc2spOw0KIH0NCiANCg==


--=-jr2duQgflPUgiqAC7TEh--

--=-72KOgeQLzt26371oQaWu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB73BaIKTPhE+8wY0RAleoAJ4okdQL/ru8CFyV0g1DXYcEAdHGUACgixH/
CAV9Ewf0mRDXetb+U9rmF7s=
=P1tf
-----END PGP SIGNATURE-----

--=-72KOgeQLzt26371oQaWu--

