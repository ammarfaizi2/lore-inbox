Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbTL2Tjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTL2Tjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:39:32 -0500
Received: from intra.cyclades.com ([64.186.161.6]:19423 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263836AbTL2Tj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:39:27 -0500
Date: Mon, 29 Dec 2003 17:32:58 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Ged Haywood <ged@www2.jubileegroup.co.uk>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: All filesystems hang under long periods of heavy load (read and
 write) on a filesystem
In-Reply-To: <Pine.LNX.4.21.0312231544250.20325-100000@www2.jubileegroup.co.uk>
Message-ID: <Pine.LNX.4.58L.0312281816140.15034@logos.cnet>
References: <Pine.LNX.4.21.0312231544250.20325-100000@www2.jubileegroup.co.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-123439936-1072643568=:15034"
Content-ID: <Pine.LNX.4.58L.0312291732400.18238@logos.cnet>
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-123439936-1072643568=:15034
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58L.0312291732401.18238@logos.cnet>



On Tue, 23 Dec 2003, Ged Haywood wrote:

> Googled lots of similar postings, if anyone wants me to try anything
> out please let me know.  Otherwise this is just a heads up to say that
> there is certainly something nasty in the released 2.4.23 IDE code...

<snip>

> Dec 23 12:19:01 www2 kernel: hdb: status timeout: status=0xd0 { Busy }
> Dec 23 12:19:01 www2 kernel:  Dec 23 12:19:01 www2 kernel:
> hdb: no DRQ after issuing WRITE Dec 23 12:19:33 www2 kernel: ide0: reset timed-out,
> status=0x80 Dec 23 12:19:33 www2 kernel: hdb: status timeout:
> status=0xd0 { Busy } Dec 23 12:19:33 www2 kernel:  Dec 23 12:19:33 www2
> kernel: hdb: no DRQ after issuing WRITE Dec 23 12:20:03 www2 kernel:
> ide0: reset timed-out, status=0x80 Dec 23 12:20:03 www2 kernel:
> end_request: I/O error, dev 03:41 (hdb), sector 35289088 ... #

Hi Ged,

I believe this migh caused by a problem in ide_wait where the kernel
thinks a timeout has happened but it hasnt in practice (the drive is ready
to go).

The attached patch from Daniel Lux should fix it. Its has just been
applied to the 2.4 BK tree.

Please try it.

--8323328-123439936-1072643568=:15034
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ide-wait.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58L.0312281832480.15034@logos.cnet>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ide-wait.patch"

PT09PT0gZHJpdmVycy9pZGUvaWRlLWlvcHMuYyAxLjcgdnMgMS45ID09PT09
DQotLS0gMS43L2RyaXZlcnMvaWRlL2lkZS1pb3BzLmMJU2F0IEF1ZyAgOSAx
MTo0ODozOSAyMDAzDQorKysgMS45L2RyaXZlcnMvaWRlL2lkZS1pb3BzLmMJ
U3VuIERlYyAyOCAxODoxNDowNSAyMDAzDQpAQCAtNjY0LDEyICs2NjQsMjIg
QEANCiAJaWYgKChzdGF0ID0gaHdpZi0+SU5CKElERV9TVEFUVVNfUkVHKSkg
JiBCVVNZX1NUQVQpIHsNCiAJCWxvY2FsX2lycV9zZXQoZmxhZ3MpOw0KIAkJ
dGltZW91dCArPSBqaWZmaWVzOw0KLQkJd2hpbGUgKChzdGF0ID0gaHdpZi0+
SU5CKElERV9TVEFUVVNfUkVHKSkgJiBCVVNZX1NUQVQpIHsNCisJCXN0YXQg
PSBod2lmLT5JTkIoSURFX1NUQVRVU19SRUcpOw0KKwkJd2hpbGUgKHN0YXQg
JiBCVVNZX1NUQVQpIHsNCiAJCQlpZiAodGltZV9hZnRlcihqaWZmaWVzLCB0
aW1lb3V0KSkgew0KLQkJCQlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7DQot
CQkJCSpzdGFydHN0b3AgPSBEUklWRVIoZHJpdmUpLT5lcnJvcihkcml2ZSwg
InN0YXR1cyB0aW1lb3V0Iiwgc3RhdCk7DQotCQkJCXJldHVybiAxOw0KKwkJ
CQkvKg0KKwkJCSAgICAgICAJICogZG8gb25lIG1vcmUgc3RhdHVzIHJlYWQg
aW4gY2FzZSB3ZSB3ZXJlIGludGVycnVwdGVkIGJldHdlZW4gbGFzdA0KKwkJ
CQkgKiBzdGF0ID0gaHdpZi0+SU5CKElERV9TVEFUVVNfUkVHKSBhbmQgdGlt
ZV9hZnRlcihqaWZmaWVzLCB0aW1lb3V0KQ0KKwkJCQkgKiBpbiB3aWNoIGNh
c2UgdGhlIHRpbWVvdXQgbWlnaHQgaGF2ZSBiZWVuIHNob3J0ZXIgdGhhbiBz
cGVjaWZpZWQuDQorCQkJCSAqLw0KKwkJCQlpZiAoKHN0YXQgPSBod2lmLT5J
TkIoSURFX1NUQVRVU19SRUcpKSAmIEJVU1lfU1RBVCkgew0KKwkJCQkJbG9j
YWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOw0KKwkJCQkJKnN0YXJ0c3RvcCA9IERS
SVZFUihkcml2ZSktPmVycm9yKGRyaXZlLCAic3RhdHVzIHRpbWVvdXQiLCBz
dGF0KTsNCisJCQkJCXJldHVybiAxOw0KKwkJCQl9DQogCQkJfQ0KKwkJCWVs
c2UNCisJCQkJc3RhdCA9IGh3aWYtPklOQihJREVfU1RBVFVTX1JFRyk7DQog
CQl9DQogCQlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7DQogCX0NCg==

--8323328-123439936-1072643568=:15034--
