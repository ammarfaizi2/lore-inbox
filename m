Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312802AbSCVTBZ>; Fri, 22 Mar 2002 14:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312803AbSCVTBQ>; Fri, 22 Mar 2002 14:01:16 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:43840 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S312802AbSCVTBA>;
	Fri, 22 Mar 2002 14:01:00 -0500
Date: Fri, 22 Mar 2002 19:05:17 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: [patch] fix two panics in microcode driver
In-Reply-To: <Pine.LNX.4.33.0202281653410.1220-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.33.0203221842000.1089-200000@einstein.homenet>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811838-856038803-1016822684=:1089"
Content-ID: <Pine.LNX.4.33.0203221845150.1089@einstein.homenet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811838-856038803-1016822684=:1089
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0203221845151.1089@einstein.homenet>

Hi Marcelo,

When writing too little (0) or too much (>num_physpages) of microcode data
to the driver it will panic because of passing illegal size request to
vmalloc() (which has an explicit BUG() on these).

Fix is attached.

Regards,
Tigran



---1463811838-856038803-1016822684=:1089
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="mc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0203221844440.1089@einstein.homenet>
Content-Description: mc.patch
Content-Disposition: ATTACHMENT; FILENAME="mc.patch"

LS0tIGFyY2gvaTM4Ni9rZXJuZWwvbWljcm9jb2RlLmMuMAlGcmkgTWFyIDIy
IDE4OjIyOjEyIDIwMDINCisrKyBhcmNoL2kzODYva2VybmVsL21pY3JvY29k
ZS5jCUZyaSBNYXIgMjIgMTg6Mjc6MDMgMjAwMg0KQEAgLTU1LDYgKzU1LDgg
QEANCiAgKgkJVGlncmFuIEFpdmF6aWFuIDx0aWdyYW5AdmVyaXRhcy5jb20+
LA0KICAqCQlTZXJpYWxpemUgdXBkYXRlcyBhcyByZXF1aXJlZCBvbiBIVCBw
cm9jZXNzb3JzIGR1ZSB0byBzcGVjdWxhdGl2ZQ0KICAqCQluYXR1cmUgb2Yg
aW1wbGVtZW50YXRpb24uDQorICoJMS4xMQkyMiBNYXIgMjAwMSBUaWdyYW4g
QWl2YXppYW4gPHRpZ3JhbkB2ZXJpdGFzLmNvbT4NCisgKgkJRml4IHRoZSBw
YW5pYyB3aGVuIHdyaXRpbmcgemVyby1sZW5ndGggbWljcm9jb2RlIGNodW5r
Lg0KICAqLw0KIA0KICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQpAQCAtNzMs
NyArNzUsNyBAQA0KIA0KIHN0YXRpYyBzcGlubG9ja190IG1pY3JvY29kZV91
cGRhdGVfbG9jayA9IFNQSU5fTE9DS19VTkxPQ0tFRDsNCiANCi0jZGVmaW5l
IE1JQ1JPQ09ERV9WRVJTSU9OIAkiMS4xMCINCisjZGVmaW5lIE1JQ1JPQ09E
RV9WRVJTSU9OIAkiMS4xMSINCiANCiBNT0RVTEVfREVTQ1JJUFRJT04oIklu
dGVsIENQVSAoSUEtMzIpIG1pY3JvY29kZSB1cGRhdGUgZHJpdmVyIik7DQog
TU9EVUxFX0FVVEhPUigiVGlncmFuIEFpdmF6aWFuIDx0aWdyYW5AdmVyaXRh
cy5jb20+Iik7DQpAQCAtMzMwLDkgKzMzMiwxMyBAQA0KIHsNCiAJc3NpemVf
dCByZXQ7DQogDQotCWlmIChsZW4gJSBzaXplb2Yoc3RydWN0IG1pY3JvY29k
ZSkgIT0gMCkgew0KKwlpZiAoIWxlbiB8fCBsZW4gJSBzaXplb2Yoc3RydWN0
IG1pY3JvY29kZSkgIT0gMCkgew0KIAkJcHJpbnRrKEtFUk5fRVJSICJtaWNy
b2NvZGU6IGNhbiBvbmx5IHdyaXRlIGluIE4qJWQgYnl0ZXMgdW5pdHNcbiIs
IA0KIAkJCXNpemVvZihzdHJ1Y3QgbWljcm9jb2RlKSk7DQorCQlyZXR1cm4g
LUVJTlZBTDsNCisJfQ0KKwlpZiAoKGxlbiA+PiBQQUdFX1NISUZUKSA+IG51
bV9waHlzcGFnZXMpIHsNCisJCXByaW50ayhLRVJOX0VSUiAibWljcm9jb2Rl
OiB0b28gbXVjaCBkYXRhIChtYXggJWQgcGFnZXMpXG4iLCBudW1fcGh5c3Bh
Z2VzKTsNCiAJCXJldHVybiAtRUlOVkFMOw0KIAl9DQogCWRvd25fd3JpdGUo
Jm1pY3JvY29kZV9yd3NlbSk7DQo=
---1463811838-856038803-1016822684=:1089--
