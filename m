Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271924AbRIIKd5>; Sun, 9 Sep 2001 06:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271941AbRIIKds>; Sun, 9 Sep 2001 06:33:48 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:47210 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S271924AbRIIKd1>; Sun, 9 Sep 2001 06:33:27 -0400
Date: Sun, 9 Sep 2001 06:33:24 -0400 (EDT)
From: Francis Galiegue <fg@mandrakesoft.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <linux-kernel@vger.kernel.org>, <alan@redhat.com>,
        <damien.clermonte@free.fr>
Subject: Re: [PATCH] 2.4.9-ac10 but not only, locks_alloc_lock()
In-Reply-To: <002801c13911$59930880$010411ac@local>
Message-ID: <Pine.LNX.4.30.0109090627430.4681-200000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463800575-56444416-1000031533=:4681"
Content-ID: <Pine.LNX.4.30.0109090632430.4681@toy.mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463800575-56444416-1000031533=:4681
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.30.0109090632431.4681@toy.mandrakesoft.com>

On Sun, 9 Sep 2001, Manfred Spraul wrote:

>
> > Not sure about one thing, though: what error code to return for
> > locks_mandatory_area() on failure. It's invoked from some of the
> > {do,sys}_*{read,write}*() routines and nowhere else AFAICT. I set it
> > to -ENOMEM, maybe this is not the right thing to do.
>
> I'd put the file_lock structure on the stack. It's ~ 90 bytes long, not
> too large.
> Returning -ENOMEM is imho not acceptable: -ENOMEM is not listed in
> SusV2, and locks_alloc_lock() internally checks for rlimits (setting
> RLIM_NLIMITS to 0 and execing another app might have dangerous
> sideeffects).
>

Not sure about what you mean wrt RLIM_NLIMITS, anyway a new patch is
attached with follows your suggestion. Does it look correct?

-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

---1463800575-56444416-1000031533=:4681
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="patch-2.4.9-ac10-locks_allock_check.2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0109090632130.4681@toy.mandrakesoft.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="patch-2.4.9-ac10-locks_allock_check.2"

ZGlmZiAtdXJOIGxpbnV4LW9sZC9mcy9sb2Nrcy5jIGxpbnV4L2ZzL2xvY2tz
LmMNCi0tLSBsaW51eC1vbGQvZnMvbG9ja3MuYwlTdW4gU2VwICA5IDA5OjAw
OjA2IDIwMDENCisrKyBsaW51eC9mcy9sb2Nrcy5jCVN1biBTZXAgIDkgMTI6
MTI6MDIgMjAwMQ0KQEAgLTY5NSwxNiArNjk1LDE4IEBADQogCQkJIHNpemVf
dCBjb3VudCkNCiB7DQogCXN0cnVjdCBmaWxlX2xvY2sgKmZsOw0KLQlzdHJ1
Y3QgZmlsZV9sb2NrICpuZXdfZmwgPSBsb2Nrc19hbGxvY19sb2NrKDApOw0K
KwlzdHJ1Y3QgZmlsZV9sb2NrIG5ld19mbDsNCiAJaW50IGVycm9yOw0KIA0K
LQluZXdfZmwtPmZsX293bmVyID0gY3VycmVudC0+ZmlsZXM7DQotCW5ld19m
bC0+ZmxfcGlkID0gY3VycmVudC0+cGlkOw0KLQluZXdfZmwtPmZsX2ZpbGUg
PSBmaWxwOw0KLQluZXdfZmwtPmZsX2ZsYWdzID0gRkxfUE9TSVggfCBGTF9B
Q0NFU1M7DQotCW5ld19mbC0+ZmxfdHlwZSA9IChyZWFkX3dyaXRlID09IEZM
T0NLX1ZFUklGWV9XUklURSkgPyBGX1dSTENLIDogRl9SRExDSzsNCi0JbmV3
X2ZsLT5mbF9zdGFydCA9IG9mZnNldDsNCi0JbmV3X2ZsLT5mbF9lbmQgPSBv
ZmZzZXQgKyBjb3VudCAtIDE7DQorCW1lbXNldCgmbmV3X2ZsLCAwLCBzaXpl
b2YobmV3X2ZsKSk7DQorCQ0KKwluZXdfZmwuZmxfb3duZXIgPSBjdXJyZW50
LT5maWxlczsNCisJbmV3X2ZsLmZsX3BpZCA9IGN1cnJlbnQtPnBpZDsNCisJ
bmV3X2ZsLmZsX2ZpbGUgPSBmaWxwOw0KKwluZXdfZmwuZmxfZmxhZ3MgPSBG
TF9QT1NJWCB8IEZMX0FDQ0VTUzsNCisJbmV3X2ZsLmZsX3R5cGUgPSAocmVh
ZF93cml0ZSA9PSBGTE9DS19WRVJJRllfV1JJVEUpID8gRl9XUkxDSyA6IEZf
UkRMQ0s7DQorCW5ld19mbC5mbF9zdGFydCA9IG9mZnNldDsNCisJbmV3X2Zs
LmZsX2VuZCA9IG9mZnNldCArIGNvdW50IC0gMTsNCiANCiAJZXJyb3IgPSAw
Ow0KIAlsb2NrX2tlcm5lbCgpOw0KQEAgLTcxNiwxNyArNzE4LDE3IEBADQog
CWZvciAoZmwgPSBpbm9kZS0+aV9mbG9jazsgZmwgIT0gTlVMTDsgZmwgPSBm
bC0+ZmxfbmV4dCkgew0KIAkJaWYgKCEoZmwtPmZsX2ZsYWdzICYgRkxfUE9T
SVgpKQ0KIAkJCWNvbnRpbnVlOw0KLQkJaWYgKGZsLT5mbF9zdGFydCA+IG5l
d19mbC0+ZmxfZW5kKQ0KKwkJaWYgKGZsLT5mbF9zdGFydCA+IG5ld19mbC5m
bF9lbmQpDQogCQkJYnJlYWs7DQotCQlpZiAocG9zaXhfbG9ja3NfY29uZmxp
Y3QobmV3X2ZsLCBmbCkpIHsNCisJCWlmIChwb3NpeF9sb2Nrc19jb25mbGlj
dCgmbmV3X2ZsLCBmbCkpIHsNCiAJCQllcnJvciA9IC1FQUdBSU47DQogCQkJ
aWYgKGZpbHAgJiYgKGZpbHAtPmZfZmxhZ3MgJiBPX05PTkJMT0NLKSkNCiAJ
CQkJYnJlYWs7DQogCQkJZXJyb3IgPSAtRURFQURMSzsNCi0JCQlpZiAocG9z
aXhfbG9ja3NfZGVhZGxvY2sobmV3X2ZsLCBmbCkpDQorCQkJaWYgKHBvc2l4
X2xvY2tzX2RlYWRsb2NrKCZuZXdfZmwsIGZsKSkNCiAJCQkJYnJlYWs7DQog
CQ0KLQkJCWVycm9yID0gbG9ja3NfYmxvY2tfb24oZmwsIG5ld19mbCk7DQor
CQkJZXJyb3IgPSBsb2Nrc19ibG9ja19vbihmbCwgJm5ld19mbCk7DQogCQkJ
aWYgKGVycm9yICE9IDApDQogCQkJCWJyZWFrOw0KIAkNCkBAIC03MzksNyAr
NzQxLDYgQEANCiAJCQlnb3RvIHJlcGVhdDsNCiAJCX0NCiAJfQ0KLQlsb2Nr
c19mcmVlX2xvY2sobmV3X2ZsKTsNCiAJdW5sb2NrX2tlcm5lbCgpOw0KIAly
ZXR1cm4gZXJyb3I7DQogfQ0KQEAgLTE0MTEsNiArMTQxMiw5IEBADQogCXN0
cnVjdCBpbm9kZSAqaW5vZGU7DQogCWludCBlcnJvcjsNCiANCisJaWYgKGZp
bGVfbG9jayA9PSBOVUxMKQ0KKwkJcmV0dXJuIC1FTk9MQ0s7DQorDQogCS8q
DQogCSAqIFRoaXMgbWlnaHQgYmxvY2ssIHNvIHdlIGRvIGl0IGJlZm9yZSBj
aGVja2luZyB0aGUgaW5vZGUuDQogCSAqLw0KQEAgLTE1NjMsNiArMTU2Nyw5
IEBADQogCXN0cnVjdCBmbG9jazY0IGZsb2NrOw0KIAlzdHJ1Y3QgaW5vZGUg
Kmlub2RlOw0KIAlpbnQgZXJyb3I7DQorDQorCWlmIChmaWxlX2xvY2sgPT0g
TlVMTCkNCisJCXJldHVybiAtRU5PTENLOw0KIA0KIAkvKg0KIAkgKiBUaGlz
IG1pZ2h0IGJsb2NrLCBzbyB3ZSBkbyBpdCBiZWZvcmUgY2hlY2tpbmcgdGhl
IGlub2RlLg0K
---1463800575-56444416-1000031533=:4681--
