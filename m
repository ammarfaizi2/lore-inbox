Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317726AbSFLQTK>; Wed, 12 Jun 2002 12:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317732AbSFLQTJ>; Wed, 12 Jun 2002 12:19:09 -0400
Received: from ierw.net.avaya.com ([198.152.13.101]:5355 "EHLO
	ierw.net.avaya.com") by vger.kernel.org with ESMTP
	id <S317726AbSFLQTI>; Wed, 12 Jun 2002 12:19:08 -0400
Date: Wed, 12 Jun 2002 10:19:51 -0600 (MDT)
From: "Bhavesh P. Davda" <bhavesh@avaya.com>
X-X-Sender: bhavesh@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: bhavesh@avaya.com
Subject: [PATCH] SCHED_FIFO and SCHED_RR scheduler fix, kernel 2.4.18
Message-ID: <Pine.LNX.4.44.0206120942410.2422-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1301095649-1023898791=:2422"
X-OriginalArrivalTime: 12 Jun 2002 16:19:24.0781 (UTC) FILETIME=[EAD9F9D0:01C2122C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1301095649-1023898791=:2422
Content-Type: TEXT/PLAIN; charset=US-ASCII


The 2.4.18 kernel was behaving incorrectly for SCHED_FIFO and SCHED_RR 
scheduling. 

The correct behaviour for SCHED_FIFO is priority preemption:
run to completion, or system call, or preemption by higher priority 
process. The correct behaviour for SCHED_RR is the same as SCHED_FIFO for 
the preemption case, or run for a time slice, and go to the back of the 
run queue for that priority.

More details can be found at:

http://www.opengroup.org/onlinepubs/7908799/xsh/realtime.html

As a side note, SCHED_RR is completely broken in the 2.2 series kernels.

This is a small patch, but fixes the behaviour for SCHED_FIFO and SCHED_RR 
scheduling in the 2.4.18 kernel. It also improves the efficiency of the 
kernel by NOT calling schedule() for every tick for a SCHED_FIFO process.

-- 
Bhavesh P. Davda
Avaya Inc
bhavesh@avaya.com

--8323328-1301095649-1023898791=:2422
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4.18-sched.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0206121019510.2422@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.4.18-sched.patch"

ZGlmZiAtTmF1ciBsaW51eC0yLjQuMTgva2VybmVsL3NjaGVkLmMgbGludXgt
Mi40LjE4LWJwZC9rZXJuZWwvc2NoZWQuYw0KLS0tIGxpbnV4LTIuNC4xOC9r
ZXJuZWwvc2NoZWQuYwlGcmkgRGVjIDIxIDEwOjQyOjA0IDIwMDENCisrKyBs
aW51eC0yLjQuMTgtYnBkL2tlcm5lbC9zY2hlZC5jCVdlZCBKdW4gMTIgMDk6
MTI6MTIgMjAwMg0KQEAgLTMxOCwxMyArMzE4LDE3IEBADQogLyoNCiAgKiBD
YXJlZnVsIQ0KICAqDQotICogVGhpcyBoYXMgdG8gYWRkIHRoZSBwcm9jZXNz
IHRvIHRoZSBfYmVnaW5uaW5nXyBvZiB0aGUNCi0gKiBydW4tcXVldWUsIG5v
dCB0aGUgZW5kLiBTZWUgdGhlIGNvbW1lbnQgYWJvdXQgIlRoaXMgaXMNCi0g
KiBzdWJ0bGUiIGluIHRoZSBzY2hlZHVsZXIgcHJvcGVyLi4NCisgKiBUaGlz
IGhhcyB0byBhZGQgdGhlIHByb2Nlc3MgdG8gdGhlIF9lbmRfIG9mIHRoZSAN
CisgKiBydW4tcXVldWUsIG5vdCB0aGUgYmVnaW5uaW5nLiBUaGUgZ29vZG5l
c3MgdmFsdWUgd2lsbA0KKyAqIGRldGVybWluZSB3aGV0aGVyIHRoaXMgcHJv
Y2VzcyB3aWxsIHJ1biBuZXh0LiBUaGlzIGlzDQorICogaW1wb3J0YW50IHRv
IGdldCBTQ0hFRF9GSUZPIGFuZCBTQ0hFRF9SUiByaWdodCwgd2hlcmUNCisg
KiBhIHByb2Nlc3MgdGhhdCBpcyBlaXRoZXIgcHJlLWVtcHRlZCBvciBpdHMg
dGltZSBzbGljZQ0KKyAqIGhhcyBleHBpcmVkLCBzaG91bGQgYmUgbW92ZWQg
dG8gdGhlIHRhaWwgb2YgdGhlIHJ1biANCisgKiBxdWV1ZSBmb3IgaXRzIHBy
aW9yaXR5IC0gQmhhdmVzaCBEYXZkYQ0KICAqLw0KIHN0YXRpYyBpbmxpbmUg
dm9pZCBhZGRfdG9fcnVucXVldWUoc3RydWN0IHRhc2tfc3RydWN0ICogcCkN
CiB7DQotCWxpc3RfYWRkKCZwLT5ydW5fbGlzdCwgJnJ1bnF1ZXVlX2hlYWQp
Ow0KKwlsaXN0X2FkZF90YWlsKCZwLT5ydW5fbGlzdCwgJnJ1bnF1ZXVlX2hl
YWQpOw0KIAlucl9ydW5uaW5nKys7DQogfQ0KIA0KQEAgLTMzNCwxMiArMzM4
LDYgQEANCiAJbGlzdF9hZGRfdGFpbCgmcC0+cnVuX2xpc3QsICZydW5xdWV1
ZV9oZWFkKTsNCiB9DQogDQotc3RhdGljIGlubGluZSB2b2lkIG1vdmVfZmly
c3RfcnVucXVldWUoc3RydWN0IHRhc2tfc3RydWN0ICogcCkNCi17DQotCWxp
c3RfZGVsKCZwLT5ydW5fbGlzdCk7DQotCWxpc3RfYWRkKCZwLT5ydW5fbGlz
dCwgJnJ1bnF1ZXVlX2hlYWQpOw0KLX0NCi0NCiAvKg0KICAqIFdha2UgdXAg
YSBwcm9jZXNzLiBQdXQgaXQgb24gdGhlIHJ1bi1xdWV1ZSBpZiBpdCdzIG5v
dA0KICAqIGFscmVhZHkgdGhlcmUuICBUaGUgImN1cnJlbnQiIHByb2Nlc3Mg
aXMgYWx3YXlzIG9uIHRoZQ0KQEAgLTk1NSw4ICs5NTMsNiBAQA0KIAlyZXR2
YWwgPSAwOw0KIAlwLT5wb2xpY3kgPSBwb2xpY3k7DQogCXAtPnJ0X3ByaW9y
aXR5ID0gbHAuc2NoZWRfcHJpb3JpdHk7DQotCWlmICh0YXNrX29uX3J1bnF1
ZXVlKHApKQ0KLQkJbW92ZV9maXJzdF9ydW5xdWV1ZShwKTsNCiANCiAJY3Vy
cmVudC0+bmVlZF9yZXNjaGVkID0gMTsNCiANCmRpZmYgLU5hdXIgbGludXgt
Mi40LjE4L2tlcm5lbC90aW1lci5jIGxpbnV4LTIuNC4xOC1icGQva2VybmVs
L3RpbWVyLmMNCi0tLSBsaW51eC0yLjQuMTgva2VybmVsL3RpbWVyLmMJTW9u
IE9jdCAgOCAxMTo0MTo0MSAyMDAxDQorKysgbGludXgtMi40LjE4LWJwZC9r
ZXJuZWwvdGltZXIuYwlXZWQgSnVuIDEyIDA5OjEzOjQzIDIwMDINCkBAIC01
ODUsNyArNTg1LDE0IEBADQogCWlmIChwLT5waWQpIHsNCiAJCWlmICgtLXAt
PmNvdW50ZXIgPD0gMCkgew0KIAkJCXAtPmNvdW50ZXIgPSAwOw0KLQkJCXAt
Pm5lZWRfcmVzY2hlZCA9IDE7DQorCQkJLyoNCisJCQkgKiBTQ0hFRF9GSUZP
IGlzIHByaW9yaXR5IHByZWVtcHRpb24sIHNvIHRoaXMgaXMgDQorCQkJICog
bm90IHRoZSBwbGFjZSB0byBkZWNpZGUgd2hldGhlciB0byByZXNjaGVkdWxl
IGENCisJCQkgKiBTQ0hFRF9GSUZPIHRhc2sgb3Igbm90IC0gQmhhdmVzaCBE
YXZkYQ0KKwkJCSAqLw0KKwkJCWlmIChwLT5wb2xpY3kgIT0gU0NIRURfRklG
Tykgew0KKwkJCQlwLT5uZWVkX3Jlc2NoZWQgPSAxOw0KKwkJCX0NCiAJCX0N
CiAJCWlmIChwLT5uaWNlID4gMCkNCiAJCQlrc3RhdC5wZXJfY3B1X25pY2Vb
Y3B1XSArPSB1c2VyX3RpY2s7DQo=
--8323328-1301095649-1023898791=:2422--
