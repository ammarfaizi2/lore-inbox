Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbTFMQKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265423AbTFMQKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:10:55 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:50905 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S265422AbTFMQKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:10:10 -0400
Date: Fri, 13 Jun 2003 12:23:53 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH-2.4] Routing interrupts to PCI on TI PCMCIA bridges
Message-ID: <Pine.LNX.4.56.0306131204320.2582@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2029045779-1055521433=:2582"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-2029045779-1055521433=:2582
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello, Marcelo and all!

This patch has been in the -ac series for a while and I haven't seen any
reports, positive or negative.

The idea is that if the bridge cannot generate ISA IRQs, it needs to be
reconfigured so that the PCI IRQ can be used.  Some TI bridges are
configured to use ISA interrupts by default, but they cannot do it because
they are connected to the PCI bus only.

I think it's time to put this patch to the main 2.4 branch.  The only
difference from the Alan's branch is that I removed an unhelpful printk,
since the socket is initialized every time the card is re-inserted, and
the message gets annoying.

2.5 kernels take care of this issue in a different way.

-- 
Regards,
Pavel Roskin
--8323328-2029045779-1055521433=:2582
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ti-autoirq.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.56.0306131223530.2582@marabou.research.att.com>
Content-Description: 
Content-Disposition: attachment; filename="ti-autoirq.diff"

LS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9wY21jaWEvdGkxMTN4LmgNCisrKyBs
aW51eC9kcml2ZXJzL3BjbWNpYS90aTExM3guaA0KQEAgLTE2Nyw2ICsxNjcs
MjUgQEANCiAJCW5ldyB8PSBJMzY1X0lOVFJfRU5BOw0KIAlpZiAobmV3ICE9
IHJlZykNCiAJCWV4Y2Ffd3JpdGViKHNvY2tldCwgSTM2NV9JTlRDVEwsIG5l
dyk7DQorDQorCS8qDQorCSAqIElmIElTQSBpbnRlcnJ1cHRzIGRvbid0IHdv
cmssIHRoZW4gZmFsbCBiYWNrIHRvIHJvdXRpbmcgY2FyZA0KKwkgKiBpbnRl
cnJ1cHRzIHRvIHRoZSBQQ0kgaW50ZXJydXB0IG9mIHRoZSBzb2NrZXQuDQor
CSAqLw0KKwlpZiAoIXNvY2tldC0+Y2FwLmlycV9tYXNrKSB7DQorCQlpbnQg
aXJxbXV4LCBkZXZjdGw7DQorDQorCQlkZXZjdGwgPSBjb25maWdfcmVhZGIo
c29ja2V0LCBUSTExM1hfREVWSUNFX0NPTlRST0wpOw0KKwkJZGV2Y3RsICY9
IH5USTExM1hfRENSX0lNT0RFX01BU0s7DQorDQorCQlpcnFtdXggPSBjb25m
aWdfcmVhZGwoc29ja2V0LCBUSTEyMlhfSVJRTVVYKTsNCisJCWlycW11eCA9
IChpcnFtdXggJiB+MHgwZikgfCAweDAyOyAvKiByb3V0ZSBJTlRBICovDQor
CQlpcnFtdXggPSAoaXJxbXV4ICYgfjB4ZjApIHwgMHgyMDsgLyogcm91dGUg
SU5UQiAqLw0KKw0KKwkJY29uZmlnX3dyaXRlbChzb2NrZXQsIFRJMTIyWF9J
UlFNVVgsIGlycW11eCk7DQorCQljb25maWdfd3JpdGViKHNvY2tldCwgVEkx
MTNYX0RFVklDRV9DT05UUk9MLCBkZXZjdGwpOw0KKwl9DQorDQogCXJldHVy
biAwOw0KIH0NCiANCg==

--8323328-2029045779-1055521433=:2582--
