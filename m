Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288338AbSATL6S>; Sun, 20 Jan 2002 06:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288411AbSATL6J>; Sun, 20 Jan 2002 06:58:09 -0500
Received: from mx2.elte.hu ([157.181.151.9]:57265 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288338AbSATL55>;
	Sun, 20 Jan 2002 06:57:57 -0500
Date: Sun, 20 Jan 2002 14:55:22 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [sched] [patch] schedule-cleanup-2.5.3-pre2-A1
Message-ID: <Pine.LNX.4.33.0201201451560.7972-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1657085055-1011534922=:7972"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1657085055-1011534922=:7972
Content-Type: TEXT/PLAIN; charset=US-ASCII


the attached patch speeds up and cleans up schedule(), removing the
need_reschedule check on bkl-reacquire. This was needed in 2.2 times when
the big kernel lock was still prominent, but today it's not needed
anymore, especially with the preemption/lowlatency patches that will do
this correctly. This change removes 5 lines from the source code, and a
number of instructions from the scheduler hotpath. (i've also reverted the
switch statement's indentation to the previous, more correct indentation
style.)

	Ingo

--8323328-1657085055-1011534922=:7972
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="schedule-cleanup-2.5.3-pre2-A1"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0201201455220.7972@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="schedule-cleanup-2.5.3-pre2-A1"

LS0tIGxpbnV4L2tlcm5lbC9zY2hlZC5jLm9yaWcJU3VuIEphbiAyMCAxMTo0
NzozOSAyMDAyDQorKysgbGludXgva2VybmVsL3NjaGVkLmMJU3VuIEphbiAy
MCAxMTo0Nzo1MyAyMDAyDQpAQCAtNTg5LDI5ICs1ODksMjYgQEANCiAgKi8N
CiBhc21saW5rYWdlIHZvaWQgc2NoZWR1bGUodm9pZCkNCiB7DQotCXRhc2tf
dCAqcHJldiwgKm5leHQ7DQorCXRhc2tfdCAqcHJldiA9IGN1cnJlbnQsICpu
ZXh0Ow0KKwlydW5xdWV1ZV90ICpycSA9IHRoaXNfcnEoKTsNCiAJcHJpb19h
cnJheV90ICphcnJheTsNCi0JcnVucXVldWVfdCAqcnE7DQogCWxpc3RfdCAq
cXVldWU7DQogCWludCBpZHg7DQogDQogCWlmICh1bmxpa2VseShpbl9pbnRl
cnJ1cHQoKSkpDQogCQlCVUcoKTsNCi1uZWVkX3Jlc2NoZWRfYmFjazoNCi0J
cHJldiA9IGN1cnJlbnQ7DQogCXJlbGVhc2Vfa2VybmVsX2xvY2socHJldiwg
c21wX3Byb2Nlc3Nvcl9pZCgpKTsNCi0JcnEgPSB0aGlzX3JxKCk7DQogCXNw
aW5fbG9ja19pcnEoJnJxLT5sb2NrKTsNCiANCiAJc3dpdGNoIChwcmV2LT5z
dGF0ZSkgew0KLQkJY2FzZSBUQVNLX0lOVEVSUlVQVElCTEU6DQotCQkJaWYg
KHVubGlrZWx5KHNpZ25hbF9wZW5kaW5nKHByZXYpKSkgew0KLQkJCQlwcmV2
LT5zdGF0ZSA9IFRBU0tfUlVOTklORzsNCi0JCQkJYnJlYWs7DQotCQkJfQ0K
LQkJZGVmYXVsdDoNCi0JCQlkZWFjdGl2YXRlX3Rhc2socHJldiwgcnEpOw0K
LQkJY2FzZSBUQVNLX1JVTk5JTkc6DQorCWNhc2UgVEFTS19JTlRFUlJVUFRJ
QkxFOg0KKwkJaWYgKHVubGlrZWx5KHNpZ25hbF9wZW5kaW5nKHByZXYpKSkg
ew0KKwkJCXByZXYtPnN0YXRlID0gVEFTS19SVU5OSU5HOw0KKwkJCWJyZWFr
Ow0KKwkJfQ0KKwlkZWZhdWx0Og0KKwkJZGVhY3RpdmF0ZV90YXNrKHByZXYs
IHJxKTsNCisJY2FzZSBUQVNLX1JVTk5JTkc6DQogCX0NCiBwaWNrX25leHRf
dGFzazoNCiAJaWYgKHVubGlrZWx5KCFycS0+bnJfcnVubmluZykpIHsNCkBA
IC02NTQsOCArNjUxLDYgQEANCiAJc3Bpbl91bmxvY2tfaXJxKCZycS0+bG9j
ayk7DQogDQogCXJlYWNxdWlyZV9rZXJuZWxfbG9jayhjdXJyZW50KTsNCi0J
aWYgKG5lZWRfcmVzY2hlZCgpKQ0KLQkJZ290byBuZWVkX3Jlc2NoZWRfYmFj
azsNCiAJcmV0dXJuOw0KIH0NCiANCg==
--8323328-1657085055-1011534922=:7972--
