Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285402AbRLNQRv>; Fri, 14 Dec 2001 11:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285403AbRLNQRl>; Fri, 14 Dec 2001 11:17:41 -0500
Received: from mx2.elte.hu ([157.181.151.9]:21653 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285402AbRLNQRg>;
	Fri, 14 Dec 2001 11:17:36 -0500
Date: Fri, 14 Dec 2001 19:14:54 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>,
        Suparna Bhattacharya <suparna@in.ibm.com>
Subject: [patch] mempool-2.5.1-D1
In-Reply-To: <Pine.LNX.4.33.0112141446030.8724-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112141908420.12688-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1766233386-1008353340=:12688"
Content-ID: <Pine.LNX.4.33.0112141909040.12688@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1766233386-1008353340=:12688
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0112141909041.12688@localhost.localdomain>


there is another thinko in the mempool code, reported by Suparna
Bhattacharya. If mempool_alloc() is called from an IRQ context then we
return too early. The correct behavior is to allocate GFP_ATOMIC, if that
fails then we look at the pool and return an element, or return NULL.

	Ingo

--8323328-1766233386-1008353340=:12688
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="mempool-2.5.1-D1"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0112141914540.12688@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="mempool-2.5.1-D1"

LS0tIGxpbnV4L21tL21lbXBvb2wuYy5vcmlnCUZyaSBEZWMgMTQgMTY6NTU6
MTIgMjAwMQ0KKysrIGxpbnV4L21tL21lbXBvb2wuYwlGcmkgRGVjIDE0IDE3
OjAzOjUyIDIwMDENCkBAIC0xNzYsNyArMTc2LDggQEANCiAgKg0KICAqIHRo
aXMgZnVuY3Rpb24gb25seSBzbGVlcHMgaWYgdGhlIGFsbG9jX2ZuIGZ1bmN0
aW9uIHNsZWVwcyBvcg0KICAqIHJldHVybnMgTlVMTC4gTm90ZSB0aGF0IGR1
ZSB0byBwcmVhbGxvY2F0aW9uLCB0aGlzIGZ1bmN0aW9uDQotICogKm5ldmVy
KiBmYWlscy4NCisgKiAqbmV2ZXIqIGZhaWxzIHdoZW4gY2FsbGVkIGZyb20g
cHJvY2VzcyBjb250ZXh0cy4gKGl0IG1pZ2h0DQorICogZmFpbCBpZiBjYWxs
ZWQgZnJvbSBhbiBJUlEgY29udGV4dC4pDQogICovDQogdm9pZCAqIG1lbXBv
b2xfYWxsb2MobWVtcG9vbF90ICpwb29sLCBpbnQgZ2ZwX21hc2spDQogew0K
QEAgLTE4NSw3ICsxODYsNyBAQA0KIAlzdHJ1Y3QgbGlzdF9oZWFkICp0bXA7
DQogCWludCBjdXJyX25yOw0KIAlERUNMQVJFX1dBSVRRVUVVRSh3YWl0LCBj
dXJyZW50KTsNCi0JaW50IGdmcF9ub3dhaXQgPSBnZnBfbWFzayAmIH5fX0dG
UF9XQUlUOw0KKwlpbnQgZ2ZwX25vd2FpdCA9IGdmcF9tYXNrICYgfihfX0dG
UF9XQUlUIHwgX19HRlBfSU8pOw0KIA0KIHJlcGVhdF9hbGxvYzoNCiAJZWxl
bWVudCA9IHBvb2wtPmFsbG9jKGdmcF9ub3dhaXQsIHBvb2wtPnBvb2xfZGF0
YSk7DQpAQCAtMTk2LDE1ICsxOTcsMTEgQEANCiAJICogSWYgdGhlIHBvb2wg
aXMgbGVzcyB0aGFuIDUwJSBmdWxsIHRoZW4gdHJ5IGhhcmRlcg0KIAkgKiB0
byBhbGxvY2F0ZSBhbiBlbGVtZW50Og0KIAkgKi8NCi0JaWYgKGdmcF9tYXNr
ICE9IGdmcF9ub3dhaXQpIHsNCi0JCWlmIChwb29sLT5jdXJyX25yIDw9IHBv
b2wtPm1pbl9uci8yKSB7DQotCQkJZWxlbWVudCA9IHBvb2wtPmFsbG9jKGdm
cF9tYXNrLCBwb29sLT5wb29sX2RhdGEpOw0KLQkJCWlmIChsaWtlbHkoZWxl
bWVudCAhPSBOVUxMKSkNCi0JCQkJcmV0dXJuIGVsZW1lbnQ7DQotCQl9DQot
CX0gZWxzZQ0KLQkJLyogd2UgbXVzdCBub3Qgc2xlZXAgKi8NCi0JCXJldHVy
biBOVUxMOw0KKwlpZiAoKGdmcF9tYXNrICE9IGdmcF9ub3dhaXQpICYmIChw
b29sLT5jdXJyX25yIDw9IHBvb2wtPm1pbl9uci8yKSkgew0KKwkJZWxlbWVu
dCA9IHBvb2wtPmFsbG9jKGdmcF9tYXNrLCBwb29sLT5wb29sX2RhdGEpOw0K
KwkJaWYgKGxpa2VseShlbGVtZW50ICE9IE5VTEwpKQ0KKwkJCXJldHVybiBl
bGVtZW50Ow0KKwl9DQogDQogCS8qDQogCSAqIEtpY2sgdGhlIFZNIGF0IHRo
aXMgcG9pbnQuDQpAQCAtMjE3LDEwICsyMTQsMTIgQEANCiAJCWxpc3RfZGVs
KHRtcCk7DQogCQllbGVtZW50ID0gdG1wOw0KIAkJcG9vbC0+Y3Vycl9uci0t
Ow0KLQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG9vbC0+bG9jaywgZmxh
Z3MpOw0KLQ0KLQkJcmV0dXJuIGVsZW1lbnQ7DQorCQlnb3RvIG91dF91bmxv
Y2s7DQogCX0NCisJLyogV2UgbXVzdCBub3Qgc2xlZXAgaW4gdGhlIEdGUF9B
VE9NSUMgY2FzZSAqLw0KKwlpZiAoZ2ZwX21hc2sgPT0gZ2ZwX25vd2FpdCkN
CisJCWdvdG8gb3V0X3VubG9jazsNCisNCiAJYWRkX3dhaXRfcXVldWVfZXhj
bHVzaXZlKCZwb29sLT53YWl0LCAmd2FpdCk7DQogCXNldF90YXNrX3N0YXRl
KGN1cnJlbnQsIFRBU0tfVU5JTlRFUlJVUFRJQkxFKTsNCiANCkBAIC0yMzYs
NiArMjM1LDkgQEANCiAJcmVtb3ZlX3dhaXRfcXVldWUoJnBvb2wtPndhaXQs
ICZ3YWl0KTsNCiANCiAJZ290byByZXBlYXRfYWxsb2M7DQorb3V0X3VubG9j
azoNCisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG9vbC0+bG9jaywgZmxh
Z3MpOw0KKwlyZXR1cm4gZWxlbWVudDsNCiB9DQogDQogLyoqDQo=
--8323328-1766233386-1008353340=:12688--
