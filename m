Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132671AbRAHLUr>; Mon, 8 Jan 2001 06:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131097AbRAHLUi>; Mon, 8 Jan 2001 06:20:38 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:34229 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132888AbRAHLU1>; Mon, 8 Jan 2001 06:20:27 -0500
Date: Mon, 8 Jan 2001 11:20:26 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Willem Dekker <dekker@serc.nl>
cc: linux-kernel@vger.kernel.org
Subject: RE: [PTACH] wrong stat of NTFS volume in linux-kernel 2.4.0
Message-ID: <Pine.SOL.3.96.1010108111401.18030A-200000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-978952425=:17453"
Content-ID: <Pine.SOL.3.96.1010108111401.18030B@libra.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-978952425=:17453
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.SOL.3.96.1010108111401.18030C@libra.cus.cam.ac.uk>

Willem,

First of all thanks for tracking down this bug! Keep up the good work.

I have produced a IMHO more elegant solution (see attached patch) which
doesn't require introducing the ugly divide function by using the
asm/bitops.h::ffs() function and then replacing all clusterfactor
arithmetic with shifts by the (new) clusterfactorbits. In fact the
clusterfactor is completely replaced by the clusterfactorbits in the
driver.

The patch has been submitted to Alan for inclusion in the 2.4.0-ac series
as Linus at present only accepts critical patches which this clearly is
not.

btw. Patch is tested and works fine.

Best regards,

	Anton Altaparmakov

-- 
Anton Altaparmakov       Phone: +44-(0)1223-333541 (lab)
Christ's College         eMail: AntonA@bigfoot.com
Cambridge CB2 3BU          WWW: http://www-stu.christs.cam.ac.uk/~aia21/
United Kingdom             ICQ: 8561279

---559023410-851401618-978952425=:17453
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ntfs_df_fix.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.96.1010108111345.17453B@libra.cus.cam.ac.uk>
Content-Description: 

LS0tIGxpbnV4L2ZzL250ZnMvc3VwZXIub2xkCU1vbiBKYW4gIDggMDk6MDg6
MTAgMjAwMQ0KKysrIGxpbnV4L2ZzL250ZnMvc3VwZXIuYwlNb24gSmFuICA4
IDAyOjM2OjMzIDIwMDENCkBAIC0xMiw2ICsxMiw3IEBADQogI2luY2x1ZGUg
InN1cGVyLmgiDQogDQogI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+DQorI2lu
Y2x1ZGUgPGFzbS9iaXRvcHMuaD4NCiAjaW5jbHVkZSAibWFjcm9zLmgiDQog
I2luY2x1ZGUgImlub2RlLmgiDQogI2luY2x1ZGUgInN1cHBvcnQuaCINCkBA
IC03NSw3ICs3Niw3IEBADQogDQogCS8qIFNlY3RvciBzaXplICovDQogCXZv
bC0+YmxvY2tzaXplPU5URlNfR0VUVTE2KGJvb3QrMHhCKTsNCi0Jdm9sLT5j
bHVzdGVyZmFjdG9yPU5URlNfR0VUVTgoYm9vdCsweEQpOw0KKwl2b2wtPmNs
dXN0ZXJmYWN0b3JiaXRzID0gZmZzKE5URlNfR0VUVTgoYm9vdCsweEQpKSAt
IDE7DQogCXZvbC0+bWZ0X2NsdXN0ZXJzX3Blcl9yZWNvcmQ9TlRGU19HRVRT
OChib290KzB4NDApOw0KIAl2b2wtPmluZGV4X2NsdXN0ZXJzX3Blcl9yZWNv
cmQ9TlRGU19HRVRTOChib290KzB4NDQpOw0KIAkNCkBAIC05NSw3ICs5Niw3
IEBADQogCWlmKHZvbC0+bWZ0X2NsdXN0ZXJzX3Blcl9yZWNvcmQ8MCAmJiB2
b2wtPm1mdF9jbHVzdGVyc19wZXJfcmVjb3JkIT0tMTApDQogCQludGZzX2Vy
cm9yKCJVbmV4cGVjdGVkIGRhdGEgIzQgaW4gYm9vdCBibG9ja1xuIik7DQog
DQotCXZvbC0+Y2x1c3RlcnNpemU9dm9sLT5ibG9ja3NpemUqdm9sLT5jbHVz
dGVyZmFjdG9yOw0KKwl2b2wtPmNsdXN0ZXJzaXplID0gdm9sLT5ibG9ja3Np
emUgPDwgdm9sLT5jbHVzdGVyZmFjdG9yYml0czsNCiAJaWYodm9sLT5tZnRf
Y2x1c3RlcnNfcGVyX3JlY29yZD4wKQ0KIAkJdm9sLT5tZnRfcmVjb3Jkc2l6
ZT0NCiAJCQl2b2wtPmNsdXN0ZXJzaXplKnZvbC0+bWZ0X2NsdXN0ZXJzX3Bl
cl9yZWNvcmQ7DQpAQCAtMzIyLDcgKzMyMyw3IEBADQogCWlvLmRvX3JlYWQ9
MTsNCiAJaW8uc2l6ZT12b2wtPmNsdXN0ZXJzaXplOw0KIAludGZzX2dldHB1
dF9jbHVzdGVycyh2b2wsMCwwLCZpbyk7DQotCSp2b2xfc2l6ZSA9IE5URlNf
R0VUVTY0KGNsdXN0ZXIwKzB4MjgpOw0KKwkqdm9sX3NpemUgPSBOVEZTX0dF
VFU2NChjbHVzdGVyMCsweDI4KSA+PiB2b2wtPmNsdXN0ZXJmYWN0b3JiaXRz
Ow0KIAludGZzX2ZyZWUoY2x1c3RlcjApOw0KIAlyZXR1cm4gMDsNCiB9DQot
LS0gbGludXgvZnMvbnRmcy9zdHJ1Y3Qub2xkCU1vbiBKYW4gIDggMDI6Mzc6
MTggMjAwMQ0KKysrIGxpbnV4L2ZzL250ZnMvc3RydWN0LmgJTW9uIEphbiAg
OCAwMjozNToxNSAyMDAxDQpAQCAtNTQsNyArNTQsNyBAQA0KIAludGZzX3Uz
MiBhdF9zeW1saW5rOyAvKiBha2EgU1lNQk9MSUNfTElOSyBvciBSRVBBUlNF
X1BPSU5UICovDQogCS8qIERhdGEgcmVhZCBmcm9tIHRoZSBib290IGZpbGUg
Ki8NCiAJaW50IGJsb2Nrc2l6ZTsNCi0JaW50IGNsdXN0ZXJmYWN0b3I7DQor
CWludCBjbHVzdGVyZmFjdG9yYml0czsNCiAJaW50IGNsdXN0ZXJzaXplOw0K
IAlpbnQgbWZ0X3JlY29yZHNpemU7DQogCWludCBtZnRfY2x1c3RlcnNfcGVy
X3JlY29yZDsNCi0tLSBsaW51eC9pbmNsdWRlL2xpbnV4L250ZnNfZnNfc2Iu
b2xkCU1vbiBKYW4gIDggMDI6Mzc6NDYgMjAwMQ0KKysrIGxpbnV4L2luY2x1
ZGUvbGludXgvbnRmc19mc19zYi5oCU1vbiBKYW4gIDggMDI6Mzc6NTQgMjAw
MQ0KQEAgLTI2LDcgKzI2LDcgQEANCiAJbnRmc191MzIgYXRfc3ltbGluazsg
LyogYWthIFNZTUJPTElDX0xJTksgb3IgUkVQQVJTRV9QT0lOVCAqLw0KIAkv
KiBEYXRhIHJlYWQgZnJvbSB0aGUgYm9vdCBmaWxlICovDQogCWludCBibG9j
a3NpemU7DQotCWludCBjbHVzdGVyZmFjdG9yOw0KKwlpbnQgY2x1c3RlcmZh
Y3RvcmJpdHM7DQogCWludCBjbHVzdGVyc2l6ZTsNCiAJaW50IG1mdF9yZWNv
cmRzaXplOw0KIAlpbnQgbWZ0X2NsdXN0ZXJzX3Blcl9yZWNvcmQ7DQo=
---559023410-851401618-978952425=:17453--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
