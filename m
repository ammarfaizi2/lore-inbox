Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVK2Qv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVK2Qv2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVK2Qv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:51:28 -0500
Received: from magic.adaptec.com ([216.52.22.17]:14234 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932168AbVK2Qv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:51:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5F505.225E8498"
Subject: [2.6 patch] dpt_i2o fix for deadlock condition
Date: Tue, 29 Nov 2005 11:51:25 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3DD6C@otce2k03.adaptec.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] dpt_i2o fix for deadlock condition
Thread-Index: AcXy4kNaWepK0VBZRr6U/J1NGyiC0QCIbFww
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: <linux-scsi@vger.kernel.org>
Cc: <James.Bottomley@SteelEye.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5F505.225E8498
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Miquel van Smoorenburg <miquels@cistron.nl> forwarded me this fix to
resolve a deadlock condition that occurs due to the API change in
2.6.13+ kernels dropping the host locking when entering the error
handling. They all end up calling adpt_i2o_post_wait(), which if you
call it unlocked, might return with host_lock locked anyway and that
causes a deadlock.

Signed-off-by: Mark Salyzyn <aacraid@adaptec.com>

 drivers/scsi/dpt_i2o.c |    25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

Patch attached to email due to Outlook corrupting content when inlined.

Sincerely -- Mark Salyzyn

------_=_NextPart_001_01C5F505.225E8498
Content-Type: application/octet-stream;
	name="dpt_i2o.deadlock.patch"
Content-Transfer-Encoding: base64
Content-Description: dpt_i2o.deadlock.patch
Content-Disposition: attachment;
	filename="dpt_i2o.deadlock.patch"

LS0tIGEvZHJpdmVycy9zY3NpL2RwdF9pMm8uYwkyMDA1LTExLTI5IDEwOjM0OjU1LjEwNjA5MDE2
MCAtMDUwMAorKysgYi9kcml2ZXJzL3Njc2kvZHB0X2kyby5jCTIwMDUtMTEtMjkgMTE6NDE6MzYu
OTI0NDY2MDIyIC0wNTAwCkBAIC02NjAsNyArNjYwLDEyIEBACiAJbXNnWzJdID0gMDsKIAltc2db
M109IDA7IAogCW1zZ1s0XSA9ICh1MzIpY21kOwotCWlmKCAocmNvZGUgPSBhZHB0X2kyb19wb3N0
X3dhaXQocEhiYSwgbXNnLCBzaXplb2YobXNnKSwgRk9SRVZFUikpICE9IDApeworCWlmIChwSGJh
LT5ob3N0KQorCQlzcGluX2xvY2tfaXJxKHBIYmEtPmhvc3QtPmhvc3RfbG9jayk7CisJcmNvZGUg
PSBhZHB0X2kyb19wb3N0X3dhaXQocEhiYSwgbXNnLCBzaXplb2YobXNnKSwgRk9SRVZFUik7CisJ
aWYgKHBIYmEtPmhvc3QpCisJCXNwaW5fdW5sb2NrX2lycShwSGJhLT5ob3N0LT5ob3N0X2xvY2sp
OworCWlmIChyY29kZSAhPSAwKSB7CiAJCWlmKHJjb2RlID09IC1FT1BOT1RTVVBQICl7CiAJCQlw
cmludGsoS0VSTl9JTkZPIiVzOiBBYm9ydCBjbWQgbm90IHN1cHBvcnRlZFxuIixwSGJhLT5uYW1l
KTsKIAkJCXJldHVybiBGQUlMRUQ7CkBAIC02OTcsMTAgKzcwMiwxNSBAQAogCW1zZ1syXSA9IDA7
CiAJbXNnWzNdID0gMDsKIAorCWlmIChwSGJhLT5ob3N0KQorCQlzcGluX2xvY2tfaXJxKHBIYmEt
Pmhvc3QtPmhvc3RfbG9jayk7CiAJb2xkX3N0YXRlID0gZC0+c3RhdGU7CiAJZC0+c3RhdGUgfD0g
RFBUSV9ERVZfUkVTRVQ7Ci0JaWYoIChyY29kZSA9IGFkcHRfaTJvX3Bvc3Rfd2FpdChwSGJhLCBt
c2csc2l6ZW9mKG1zZyksIEZPUkVWRVIpKSApewotCQlkLT5zdGF0ZSA9IG9sZF9zdGF0ZTsKKwly
Y29kZSA9IGFkcHRfaTJvX3Bvc3Rfd2FpdChwSGJhLCBtc2csc2l6ZW9mKG1zZyksIEZPUkVWRVIp
OworCWQtPnN0YXRlID0gb2xkX3N0YXRlOworCWlmIChwSGJhLT5ob3N0KQorCQlzcGluX3VubG9j
a19pcnEocEhiYS0+aG9zdC0+aG9zdF9sb2NrKTsKKwlpZiAocmNvZGUgIT0gMCkgewogCQlpZihy
Y29kZSA9PSAtRU9QTk9UU1VQUCApewogCQkJcHJpbnRrKEtFUk5fSU5GTyIlczogRGV2aWNlIHJl
c2V0IG5vdCBzdXBwb3J0ZWRcbiIscEhiYS0+bmFtZSk7CiAJCQlyZXR1cm4gRkFJTEVEOwpAQCAt
NzA4LDcgKzcxOCw2IEBACiAJCXByaW50ayhLRVJOX0lORk8iJXM6IERldmljZSByZXNldCBmYWls
ZWRcbiIscEhiYS0+bmFtZSk7CiAJCXJldHVybiBGQUlMRUQ7CiAJfSBlbHNlIHsKLQkJZC0+c3Rh
dGUgPSBvbGRfc3RhdGU7CiAJCXByaW50ayhLRVJOX0lORk8iJXM6IERldmljZSByZXNldCBzdWNj
ZXNzZnVsXG4iLHBIYmEtPm5hbWUpOwogCQlyZXR1cm4gU1VDQ0VTUzsKIAl9CkBAIC03MjEsNiAr
NzMwLDcgQEAKIHsKIAlhZHB0X2hiYSogcEhiYTsKIAl1MzIgbXNnWzRdOworCXUzMiByY29kZTsK
IAogCXBIYmEgPSAoYWRwdF9oYmEqKWNtZC0+ZGV2aWNlLT5ob3N0LT5ob3N0ZGF0YVswXTsKIAlt
ZW1zZXQobXNnLCAwLCBzaXplb2YobXNnKSk7CkBAIC03MjksNyArNzM5LDEyIEBACiAJbXNnWzFd
ID0gKEkyT19IQkFfQlVTX1JFU0VUPDwyNHxIT1NUX1RJRDw8MTJ8cEhiYS0+Y2hhbm5lbFtjbWQt
PmRldmljZS0+Y2hhbm5lbF0udGlkKTsKIAltc2dbMl0gPSAwOwogCW1zZ1szXSA9IDA7Ci0JaWYo
YWRwdF9pMm9fcG9zdF93YWl0KHBIYmEsIG1zZyxzaXplb2YobXNnKSwgRk9SRVZFUikgKXsKKwlp
ZiAocEhiYS0+aG9zdCkKKwkJc3Bpbl9sb2NrX2lycShwSGJhLT5ob3N0LT5ob3N0X2xvY2spOwor
CXJjb2RlID0gYWRwdF9pMm9fcG9zdF93YWl0KHBIYmEsIG1zZyxzaXplb2YobXNnKSwgRk9SRVZF
Uik7CisJaWYgKHBIYmEtPmhvc3QpCisJCXNwaW5fdW5sb2NrX2lycShwSGJhLT5ob3N0LT5ob3N0
X2xvY2spOworCWlmIChyY29kZSAhPSAwKSB7CiAJCXByaW50ayhLRVJOX1dBUk5JTkciJXM6IEJ1
cyByZXNldCBmYWlsZWQuXG4iLHBIYmEtPm5hbWUpOwogCQlyZXR1cm4gRkFJTEVEOwogCX0gZWxz
ZSB7Cg==

------_=_NextPart_001_01C5F505.225E8498--
