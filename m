Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264370AbUEDN7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbUEDN7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 09:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUEDN7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 09:59:13 -0400
Received: from mail2.soliscom.uu.nl ([131.211.4.74]:43936 "EHLO
	solis202.soliscom.uu.nl") by vger.kernel.org with ESMTP
	id S264370AbUEDN7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 09:59:11 -0400
Subject: [PATCH - 1/2] new i2c video decoder calls
From: "Ronald S. Bultje" <R.S.Bultje@students.uu.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Michael Hunold <hunold@convergence.de>,
       Gerd Knorr <kraxel@bytesex.org>
Content-Type: multipart/mixed; boundary="=-Nv4u8mFCRM6Wq+tsAzmM"
Message-Id: <1083657613.26831.0.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 04 May 2004 10:00:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Nv4u8mFCRM6Wq+tsAzmM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

attached patch adds three new calls to the i2c video decoder API. The
changes were requested by Michael (CC'ed) and approved by Gerd Knorr
(v4l maintainer, CC'ed).

Short explanation:
* INIT is a general initialization call with optional initialization
data. Reason for this is that several i2c decoders (or general: clients)
are being used by several adapters (main drivers), and in some cases,
one adapter simply needs different settings than the other, either
because the adapter is completely different or because the card was
reverse engineered in a way that doesn't allow multiple adapters to run
using the same original initialization data. Michael faces such a
problem right now. Both he and me lack time to properly sit together and
work out the exact details or a proper way to merge.

* VBI_BYPASS and GPIO set specific pins on the decoder. This will be
used in the saa7111 driver. My driver (zr36067, original user of the
saa7111 driver) doesn't use any of this, but Michael's does.

Patch should apply against any recent 2.6.x kernel.

Thanks,

Ronald

--=-Nv4u8mFCRM6Wq+tsAzmM
Content-Disposition: attachment; filename=linux-i2c-video-decoder.diff
Content-Type: text/x-patch; name=linux-i2c-video-decoder.diff; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtdXJhIHh4LWxpbnV4LTIuNi4zL2luY2x1ZGUvbGludXgvdmlkZW9fZGVjb2Rlci5oIGxp
bnV4LTIuNi4zL2luY2x1ZGUvbGludXgvdmlkZW9fZGVjb2Rlci5oDQotLS0geHgtbGludXgtMi42
LjMvaW5jbHVkZS9saW51eC92aWRlb19kZWNvZGVyLmgJMjAwMy0xMi0xOCAwMzo1ODowNC4wMDAw
MDAwMDAgKzAxMDANCisrKyBsaW51eC0yLjYuMy9pbmNsdWRlL2xpbnV4L3ZpZGVvX2RlY29kZXIu
aAkyMDA0LTAyLTIyIDE2OjIwOjA3LjAwMDAwMDAwMCArMDEwMA0KQEAgLTIyLDYgKzIyLDEwIEBA
DQogI2RlZmluZQlERUNPREVSX1NUQVRVU19OVFNDCTgJLyogYXV0byBkZXRlY3RlZCAqLw0KICNk
ZWZpbmUJREVDT0RFUl9TVEFUVVNfU0VDQU0JMTYJLyogYXV0byBkZXRlY3RlZCAqLw0KIA0KK3N0
cnVjdCB2aWRlb19kZWNvZGVyX2luaXQgew0KKwl1bnNpZ25lZCBjaGFyIGxlbjsNCisJY29uc3Qg
dW5zaWduZWQgY2hhciAqZGF0YTsNCit9Ow0KIA0KICNkZWZpbmUJREVDT0RFUl9HRVRfQ0FQQUJJ
TElUSUVTIF9JT1IoJ2QnLCAxLCBzdHJ1Y3QgdmlkZW9fZGVjb2Rlcl9jYXBhYmlsaXR5KQ0KICNk
ZWZpbmUJREVDT0RFUl9HRVRfU1RBVFVTICAgIAlfSU9SKCdkJywgMiwgaW50KQ0KQEAgLTMwLDYg
KzM0LDkgQEANCiAjZGVmaW5lCURFQ09ERVJfU0VUX09VVFBVVAlfSU9XKCdkJywgNSwgaW50KQkv
KiAwIDw9IG91dHB1dCA8ICNvdXRwdXRzICovDQogI2RlZmluZQlERUNPREVSX0VOQUJMRV9PVVRQ
VVQJX0lPVygnZCcsIDYsIGludCkJLyogYm9vbGVhbiBvdXRwdXQgZW5hYmxlIGNvbnRyb2wgKi8N
CiAjZGVmaW5lCURFQ09ERVJfU0VUX1BJQ1RVUkUgICAJX0lPVygnZCcsIDcsIHN0cnVjdCB2aWRl
b19waWN0dXJlKQ0KKyNkZWZpbmUJREVDT0RFUl9TRVRfR1BJTwlfSU9XKCdkJywgOCwgaW50KQkv
KiBzd2l0Y2ggZ2VuZXJhbCBwdXJwb3NlIHBpbiAqLw0KKyNkZWZpbmUJREVDT0RFUl9JTklUCQlf
SU9XKCdkJywgOSwgc3RydWN0IHZpZGVvX2RlY29kZXJfaW5pdCkJLyogaW5pdCBpbnRlcm5hbCBy
ZWdpc3RlcnMgYXQgb25jZSAqLw0KKyNkZWZpbmUJREVDT0RFUl9TRVRfVkJJX0JZUEFTUwlfSU9X
KCdkJywgMTAsIGludCkJLyogc3dpdGNoIHZiaSBieXBhc3MgKi8NCiANCiAjZGVmaW5lCURFQ09E
RVJfRFVNUAkJX0lPKCdkJywgMTkyKQkJLyogZGVidWcgaG9vayAqLw0KIA0K

--=-Nv4u8mFCRM6Wq+tsAzmM--
