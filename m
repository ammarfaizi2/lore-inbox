Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQKPEQs>; Wed, 15 Nov 2000 23:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQKPEQh>; Wed, 15 Nov 2000 23:16:37 -0500
Received: from mout0.freenet.de ([194.97.50.131]:5076 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S129132AbQKPEQ2>;
	Wed, 15 Nov 2000 23:16:28 -0500
Date: Wed, 15 Nov 2000 20:20:59 +0100 (CET)
From: Gert Wollny <wollny@cns.mpg.de>
To: James M <dart@windeath.2y.net>
cc: linux-kernel@vger.kernel.org, twaugh@redhat.com
Subject: Re: BUG Report 2.4.0-test11-pre3: NMI Watchdoch detected LOCKUP 
 atCPU[01]
In-Reply-To: <3A11AE6E.22AB1A32@windeath.2y.net>
Message-ID: <Pine.LNX.4.10.10011152005570.769-200000@bolide.beigert.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811830-882212148-974316059=:769"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811830-882212148-974316059=:769
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello,

i think it got it nailed, please try the attached patch (it is against
11-pre4, but it should work against all test11).

Explanation: 
with test7-pre6 in the  imm-module the new scsi - code was enabled (see
imm.h).
This causes the locking of the io_request_lock in scsi_register_host 
(scsi.c) during detection of the ZIP drive. Seems, that the request_module
call for the parport_pc doesn't like this.
The patch does, what the comment in scsi.c suggests: Enable the new code
only, after the drive is detected.

Have a nice day

Gert




 


---1463811830-882212148-974316059=:769
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="imm-lockup.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10011152020590.769@bolide.beigert.de>
Content-Description: the patch
Content-Disposition: attachment; filename="imm-lockup.patch"

ZGlmZiAtcnUgMi40LjAtdGVzdDExLXByZTQvZHJpdmVycy9zY3NpL2ltbS5j
IDIuNC4wLXRlc3QxMS1wcmU0LW15L2RyaXZlcnMvc2NzaS9pbW0uYw0KLS0t
IDIuNC4wLXRlc3QxMS1wcmU0L2RyaXZlcnMvc2NzaS9pbW0uYwlXZWQgTm92
IDE1IDE5OjM5OjQxIDIwMDANCisrKyAyLjQuMC10ZXN0MTEtcHJlNC1teS9k
cml2ZXJzL3Njc2kvaW1tLmMJV2VkIE5vdiAxNSAxOTo0NDo1NiAyMDAwDQpA
QCAtMjEyLDggKzIxMiwxMSBAQA0KIAkgICAgcmV0dXJuIDA7DQogCXRyeV9h
Z2FpbiA9IDE7DQogCWdvdG8gcmV0cnlfZW50cnk7DQotICAgIH0gZWxzZQ0K
LQlyZXR1cm4gMTsJCS8qIHJldHVybiBudW1iZXIgb2YgaG9zdHMgZGV0ZWN0
ZWQgKi8NCisgICAgfSBlbHNlIHsNCisJIC8qIG5vdyBlbmFibGUgdGhlIG5l
dyBjb2RlICovDQorCSBob3N0LT51c2VfbmV3X2VoX2NvZGUgPSAxOw0KKwkg
cmV0dXJuIDE7CQkvKiByZXR1cm4gbnVtYmVyIG9mIGhvc3RzIGRldGVjdGVk
ICovDQorICAgIH0JIA0KIH0NCiANCiAvKiBUaGlzIGlzIHRvIGdpdmUgdGhl
IGltbSBkcml2ZXIgYSB3YXkgdG8gbW9kaWZ5IHRoZSB0aW1pbmdzIChhbmQg
b3RoZXINCmRpZmYgLXJ1IDIuNC4wLXRlc3QxMS1wcmU0L2RyaXZlcnMvc2Nz
aS9pbW0uaCAyLjQuMC10ZXN0MTEtcHJlNC1teS9kcml2ZXJzL3Njc2kvaW1t
LmgNCi0tLSAyLjQuMC10ZXN0MTEtcHJlNC9kcml2ZXJzL3Njc2kvaW1tLmgJ
V2VkIE5vdiAxNSAxOTo0MDo0NCAyMDAwDQorKysgMi40LjAtdGVzdDExLXBy
ZTQtbXkvZHJpdmVycy9zY3NpL2ltbS5oCVdlZCBOb3YgMTUgMjA6MDE6MTEg
MjAwMA0KQEAgLTEwLDcgKzEwLDcgQEANCiAjaWZuZGVmIF9JTU1fSA0KICNk
ZWZpbmUgX0lNTV9IDQogDQotI2RlZmluZSAgIElNTV9WRVJTSU9OICAgIjIu
MDQgKGZvciBMaW51eCAyLjQuMCkiDQorI2RlZmluZSAgIElNTV9WRVJTSU9O
ICAgIjIuMDUgKGZvciBMaW51eCAyLjQuMCkiDQogDQogLyogDQogICogMTAg
QXByIDE5OTggKEdvb2QgRnJpZGF5KSAtIFJlY2VpdmVkIEVOMTQ0MzAyIGJ5
IGVtYWlsIGZyb20gSW9tZWdhLg0KQEAgLTYwLDYgKzYwLDkgQEANCiAgKiAg
ICBhZGRlZCBDT05GSUdfU0NTSV9JWklQX1NMT1dfQ1RSIG9wdGlvbg0KICAq
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgWzIuMDNdDQogICogIEZpeCBrZXJuZWwgcGFuaWMgb24gc2Nz
aSB0aW1lb3V0LgkJMjBBdWcwMCBbMi4wNF0NCisgKg0KKyAqICBGaXggYSBs
b2NrdXAgZHVyaW5nIGRldGVjdGlvbiBvZiBkcml2ZSAgICAgIDE0Tm92MDAg
WzIuMDVdDQorICogIDx3b2xsbnlAY25zLm1wZy5kZT4NCiAgKi8NCiAvKiAt
LS0tLS0gRU5EIE9GIFVTRVIgQ09ORklHVVJBQkxFIFBBUkFNRVRFUlMgLS0t
LS0gKi8NCiANCkBAIC0xNzIsNyArMTc1LDcgQEANCiAgICAgICAgICAgICAg
ICAgZWhfZGV2aWNlX3Jlc2V0X2hhbmRsZXI6ICAgICAgICBOVUxMLCAgICAg
ICAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAgIGVoX2J1c19yZXNl
dF9oYW5kbGVyOiAgICAgICAgICAgaW1tX3Jlc2V0LCAgICAgICAgICAgICAg
XA0KICAgICAgICAgICAgICAgICBlaF9ob3N0X3Jlc2V0X2hhbmRsZXI6ICAg
ICAgICAgIGltbV9yZXNldCwgICAgICAgICAgICAgIFwNCi0JCXVzZV9uZXdf
ZWhfY29kZToJCTEsCQkJXA0KKwkJdXNlX25ld19laF9jb2RlOgkJMCwJCQlc
DQogCQliaW9zX3BhcmFtOgkJICAgICAgICBpbW1fYmlvc3BhcmFtLAkJXA0K
IAkJdGhpc19pZDoJCQk3LAkJCVwNCiAJCXNnX3RhYmxlc2l6ZToJCQlTR19B
TEwsCQkJXA0K
---1463811830-882212148-974316059=:769--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
