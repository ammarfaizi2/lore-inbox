Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282983AbRK0X3v>; Tue, 27 Nov 2001 18:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282961AbRK0X3l>; Tue, 27 Nov 2001 18:29:41 -0500
Received: from vir.tninet.se ([195.100.94.108]:4367 "EHLO smtp.tninet.se")
	by vger.kernel.org with ESMTP id <S282983AbRK0X3e>;
	Tue, 27 Nov 2001 18:29:34 -0500
Date: Wed, 28 Nov 2001 00:29:31 +0100 (MET)
From: Per Larsson <tucker@algonet.se>
To: linux-kernel@vger.kernel.org
cc: alan@redhat.com
Subject: Patch for fdomain driver.
Message-ID: <Pine.SOL.4.10.10111280022080.9380-200000@kairos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1006903771=:9380"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1006903771=:9380
Content-Type: TEXT/PLAIN; charset=US-ASCII


I've been using my old Quantum ISA-200S fdomain-based scsi-card to
drive my zipdrive for a few years now, and when I upgraded to 2.4, 
I got an Oops.

After much testing, I found the fdomain driver to be the culprit,
especially the readb() calls.

Since this is a ISA card, those should apparently rather be isa_readb()
instead.

There might be more changes needed, but it works for me now.

/Per Larsson.

-- 
Democracy is the working model of any form of mob rule. The fruit of
democracy, if unchecked by respect for human rights, is gang violence.
Always! -- http://www.unquietmind.com/mislaid_iv.html

---559023410-851401618-1006903771=:9380
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fdomain.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.10.10111280029310.9380@kairos>
Content-Description: 
Content-Disposition: attachment; filename="fdomain.diff"

LS0tIC90bXAvZm9vL2Zkb21haW4uYy5vcmlnCVN1biBTZXAgMzAgMjE6MjY6
MDcgMjAwMQ0KKysrIGRyaXZlcnMvc2NzaS9mZG9tYWluLmMJVHVlIE5vdiAy
NyAyMzo1OTo1OSAyMDAxDQpAQCAtNzI5LDEzICs3MjksMTMgQEANCiAgICAg
ICBzd2l0Y2ggKFF1YW50dW0pIHsNCiAgICAgICBjYXNlIDI6CQkJLyogSVNB
XzIwMFMgKi8NCiAgICAgICBjYXNlIDM6CQkJLyogSVNBXzI1ME1HICovDQot
CSBiYXNlID0gcmVhZGIoYmlvc19iYXNlICsgMHgxZmEyKSArIChyZWFkYihi
aW9zX2Jhc2UgKyAweDFmYTMpIDw8IDgpOw0KKwkgYmFzZSA9IGlzYV9yZWFk
YihiaW9zX2Jhc2UgKyAweDFmYTIpICsgKGlzYV9yZWFkYihiaW9zX2Jhc2Ug
KyAweDFmYTMpIDw8IDgpOw0KIAkgYnJlYWs7DQogICAgICAgY2FzZSA0OgkJ
CS8qIElTQV8yMDBTIChhbm90aGVyIG9uZSkgKi8NCi0JIGJhc2UgPSByZWFk
YihiaW9zX2Jhc2UgKyAweDFmYTMpICsgKHJlYWRiKGJpb3NfYmFzZSArIDB4
MWZhNCkgPDwgOCk7DQorCSBiYXNlID0gaXNhX3JlYWRiKGJpb3NfYmFzZSAr
IDB4MWZhMykgKyAoaXNhX3JlYWRiKGJpb3NfYmFzZSArIDB4MWZhNCkgPDwg
OCk7DQogCSBicmVhazsNCiAgICAgICBkZWZhdWx0Og0KLQkgYmFzZSA9IHJl
YWRiKGJpb3NfYmFzZSArIDB4MWZjYykgKyAocmVhZGIoYmlvc19iYXNlICsg
MHgxZmNkKSA8PCA4KTsNCisJIGJhc2UgPSBpc2FfcmVhZGIoYmlvc19iYXNl
ICsgMHgxZmNjKSArIChpc2FfcmVhZGIoYmlvc19iYXNlICsgMHgxZmNkKSA8
PCA4KTsNCiAJIGJyZWFrOw0KICAgICAgIH0NCiAgICANCkBAIC0xOTU1LDcg
KzE5NTUsNyBAQA0KIAkgb2Zmc2V0ID0gYmlvc19iYXNlICsgMHgxZjMxICsg
ZHJpdmUgKiAyNTsNCiAJIGJyZWFrOw0KICAgICAgIH0NCi0gICAgICBtZW1j
cHlfZnJvbWlvKCAmaSwgb2Zmc2V0LCBzaXplb2YoIHN0cnVjdCBkcml2ZV9p
bmZvICkgKTsNCisgICAgICBpc2FfbWVtY3B5X2Zyb21pbyggJmksIG9mZnNl
dCwgc2l6ZW9mKCBzdHJ1Y3QgZHJpdmVfaW5mbyApICk7DQogICAgICAgaW5m
b19hcnJheVswXSA9IGkuaGVhZHM7DQogICAgICAgaW5mb19hcnJheVsxXSA9
IGkuc2VjdG9yczsNCiAgICAgICBpbmZvX2FycmF5WzJdID0gaS5jeWxpbmRl
cnM7DQo=
---559023410-851401618-1006903771=:9380--
