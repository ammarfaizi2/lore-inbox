Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287565AbSBECwj>; Mon, 4 Feb 2002 21:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287658AbSBECwU>; Mon, 4 Feb 2002 21:52:20 -0500
Received: from [64.246.4.29] ([64.246.4.29]:7052 "EHLO corncob.localhost.tld")
	by vger.kernel.org with ESMTP id <S287565AbSBECwL>;
	Mon, 4 Feb 2002 21:52:11 -0500
Date: Mon, 4 Feb 2002 20:51:40 -0600 (CST)
From: Clifford Kite <ckite@ev1.net>
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Kernel zombie threads after module removal.
Message-ID: <Pine.LNX.4.21.0202042005220.12873-200000@corncob.localhost.tld>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811840-774244154-1003155718=:766"
Content-ID: <Pine.LNX.4.21.0202042005221.12873@corncob.localhost.tld>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811840-774244154-1003155718=:766
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0202042005222.12873@corncob.localhost.tld>

Hello,

I sent the email below and attached patch, based on Kasper Dupont's patch
for a 2.4.5 kernel, to Johannes Erdfelt <johannes@erdfelt.com> on Monday,
October 15, 2001 but received no reply.  The problem still exists in the
2.4.12 kernel, and, as far as I can tell by looking through the kernel
patches through 2.4.17, the problem still hasn't been fixed.

Perhaps I was mistaken in sending the patch to him, so I'm sending it
to the linux-kernel list this time.  I'd really like to see this patch,
or any patch that fixes the problem, get into the kernel source.

---
Best regards,
Clifford Kite

Problem description
------------------------------------------------------------------------
This problem occurs in the kernels 2.4.5-ac9 and 2.4.12, with basic USB
support compiled into both the kernels.  After removing the usb-storage.o
and the SCSI sd_mod.o modules two zombie kernel treads remain:

root  2985  0.0  0.0  0  0  ?  Z  12:07  0:00 [usb-storage-0 <defunct>]
root  2986  0.0  0.0  0  0  ?  Z  12:07  0:00 [scsi_eh_0 <defunct>]

These zombies *accumulate*, a new pair appears for each time the modules
are removed.  The modules are inserted and removed manually with these
commands in scripts:

/sbin/modprobe -a usb-uhci usb-storage sd_mod
/sbin/modprobe -ar sd_mod usb-storage usb-uhci

The problem was fixed in 2.4.5-ac9 after applying a simple patch that
Kasper Dupont sent in answer to my posts on colds for help.  I was
surprised to find that this is still a problem with the 2.4.12 kernel
so this time I'm making an effort to get a fix incorporated into the
kernel source.

Although I'm not a C programmer I can read C a bit, and it seemed that
modifying the hub.c code for 2.4.12 in the same way as the previous patch
did for 2.4.5-ac9 might fix the problem in it too.  It did fix the problem,
but it would be nice if the kernel sources were modified to fix it by the
developer, either as done by Kasper's patch, or with other code that fixes
the problem in a more appropriate way.

The 2.4.12 patch is included as an attachment in this email and includes
comments by Kasper from the original patch for 2.4.5-ac9.  I'll be glad
to answer any questions you may have and to cooperate by applying any
other patch to hub.c and testing it here.  I posted a comment on colds
after applying the fix describing my observations in more detail and can
send it, if you think it might help.

---

---1463811840-774244154-1003155718=:766
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="KD_USBhub.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0110150921580.766@corncob.inetport.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="KD_USBhub.patch"

LS0tIGh1Yi5jLW9yaWdpbmFsCVR1ZSBPY3QgIDkgMTc6MTU6MDIgMjAwMQ0K
KysrIGh1Yi5jCVN1biBPY3QgMTQgMjE6MDk6MTggMjAwMQ0KQEAgLTUsNyAr
NSw5IEBADQogICogKEMpIENvcHlyaWdodCAxOTk5IEpvaGFubmVzIEVyZGZl
bHQNCiAgKiAoQykgQ29weXJpZ2h0IDE5OTkgR3JlZ29yeSBQLiBTbWl0aA0K
ICAqIChDKSBDb3B5cmlnaHQgMjAwMSBCcmFkIEhhcmRzIChiaGFyZHNAYmln
cG9uZC5uZXQuYXUpDQotICoNCisgKi8NCisvKiBXb3JrYXJvdW5kIHRvIGF2
b2lkIHpvbWJpZXMuIChVbnRlc3RlZCkNCisgKiAoQykgMjAwMSBLYXNwZXIg
RHVwb250IDxrYXNwZXJkQGRhaW1pLmF1LmRrPg0KICAqLw0KIA0KICNpbmNs
dWRlIDxsaW51eC9jb25maWcuaD4NCkBAIC03MTQsNyArNzE2LDcgQEANCiAJ
CWtmcmVlKHRlbXBzdHIpOw0KIH0NCiANCi1zdGF0aWMgdm9pZCB1c2JfaHVi
X2V2ZW50cyh2b2lkKQ0KK3N0YXRpYyB2b2lkIHVzYl9odWJfZXZlbnRzKHZv
aWQqdW51c2VkKQ0KIHsNCiAJdW5zaWduZWQgbG9uZyBmbGFnczsNCiAJc3Ry
dWN0IGxpc3RfaGVhZCAqdG1wOw0KQEAgLTg1Miw3ICs4NTQsMjIgQEANCiAN
CiAJLyogU2VuZCBtZSBhIHNpZ25hbCB0byBnZXQgbWUgZGllIChmb3IgZGVi
dWdnaW5nKSAqLw0KIAlkbyB7DQotCQl1c2JfaHViX2V2ZW50cygpOw0KKwkJ
LyogSW5zdGVhZCBvZiBjYWxsaW5nIHVzYl9odWJfZXZlbnRzKCkNCisJCSog
SSBsZWF2ZSB0aGUgam9iIHRvIGtldmVudGQuIFRoYXQgd2F5DQorCQkqIG5l
dyBrZXJuZWwgdGhyZWFkcyB3aWxsIGhhdmUga2V2ZW50ZA0KKwkJKiBhcyBm
YXRoZXIgaW5zdGVhZCBvZiBraHViZC4gSXQgd291bGQNCisJCSogYmUgYmV0
dGVyIGJ1dCBtb3JlIGRpZmZpY3VsdCB0byBoYXZlDQorCQkqIGtodWJkIHRh
a2luZyBjYXJlIG9mIGl0cyBvd24gZGVhZA0KKwkJKiBjaGlsZHJlbi4NCisJ
CSovDQorCQlzdHJ1Y3QgdHFfc3RydWN0IHRhc2s7DQorCQl0YXNrLnJvdXRp
bmU9dXNiX2h1Yl9ldmVudHM7DQorCQlzY2hlZHVsZV90YXNrKCZ0YXNrKTsN
CisJCS8qIEkgYmVsaWV2ZSBmbHVzaGluZyBhdCB0aGlzIHBvaW50IGlzDQor
CQkqIHRoZSBzYWZlc3QgdGhpbmcgdG8gZG8uIEl0IG1pZ2h0IG5vdA0KKwkJ
KiBiZSB0aGUgbW9zdCBlZmZpY2llbnQgdGhvdWdoLg0KKwkJKi8NCisJCWZs
dXNoX3NjaGVkdWxlZF90YXNrcygpOw0KIAkJaW50ZXJydXB0aWJsZV9zbGVl
cF9vbigma2h1YmRfd2FpdCk7DQogCX0gd2hpbGUgKCFzaWduYWxfcGVuZGlu
ZyhjdXJyZW50KSk7DQogDQo=
---1463811840-774244154-1003155718=:766--
