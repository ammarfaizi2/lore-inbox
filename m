Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268229AbUHKUwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268229AbUHKUwm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 16:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268226AbUHKUwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 16:52:42 -0400
Received: from fmr06.intel.com ([134.134.136.7]:33475 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S268229AbUHKUwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 16:52:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C47FE5.19682F12"
Subject: RE: [PATCH][2.6] fix i386 idle routine selection
Date: Wed, 11 Aug 2004 13:52:21 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB600296D1A9@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6] fix i386 idle routine selection
Thread-Index: AcR/T5lv5GMpJRvKRiqvztgBSZR0vAAlP+5w
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Aug 2004 20:52:23.0193 (UTC) FILETIME=[19E59090:01C47FE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C47FE5.19682F12
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org=20
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Zwane=20
>Mwaikambo
>
>Hi Venkatesh,
>
>On Tue, 10 Aug 2004, Pallipadi, Venkatesh wrote:
>
>> The original idea of setting it back to default_idle(),
>> was to handle the cases:
>> 1) CPU 0 says it can do mwait and CPU 1 later says it
>> cannot do mwait
>> 2) CPU 0 says it cannot do mwait and later CPU 1 says
>> that it can do mwait
>>
>> Not that I know of any system like that. But, ideally
>> mwait_idle should be set only when all CPUs say that
>> they can do it.
>
>Hmm. Something like mwait/monitor really should be supported on all
>processors in a system running the same executive, if you do happen to
>come across a system with mixed capabilities then we should clear the
>capability during the processor setup so that we never even select the
>mwait idle. So we should defer handling such a scenario until someone
>ships something, but generally the lowest common denominator with
>respect to capabilities should be the BSP.
>

Agreed that handling asymmetric CPUs here is a bit of overkill.=20
We can stick to the original patch + few more cleanups (attached).

Thanks,
Venki


------_=_NextPart_001_01C47FE5.19682F12
Content-Type: application/octet-stream;
	name="mwait_bug1.patch"
Content-Transfer-Encoding: base64
Content-Description: mwait_bug1.patch
Content-Disposition: attachment;
	filename="mwait_bug1.patch"

VGhpcyB3YXMgYnJva2VuIHdoZW4gdGhlIG13YWl0IHN0dWZmIHdlbnQgaW4gc2luY2UgaXQgZXhl
Y3V0ZXMgYWZ0ZXIgdGhlCmluaXRpYWwgaWRsZV9zZXR1cCgpIGhhcyBhbHJlYWR5IHNlbGVjdGVk
IGFuIGlkbGUgcm91dGluZSBhbmQgb3ZlcnJpZGVzIGl0CndpdGggZGVmYXVsdF9pZGxlLgoKU2ln
bmVkLW9mZi1ieTogVmVua2F0ZXNoIFBhbGxpcGFkaSA8dmVua2F0ZXNoLnBhbGxpcGFkaUBpbnRl
bC5jb20+CgotLS0gbGludXgtMi42LjgtcmMyLy9hcmNoL2kzODYva2VybmVsL3Byb2Nlc3MuYy5v
cmcJMjAwNC0wOC0xMCAxOToxMDozMC4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNi44LXJj
Mi8vYXJjaC9pMzg2L2tlcm5lbC9wcm9jZXNzLmMJMjAwNC0wOC0xMSAxNjoxMDoxMi4wMDAwMDAw
MDAgLTA3MDAKQEAgLTIxOCwxOCArMjE4LDEzIEBAIHZvaWQgX19pbml0IHNlbGVjdF9pZGxlX3Jv
dXRpbmUoY29uc3Qgc3QKIAkJcHJpbnRrKCJtb25pdG9yL213YWl0IGZlYXR1cmUgcHJlc2VudC5c
biIpOwogCQkvKgogCQkgKiBTa2lwLCBpZiBzZXR1cCBoYXMgb3ZlcnJpZGRlbiBpZGxlLgotCQkg
KiBBbHNvLCB0YWtlIGNhcmUgb2Ygc3lzdGVtIHdpdGggYXN5bW1ldHJpYyBDUFVzLgotCQkgKiBV
c2UsIG13YWl0X2lkbGUgb25seSBpZiBhbGwgY3B1cyBzdXBwb3J0IGl0LgotCQkgKiBJZiBub3Qs
IHdlIGZhbGxiYWNrIHRvIGRlZmF1bHRfaWRsZSgpCisJCSAqIE9uZSBDUFUgc3VwcG9ydHMgbXdh
aXQgPT4gQWxsIENQVXMgc3VwcG9ydHMgbXdhaXQKIAkJICovCiAJCWlmICghcG1faWRsZSkgewog
CQkJcHJpbnRrKCJ1c2luZyBtd2FpdCBpbiBpZGxlIHRocmVhZHMuXG4iKTsKIAkJCXBtX2lkbGUg
PSBtd2FpdF9pZGxlOwogCQl9Ci0JCXJldHVybjsKIAl9Ci0JcG1faWRsZSA9IGRlZmF1bHRfaWRs
ZTsKLQlyZXR1cm47CiB9CiAKIHN0YXRpYyBpbnQgX19pbml0IGlkbGVfc2V0dXAgKGNoYXIgKnN0
cikKLS0tIGxpbnV4LTIuNi44LXJjMi8vYXJjaC94ODZfNjQva2VybmVsL3Byb2Nlc3MuYy5vcmcJ
MjAwNC0wOC0xMCAxOToxODo0OC4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNi44LXJjMi8v
YXJjaC94ODZfNjQva2VybmVsL3Byb2Nlc3MuYwkyMDA0LTA4LTExIDE2OjEwOjE2LjAwMDAwMDAw
MCAtMDcwMApAQCAtMTY5LDkgKzE2OSw3IEBAIHZvaWQgX19pbml0IHNlbGVjdF9pZGxlX3JvdXRp
bmUoY29uc3Qgc3QKIAlpZiAoY3B1X2hhcyhjLCBYODZfRkVBVFVSRV9NV0FJVCkpIHsKIAkJLyoK
IAkJICogU2tpcCwgaWYgc2V0dXAgaGFzIG92ZXJyaWRkZW4gaWRsZS4KLQkJICogQWxzbywgdGFr
ZSBjYXJlIG9mIHN5c3RlbSB3aXRoIGFzeW1tZXRyaWMgQ1BVcy4KLQkJICogVXNlLCBtd2FpdF9p
ZGxlIG9ubHkgaWYgYWxsIGNwdXMgc3VwcG9ydCBpdC4KLQkJICogSWYgbm90LCB3ZSBmYWxsYmFj
ayB0byBkZWZhdWx0X2lkbGUoKQorCQkgKiBPbmUgQ1BVIHN1cHBvcnRzIG13YWl0ID0+IEFsbCBD
UFVzIHN1cHBvcnRzIG13YWl0CiAJCSAqLwogCQlpZiAoIXBtX2lkbGUpIHsKIAkJCWlmICghcHJp
bnRlZCkgewpAQCAtMTgwLDEwICsxNzgsNyBAQCB2b2lkIF9faW5pdCBzZWxlY3RfaWRsZV9yb3V0
aW5lKGNvbnN0IHN0CiAJCQl9CiAJCQlwbV9pZGxlID0gbXdhaXRfaWRsZTsKIAkJfQotCQlyZXR1
cm47CiAJfQotCXBtX2lkbGUgPSBkZWZhdWx0X2lkbGU7Ci0JcmV0dXJuOwogfQogCiBzdGF0aWMg
aW50IF9faW5pdCBpZGxlX3NldHVwIChjaGFyICpzdHIpCg==

------_=_NextPart_001_01C47FE5.19682F12--
