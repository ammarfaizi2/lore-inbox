Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbTLVFtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 00:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbTLVFtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 00:49:07 -0500
Received: from zero.voxel.net ([209.123.232.253]:8148 "EHLO zero.voxel.net")
	by vger.kernel.org with ESMTP id S264310AbTLVFtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 00:49:03 -0500
Subject: [PATCH] CONFIG_PCMCIA_PROBE fix
From: Andres Salomon <dilinger@voxel.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PXoIkaBXQKzpIA6NFH81"
Message-Id: <1072072123.27831.6.camel@spiral.internal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Dec 2003 00:48:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PXoIkaBXQKzpIA6NFH81
Content-Type: multipart/mixed; boundary="=-oTLQBMh64P3BjhxO/X9c"


--=-oTLQBMh64P3BjhxO/X9c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Some time ago, Russell King submitted a patch to use CONFIG_PCMCIA_PROBE
instead of CONFIG_ISA in pcmcia probing code.  Unfortunately,
CONFIG_PCMCIA_PROBE still is only set if CONFIG_ISA is set.  This means
that if ISA isn't enabled, certain things break in 2.6; for example, my
pcmcia nic/modem (using pcnet_cs/serial_cs).  These worked fine in 2.4;
I tracked the behavior to the fact that if irq_mask is set on a pcmcia
socket (instead of pci_irq), and PCMCIA_PROBE isn't set,
pcmcia_request_irq refuses to assign an irq.  Most of the pcmcia bridges
appear to set an irq_mask, so the attached patch changes Kconfig to set
CONFIG_PCMCIA_PROBE if any of those bridges are selected.

Please apply this (or an alternative fix), as it fixes a 2.6 regression
in pcmcia functionality.


--=-oTLQBMh64P3BjhxO/X9c
Content-Disposition: attachment; filename=000-pcmcia_probe.patch
Content-Type: text/x-patch; name=000-pcmcia_probe.patch; charset=us-ascii
Content-Transfer-Encoding: base64

UmV2aXNpb246IGxpbnV4LS1tYWlubGluZS0tMi42LS1wYXRjaC0yDQpBcmNoaXZlOiBkaWxpbmdl
ckB2b3hlbC5uZXQtLTIwMDMtc3BpcmFsDQpDcmVhdG9yOiBBbmRyZXMgU2Fsb21vbiA8ZGlsaW5n
ZXJAdm94ZWwubmV0Pg0KRGF0ZTogU3VuIERlYyAyMSAwMzowNToyNyBFU1QgMjAwMw0KU3RhbmRh
cmQtZGF0ZTogMjAwMy0xMi0yMSAwODowNToyNyBHTVQNCk1vZGlmaWVkLWZpbGVzOiBkcml2ZXJz
L3BjbWNpYS9LY29uZmlnDQpOZXctcGF0Y2hlczogZGlsaW5nZXJAdm94ZWwubmV0LS0yMDAzLXNw
aXJhbC9saW51eC0tbWFpbmxpbmUtLTIuNi0tcGF0Y2gtMg0KU3VtbWFyeTogRW5hYmxlIFBDTUNJ
QV9QUk9CRSBvbiBwY21jaWEgYnJpZGdlcw0KS2V5d29yZHM6IA0KDQpDdXJyZW50IGJlaGF2aW9y
IG9ubHkgZW5hYmxlcyBDT05GSUdfUENNQ0lBX1BST0JFIGlmIENPTkZJR19JU0EgaXMgc2V0LiAg
U29tZQ0KYnJpZGdlcyAoZm9yIGV4YW1wbGUsIHllbnRhKSBicmVhayBiYWRseSB3L291dCBQQ01D
SUFfUFJPQkU7IHcvb3V0IGl0LA0KcGNtY2lhX3JlcXVlc3RfaXJxKCkgZmFpbHMgaWYgYW4gaXJx
X21hc2sgaXMgc2V0LiAgVGhlIGlkZWEgaXMgdG8gZGVjb3VwbGUNCkNPTkZJR19JU0EgZnJvbSBD
T05GSUdfUENNQ0lBX1BST0JFOyBzbywgd2hhdCBJJ3ZlIGRvbmUgaXMgdG8gZW5hYmxlDQpQQ01D
SUFfUFJPQkUgZm9yIGJyaWRnZXMgdGhhdCBzZXQgaXJxX21hc2tzIGZvciB0aGVpciBzb2NrZXRz
Lg0KDQoqIGFkZGVkIGZpbGVzDQoNCiAgICB7YXJjaH0vbGludXgvbGludXgtLW1haW5saW5lL2xp
bnV4LS1tYWlubGluZS0tMi42L2RpbGluZ2VyQHZveGVsLm5ldC0tMjAwMy1zcGlyYWwvcGF0Y2gt
bG9nL3BhdGNoLTINCg0KKiBtb2RpZmllZCBmaWxlcw0KDQotLS0gb3JpZy9kcml2ZXJzL3BjbWNp
YS9LY29uZmlnDQorKysgbW9kL2RyaXZlcnMvcGNtY2lhL0tjb25maWcNCkBAIC0xMDMsNyArMTAz
LDcgQEANCiANCiBjb25maWcgUENNQ0lBX1BST0JFDQogCWJvb2wNCi0JZGVmYXVsdCB5IGlmIElT
QSAmJiAhQVJDSF9TQTExMDAgJiYgIUFSQ0hfQ0xQUzcxMVgNCisJZGVmYXVsdCB5IGlmICFBUkNI
X1NBMTEwMCAmJiAhQVJDSF9DTFBTNzExWCAmJiAoSVNBIHx8IFlFTlRBIHx8IFRDSUMgfHwgSEQ2
NDQ2NV9QQ01DSUEgfHwgSTgyMzY1KQ0KIA0KIGVuZG1lbnUNCiANCg0KDQoNCg==

--=-oTLQBMh64P3BjhxO/X9c--

--=-PXoIkaBXQKzpIA6NFH81
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/5oW678o9R9NraMQRAinQAKCKQMe4735qtfqw4TpD0CS/amPFwQCfRuOY
kp3beE8Wq2sbmQIuaVJsFTc=
=HNmD
-----END PGP SIGNATURE-----

--=-PXoIkaBXQKzpIA6NFH81--

