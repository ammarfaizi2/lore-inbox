Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129157AbQKOC1t>; Tue, 14 Nov 2000 21:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129322AbQKOC1j>; Tue, 14 Nov 2000 21:27:39 -0500
Received: from zero.tech9.net ([209.61.188.187]:59908 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S129157AbQKOC13>;
	Tue, 14 Nov 2000 21:27:29 -0500
Date: Tue, 14 Nov 2000 20:58:59 -0500 (EST)
From: "Robert M. Love" <rml@tech9.net>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.0] agpgart support for i815 not using on-board video 
Message-ID: <Pine.LNX.4.30.0011142047540.5098-200000@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-491173686-974253539=:5098"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-491173686-974253539=:5098
Content-Type: TEXT/PLAIN; charset=US-ASCII

the agp driver for the i810/i815 is designed to support the 810/815's
on-board i7xx video. the i815 (which can use on-board video or a seperate
AGP 2x/4x/Pro card) does not function with this driver when using a
seperate AGP card.

the 440LX/BX/GX and 840 agp driver does work, however, if
agp_try_unsupported is set to 1 -- they all share the same generic Intel
AGP interface, the driver just does not detect the i815.

this patch, against 2.4.0-test11-pre5, adds specific support for the 815
to the 440LX/BX/GX/840 driver, so agp_try_unsupported need not be set, and
the i815 is detected and handled properly.

the patch also updates the configure docs to show that CONFIG_AGP_INTEL
now supports the i815, and CONFIG_AGP_I810 supports the i815 when using
the on-board video only.

ive been using this patch for a couple days with no problem, and
agp_try_unsupported=1 for many months ... DRI works great with it.

my system is an ASUS CUSL2 with a Matrox G400.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

--8323328-491173686-974253539=:5098
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; name="patch-2.4.0-test11-pre5-i815-AGP"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0011142058590.5098@phantasy.awol.org>
Content-Description: i815 AGP patch against 2.4.0
Content-Disposition: attachment; filename="patch-2.4.0-test11-pre5-i815-AGP"

ZGlmZiAtLXJlY3Vyc2l2ZSAtdSBsaW51eH4vQ1JFRElUUyBsaW51eC9DUkVE
SVRTDQotLS0gbGludXh+L0NSRURJVFMJVHVlIE5vdiAxNCAyMDozOToxMyAy
MDAwDQorKysgbGludXgvQ1JFRElUUwlUdWUgTm92IDE0IDE5OjU0OjUxIDIw
MDANCkBAIC0xNjAwLDcgKzE2MDAsOCBAQA0KIEU6IHJtbEB0ZWNoOS5uZXQN
CiBFOiBybWxAdWZsLmVkdQ0KIEQ6IG1pc2MuIGtlcm5lbCBoYWNraW5nIGFu
ZCBkZWJ1Z2dpbmcNCi1TOiBGTCwgVVNBDQorUzogR2FpbmVzdmlsbGUsIEZs
b3JpZGEgMzI2MDgNCitTOiBVU0ENCiANCiBOOiBNYXJ0aW4gdm9uIEz2d2lz
DQogRTogbG9ld2lzQGluZm9ybWF0aWsuaHUtYmVybGluLmRlDQpkaWZmIC0t
cmVjdXJzaXZlIC11IGxpbnV4fi9Eb2N1bWVudGF0aW9uL0NvbmZpZ3VyZS5o
ZWxwIGxpbnV4L0RvY3VtZW50YXRpb24vQ29uZmlndXJlLmhlbHANCi0tLSBs
aW51eH4vRG9jdW1lbnRhdGlvbi9Db25maWd1cmUuaGVscAlUdWUgTm92IDE0
IDIwOjM5OjEzIDIwMDANCisrKyBsaW51eC9Eb2N1bWVudGF0aW9uL0NvbmZp
Z3VyZS5oZWxwCVR1ZSBOb3YgMTQgMTk6NTQ6NTEgMjAwMA0KQEAgLTIzNTUs
NyArMjM1NSw3IEBADQogSW50ZWwgNDQwTFgvQlgvR1ggc3VwcG9ydA0KIENP
TkZJR19BR1BfSU5URUwNCiAgIFRoaXMgb3B0aW9uIGdpdmVzIHlvdSBBR1Ag
c3VwcG9ydCBmb3IgdGhlIEdMWCBjb21wb25lbnQgb2YgdGhlDQotICBYRnJl
ZTg2IDQueCBvbiBJbnRlbCA0NDBMWC9CWC9HWCBjaGlwc2V0cy4NCisgIFhG
cmVlODYgNC54IG9uIEludGVsIDQ0MExYL0JYL0dYLCA4MTUsIGFuZCA4NDAg
Y2hpcHNldHMuDQogDQogICBGb3IgdGhlIG1vbWVudCwgeW91IHNob3VsZCBw
cm9iYWJseSBzYXkgTiwgdW5sZXNzIHlvdSB3YW50IHRvIHRlc3QNCiAgIHRo
ZSBHTFggY29tcG9uZW50IGZvciBYRnJlZTg2IDMuMy42LCB3aGljaCBjYW4g
YmUgZG93bmxvYWRlZCBmcm9tDQpAQCAtMjM2Myw5ICsyMzYzLDkgQEANCiAN
CiBJbnRlbCBJODEwL0k4MTAgREMxMDAvSTgxMGUgc3VwcG9ydA0KIENPTkZJ
R19BR1BfSTgxMA0KLSAgVGhpcyBvcHRpb24gZ2l2ZXMgeW91IEFHUCBzdXBw
b3J0IGZvciB0aGUgWHNlcnZlciBmb3IgdGhlIEludGVsDQotICA4MTAgY2hp
cHNldCBib2FyZHMuIFRoaXMgaXMgcmVxdWlyZWQgdG8gZG8gYW55IHVzZWZ1
bCB2aWRlbw0KLSAgbW9kZXMuDQorICBUaGlzIG9wdGlvbiBnaXZlcyB5b3Ug
QUdQIHN1cHBvcnQgZm9yIHRoZSBYc2VydmVyIG9uIHRoZSBJbnRlbCA4MTAN
CisgIGFuZCA4MTUgY2hpcHNldCBib2FyZHMgZm9yIHRoZWlyIG9uLWJvYXJk
IGludGVncmF0ZWQgZ3JhcGhpY3MuIFRoaXMNCisgIGlzIHJlcXVpcmVkIHRv
IGRvIGFueSB1c2VmdWwgdmlkZW8gbW9kZXMgd2l0aCB0aGVzZSBib2FyZHMu
DQogDQogVklBIGNoaXBzZXQgc3VwcG9ydA0KIENPTkZJR19BR1BfVklBDQpk
aWZmIC0tcmVjdXJzaXZlIC11IGxpbnV4fi9kcml2ZXJzL2NoYXIvQ29uZmln
LmluIGxpbnV4L2RyaXZlcnMvY2hhci9Db25maWcuaW4NCi0tLSBsaW51eH4v
ZHJpdmVycy9jaGFyL0NvbmZpZy5pbglUdWUgTm92IDE0IDIwOjM5OjE0IDIw
MDANCisrKyBsaW51eC9kcml2ZXJzL2NoYXIvQ29uZmlnLmluCVR1ZSBOb3Yg
MTQgMTk6NTY6MzQgMjAwMA0KQEAgLTE3OCw4ICsxNzgsOCBAQA0KIA0KIHRy
aXN0YXRlICcvZGV2L2FncGdhcnQgKEFHUCBTdXBwb3J0KScgQ09ORklHX0FH
UCAkQ09ORklHX0RSTV9BR1ANCiBpZiBbICIkQ09ORklHX0FHUCIgIT0gIm4i
IF07IHRoZW4NCi0gICBib29sICcgIEludGVsIDQ0MExYL0JYL0dYIDg0MCBz
dXBwb3J0JyBDT05GSUdfQUdQX0lOVEVMDQotICAgYm9vbCAnICBJbnRlbCBJ
ODEwL0k4MTUgc3VwcG9ydCcgQ09ORklHX0FHUF9JODEwDQorICAgYm9vbCAn
ICBJbnRlbCA0NDBMWC9CWC9HWCBhbmQgSTgxNS9JODQwIHN1cHBvcnQnIENP
TkZJR19BR1BfSU5URUwNCisgICBib29sICcgIEludGVsIEk4MTAvSTgxNSAo
b24tYm9hcmQpIHN1cHBvcnQnIENPTkZJR19BR1BfSTgxMA0KICAgIGJvb2wg
JyAgVklBIGNoaXBzZXQgc3VwcG9ydCcgQ09ORklHX0FHUF9WSUENCiAgICBi
b29sICcgIEFNRCBJcm9uZ2F0ZSBzdXBwb3J0JyBDT05GSUdfQUdQX0FNRA0K
ICAgIGJvb2wgJyAgR2VuZXJpYyBTaVMgc3VwcG9ydCcgQ09ORklHX0FHUF9T
SVMNCmRpZmYgLS1yZWN1cnNpdmUgLXUgbGludXh+L2RyaXZlcnMvY2hhci9h
Z3AvYWdwZ2FydF9iZS5jIGxpbnV4L2RyaXZlcnMvY2hhci9hZ3AvYWdwZ2Fy
dF9iZS5jDQotLS0gbGludXh+L2RyaXZlcnMvY2hhci9hZ3AvYWdwZ2FydF9i
ZS5jCVR1ZSBOb3YgMTQgMjA6Mzk6MTQgMjAwMA0KKysrIGxpbnV4L2RyaXZl
cnMvY2hhci9hZ3AvYWdwZ2FydF9iZS5jCVR1ZSBOb3YgMTQgMTk6NTQ6NTEg
MjAwMA0KQEAgLTIwNTcsNiArMjA1NywxMyBAQA0KIAkJIkludGVsIiwNCiAJ
CSI0NDBHWCIsDQogCQlpbnRlbF9nZW5lcmljX3NldHVwIH0sDQorCS8qIGNv
dWxkIHdlIGFkZCBzdXBwb3J0IGZvciBQQ0lfREVWSUNFX0lEX0lOVEVMXzgx
NV8xIHRvbyA/ICovDQorCXsgUENJX0RFVklDRV9JRF9JTlRFTF84MTVfMCwN
CisJCVBDSV9WRU5ET1JfSURfSU5URUwsDQorCQlJTlRFTF9JODE1LA0KKwkJ
IkludGVsIiwNCisJCSJpODE1IiwNCisJCWludGVsX2dlbmVyaWNfc2V0dXAg
fSwNCiAJeyBQQ0lfREVWSUNFX0lEX0lOVEVMXzg0MF8wLA0KIAkJUENJX1ZF
TkRPUl9JRF9JTlRFTCwNCiAJCUlOVEVMX0k4NDAsDQpkaWZmIC0tcmVjdXJz
aXZlIC11IGxpbnV4fi9pbmNsdWRlL2xpbnV4L2FncF9iYWNrZW5kLmggbGlu
dXgvaW5jbHVkZS9saW51eC9hZ3BfYmFja2VuZC5oDQotLS0gbGludXh+L2lu
Y2x1ZGUvbGludXgvYWdwX2JhY2tlbmQuaAlUdWUgTm92IDE0IDIwOjM5OjE1
IDIwMDANCisrKyBsaW51eC9pbmNsdWRlL2xpbnV4L2FncF9iYWNrZW5kLmgJ
VHVlIE5vdiAxNCAxOTo1NDo1MyAyMDAwDQpAQCAtNDUsNiArNDUsNyBAQA0K
IAlJTlRFTF9CWCwNCiAJSU5URUxfR1gsDQogCUlOVEVMX0k4MTAsDQorICAg
ICAgIElOVEVMX0k4MTUsDQogCUlOVEVMX0k4NDAsDQogCVZJQV9HRU5FUklD
LA0KIAlWSUFfVlAzLA0K
--8323328-491173686-974253539=:5098--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
