Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285399AbRLGTAy>; Fri, 7 Dec 2001 14:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285417AbRLGTAo>; Fri, 7 Dec 2001 14:00:44 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:40865 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S285399AbRLGTAd>;
	Fri, 7 Dec 2001 14:00:33 -0500
Date: Fri, 7 Dec 2001 14:00:32 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@transmeta.com>, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Athlon bug stomper UPDATE (as per VIA's Windows patch)
Message-ID: <Pine.LNX.4.30.0112071352040.8124-300000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-74666095-1768302542-1007751632=:8124"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---74666095-1768302542-1007751632=:8124
Content-Type: TEXT/PLAIN; charset=US-ASCII


This patch detects the 0305, 3099, 3102, and 3112 (KT133x, KT266x, VT8662,
and KLE133) *only*. On these chipsets, it will patch register 55 in the
Northbridge and turn off bits: 5, 6, AND 7.  (It does this to register 95
on the KT266x Northbridge). This will supposedly switch off a Memory Write
Queue timer, which can cause those infinite loop bugs and other assorted
crashes.  This patch works just like a similar patch that VIA recently
released for Windows machines.


The difference between this patch and the original athlon bug stomper is
that it is expanded to recognize more chipsets and also does a special
case for the KT266x chipset.

The attached patch is similar to one already submitted to the mailing
list, except I think it's a bit more elegant as it doesn't create a whole
new function for stomping the kt266 register 95, but rather instead used
the existing athlon bug stomper function in pci-pc.c and simply overloads
its functionality. (More efficient in that it has fewer lines and less
generated binary code).


I tested this patch on my KT266 motherboard and it seems to work
correctly.  Essentially no harm can be done by this patch, as most of the
time those registers have those bits turned off anyway.  Only some BIOS's
set those bits incorrectly and thus can cause problems.

-Calin



---74666095-1768302542-1007751632=:8124
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=README
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0112071400320.8124@rtlab.med.cornell.edu>
Content-Description: 
Content-Disposition: attachment; filename=README

VGhpcyBwYXRjaCBkZXRlY3RzIHRoZSAwMzA1LCAzMDk5LCAzMTAyLCBhbmQg
MzExMiAoS1QxMzN4LCBLVDI2NngsIFZUODY2MiwNCmFuZCBLTEUxMzMpICpv
bmx5Ki4gT24gdGhlc2UgY2hpcHNldHMsIGl0IHdpbGwgcGF0Y2ggcmVnaXN0
ZXIgNTUgaW4gdGhlDQpOb3J0aGJyaWRnZSBhbmQgdHVybiBvZmYgYml0czog
NSwgNiwgQU5EIDcuICAoSXQgZG9lcyB0aGlzIHRvIHJlZ2lzdGVyIDk1DQpv
biB0aGUgS1QyNjZ4IE5vcnRoYnJpZGdlKS4gVGhpcyB3aWxsIHN1cHBvc2Vk
bHkgc3dpdGNoIG9mZiBhIE1lbW9yeSBXcml0ZQ0KUXVldWUgdGltZXIsIHdo
aWNoIGNhbiBjYXVzZSB0aG9zZSBpbmZpbml0ZSBsb29wIGJ1Z3MgYW5kIG90
aGVyIGFzc29ydGVkDQpjcmFzaGVzLg0KDQpDYWxpbiBDdWxpYW51DQpjYWxp
bkBydGxhYi5vcmcNCg==
---74666095-1768302542-1007751632=:8124
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="athlon_bug_stomper_new_2_4_16.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0112071400321.8124@rtlab.med.cornell.edu>
Content-Description: The athlong bug stomper patch
Content-Disposition: attachment; filename="athlon_bug_stomper_new_2_4_16.patch"

ZGlmZiAtdSAtciB2YW5pbGxhL2FyY2gvaTM4Ni9rZXJuZWwvcGNpLXBjLmMg
cGF0Y2hlZC9hcmNoL2kzODYva2VybmVsL3BjaS1wYy5jDQotLS0gdmFuaWxs
YS9hcmNoL2kzODYva2VybmVsL3BjaS1wYy5jCUZyaSBOb3YgIDkgMTY6NTg6
MDIgMjAwMQ0KKysrIHBhdGNoZWQvYXJjaC9pMzg2L2tlcm5lbC9wY2ktcGMu
YwlUaHUgRGVjICA2IDE5OjAzOjAzIDIwMDENCkBAIC0xMTE0LDE3ICsxMTE0
LDI2IEBADQogICogQnV0IGl0IGRvZXMgc2VlbSB0byBmaXggc29tZSB1bnNw
ZWNpZmllZCBwcm9ibGVtDQogICogd2l0aCAnbW92bnRxJyBjb3BpZXMgb24g
QXRobG9ucy4NCiAgKg0KLSAqIFZJQSA4MzYzIGNoaXBzZXQ6DQotICogIC0g
Yml0IDcgYXQgb2Zmc2V0IDB4NTU6IERlYnVnIChSVykNCisgKiBWSUEgODM2
Myw4NjIyLDgzNjEgTm9ydGhicmlkZ2VzOg0KKyAqICAtIGJpdHMgIDUsIDYs
IDcgYXQgb2Zmc2V0IDB4NTUgbmVlZCB0byBiZSB0dXJuZWQgb2ZmDQorICog
VklBIDgzNjcgKEtUMjY2eCkgTm9ydGhicmlkZ2VzOg0KKyAqICAtIGJpdHMg
IDUsIDYsIDcgYXQgb2Zmc2V0IDB4OTUgbmVlZCB0byBiZSB0dXJuZWQgb2Zm
DQogICovDQogc3RhdGljIHZvaWQgX19pbml0IHBjaV9maXh1cF92aWFfYXRo
bG9uX2J1ZyhzdHJ1Y3QgcGNpX2RldiAqZCkNCiB7DQogCXU4IHY7DQotCXBj
aV9yZWFkX2NvbmZpZ19ieXRlKGQsIDB4NTUsICZ2KTsNCi0JaWYgKHYgJiAw
eDgwKSB7DQorCWludCB3aGVyZSA9IDB4NTU7DQorDQorCWlmIChkLT5kZXZp
Y2UgPT0gUENJX0RFVklDRV9JRF9WSUFfODM2N18wKSB7DQorICAJICAgICAg
ICB3aGVyZSA9IDB4OTU7IC8qIHRoZSBtZW1vcnkgd3JpdGUgcXVldWUgdGlt
ZXIgcmVnaXN0ZXIgaXMgDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZGlmZmVyZW50IGZvciB0aGUga3QyNjZ4J3M6IDB4OTUgbm90IDB4
NTUgKi8NCisJfQ0KKw0KKyAgICAgICAgcGNpX3JlYWRfY29uZmlnX2J5dGUo
ZCwgd2hlcmUsICZ2KTsNCisJaWYgKHYgJiAweGUwKSB7DQogCQlwcmludGso
IlRyeWluZyB0byBzdG9tcCBvbiBBdGhsb24gYnVnLi4uXG4iKTsNCi0JCXYg
Jj0gMHg3ZjsgLyogY2xlYXIgYml0IDU1LjcgKi8NCi0JCXBjaV93cml0ZV9j
b25maWdfYnl0ZShkLCAweDU1LCB2KTsNCisJCXYgJj0gMHgxZjsgLyogY2xl
YXIgYml0cyA1LCA2LCA3ICovDQorCQlwY2lfd3JpdGVfY29uZmlnX2J5dGUo
ZCwgd2hlcmUsIHYpOw0KIAl9DQogfQ0KIA0KQEAgLTExMzgsNiArMTE0Nyw5
IEBADQogCXsgUENJX0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9JRF9TSSwJ
UENJX0RFVklDRV9JRF9TSV81NTk4LAkJcGNpX2ZpeHVwX2xhdGVuY3kgfSwN
CiAgCXsgUENJX0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9JRF9JTlRFTCwJ
UENJX0RFVklDRV9JRF9JTlRFTF84MjM3MUFCXzMsCXBjaV9maXh1cF9waWl4
NF9hY3BpIH0sDQogCXsgUENJX0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9J
RF9WSUEsCVBDSV9ERVZJQ0VfSURfVklBXzgzNjNfMCwJcGNpX2ZpeHVwX3Zp
YV9hdGhsb25fYnVnIH0sDQorCXsgUENJX0ZJWFVQX0hFQURFUiwJUENJX1ZF
TkRPUl9JRF9WSUEsCVBDSV9ERVZJQ0VfSURfVklBXzg2MjIsCSAgICAgICAg
cGNpX2ZpeHVwX3ZpYV9hdGhsb25fYnVnIH0sDQorCXsgUENJX0ZJWFVQX0hF
QURFUiwJUENJX1ZFTkRPUl9JRF9WSUEsCVBDSV9ERVZJQ0VfSURfVklBXzgz
NjEsCSAgICAgICAgcGNpX2ZpeHVwX3ZpYV9hdGhsb25fYnVnIH0sDQorCXsg
UENJX0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9JRF9WSUEsCVBDSV9ERVZJ
Q0VfSURfVklBXzgzNjdfMCwJcGNpX2ZpeHVwX3ZpYV9hdGhsb25fYnVnIH0s
DQogCXsgMCB9DQogfTsNCiANCmRpZmYgLXUgLXIgdmFuaWxsYS9pbmNsdWRl
L2xpbnV4L3BjaV9pZHMuaCBwYXRjaGVkL2luY2x1ZGUvbGludXgvcGNpX2lk
cy5oDQotLS0gdmFuaWxsYS9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaAlGcmkg
Tm92ICA5IDE3OjExOjE1IDIwMDENCisrKyBwYXRjaGVkL2luY2x1ZGUvbGlu
dXgvcGNpX2lkcy5oCVRodSBEZWMgIDYgMTk6MDA6NTcgMjAwMQ0KQEAgLTkx
Miw3ICs5MTIsNyBAQA0KICNkZWZpbmUgUENJX0RFVklDRV9JRF9UVElfSFBU
MzY2CTB4MDAwNA0KIA0KICNkZWZpbmUgUENJX1ZFTkRPUl9JRF9WSUEJCTB4
MTEwNg0KLSNkZWZpbmUgUENJX0RFVklDRV9JRF9WSUFfODM2M18wCTB4MDMw
NQ0KKyNkZWZpbmUgUENJX0RFVklDRV9JRF9WSUFfODM2M18wCTB4MDMwNSAN
CiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfVklBXzgzNzFfMAkweDAzOTENCiAj
ZGVmaW5lIFBDSV9ERVZJQ0VfSURfVklBXzg1MDFfMAkweDA1MDENCiAjZGVm
aW5lIFBDSV9ERVZJQ0VfSURfVklBXzgyQzUwNQkweDA1MDUNCkBAIC05NDYs
OSArOTQ2LDExIEBADQogI2RlZmluZSBQQ0lfREVWSUNFX0lEX1ZJQV84MjMz
XzcJMHgzMDY1DQogI2RlZmluZSBQQ0lfREVWSUNFX0lEX1ZJQV84MkM2ODZf
NgkweDMwNjgNCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfVklBXzgyMzNfMAkw
eDMwNzQNCisjZGVmaW5lIFBDSV9ERVZJQ0VfSURfVklBXzg2MjIgICAgICAg
ICAgMHgzMTAyIA0KICNkZWZpbmUgUENJX0RFVklDRV9JRF9WSUFfODIzM0Nf
MAkweDMxMDkNCisjZGVmaW5lIFBDSV9ERVZJQ0VfSURfVklBXzgzNjEgICAg
ICAgICAgMHgzMTEyIA0KICNkZWZpbmUgUENJX0RFVklDRV9JRF9WSUFfODYz
M18wCTB4MzA5MQ0KLSNkZWZpbmUgUENJX0RFVklDRV9JRF9WSUFfODM2N18w
CTB4MzA5OQ0KKyNkZWZpbmUgUENJX0RFVklDRV9JRF9WSUFfODM2N18wCTB4
MzA5OSANCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfVklBXzg2QzEwMEEJMHg2
MTAwDQogI2RlZmluZSBQQ0lfREVWSUNFX0lEX1ZJQV84MjMxCQkweDgyMzEN
CiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfVklBXzgyMzFfNAkweDgyMzUNCg==
---74666095-1768302542-1007751632=:8124--
