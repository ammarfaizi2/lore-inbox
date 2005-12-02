Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVLBCtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVLBCtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVLBCtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:49:09 -0500
Received: from fmr19.intel.com ([134.134.136.18]:55438 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S964810AbVLBCtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:49:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5F6EA.F1486759"
Subject: RE: [BUG] Variable stopmachine_state should be volatile
Date: Fri, 2 Dec 2005 10:48:57 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E840410AF14@pdsmsx404>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] Variable stopmachine_state should be volatile
Thread-Index: AcX2Ye1c3ke+iIr7T6yNJfnl6QNRugAh25eg
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>
X-OriginalArrivalTime: 02 Dec 2005 02:48:58.0565 (UTC) FILETIME=[F192FF50:01C5F6EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5F6EA.F1486759
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

>>-----Original Message-----
>>From: Pavel Machek [mailto:pavel@ucw.cz]
>>Sent: 2005=C4=EA12=D4=C21=C8=D5 18:26
>>To: Zhang, Yanmin
>>Cc: linux-kernel@vger.kernel.org; Pallipadi, Venkatesh; Shah, Rajesh
>>Subject: Re: [BUG] Variable stopmachine_state should be volatile
>>
>>Hi!
>>
>>> >>Those barriers should already prevent compiler optimalization, no? =
If
>>> >>they do not, just use some barriers that do.
>>>
>>>
>>> I hit the problem when compiling 2.6 kernel by intel compiler.
>>> How about to change the type of stopmachine_state to atomic_t?
>>
>>That is certainly safest / very conservative solution.
>>								Pavel
Thanks. The functions are not performance sensitive, so atomic_t is ok. =
Here is the new patch.


------_=_NextPart_001_01C5F6EA.F1486759
Content-Type: application/octet-stream;
	name="stopmachine_state_volatile_2.6.15_rc3_v2.patch"
Content-Transfer-Encoding: base64
Content-Description: stopmachine_state_volatile_2.6.15_rc3_v2.patch
Content-Disposition: attachment;
	filename="stopmachine_state_volatile_2.6.15_rc3_v2.patch"

LS0tIGxpbnV4LTIuNi4xNS1yYzMva2VybmVsL3N0b3BfbWFjaGluZS5jCTIwMDUtMTEtMjkgMDA6
MDI6NDQuMDAwMDAwMDAwICswODAwCisrKyBsaW51eC0yLjYuMTUtcmMzX2ZpeC9rZXJuZWwvc3Rv
cF9tYWNoaW5lLmMJMjAwNS0xMS0zMCAxODo0MTo1NS4wMDAwMDAwMDAgKzA4MDAKQEAgLTEzLDE0
ICsxMywxMiBAQAogICoga3RocmVhZC4gKi8KIAogLyogVGhyZWFkIHRvIHN0b3AgZWFjaCBDUFUg
aW4gdXNlciBjb250ZXh0LiAqLwotZW51bSBzdG9wbWFjaGluZV9zdGF0ZSB7Ci0JU1RPUE1BQ0hJ
TkVfV0FJVCwKLQlTVE9QTUFDSElORV9QUkVQQVJFLAotCVNUT1BNQUNISU5FX0RJU0FCTEVfSVJR
LAotCVNUT1BNQUNISU5FX0VYSVQsCi19OworI2RlZmluZQlTVE9QTUFDSElORV9XQUlUCQkwCisj
ZGVmaW5lCVNUT1BNQUNISU5FX1BSRVBBUkUJCTEKKyNkZWZpbmUJU1RPUE1BQ0hJTkVfRElTQUJM
RV9JUlEJCTIKKyNkZWZpbmUJU1RPUE1BQ0hJTkVfRVhJVAkJMwogCi1zdGF0aWMgZW51bSBzdG9w
bWFjaGluZV9zdGF0ZSBzdG9wbWFjaGluZV9zdGF0ZTsKK3N0YXRpYyBhdG9taWNfdCBzdG9wbWFj
aGluZV9zdGF0ZTsKIHN0YXRpYyB1bnNpZ25lZCBpbnQgc3RvcG1hY2hpbmVfbnVtX3RocmVhZHM7
CiBzdGF0aWMgYXRvbWljX3Qgc3RvcG1hY2hpbmVfdGhyZWFkX2FjazsKIHN0YXRpYyBERUNMQVJF
X01VVEVYKHN0b3BtYWNoaW5lX211dGV4KTsKQEAgLTMzLDI0ICszMSwyMSBAQCBzdGF0aWMgaW50
IHN0b3BtYWNoaW5lKHZvaWQgKmNwdSkKIAlzZXRfY3B1c19hbGxvd2VkKGN1cnJlbnQsIGNwdW1h
c2tfb2ZfY3B1KChpbnQpKGxvbmcpY3B1KSk7CiAKIAkvKiBBY2s6IHdlIGFyZSBhbGl2ZSAqLwot
CXNtcF9tYigpOyAvKiBUaGVvcmV0aWNhbGx5IHRoZSBhY2sgPSAwIG1pZ2h0IG5vdCBiZSBvbiB0
aGlzIENQVSB5ZXQuICovCiAJYXRvbWljX2luYygmc3RvcG1hY2hpbmVfdGhyZWFkX2Fjayk7CiAK
IAkvKiBTaW1wbGUgc3RhdGUgbWFjaGluZSAqLwotCXdoaWxlIChzdG9wbWFjaGluZV9zdGF0ZSAh
PSBTVE9QTUFDSElORV9FWElUKSB7Ci0JCWlmIChzdG9wbWFjaGluZV9zdGF0ZSA9PSBTVE9QTUFD
SElORV9ESVNBQkxFX0lSUSAKKwl3aGlsZSAoYXRvbWljX3JlYWQoJnN0b3BtYWNoaW5lX3N0YXRl
KSAhPSBTVE9QTUFDSElORV9FWElUKSB7CisJCWlmIChhdG9taWNfcmVhZCgmc3RvcG1hY2hpbmVf
c3RhdGUpID09IFNUT1BNQUNISU5FX0RJU0FCTEVfSVJRIAogCQkgICAgJiYgIWlycXNfZGlzYWJs
ZWQpIHsKIAkJCWxvY2FsX2lycV9kaXNhYmxlKCk7CiAJCQlpcnFzX2Rpc2FibGVkID0gMTsKIAkJ
CS8qIEFjazogaXJxcyBkaXNhYmxlZC4gKi8KLQkJCXNtcF9tYigpOyAvKiBNdXN0IHJlYWQgc3Rh
dGUgZmlyc3QuICovCiAJCQlhdG9taWNfaW5jKCZzdG9wbWFjaGluZV90aHJlYWRfYWNrKTsKLQkJ
fSBlbHNlIGlmIChzdG9wbWFjaGluZV9zdGF0ZSA9PSBTVE9QTUFDSElORV9QUkVQQVJFCi0JCQkg
ICAmJiAhcHJlcGFyZWQpIHsKKwkJfSBlbHNlIGlmIChhdG9taWNfcmVhZCgmc3RvcG1hY2hpbmVf
c3RhdGUpCisJCQkJPT0gU1RPUE1BQ0hJTkVfUFJFUEFSRSAmJiAhcHJlcGFyZWQpIHsKIAkJCS8q
IEV2ZXJ5b25lIGlzIGluIHBsYWNlLCBob2xkIENQVS4gKi8KIAkJCXByZWVtcHRfZGlzYWJsZSgp
OwogCQkJcHJlcGFyZWQgPSAxOwotCQkJc21wX21iKCk7IC8qIE11c3QgcmVhZCBzdGF0ZSBmaXJz
dC4gKi8KIAkJCWF0b21pY19pbmMoJnN0b3BtYWNoaW5lX3RocmVhZF9hY2spOwogCQl9CiAJCS8q
IFlpZWxkIGluIGZpcnN0IHN0YWdlOiBtaWdyYXRpb24gdGhyZWFkcyBuZWVkIHRvCkBAIC02Miw3
ICs1Nyw2IEBAIHN0YXRpYyBpbnQgc3RvcG1hY2hpbmUodm9pZCAqY3B1KQogCX0KIAogCS8qIEFj
azogd2UgYXJlIGV4aXRpbmcuICovCi0Jc21wX21iKCk7IC8qIE11c3QgcmVhZCBzdGF0ZSBmaXJz
dC4gKi8KIAlhdG9taWNfaW5jKCZzdG9wbWFjaGluZV90aHJlYWRfYWNrKTsKIAogCWlmIChpcnFz
X2Rpc2FibGVkKQpAQCAtNzQsMTEgKzY4LDEwIEBAIHN0YXRpYyBpbnQgc3RvcG1hY2hpbmUodm9p
ZCAqY3B1KQogfQogCiAvKiBDaGFuZ2UgdGhlIHRocmVhZCBzdGF0ZSAqLwotc3RhdGljIHZvaWQg
c3RvcG1hY2hpbmVfc2V0X3N0YXRlKGVudW0gc3RvcG1hY2hpbmVfc3RhdGUgc3RhdGUpCitzdGF0
aWMgdm9pZCBzdG9wbWFjaGluZV9zZXRfc3RhdGUoaW50IHN0YXRlKQogewogCWF0b21pY19zZXQo
JnN0b3BtYWNoaW5lX3RocmVhZF9hY2ssIDApOwotCXNtcF93bWIoKTsKLQlzdG9wbWFjaGluZV9z
dGF0ZSA9IHN0YXRlOworCWF0b21pY19zZXQoJnN0b3BtYWNoaW5lX3N0YXRlLCBzdGF0ZSk7CiAJ
d2hpbGUgKGF0b21pY19yZWFkKCZzdG9wbWFjaGluZV90aHJlYWRfYWNrKSAhPSBzdG9wbWFjaGlu
ZV9udW1fdGhyZWFkcykKIAkJY3B1X3JlbGF4KCk7CiB9CkBAIC05Nyw3ICs5MCw3IEBAIHN0YXRp
YyBpbnQgc3RvcF9tYWNoaW5lKHZvaWQpCiAKIAlhdG9taWNfc2V0KCZzdG9wbWFjaGluZV90aHJl
YWRfYWNrLCAwKTsKIAlzdG9wbWFjaGluZV9udW1fdGhyZWFkcyA9IDA7Ci0Jc3RvcG1hY2hpbmVf
c3RhdGUgPSBTVE9QTUFDSElORV9XQUlUOworCWF0b21pY19zZXQoJnN0b3BtYWNoaW5lX3N0YXRl
LCBTVE9QTUFDSElORV9XQUlUKTsKIAogCWZvcl9lYWNoX29ubGluZV9jcHUoaSkgewogCQlpZiAo
aSA9PSByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpKQo=

------_=_NextPart_001_01C5F6EA.F1486759--
