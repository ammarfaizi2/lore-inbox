Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263880AbTCVVw4>; Sat, 22 Mar 2003 16:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263888AbTCVVwz>; Sat, 22 Mar 2003 16:52:55 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:44272 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S263880AbTCVVwy>; Sat, 22 Mar 2003 16:52:54 -0500
Date: Sat, 22 Mar 2003 23:03:33 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Dominik Brodowski <linux@brodo.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: 2.5.65-ac2 -- hda/ide trouble on ICH4
In-Reply-To: <20030322162502.GA870@brodo.de>
Message-ID: <Pine.SOL.4.30.0303221730110.15619-200000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1048370613=:23357"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1048370613=:23357
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sat, 22 Mar 2003, Dominik Brodowski wrote:
> On Sat, Mar 22, 2003 at 04:35:05PM +0000, Alan Cox wrote:
> >
> > I've seen 3 or 4 reports of this, none of them duplicatable with the same IDE
> > code on 2.4 so far. Which is odd but I don't yet understand what is going on.
> /me neither, unfortunately :-(


Alan, I can trigger the same dma_intr bug under 2.4.21-pre5-ac3 but not
2.4.20-ac2 (VIA vt8235 + WD800JB so it is not controller/disk related).

Dominik could you try attached patch with vanilla 2.5.65?
It reverts previous logic of handling masked_irq argument of ide_do_request().

Previously callers called it with masked_irq=0 and disabling/enabling
hwif->irq code wasn't executed, now ide_do_request() is called with
masked_irq=IDE_NO_IRQ=-1 so this code is executed for sure.

And no, I don't know wtf is exactly going on there :\.


[ Alan, please forget about yesterday's mail, I hitted dma_intr again today
  with yesterday's patch, with attached patch I hope it is gone now :-) ]

BTW 2.5.64-ac4 deadlocks for me the same way Dominik has described.


Greets
--
Bartlomiej

---559023410-851401618-1048370613=:23357
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.5.65-dma_intr-fix.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.30.0303222303330.23357@mion.elka.pw.edu.pl>
Content-Description: 
Content-Disposition: attachment; filename="2.5.65-dma_intr-fix.diff"

LS0tIGxpbnV4LTIuNS42NS9kcml2ZXJzL2lkZS9pZGUtaW8uYwlGcmkgTWFy
IDIxIDE0OjI0OjMxIDIwMDMNCisrKyBsaW51eC1kbWFfaW50ci1maXgvZHJp
dmVycy9pZGUvaWRlLWlvLmMJU2F0IE1hciAyMiAyMjowMzoyNiAyMDAzDQpA
QCAtODM4LDE0ICs4MzgsMTQgQEANCiAJCSAqIGhhcHBlbnMgYW55d2F5IHdo
ZW4gYW55IGludGVycnVwdCBjb21lcyBpbiwgSURFIG9yIG90aGVyd2lzZQ0K
IAkJICogIC0tIHRoZSBrZXJuZWwgbWFza3MgdGhlIElSUSB3aGlsZSBpdCBp
cyBiZWluZyBoYW5kbGVkLg0KIAkJICovDQotCQlpZiAoaHdpZi0+aXJxICE9
IG1hc2tlZF9pcnEpDQorCQlpZiAobWFza2VkX2lycSAmJiBod2lmLT5pcnEg
IT0gbWFza2VkX2lycSkNCiAJCQlkaXNhYmxlX2lycV9ub3N5bmMoaHdpZi0+
aXJxKTsNCiAJCXNwaW5fdW5sb2NrKCZpZGVfbG9jayk7DQogCQlsb2NhbF9p
cnFfZW5hYmxlKCk7DQogCQkJLyogYWxsb3cgb3RoZXIgSVJRcyB3aGlsZSB3
ZSBzdGFydCB0aGlzIHJlcXVlc3QgKi8NCiAJCXN0YXJ0c3RvcCA9IHN0YXJ0
X3JlcXVlc3QoZHJpdmUsIHJxKTsNCiAJCXNwaW5fbG9ja19pcnEoJmlkZV9s
b2NrKTsNCi0JCWlmIChod2lmLT5pcnEgIT0gbWFza2VkX2lycSkNCisJCWlm
IChtYXNrZWRfaXJxICYmIGh3aWYtPmlycSAhPSBtYXNrZWRfaXJxKQ0KIAkJ
CWVuYWJsZV9pcnEoaHdpZi0+aXJxKTsNCiAJCWlmIChzdGFydHN0b3AgPT0g
aWRlX3JlbGVhc2VkKQ0KIAkJCWdvdG8gcXVldWVfbmV4dDsNCkBAIC04NjEs
NyArODYxLDcgQEANCiAgKi8NCiB2b2lkIGRvX2lkZV9yZXF1ZXN0KHJlcXVl
c3RfcXVldWVfdCAqcSkNCiB7DQotCWlkZV9kb19yZXF1ZXN0KHEtPnF1ZXVl
ZGF0YSwgSURFX05PX0lSUSk7DQorCWlkZV9kb19yZXF1ZXN0KHEtPnF1ZXVl
ZGF0YSwgMCk7DQogfQ0KIA0KIC8qDQpAQCAtMTAwOSw3ICsxMDA5LDcgQEAN
CiAJCQkJaHdncm91cC0+YnVzeSA9IDA7DQogCQl9DQogCX0NCi0JaWRlX2Rv
X3JlcXVlc3QoaHdncm91cCwgSURFX05PX0lSUSk7DQorCWlkZV9kb19yZXF1
ZXN0KGh3Z3JvdXAsIDApOw0KIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZp
ZGVfbG9jaywgZmxhZ3MpOw0KIH0NCiANCkBAIC0xMjk5LDcgKzEyOTksNyBA
QA0KIAkJaW5zZXJ0X2VuZCA9IDA7DQogCX0NCiAJX19lbHZfYWRkX3JlcXVl
c3QoJmRyaXZlLT5xdWV1ZSwgcnEsIGluc2VydF9lbmQsIDApOw0KLQlpZGVf
ZG9fcmVxdWVzdChod2dyb3VwLCBJREVfTk9fSVJRKTsNCisJaWRlX2RvX3Jl
cXVlc3QoaHdncm91cCwgMCk7DQogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JmlkZV9sb2NrLCBmbGFncyk7DQogDQogCWVyciA9IDA7DQo=
---559023410-851401618-1048370613=:23357--
