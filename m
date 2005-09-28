Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965262AbVI1Gvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965262AbVI1Gvm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 02:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbVI1Gvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 02:51:42 -0400
Received: from mailgate.urz.uni-halle.de ([141.48.3.51]:28042 "EHLO
	mailgate.uni-halle.de") by vger.kernel.org with ESMTP
	id S965262AbVI1Gvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 02:51:41 -0400
Date: Wed, 28 Sep 2005 08:51:26 +0200 (METDST)
From: Clemens Ladisch <clemens@ladisch.de>
To: Bob Picco <bob.picco@hp.com>
cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: Re: [PATCH 1/2] HPET: disallow zero interrupt frequency
In-Reply-To: <20050922191419.GF16066@localhost.localdomain>
Message-ID: <Pine.HPX.4.33n.0509280842300.3203-200000@studcom.urz.uni-halle.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="2015913978-851401618-1127890286=:3203"
X-Scan-Signature: f4d1cd71b546dc9332e9a967de127e57
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2015913978-851401618-1127890286=:3203
Content-Type: TEXT/PLAIN; charset=US-ASCII

Bob Picco wrote:
> > -	if (arg & (arg - 1)) {
> > +	if (arg < 1 || (arg & (arg - 1))) {
>
> Well it seems like what you want is:
>
> 	if (!arg || (arg & (arg - 1))) {

Yes, it's the same.  Here's the new patch:

Disallow setting an interrupt frequency of zero (which would result in
a division by zero), and disallow enabling the interrupt when the
frequency hasn't yet been set (which would use an interrupt period of
zero).

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--2015913978-851401618-1127890286=:3203
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="hpet-freq0.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.HPX.4.33n.0509280851260.3203@studcom.urz.uni-halle.de>
Content-Description: 
Content-Disposition: attachment; filename="hpet-freq0.diff"

LS0tIGxpbnV4LTIuNi4xMy5vcmlnL2RyaXZlcnMvY2hhci9ocGV0LmMJMjAw
NS0wOS0yMiAxMDo1NjoyMy4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51eC0y
LjYuMTMvZHJpdmVycy9jaGFyL2hwZXQuYwkyMDA1LTA5LTI1IDE5OjAyOjAy
LjAwMDAwMDAwMCArMDIwMA0KQEAgLTM2NSw2ICszNjUsOSBAQCBzdGF0aWMg
aW50IGhwZXRfaW9jdGxfaWVvbihzdHJ1Y3QgaHBldF9kDQogCWhwZXQgPSBk
ZXZwLT5oZF9ocGV0Ow0KIAlocGV0cCA9IGRldnAtPmhkX2hwZXRzOw0KIA0K
KwlpZiAoIWRldnAtPmhkX2lyZXFmcmVxKQ0KKwkJcmV0dXJuIC1FSU87DQor
DQogCXYgPSByZWFkcSgmdGltZXItPmhwZXRfY29uZmlnKTsNCiAJc3Bpbl9s
b2NrX2lycSgmaHBldF9sb2NrKTsNCiANCkBAIC01MTcsNyArNTIwLDcgQEAg
aHBldF9pb2N0bF9jb21tb24oc3RydWN0IGhwZXRfZGV2ICpkZXZwLA0KIAkJ
CWJyZWFrOw0KIAkJfQ0KIA0KLQkJaWYgKGFyZyAmIChhcmcgLSAxKSkgew0K
KwkJaWYgKCFhcmcgfHwgKGFyZyAmIChhcmcgLSAxKSkpIHsNCiAJCQllcnIg
PSAtRUlOVkFMOw0KIAkJCWJyZWFrOw0KIAkJfQ0K
--2015913978-851401618-1127890286=:3203--
