Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285058AbRLQJON>; Mon, 17 Dec 2001 04:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbRLQJOE>; Mon, 17 Dec 2001 04:14:04 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48007 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285058AbRLQJNt>;
	Mon, 17 Dec 2001 04:13:49 -0500
Date: Mon, 17 Dec 2001 12:11:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] bouncefix-2.5.1-A2
In-Reply-To: <Pine.LNX.4.33.0112170826070.29314-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0112171207001.5773-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-993899264-1008587474=:5773"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-993899264-1008587474=:5773
Content-Type: TEXT/PLAIN; charset=US-ASCII


okay, there was another bug as well, this time in the loopback driver: it
did not set up its own bounce limit. This happens because the loopback
driver is a special driver that is not governed by the normal elevator,
thus it does not call blk_init_queue(). So the attached patch has two
fixes:

 - call blk_queue_bounce_limit() from loop.c
 - it fixes the off-by-one bounce-limit bugs in blkdev.h

does this fix your system?

	Ingo

--8323328-993899264-1008587474=:5773
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="bouncefix-2.5.1-A2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0112171211140.5773@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="bouncefix-2.5.1-A2"

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgvYmxrZGV2Lmgub3JpZwlTdW4gRGVj
IDE2IDE4OjA1OjI0IDIwMDENCisrKyBsaW51eC9pbmNsdWRlL2xpbnV4L2Js
a2Rldi5oCU1vbiBEZWMgMTcgMDk6Mjc6MjkgMjAwMQ0KQEAgLTIwMCw4ICsy
MDAsOCBAQA0KIA0KIGV4dGVybiB1bnNpZ25lZCBsb25nIGJsa19tYXhfbG93
X3BmbiwgYmxrX21heF9wZm47DQogDQotI2RlZmluZSBCTEtfQk9VTkNFX0hJ
R0gJKGJsa19tYXhfbG93X3BmbiA8PCBQQUdFX1NISUZUKQ0KLSNkZWZpbmUg
QkxLX0JPVU5DRV9BTlkJKGJsa19tYXhfcGZuIDw8IFBBR0VfU0hJRlQpDQor
I2RlZmluZSBCTEtfQk9VTkNFX0hJR0gJKChibGtfbWF4X2xvd19wZm4gKyAx
KSA8PCBQQUdFX1NISUZUKQ0KKyNkZWZpbmUgQkxLX0JPVU5DRV9BTlkJKChi
bGtfbWF4X3BmbiArIDEpIDw8IFBBR0VfU0hJRlQpDQogDQogI2lmZGVmIENP
TkZJR19ISUdITUVNDQogDQotLS0gbGludXgvZHJpdmVycy9ibG9jay9sb29w
LmMub3JpZwlNb24gRGVjIDE3IDA5OjUyOjI3IDIwMDENCisrKyBsaW51eC9k
cml2ZXJzL2Jsb2NrL2xvb3AuYwlNb24gRGVjIDE3IDA5OjU2OjM5IDIwMDEN
CkBAIC0xMDA3LDYgKzEwMDcsNyBAQA0KIAkJZ290byBvdXRfbWVtOw0KIA0K
IAlibGtfcXVldWVfbWFrZV9yZXF1ZXN0KEJMS19ERUZBVUxUX1FVRVVFKE1B
Sk9SX05SKSwgbG9vcF9tYWtlX3JlcXVlc3QpOw0KKwlibGtfcXVldWVfYm91
bmNlX2xpbWl0KEJMS19ERUZBVUxUX1FVRVVFKE1BSk9SX05SKSwgQkxLX0JP
VU5DRV9ISUdIKTsNCiANCiAJZm9yIChpID0gMDsgaSA8IG1heF9sb29wOyBp
KyspIHsNCiAJCXN0cnVjdCBsb29wX2RldmljZSAqbG8gPSAmbG9vcF9kZXZb
aV07DQo=
--8323328-993899264-1008587474=:5773--
