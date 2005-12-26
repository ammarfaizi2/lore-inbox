Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVL0Bjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVL0Bjl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 20:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVL0Bjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 20:39:41 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:24733 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S932185AbVL0Bjk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 20:39:40 -0500
X-Sieve: CMU Sieve 2.2
Date: Mon, 26 Dec 2005 15:55:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jules Villard <jvillard@ens-lyon.fr>
Cc: linux-kernel@vger.org, Andrew Morton <akpm@osdl.org>,
       Dave Airlie <airlied@linux.ie>,
       Ben Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
In-Reply-To: <20051226194527.GA3036@blatterie>
Message-ID: <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org>
References: <20051226194527.GA3036@blatterie>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-800927175-1135641321=:14098"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-800927175-1135641321=:14098
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Mon, 26 Dec 2005, Jules Villard wrote:
> 
> Please find my .config and the lspci output attached (my graphic card
> is a AGP plugged ATI Radeon Mobility 7500 and I use the "radeon"
> driver from xorg).

Ok, from the sysrq-T stuff it _looks_ like X is just busy-looping in user 
space. So it's probably some disagreement between radeonfb and X.org

The fact that everything was ok in -rc5 would imply that it's likely one 
of the radeon aperture size issue patches.

> Investigating a bit further, I found out that resume is quite innocent
> about all this: what hangs X is switching from a vt to X.

I'm cc'ing BenH and DaveA, but in the meantime, while waiting for the 
professionals, can you try to revert the two attachments (revert "diff-1" 
first, try that, and revert "diff-2" after that if it didn't start 
working after the first revert).

Thanks,

		Linus
--21872808-800927175-1135641321=:14098
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=diff-1
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0512261555210.14098@g5.osdl.org>
Content-Description: 
Content-Disposition: attachment; filename=diff-1

ZGlmZi10cmVlIDI4MWFiMDMxYThjOWU1YjU5MzE0MmViNGVjNTlhODdmYWFl
ODY3NmEgKGZyb20gN2I2NjY2NTMwZTI3MzZmMTkwYTI2MjljOGFiZTM0Mjc1
MDU0NDQ5ZikNCkF1dGhvcjogQmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVu
aEBrZXJuZWwuY3Jhc2hpbmcub3JnPg0KRGF0ZTogICBGcmkgRGVjIDE2IDE2
OjUyOjIyIDIwMDUgKzExMDANCg0KICAgIFtQQVRDSF0gcmFkZW9uIGRybTog
Zml4IGFncCBhcGVydHVyZSBtYXAgb2Zmc2V0DQogICAgDQogICAgVGhpcyBm
aW5hbGx5IGZpeGVzIHRoZSByYWRlb24gbWVtb3J5IG1hcHBpbmcgYnVnIHRo
YXQgd2FzIGluY29ycmVjdGx5DQogICAgZml4ZWQgYnkgdGhlIHByZXZpb3Vz
IHBhdGNoLiAgVGhpcyB0aW1lLCB3ZSB1c2UgdGhlIGFjdHVhbCB2cmFtIHNp
emUgYXMNCiAgICB0aGUgc2l6ZSB0byBjYWxjdWxhdGUgaG93IGZhciB0byBt
b3ZlIHRoZSBBR1AgYXBlcnR1cmUgZnJvbSB0aGUNCiAgICBmcmFtZWJ1ZmZl
ciBpbiBjYXJkJ3MgbWVtb3J5IHNwYWNlLg0KICAgIA0KICAgIElmIHRoZXJl
IGFyZSBzdGlsbCBpc3N1ZXMgd2l0aCB0aGlzIHBhdGNoLCB0aGV5IGFyZSBk
dWUgdG8gYnVncyBpbiB0aGUgWA0KICAgIGRyaXZlciB0aGF0IEknbSB3b3Jr
aW5nIG9uIGZpeGluZyB0b28uDQogICAgDQogICAgU2lnbmVkLW9mZi1ieTog
QmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVuaEBrZXJuZWwuY3Jhc2hpbmcu
b3JnPg0KICAgIENjOiBNYXJrIE0uIEhvZmZtYW4gPG1ob2ZmbWFuQGxpZ2h0
bGluay5jb20+DQogICAgQ2M6IFBhdWwgTWFja2VycmFzIDxwYXVsdXNAc2Ft
YmEub3JnPg0KICAgIFNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0
b3J2YWxkc0Bvc2RsLm9yZz4NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hh
ci9kcm0vcmFkZW9uX2NwLmMgYi9kcml2ZXJzL2NoYXIvZHJtL3JhZGVvbl9j
cC5jDQppbmRleCA5ZjJiNGVmLi45NWFlOWUwIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9jaGFyL2RybS9yYWRlb25fY3AuYw0KKysrIGIvZHJpdmVycy9jaGFy
L2RybS9yYWRlb25fY3AuYw0KQEAgLTEzMTIsNiArMTMxMiw4IEBAIHN0YXRp
YyB2b2lkIHJhZGVvbl9zZXRfcGNpZ2FydChkcm1fcmFkZW8NCiBzdGF0aWMg
aW50IHJhZGVvbl9kb19pbml0X2NwKGRybV9kZXZpY2VfdCAqIGRldiwgZHJt
X3JhZGVvbl9pbml0X3QgKiBpbml0KQ0KIHsNCiAJZHJtX3JhZGVvbl9wcml2
YXRlX3QgKmRldl9wcml2ID0gZGV2LT5kZXZfcHJpdmF0ZTsNCisJdW5zaWdu
ZWQgaW50IG1lbV9zaXplOw0KKw0KIAlEUk1fREVCVUcoIlxuIik7DQogDQog
CWRldl9wcml2LT5pc19wY2kgPSBpbml0LT5pc19wY2k7DQpAQCAtMTUyMSw4
ICsxNTIzLDExIEBAIHN0YXRpYyBpbnQgcmFkZW9uX2RvX2luaXRfY3AoZHJt
X2RldmljZV8NCiAJCQkJCSAgKyBkZXZfcHJpdi0+ZmJfbG9jYXRpb24pID4+
IDEwKSk7DQogDQogCWRldl9wcml2LT5nYXJ0X3NpemUgPSBpbml0LT5nYXJ0
X3NpemU7DQotCWRldl9wcml2LT5nYXJ0X3ZtX3N0YXJ0ID0gZGV2X3ByaXYt
PmZiX2xvY2F0aW9uDQotCSAgICArIFJBREVPTl9SRUFEKFJBREVPTl9DT05G
SUdfQVBFUl9TSVpFKSAqIDI7DQorDQorCW1lbV9zaXplID0gUkFERU9OX1JF
QUQoUkFERU9OX0NPTkZJR19NRU1TSVpFKTsNCisJaWYgKG1lbV9zaXplID09
IDApDQorCQltZW1fc2l6ZSA9IDB4ODAwMDAwOw0KKwlkZXZfcHJpdi0+Z2Fy
dF92bV9zdGFydCA9IGRldl9wcml2LT5mYl9sb2NhdGlvbiArIG1lbV9zaXpl
Ow0KIA0KICNpZiBfX09TX0hBU19BR1ANCiAJaWYgKCFkZXZfcHJpdi0+aXNf
cGNpKQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9kcm0vcmFkZW9uX2Ry
di5oIGIvZHJpdmVycy9jaGFyL2RybS9yYWRlb25fZHJ2LmgNCmluZGV4IDdi
ZGE3ZTMuLmQ5MmNjZWUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NoYXIvZHJt
L3JhZGVvbl9kcnYuaA0KKysrIGIvZHJpdmVycy9jaGFyL2RybS9yYWRlb25f
ZHJ2LmgNCkBAIC0zNzksNiArMzc5LDcgQEAgZXh0ZXJuIGludCByMzAwX2Rv
X2NwX2NtZGJ1Zihkcm1fZGV2aWNlXw0KICMJZGVmaW5lIFJBREVPTl9QTExf
V1JfRU4JCQkoMSA8PCA3KQ0KICNkZWZpbmUgUkFERU9OX0NMT0NLX0NOVExf
SU5ERVgJCTB4MDAwOA0KICNkZWZpbmUgUkFERU9OX0NPTkZJR19BUEVSX1NJ
WkUJCTB4MDEwOA0KKyNkZWZpbmUgUkFERU9OX0NPTkZJR19NRU1TSVpFCQkw
eDAwZjgNCiAjZGVmaW5lIFJBREVPTl9DUlRDX09GRlNFVAkJMHgwMjI0DQog
I2RlZmluZSBSQURFT05fQ1JUQ19PRkZTRVRfQ05UTAkJMHgwMjI4DQogIwlk
ZWZpbmUgUkFERU9OX0NSVENfVElMRV9FTgkJKDEgPDwgMTUpDQo=

--21872808-800927175-1135641321=:14098
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=diff-2
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0512261555211.14098@g5.osdl.org>
Content-Description: 
Content-Disposition: attachment; filename=diff-2

ZGlmZi10cmVlIDQ3ODA3Y2UzODFhY2MzNGE3ZmZlZTJiNDJlMzVlOTZjMGYz
MjJlNTIgKGZyb20gMGU2NzA1MDY2NjhhNDNlMTM1NWI4ZjEwYzMzZDA4MWE2
NzZiZDUyMSkNCkF1dGhvcjogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+DQpEYXRlOiAgIFR1ZSBEZWMgMTMgMDQ6MTg6NDEgMjAwNSArMDAwMA0K
DQogICAgW2RybV0gZml4IHJhZGVvbiBhcGVydHVyZSBpc3N1ZQ0KICAgIA0K
ICAgIEJlbiBub3RpY2VkIHRoYXQgb24gY2VydGFpbiBjYXJkcyB3ZSd2ZSBs
YW5kZWQgdGhlIEFHUCBzcGFjZSBvbiB0b3Agb2YNCiAgICB0aGUgc2Vjb25k
IGFwZXJ0dXJlIGluc3RlYWQgb2YgYWZ0ZXIgaXQuLiAgV2hpY2ggbWVzc2Vz
IHRoaW5ncyB1cCBhIGxvdA0KICAgIG9uIHRob3NlIG1hY2hpbmVzLg0KICAg
IA0KICAgIFRoaXMganVzdCBtb3ZlcyB0aGUgZ2FydCBmdXJ0aGVyIG91dCwg
YSBtb3JlIGNvcnJlY3QgZml4IGlzIGluIHRoZSB3b3Jrcw0KICAgIGZyb20g
QmVuIGZvciBhZnRlciAyLjYuMTUuDQogICAgDQogICAgU2lnbmVkLW9mZi1i
eTogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+DQogICAgQ0M6IEJl
biBIZXJyZW5zY2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+DQog
ICAgU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQG9z
ZGwub3JnPg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL2RybS9yYWRl
b25fY3AuYyBiL2RyaXZlcnMvY2hhci9kcm0vcmFkZW9uX2NwLmMNCmluZGV4
IDAzODM5ZWEuLjlmMmI0ZWYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NoYXIv
ZHJtL3JhZGVvbl9jcC5jDQorKysgYi9kcml2ZXJzL2NoYXIvZHJtL3JhZGVv
bl9jcC5jDQpAQCAtMTUyMiw3ICsxNTIyLDcgQEAgc3RhdGljIGludCByYWRl
b25fZG9faW5pdF9jcChkcm1fZGV2aWNlXw0KIA0KIAlkZXZfcHJpdi0+Z2Fy
dF9zaXplID0gaW5pdC0+Z2FydF9zaXplOw0KIAlkZXZfcHJpdi0+Z2FydF92
bV9zdGFydCA9IGRldl9wcml2LT5mYl9sb2NhdGlvbg0KLQkgICAgKyBSQURF
T05fUkVBRChSQURFT05fQ09ORklHX0FQRVJfU0laRSk7DQorCSAgICArIFJB
REVPTl9SRUFEKFJBREVPTl9DT05GSUdfQVBFUl9TSVpFKSAqIDI7DQogDQog
I2lmIF9fT1NfSEFTX0FHUA0KIAlpZiAoIWRldl9wcml2LT5pc19wY2kpDQo=

--21872808-800927175-1135641321=:14098--
