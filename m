Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268505AbUHYHc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268505AbUHYHc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 03:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268511AbUHYHc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 03:32:59 -0400
Received: from fmr12.intel.com ([134.134.136.15]:50607 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S268505AbUHYHcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 03:32:55 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C48A75.B2EDFC49"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: interrupt is enabled before it should be when kernel is booted
Date: Wed, 25 Aug 2004 15:32:38 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E843936F6@pdsmsx404>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: interrupt is enabled before it should be when kernel is booted
Thread-Index: AcSJpKnt8shjlyZpS7KgENRmk/3kzQA0I9kQ
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Aug 2004 07:32:39.0831 (UTC) FILETIME=[B35E1270:01C48A75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C48A75.B2EDFC49
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

The attachment is a new patch against kernel 2.6.9-rc1.

Signed-off-by:	Zhang Yanmin <yanmin.zhang@intel.com>
Signed-off-by:	Yao Jun	<junx.yao@intel.com>



>>-----Original Message-----
>>From: Zhang, Yanmin
>>Sent: 2004年8月24日 14:36
>>To: linux-kernel@vger.kernel.org
>>Subject: interrupt is enabled before it should be when kernel is booted
>>
>>There is a minor problem in function start_kernel. start_kernel will enable
>>interrupt after calling profile_init. However, before that, function time_init
>>on IA64 platform could enable interrupt. See this call sequence:
>>start_kernel->time_init->ia64_init_itm->register_time_interpolator->write_
>>seqlock_irq.
>>The attachment is a patch to fix it in generic source codes against 2.6.8.


------_=_NextPart_001_01C48A75.B2EDFC49
Content-Type: application/octet-stream;
	name="time_init_enable_interrupt.patch.diff"
Content-Transfer-Encoding: base64
Content-Description: time_init_enable_interrupt.patch.diff
Content-Disposition: attachment;
	filename="time_init_enable_interrupt.patch.diff"

ZGlmZiAtTnJhdXAgbGludXgtMi42LjktcmMxL2tlcm5lbC90aW1lci5jIGxpbnV4LTIuNi45LXJj
MV9maXgva2VybmVsL3RpbWVyLmMKLS0tIGxpbnV4LTIuNi45LXJjMS9rZXJuZWwvdGltZXIuYwky
MDA0LTA4LTI1IDEyOjA5OjM2LjY0ODMwMzgzMiArMDgwMAorKysgbGludXgtMi42LjktcmMxX2Zp
eC9rZXJuZWwvdGltZXIuYwkyMDA0LTA4LTI1IDEyOjEwOjM0LjE4NjM4OTA2NCArMDgwMApAQCAt
MTQ0NiwxMSArMTQ0NiwxMyBAQCBpc19iZXR0ZXJfdGltZV9pbnRlcnBvbGF0b3Ioc3RydWN0IHRp
bWVfCiB2b2lkCiByZWdpc3Rlcl90aW1lX2ludGVycG9sYXRvcihzdHJ1Y3QgdGltZV9pbnRlcnBv
bGF0b3IgKnRpKQogeworCXVuc2lnbmVkIGxvbmcJZmxhZ3M7CisKIAlzcGluX2xvY2soJnRpbWVf
aW50ZXJwb2xhdG9yX2xvY2spOwotCXdyaXRlX3NlcWxvY2tfaXJxKCZ4dGltZV9sb2NrKTsKKwl3
cml0ZV9zZXFsb2NrX2lycXNhdmUoJnh0aW1lX2xvY2ssIGZsYWdzKTsKIAlpZiAoaXNfYmV0dGVy
X3RpbWVfaW50ZXJwb2xhdG9yKHRpKSkKIAkJdGltZV9pbnRlcnBvbGF0b3IgPSB0aTsKLQl3cml0
ZV9zZXF1bmxvY2tfaXJxKCZ4dGltZV9sb2NrKTsKKwl3cml0ZV9zZXF1bmxvY2tfaXJxcmVzdG9y
ZSgmeHRpbWVfbG9jaywgZmxhZ3MpOwogCiAJdGktPm5leHQgPSB0aW1lX2ludGVycG9sYXRvcl9s
aXN0OwogCXRpbWVfaW50ZXJwb2xhdG9yX2xpc3QgPSB0aTsKQEAgLTE0NjEsNiArMTQ2Myw3IEBA
IHZvaWQKIHVucmVnaXN0ZXJfdGltZV9pbnRlcnBvbGF0b3Ioc3RydWN0IHRpbWVfaW50ZXJwb2xh
dG9yICp0aSkKIHsKIAlzdHJ1Y3QgdGltZV9pbnRlcnBvbGF0b3IgKmN1cnIsICoqcHJldjsKKwl1
bnNpZ25lZCBsb25nCWZsYWdzOwogCiAJc3Bpbl9sb2NrKCZ0aW1lX2ludGVycG9sYXRvcl9sb2Nr
KTsKIAlwcmV2ID0gJnRpbWVfaW50ZXJwb2xhdG9yX2xpc3Q7CkBAIC0xNDcyLDcgKzE0NzUsNyBA
QCB1bnJlZ2lzdGVyX3RpbWVfaW50ZXJwb2xhdG9yKHN0cnVjdCB0aW1lCiAJCXByZXYgPSAmY3Vy
ci0+bmV4dDsKIAl9CiAKLQl3cml0ZV9zZXFsb2NrX2lycSgmeHRpbWVfbG9jayk7CisJd3JpdGVf
c2VxbG9ja19pcnFzYXZlKCZ4dGltZV9sb2NrLCBmbGFncyk7CiAJaWYgKHRpID09IHRpbWVfaW50
ZXJwb2xhdG9yKSB7CiAJCS8qIHdlIGxvc3QgdGhlIGJlc3QgdGltZS1pbnRlcnBvbGF0b3I6ICov
CiAJCXRpbWVfaW50ZXJwb2xhdG9yID0gTlVMTDsKQEAgLTE0ODEsNyArMTQ4NCw3IEBAIHVucmVn
aXN0ZXJfdGltZV9pbnRlcnBvbGF0b3Ioc3RydWN0IHRpbWUKIAkJCWlmIChpc19iZXR0ZXJfdGlt
ZV9pbnRlcnBvbGF0b3IoY3VycikpCiAJCQkJdGltZV9pbnRlcnBvbGF0b3IgPSBjdXJyOwogCX0K
LQl3cml0ZV9zZXF1bmxvY2tfaXJxKCZ4dGltZV9sb2NrKTsKKwl3cml0ZV9zZXF1bmxvY2tfaXJx
cmVzdG9yZSgmeHRpbWVfbG9jaywgZmxhZ3MpOwogCXNwaW5fdW5sb2NrKCZ0aW1lX2ludGVycG9s
YXRvcl9sb2NrKTsKIH0KICNlbmRpZiAvKiBDT05GSUdfVElNRV9JTlRFUlBPTEFUSU9OICovCg==

------_=_NextPart_001_01C48A75.B2EDFC49--
