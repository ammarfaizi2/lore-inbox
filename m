Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129520AbQLAAsJ>; Thu, 30 Nov 2000 19:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQLAAr7>; Thu, 30 Nov 2000 19:47:59 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:43466 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129520AbQLAArw>; Thu, 30 Nov 2000 19:47:52 -0500
Date: Fri, 1 Dec 2000 00:17:25 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: PATCH: 2.4.0-test12-pre3: fix ntfs BUG() call
Message-ID: <Pine.SOL.3.96.1001201001535.26566C-200000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-975629726=:26566"
Content-ID: <Pine.SOL.3.96.1001201001535.26566D@virgo.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-975629726=:26566
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.SOL.3.96.1001201001535.26566E@virgo.cus.cam.ac.uk>

Attached patch fixes the BUG() people are seeing when using the ntfs
driver with 2.4.0-test* kernels. Patch is tested and everything seems to
be working fine with it. 

Description:

The BUG() call was due to a not implemented ntfs_get_block().

The fix is to comment out all [bm]map associated code since if any of it
is used it results in the BUG().

I haven't removed the code altogether, since, once ntfs_get_block is
implemented, the rest of the code can just be uncommented and it should
all work.

This patch has been submitted to Linus for inclusion in the next
2.4.0.test* kernel.

Regards,

	Anton

-- 
Anton Altaparmakov       Phone: +44-(0)1223-333541 (lab)
Christ's College         eMail: AntonA@bigfoot.com / aia21@[cus.]cam.ac.uk
Cambridge CB2 3BU          WWW: http://www-stu.christs.cam.ac.uk/~aia21/
United Kingdom             ICQ: 8561279

---559023410-1804928587-975629726=:26566
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ntfs_no_bmmap.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.96.1001201001526.26566B@virgo.cus.cam.ac.uk>
Content-Description: 

ZGlmZiAtdXIgbGludXgtMi40LjAtdGVzdDEyLXByZTMvZnMvbnRmcy9mcy5j
IGxpbnV4L2ZzL250ZnMvZnMuYw0KLS0tIGxpbnV4LTIuNC4wLXRlc3QxMi1w
cmUzL2ZzL250ZnMvZnMuYwlUaHUgTm92IDE2IDIxOjE4OjI2IDIwMDANCisr
KyBsaW51eC9mcy9udGZzL2ZzLmMJRnJpIERlYyAgMSAwMDowODozOCAyMDAw
DQpAQCAtNTU3LDcgKzU1Nyw4IEBADQogI2VuZGlmDQogDQogLyogSXQncyBm
c2NraW5nIGJyb2tlbi4gKi8NCi0NCisvKiBGSVhNRTogW2JtXW1hcCBjb2Rl
IGlzIGRpc2FibGVkIHVudGlsIG50ZnNfZ2V0X2Jsb2NrIGdldHMgc29ydGVk
ISAqLw0KKy8qDQogc3RhdGljIGludCBudGZzX2dldF9ibG9jayhzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBsb25nIGJsb2NrLCBzdHJ1Y3QgYnVmZmVyX2hlYWQg
KmJoLCBpbnQgY3JlYXRlKQ0KIHsNCiAJQlVHKCk7DQpAQCAtNTczLDYgKzU3
NCw3IEBADQogfTsNCiANCiBzdGF0aWMgc3RydWN0IGlub2RlX29wZXJhdGlv
bnMgbnRmc19pbm9kZV9vcGVyYXRpb25zOw0KKyovDQogDQogc3RhdGljIHN0
cnVjdCBmaWxlX29wZXJhdGlvbnMgbnRmc19kaXJfb3BlcmF0aW9ucyA9IHsN
CiAJcmVhZDoJCWdlbmVyaWNfcmVhZF9kaXIsDQpAQCAtNTg3LDYgKzU4OSw3
IEBADQogI2VuZGlmDQogfTsNCiANCisvKg0KIHN0YXRpYyBpbnQgbnRmc193
cml0ZXBhZ2Uoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBwYWdlICpwYWdl
KQ0KIHsNCiAJcmV0dXJuIGJsb2NrX3dyaXRlX2Z1bGxfcGFnZShwYWdlLG50
ZnNfZ2V0X2Jsb2NrKTsNCkBAIC02MTIsNiArNjE1LDggQEANCiAJY29tbWl0
X3dyaXRlOiBnZW5lcmljX2NvbW1pdF93cml0ZSwNCiAJYm1hcDogX250ZnNf
Ym1hcA0KIH07DQorKi8NCisNCiAvKiBudGZzX3JlYWRfaW5vZGUgaXMgY2Fs
bGVkIGJ5IHRoZSBWaXJ0dWFsIEZpbGUgU3lzdGVtICh0aGUga2VybmVsIGxh
eWVyIHRoYXQNCiAgKiBkZWFscyB3aXRoIGZpbGVzeXN0ZW1zKSB3aGVuIGln
ZXQgaXMgY2FsbGVkIHJlcXVlc3RpbmcgYW4gaW5vZGUgbm90IGFscmVhZHkN
CiAgKiBwcmVzZW50IGluIHRoZSBpbm9kZSB0YWJsZS4gVHlwaWNhbGx5IGZp
bGVzeXN0ZW1zIGhhdmUgc2VwYXJhdGUNCkBAIC02NjQsNyArNjY5LDEwIEBA
DQogCWVsc2UNCiAJew0KIAkJaW5vZGUtPmlfc2l6ZT1kYXRhLT5zaXplOw0K
LQkJY2FuX21tYXA9IWRhdGEtPnJlc2lkZW50ICYmICFkYXRhLT5jb21wcmVz
c2VkOw0KKwkJLyogRklYTUU6IG9uY2UgbnRmc19nZXRfYmxvY2sgaXMgaW1w
bGVtZW50ZWQsIHVuY29tbWVudCB0aGUNCisJCSAqIG5leHQgbGluZSBhbmQg
cmVtb3ZlIHRoZSBjYW5fbW1hcCA9IDA7ICovDQorCQkvKiBjYW5fbW1hcD0h
ZGF0YS0+cmVzaWRlbnQgJiYgIWRhdGEtPmNvbXByZXNzZWQ7Ki8NCisJCWNh
bl9tbWFwID0gMDsNCiAJfQ0KIAkvKiBnZXQgdGhlIGZpbGUgbW9kaWZpY2F0
aW9uIHRpbWVzIGZyb20gdGhlIHN0YW5kYXJkIGluZm9ybWF0aW9uICovDQog
CXNpPW50ZnNfZmluZF9hdHRyKGlubyx2b2wtPmF0X3N0YW5kYXJkX2luZm9y
bWF0aW9uLE5VTEwpOw0KQEAgLTY4NywxMiArNjk1LDE3IEBADQogCX0NCiAJ
ZWxzZQ0KIAl7DQotCQlpZiAoY2FuX21tYXApIHsNCisJCS8qIEFzIGxvbmcg
YXMgbnRmc19nZXRfYmxvY2soKSBpcyBqdXN0IGEgY2FsbCB0byBCVUcoKSBk
byBub3QNCisJIAkgKiBkZWZpbmUgYW55IFtibV1tYXAgb3BzIG9yIHdlIGdl
dCB0aGUgQlVHKCkgd2hlbmV2ZXIgc29tZW9uZQ0KKwkJICogcnVucyBtYyBv
ciBtcGcxMjMgb24gYW4gbnRmcyBwYXJ0aXRpb24hDQorCQkgKiBGSVhNRTog
VW5jb21tZW50IHRoZSBiZWxvdyBjb2RlIHdoZW4gbnRmc19nZXRfYmxvY2sg
aXMNCisJCSAqIGltcGxlbWVudGVkLiAqLw0KKwkJLyogaWYgKGNhbl9tbWFw
KSB7DQogCQkJaW5vZGUtPmlfb3AgPSAmbnRmc19pbm9kZV9vcGVyYXRpb25z
Ow0KIAkJCWlub2RlLT5pX2ZvcCA9ICZudGZzX2ZpbGVfb3BlcmF0aW9uczsN
CiAJCQlpbm9kZS0+aV9tYXBwaW5nLT5hX29wcyA9ICZudGZzX2FvcHM7DQog
CQkJaW5vZGUtPnUubnRmc19pLm1tdV9wcml2YXRlID0gaW5vZGUtPmlfc2l6
ZTsNCi0JCX0gZWxzZSB7DQorCQl9IGVsc2UgKi8gew0KIAkJCWlub2RlLT5p
X29wPSZudGZzX2lub2RlX29wZXJhdGlvbnNfbm9ibWFwOw0KIAkJCWlub2Rl
LT5pX2ZvcD0mbnRmc19maWxlX29wZXJhdGlvbnNfbm9tbWFwOw0KIAkJfQ0K
DQo=
---559023410-1804928587-975629726=:26566--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
