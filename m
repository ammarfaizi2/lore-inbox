Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269292AbUJKWdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269292AbUJKWdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUJKWdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:33:47 -0400
Received: from 60.Red-213-97-200.pooles.rima-tde.net ([213.97.200.60]:8320
	"EHLO marlow.intranet.hisitech.com") by vger.kernel.org with ESMTP
	id S269292AbUJKWc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:32:57 -0400
Subject: [PATCH] profiler fix for non-SMP linuk-2.4.6-rc4-mm1
From: Santiago Gala <sgala@hisitech.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-k1I2geoant1RA2shAe9P"
Organization: High Sierra Technology, SLU
Date: Tue, 12 Oct 2004 00:32:43 +0200
Message-Id: <1097533963.7198.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k1I2geoant1RA2shAe9P
Content-Type: multipart/mixed; boundary="=-Pk7btTa0zJyXIjSIbWJn"


--=-Pk7btTa0zJyXIjSIbWJn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I need the patches shown here, from J.A. Magall=C3=B3n, to have 2.6.9-rc4-m=
m1
running on my TiBook (but they are slightly wrong).
http://lkml.org/lkml/2004/10/11/111

Without this patches, I'm having one error like:

Oct 11 21:35:12 marlow Oops: kernel access of bad area, sig: 11 [#148]
Oct 11 21:35:12 marlow NIP: C001AA98 LR: C0016CBC SP: D7E97F10 REGS:
d7e97e60 TRAP: 0300    Not tainted
Oct 11 21:35:12 marlow MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
Oct 11 21:35:12 marlow DAR: 00015380, DSISR: 40000000
Oct 11 21:35:12 marlow TASK =3D dfece610[8077] 'apache2' THREAD:
d7e96000Last syscall: 156
Oct 11 21:35:12 marlow GPR00: 00015380 D7E97F10 DFECE610 00000002
000054E0 00000004 D7E97F18 0F8E0F7C
Oct 11 21:35:12 marlow GPR08: 00000000 00015380 000054E0 C0310000
82004422 1006B304 0FA29334 101A27A0
Oct 11 21:35:12 marlow GPR16: 0FA293B8 3003DDA0 101A2700 0FA293BC
FFFFF000 1016E178 0FA29328 0FA2B8BC
Oct 11 21:35:12 marlow GPR24: 101A2DC0 C00054E0 00000000 DFECE610
FFFFFFEA 101A2DC0 C03205B8 D7E97F10
Oct 11 21:35:12 marlow NIP [c001aa98] profile_hit+0x40/0x54
Oct 11 21:35:12 marlow LR [c0016cbc] setscheduler+0xf4/0x2b0
Oct 11 21:35:12 marlow Call trace:
Oct 11 21:35:12 marlow [c00054e0] ret_from_syscall+0x0/0x44

three times per second or so, though the kernel works enough to have me
shutting it down orderly. When I logged into gnome, the Oops was not
always in apache, but sometimes in nautilus or other apps.

The patch he sent does not work for non SMP configs (cut&paste error?)
The one I attach works for my laptop, while not changing the SMP part,
AFAIK.

This mm kernel is looking very stable, and I'll give it a try not
rebooting it till tomorrow or till I see some problems with my firewire
device (still giving problems for time to time here).

The patch is against rc4-mm1.

Regards
--=20
Santiago Gala <sgala@hisitech.com>
High Sierra Technology, SLU

--=-Pk7btTa0zJyXIjSIbWJn
Content-Disposition: attachment; filename=profiler.patch
Content-Type: text/x-patch; name=profiler.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi45LXJjNC1tbTEvaW5jbHVkZS9saW51eC9wcm9maWxlLmgJMjAwNC0xMC0x
MSAxOTo1MjowNC4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51eC0yLjYuOS1yYzQtbW0xLW1pbmUv
aW5jbHVkZS9saW51eC9wcm9maWxlLmgJMjAwNC0xMC0xMSAyMzoxNzowMS4wMDAwMDAwMDAgKzAy
MDANCkBAIC04LDYgKzgsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQogI2luY2x1ZGUg
PGxpbnV4L2NwdW1hc2suaD4NCiAjaW5jbHVkZSA8YXNtL2Vycm5vLmg+DQorI2luY2x1ZGUgPGFz
bS9hdG9taWMuaD4NCiANCiAjZGVmaW5lIENQVV9QUk9GSUxJTkcJMQ0KICNkZWZpbmUgU0NIRURf
UFJPRklMSU5HCTINCkBAIC0xNyw4ICsxOCw4IEBADQogDQogLyogaW5pdCBiYXNpYyBrZXJuZWwg
cHJvZmlsZXIgKi8NCiB2b2lkIF9faW5pdCBwcm9maWxlX2luaXQodm9pZCk7DQotdm9pZCBwcm9m
aWxlX3RpY2soaW50LCBzdHJ1Y3QgcHRfcmVncyAqKTsNCi12b2lkIHByb2ZpbGVfaGl0KGludCwg
dm9pZCAqKTsNCit2b2lkIEZBU1RDQUxMKF9fcHJvZmlsZV9oaXQodm9pZCAqKSk7DQorDQogI2lm
ZGVmIENPTkZJR19QUk9DX0ZTDQogdm9pZCBjcmVhdGVfcHJvZl9jcHVfbWFzayhzdHJ1Y3QgcHJv
Y19kaXJfZW50cnkgKik7DQogI2Vsc2UNCkBAIC0xMDEsNiArMTAyLDI2IEBADQogDQogI2VuZGlm
IC8qIENPTkZJR19QUk9GSUxJTkcgKi8NCiANCitzdGF0aWMgaW5saW5lIHZvaWQgcHJvZmlsZV9o
aXQoaW50IHR5cGUsIHZvaWQgKnBjKQ0KK3sNCisJZXh0ZXJuIGludCBwcm9mX29uOw0KKwlleHRl
cm4gYXRvbWljX3QgKnByb2ZfYnVmZmVyOw0KKw0KKwlpZiAocHJvZl9vbiA9PSB0eXBlICYmIHBy
b2ZfYnVmZmVyKQ0KKwkJX19wcm9maWxlX2hpdChwYyk7DQorfQ0KKw0KK3N0YXRpYyBpbmxpbmUg
dm9pZCBwcm9maWxlX3RpY2soaW50IHR5cGUsIHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KK3sNCisJ
ZXh0ZXJuIGNwdW1hc2tfdCBwcm9mX2NwdV9tYXNrOw0KKw0KKwlpZiAodHlwZSAhPSBDUFVfUFJP
RklMSU5HKQ0KKwkJcmV0dXJuOw0KKwlwcm9maWxlX2hvb2socmVncyk7DQorCWlmICghdXNlcl9t
b2RlKHJlZ3MpICYmIGNwdV9pc3NldChzbXBfcHJvY2Vzc29yX2lkKCksIHByb2ZfY3B1X21hc2sp
KQ0KKwkJcHJvZmlsZV9oaXQodHlwZSwgKHZvaWQgKilwcm9maWxlX3BjKHJlZ3MpKTsNCit9DQor
DQogI2VuZGlmIC8qIF9fS0VSTkVMX18gKi8NCiANCiAjZW5kaWYgLyogX0xJTlVYX1BST0ZJTEVf
SCAqLw0KLS0tIGxpbnV4LTIuNi45LXJjNC1tbTEva2VybmVsL3Byb2ZpbGUuYwkyMDA0LTEwLTEx
IDE5OjU0OjM1LjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4LTIuNi45LXJjNC1tbTEtbWluZS9r
ZXJuZWwvcHJvZmlsZS5jCTIwMDQtMTAtMTEgMjM6MzQ6MTkuMDAwMDAwMDAwICswMjAwDQpAQCAt
MzQsMTAgKzM0LDEwIEBADQogI2RlZmluZSBOUl9QUk9GSUxFX0hJVAkJKFBBR0VfU0laRS9zaXpl
b2Yoc3RydWN0IHByb2ZpbGVfaGl0KSkNCiAjZGVmaW5lIE5SX1BST0ZJTEVfR1JQCQkoTlJfUFJP
RklMRV9ISVQvUFJPRklMRV9HUlBTWikNCiANCi1zdGF0aWMgYXRvbWljX3QgKnByb2ZfYnVmZmVy
Ow0KK2F0b21pY190ICpwcm9mX2J1ZmZlcjsNCiBzdGF0aWMgdW5zaWduZWQgbG9uZyBwcm9mX2xl
biwgcHJvZl9zaGlmdDsNCi1zdGF0aWMgaW50IHByb2Zfb247DQotc3RhdGljIGNwdW1hc2tfdCBw
cm9mX2NwdV9tYXNrID0gQ1BVX01BU0tfQUxMOw0KK2ludCBwcm9mX29uOw0KK2NwdW1hc2tfdCBw
cm9mX2NwdV9tYXNrID0gQ1BVX01BU0tfQUxMOw0KICNpZmRlZiBDT05GSUdfU01QDQogc3RhdGlj
IERFRklORV9QRVJfQ1BVKHN0cnVjdCBwcm9maWxlX2hpdCAqWzJdLCBjcHVfcHJvZmlsZV9oaXRz
KTsNCiBzdGF0aWMgREVGSU5FX1BFUl9DUFUoaW50LCBjcHVfcHJvZmlsZV9mbGlwKTsNCkBAIC0y
ODQsMTQgKzI4NCwxMiBAQA0KIAl1cCgmcHJvZmlsZV9mbGlwX211dGV4KTsNCiB9DQogDQotdm9p
ZCBwcm9maWxlX2hpdChpbnQgdHlwZSwgdm9pZCAqX19wYykNCit2b2lkIGZhc3RjYWxsIF9fcHJv
ZmlsZV9oaXQodm9pZCAqX19wYykNCiB7DQogCXVuc2lnbmVkIGxvbmcgcHJpbWFyeSwgc2Vjb25k
YXJ5LCBmbGFncywgcGMgPSAodW5zaWduZWQgbG9uZylfX3BjOw0KIAlpbnQgaSwgaiwgY3B1Ow0K
IAlzdHJ1Y3QgcHJvZmlsZV9oaXQgKmhpdHM7DQogDQotCWlmIChwcm9mX29uICE9IHR5cGUgfHwg
IXByb2ZfYnVmZmVyKQ0KLQkJcmV0dXJuOw0KIAlwYyA9IG1pbigocGMgLSAodW5zaWduZWQgbG9u
Zylfc3RleHQpID4+IHByb2Zfc2hpZnQsIHByb2ZfbGVuIC0gMSk7DQogCWkgPSBwcmltYXJ5ID0g
KHBjICYgKE5SX1BST0ZJTEVfR1JQIC0gMSkpIDw8IFBST0ZJTEVfR1JQU0hJRlQ7DQogCXNlY29u
ZGFyeSA9ICh+KHBjIDw8IDEpICYgKE5SX1BST0ZJTEVfR1JQIC0gMSkpIDw8IFBST0ZJTEVfR1JQ
U0hJRlQ7DQpAQCAtMzgwLDI2ICszNzgsMTUgQEANCiAjZWxzZSAvKiAhQ09ORklHX1NNUCAqLw0K
ICNkZWZpbmUgcHJvZmlsZV9mbGlwX2J1ZmZlcnMoKQkJZG8geyB9IHdoaWxlICgwKQ0KICNkZWZp
bmUgcHJvZmlsZV9kaXNjYXJkX2ZsaXBfYnVmZmVycygpCWRvIHsgfSB3aGlsZSAoMCkNCi0NCi1p
bmxpbmUgdm9pZCBwcm9maWxlX2hpdChpbnQgdHlwZSwgdm9pZCAqX19wYykNCi17DQotCXVuc2ln
bmVkIGxvbmcgcGM7DQotDQordm9pZCBfX3Byb2ZpbGVfaGl0KHZvaWQgKl9fcGMpDQorIHsNCisg
IAl1bnNpZ25lZCBsb25nIHBjOw0KKwkgDQogCXBjID0gKCh1bnNpZ25lZCBsb25nKV9fcGMgLSAo
dW5zaWduZWQgbG9uZylfc3RleHQpID4+IHByb2Zfc2hpZnQ7DQogCWF0b21pY19pbmMoJnByb2Zf
YnVmZmVyW21pbihwYywgcHJvZl9sZW4gLSAxKV0pOw0KLX0NCisgfQ0KICNlbmRpZiAvKiAhQ09O
RklHX1NNUCAqLw0KIA0KLXZvaWQgcHJvZmlsZV90aWNrKGludCB0eXBlLCBzdHJ1Y3QgcHRfcmVn
cyAqcmVncykNCi17DQotCWlmICh0eXBlID09IENQVV9QUk9GSUxJTkcpDQotCQlwcm9maWxlX2hv
b2socmVncyk7DQotCWlmIChwcm9mX29uICE9IHR5cGUgfHwgIXByb2ZfYnVmZmVyKQ0KLQkJcmV0
dXJuOw0KLQlpZiAoIXVzZXJfbW9kZShyZWdzKSAmJiBjcHVfaXNzZXQoc21wX3Byb2Nlc3Nvcl9p
ZCgpLCBwcm9mX2NwdV9tYXNrKSkNCi0JCXByb2ZpbGVfaGl0KHR5cGUsICh2b2lkICopcHJvZmls
ZV9wYyhyZWdzKSk7DQotfQ0KLQ0KICNpZmRlZiBDT05GSUdfUFJPQ19GUw0KICNpbmNsdWRlIDxs
aW51eC9wcm9jX2ZzLmg+DQogI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+DQo=


--=-Pk7btTa0zJyXIjSIbWJn--

--=-k1I2geoant1RA2shAe9P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBawoLMGY6e0B83Y0RAsj7AKDE/y5jQulk+a6kWx/XuvnVcQO+FwCdGmoy
MrgCS7v3KqGXR+vNtMfPx70=
=0F1Q
-----END PGP SIGNATURE-----

--=-k1I2geoant1RA2shAe9P--

