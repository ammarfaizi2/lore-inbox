Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130186AbRBZUpa>; Mon, 26 Feb 2001 15:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130166AbRBZUpV>; Mon, 26 Feb 2001 15:45:21 -0500
Received: from chiara.elte.hu ([157.181.150.200]:45842 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130186AbRBZUpH>;
	Mon, 26 Feb 2001 15:45:07 -0500
Date: Mon, 26 Feb 2001 21:44:16 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rico Tudor <rico@patrec.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: [patch] highmem-2.4.2-A0
In-Reply-To: <20010226181049.G29254@athlon.random>
Message-ID: <Pine.LNX.4.30.0102262139420.7414-200000@elte.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655616-1389835268-983220199=:7414"
Content-ID: <Pine.LNX.4.30.0102262144000.7414@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--655616-1389835268-983220199=:7414
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.30.0102262144001.7414@elte.hu>


On Mon, 26 Feb 2001, Andrea Arcangeli wrote:

> The highmem changes in 2.4.2ac3 has a couple of bugs, one relevant
> that can generate deadlocks (re-enable interrupts with io_request_lock
> acquired).

oops, right, the emergency-pool patch was just a quick hack to check
whether this is the final problem affecting RL highmem systems.

the attached highmem-2.4.2-A0 patch does the jist of your fixes, against
-ac4. Differences: no need to complicate highmem.c with pool-fillup on
bootup. It will get refilled after the first disk-accesses anyway.

i'm unsure about the other changes done by your patch, could you explain
them? Notably the pgalloc-3level.h and fault.c changes. Thanks,

	Ingo

--655616-1389835268-983220199=:7414
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="highmem-2.4.2-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0102262143190.7414@elte.hu>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="highmem-2.4.2-A0"

LS0tIGxpbnV4L21tL2hpZ2htZW0uYy5vcmlnCU1vbiBGZWIgMjYgMjM6MzM6
MTcgMjAwMQ0KKysrIGxpbnV4L21tL2hpZ2htZW0uYwlNb24gRmViIDI2IDIz
OjM3OjAyIDIwMDENCkBAIC0yMTcsNiArMjE3LDcgQEANCiBzdGF0aWMgaW5s
aW5lIHZvaWQgYm91bmNlX2VuZF9pbyAoc3RydWN0IGJ1ZmZlcl9oZWFkICpi
aCwgaW50IHVwdG9kYXRlKQ0KIHsNCiAJc3RydWN0IHBhZ2UgKnBhZ2U7DQor
CXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQogCXN0cnVjdCBsaXN0X2hlYWQgKnRt
cDsNCiAJc3RydWN0IGJ1ZmZlcl9oZWFkICpiaF9vcmlnID0gKHN0cnVjdCBi
dWZmZXJfaGVhZCAqKShiaC0+Yl9wcml2YXRlKTsNCiANCkBAIC0yMzEsMjcg
KzIzMiwyNyBAQA0KIAkJX19mcmVlX3BhZ2UocGFnZSk7DQogCWVsc2Ugew0K
IAkJdG1wID0gJmVtZXJnZW5jeV9wYWdlczsNCi0JCXNwaW5fbG9ja19pcnEo
JmVtZXJnZW5jeV9sb2NrKTsNCisJCXNwaW5fbG9ja19pcnFzYXZlKCZlbWVy
Z2VuY3lfbG9jaywgZmxhZ3MpOw0KIAkJLyoNCiAJCSAqIFdlIGFyZSBhYnVz
aW5nIHBhZ2UtPmxpc3QgdG8gbWFuYWdlDQogCQkgKiB0aGUgaGlnaG1lbSBl
bWVyZ2VuY3kgcG9vbDoNCiAJCSAqLw0KIAkJbGlzdF9hZGQoJnBhZ2UtPmxp
c3QsICZlbWVyZ2VuY3lfcGFnZXMpOw0KIAkJbnJfZW1lcmdlbmN5X3BhZ2Vz
Kys7DQotCQlzcGluX3VubG9ja19pcnEoJmVtZXJnZW5jeV9sb2NrKTsNCisJ
CXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmVtZXJnZW5jeV9sb2NrLCBmbGFn
cyk7DQogCX0NCiAJDQogCWlmIChucl9lbWVyZ2VuY3lfcGFnZXMgPj0gUE9P
TF9TSVpFKQ0KIAkJa21lbV9jYWNoZV9mcmVlKGJoX2NhY2hlcCwgYmgpOw0K
IAllbHNlIHsNCiAJCXRtcCA9ICZlbWVyZ2VuY3lfYmhzOw0KLQkJc3Bpbl9s
b2NrX2lycSgmZW1lcmdlbmN5X2xvY2spOw0KKwkJc3Bpbl9sb2NrX2lycXNh
dmUoJmVtZXJnZW5jeV9sb2NrLCBmbGFncyk7DQogCQkvKg0KIAkJICogRGl0
dG8gaW4gdGhlIGJoIGNhc2UsIGhlcmUgd2UgYWJ1c2UgYl9pbm9kZV9idWZm
ZXJzOg0KIAkJICovDQogCQlsaXN0X2FkZCgmYmgtPmJfaW5vZGVfYnVmZmVy
cywgJmVtZXJnZW5jeV9iaHMpOw0KIAkJbnJfZW1lcmdlbmN5X2JocysrOw0K
LQkJc3Bpbl91bmxvY2tfaXJxKCZlbWVyZ2VuY3lfbG9jayk7DQorCQlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZlbWVyZ2VuY3lfbG9jaywgZmxhZ3MpOw0K
IAl9DQogfQ0KIA0KQEAgLTI5Nyw2ICsyOTgsMTIgQEANCiAJc3Bpbl91bmxv
Y2tfaXJxKCZlbWVyZ2VuY3lfbG9jayk7DQogCWlmIChwYWdlKQ0KIAkJcmV0
dXJuIHBhZ2U7DQorDQorCXJ1bl90YXNrX3F1ZXVlKCZ0cV9kaXNrKTsNCisN
CisJY3VycmVudC0+cG9saWN5IHw9IFNDSEVEX1lJRUxEOw0KKwlfX3NldF9j
dXJyZW50X3N0YXRlKFRBU0tfUlVOTklORyk7DQorCXNjaGVkdWxlKCk7DQog
CWdvdG8gcmVwZWF0X2FsbG9jOw0KIH0NCiANCkBAIC0zMjgsNiArMzM1LDEy
IEBADQogCXNwaW5fdW5sb2NrX2lycSgmZW1lcmdlbmN5X2xvY2spOw0KIAlp
ZiAoYmgpDQogCQlyZXR1cm4gYmg7DQorDQorCXJ1bl90YXNrX3F1ZXVlKCZ0
cV9kaXNrKTsNCisNCisJY3VycmVudC0+cG9saWN5IHw9IFNDSEVEX1lJRUxE
Ow0KKwlfX3NldF9jdXJyZW50X3N0YXRlKFRBU0tfUlVOTklORyk7DQorCXNj
aGVkdWxlKCk7DQogCWdvdG8gcmVwZWF0X2FsbG9jOw0KIH0NCiANCg==
--655616-1389835268-983220199=:7414--
