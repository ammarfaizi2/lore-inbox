Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268971AbUIHCVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268971AbUIHCVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 22:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268972AbUIHCVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 22:21:17 -0400
Received: from fmr06.intel.com ([134.134.136.7]:17821 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S268971AbUIHCVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 22:21:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4954A.7B2A6DBA"
Subject: RE: [ACPI] Re: [PATCH] Oops and panic while unloading holder of pm_idle
Date: Wed, 8 Sep 2004 10:20:59 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575120967@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] Re: [PATCH] Oops and panic while unloading holder of pm_idle
Thread-Index: AcSU885iMCehqemiQcmgE2lhitbGxgATzjNw
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>,
       "BlaisorBlade" <blaisorblade_spam@yahoo.it>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>, "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 08 Sep 2004 02:21:00.0472 (UTC) FILETIME=[7B76D380:01C4954A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4954A.7B2A6DBA
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Zwane Mwaikambo wrote:
>To: BlaisorBlade
>Cc: linux-kernel@vger.kernel.org; acpi-devel@lists.sourceforge.net;
Brown,
>Len
>Subject: [ACPI] Re: [PATCH] Oops and panic while unloading holder of
>pm_idle
>
>On Sun, 5 Sep 2004, BlaisorBlade wrote:
>
>> > There aren't many users of pm_idle
>> > outside of arch/*/kernel/process.c
>> Both APM and ACPI set pm_idle, and both can be modular. It seems,
however,
>> they are the only such ones. And since they APM and ACPI refuse to be
>both
>> loaded, we cannot have (actually) two modules which override pm_idle.
So
>> you're right.
>
>There are a few other issues with pm_idle, preempt and modular drivers
>which someone else is looking at, we'll see how things go from there.
Yes, preempt will cause oops in pc_idle. Attached patch should close the
final race corner.=20

Thanks,
Shaohua

------_=_NextPart_001_01C4954A.7B2A6DBA
Content-Type: application/octet-stream;
	name="idle.patch"
Content-Transfer-Encoding: base64
Content-Description: idle.patch
Content-Disposition: attachment;
	filename="idle.patch"

PT09PT0gYXJjaC9pMzg2L2tlcm5lbC9hcG0uYyAxLjY3IHZzIGVkaXRlZCA9PT09PQotLS0gMS42
Ny9hcmNoL2kzODYva2VybmVsL2FwbS5jCTIwMDQtMDgtMjQgMTc6MDg6NDcgKzA4OjAwCisrKyBl
ZGl0ZWQvYXJjaC9pMzg2L2tlcm5lbC9hcG0uYwkyMDA0LTA5LTA4IDA4OjQ4OjEyICswODowMApA
QCAtMjM2Miw4ICsyMzYyLDEzIEBAIHN0YXRpYyB2b2lkIF9fZXhpdCBhcG1fZXhpdCh2b2lkKQog
ewogCWludAllcnJvcjsKIAotCWlmIChzZXRfcG1faWRsZSkKKwlpZiAoc2V0X3BtX2lkbGUpIHsK
IAkJcG1faWRsZSA9IG9yaWdpbmFsX3BtX2lkbGU7CisJCS8qIFdhaXQgdGhlIGlkbGUgdGhyZWFk
IHRvIHJlYWQgdGhlIG5ldyB2YWx1ZSwgCisJCSAqIG90aGVyd2lzZSB3ZSBPb3BzLgorCQkgKi8K
KwkJc3luY2hyb25pemVfa2VybmVsKCk7CisJfQogCWlmICgoKGFwbV9pbmZvLmJpb3MuZmxhZ3Mg
JiBBUE1fQklPU19ESVNFTkdBR0VEKSA9PSAwKQogCSAgICAmJiAoYXBtX2luZm8uY29ubmVjdGlv
bl92ZXJzaW9uID4gMHgwMTAwKSkgewogCQllcnJvciA9IGFwbV9lbmdhZ2VfcG93ZXJfbWFuYWdl
bWVudChBUE1fREVWSUNFX0FMTCwgMCk7Cj09PT09IGFyY2gvaTM4Ni9rZXJuZWwvcHJvY2Vzcy5j
IDEuNzUgdnMgZWRpdGVkID09PT09Ci0tLSAxLjc1L2FyY2gvaTM4Ni9rZXJuZWwvcHJvY2Vzcy5j
CTIwMDQtMDgtMjQgMTc6MDg6NDQgKzA4OjAwCisrKyBlZGl0ZWQvYXJjaC9pMzg2L2tlcm5lbC9w
cm9jZXNzLmMJMjAwNC0wOS0wOCAwOTowMDowNiArMDg6MDAKQEAgLTE0Miw2ICsxNDIsMTAgQEAg
dm9pZCBjcHVfaWRsZSAodm9pZCkKIAkvKiBlbmRsZXNzIGlkbGUgbG9vcCB3aXRoIG5vIHByaW9y
aXR5IGF0IGFsbCAqLwogCXdoaWxlICgxKSB7CiAJCXdoaWxlICghbmVlZF9yZXNjaGVkKCkpIHsK
KwkJCS8qIElmIHBtX2lkbGUgaXMgaW4gYSBtb2R1bGUgYW5kIGlzIHByZWVtcHRlZCwKKwkJCSAq
IG9vcHMgb2NjdXJzLiBEaXNhYmxlIHByZWVtcHQuCisJCQkgKi8KKwkJCXJjdV9yZWFkX2xvY2so
KTsKIAkJCXZvaWQgKCppZGxlKSh2b2lkKSA9IHBtX2lkbGU7CiAKIAkJCWlmICghaWRsZSkKQEAg
LTE0OSw2ICsxNTMsNyBAQCB2b2lkIGNwdV9pZGxlICh2b2lkKQogCiAJCQlpcnFfc3RhdFtzbXBf
cHJvY2Vzc29yX2lkKCldLmlkbGVfdGltZXN0YW1wID0gamlmZmllczsKIAkJCWlkbGUoKTsKKwkJ
CXJjdV9yZWFkX3VubG9jaygpOwogCQl9CiAJCXNjaGVkdWxlKCk7CiAJfQo9PT09PSBhcmNoL2lh
NjQva2VybmVsL3Byb2Nlc3MuYyAxLjYyIHZzIGVkaXRlZCA9PT09PQotLS0gMS42Mi9hcmNoL2lh
NjQva2VybmVsL3Byb2Nlc3MuYwkyMDA0LTA3LTI3IDEzOjI2OjUwICswODowMAorKysgZWRpdGVk
L2FyY2gvaWE2NC9rZXJuZWwvcHJvY2Vzcy5jCTIwMDQtMDktMDggMDk6MDQ6NTggKzA4OjAwCkBA
IC0yMjgsMTggKzIyOCwyNCBAQCBjcHVfaWRsZSAodm9pZCAqdW51c2VkKQogCiAJLyogZW5kbGVz
cyBpZGxlIGxvb3Agd2l0aCBubyBwcmlvcml0eSBhdCBhbGwgKi8KIAl3aGlsZSAoMSkgewotCQl2
b2lkICgqaWRsZSkodm9pZCkgPSBwbV9pZGxlOwotCQlpZiAoIWlkbGUpCi0JCQlpZGxlID0gZGVm
YXVsdF9pZGxlOwotCiAjaWZkZWYgQ09ORklHX1NNUAogCQlpZiAoIW5lZWRfcmVzY2hlZCgpKQog
CQkJbWluX3h0cCgpOwogI2VuZGlmCiAJCXdoaWxlICghbmVlZF9yZXNjaGVkKCkpIHsKKwkJCXZv
aWQgKCppZGxlKSh2b2lkKSA9IE5VTEw7CisJCQkKIAkJCWlmIChtYXJrX2lkbGUpCiAJCQkJKCpt
YXJrX2lkbGUpKDEpOworCQkJLyogSWYgcG1faWRsZSBpcyBpbiBhIG1vZHVsZSBhbmQgaXMgcHJl
ZW1wdGVkLAorCQkJICogb29wcyBvY2N1cnMuIERpc2FibGUgcHJlZW1wdC4KKwkJCSAqLworCQkJ
cmN1X3JlYWRfbG9jaygpOworCQkJaWRsZT0gcG1faWRsZTsKKwkJCWlmICghaWRsZSkKKwkJCQlp
ZGxlID0gZGVmYXVsdF9pZGxlOwogCQkJKCppZGxlKSgpOworCQkJcmN1X3JlYWRfdW5sb2NrKCk7
CiAJCX0KIAogCQlpZiAobWFya19pZGxlKQo9PT09PSBhcmNoL3g4Nl82NC9rZXJuZWwvcHJvY2Vz
cy5jIDEuMzUgdnMgZWRpdGVkID09PT09Ci0tLSAxLjM1L2FyY2gveDg2XzY0L2tlcm5lbC9wcm9j
ZXNzLmMJMjAwNC0wOC0yNCAxNzowODo0NCArMDg6MDAKKysrIGVkaXRlZC9hcmNoL3g4Nl82NC9r
ZXJuZWwvcHJvY2Vzcy5jCTIwMDQtMDktMDggMDk6MDQ6MzEgKzA4OjAwCkBAIC0xMzAsMTEgKzEz
MCwxOCBAQCB2b2lkIGNwdV9pZGxlICh2b2lkKQogewogCS8qIGVuZGxlc3MgaWRsZSBsb29wIHdp
dGggbm8gcHJpb3JpdHkgYXQgYWxsICovCiAJd2hpbGUgKDEpIHsKLQkJdm9pZCAoKmlkbGUpKHZv
aWQpID0gcG1faWRsZTsKLQkJaWYgKCFpZGxlKQotCQkJaWRsZSA9IGRlZmF1bHRfaWRsZTsKLQkJ
d2hpbGUgKCFuZWVkX3Jlc2NoZWQoKSkKKwkJd2hpbGUgKCFuZWVkX3Jlc2NoZWQoKSkgeworCQkJ
dm9pZCAoKmlkbGUpKHZvaWQpID0gTlVMTDsKKwkJCS8qIElmIHBtX2lkbGUgaXMgaW4gYSBtb2R1
bGUgYW5kIGlzIHByZWVtcHRlZCwKKwkJCSAqIG9vcHMgb2NjdXJzLiBEaXNhYmxlIHByZWVtcHQu
CisJCQkgKi8KKwkJCXJjdV9yZWFkX2xvY2soKTsKKwkJCWlkbGUgPSBwbV9pZGxlOworCQkJaWYg
KCFpZGxlKQorCQkJCWlkbGUgPSBkZWZhdWx0X2lkbGU7CiAJCQlpZGxlKCk7CisJCQlyY3VfcmVh
ZF91bmxvY2soKTsKKwkJfQogCQlzY2hlZHVsZSgpOwogCX0KIH0KPT09PT0gZHJpdmVycy9hY3Bp
L3Byb2Nlc3Nvci5jIDEuNjEgdnMgZWRpdGVkID09PT09Ci0tLSAxLjYxL2RyaXZlcnMvYWNwaS9w
cm9jZXNzb3IuYwkyMDA0LTA4LTMxIDIzOjI3OjI5ICswODowMAorKysgZWRpdGVkL2RyaXZlcnMv
YWNwaS9wcm9jZXNzb3IuYwkyMDA0LTA5LTA4IDA5OjEyOjM0ICswODowMApAQCAtMjQxOSw2ICsy
NDE5LDkgQEAgYWNwaV9wcm9jZXNzb3JfcmVtb3ZlICgKIAkvKiBVbnJlZ2lzdGVyIHRoZSBpZGxl
IGhhbmRsZXIgd2hlbiBwcm9jZXNzb3IgIzAgaXMgcmVtb3ZlZC4gKi8KIAlpZiAocHItPmlkID09
IDApIHsKIAkJcG1faWRsZSA9IHBtX2lkbGVfc2F2ZTsKKwkJLyogV2FpdCB0aGUgaWRsZSB0aHJl
YWQgdG8gcmVhZCB0aGUgbmV3IHZhbHVlLAorCQkgKiBvdGhlcndpc2Ugd2UgT29wcy4KKwkJICov
CiAJCXN5bmNocm9uaXplX2tlcm5lbCgpOwogCX0KIAo=

------_=_NextPart_001_01C4954A.7B2A6DBA--
