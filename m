Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbTLISI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbTLISI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:08:26 -0500
Received: from cdc868fe.powerlandcomputers.com ([205.200.104.254]:8607 "EHLO
	pl6w2kex.lan.powerlandcomputers.com") by vger.kernel.org with ESMTP
	id S264910AbTLISIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:08:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3BE7F.6ED5FAF8"
Subject: Minor bugs in via_dsp_release in via82cxxx_audio.c in 2.4.22
Date: Tue, 9 Dec 2003 12:08:22 -0600
Message-ID: <18DFD6B776308241A200853F3F83D507169CCF@pl6w2kex.lan.powerlandcomputers.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Minor bugs in via_dsp_release in via82cxxx_audio.c in 2.4.22
Thread-Index: AcO+f27OCF0f/D12QAaLqnSJGBTJzg==
From: "Chad Kitching" <CKitching@powerlandcomputers.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3BE7F.6ED5FAF8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

There are two bugs in the via_dsp_release function for this sound =
driver.
The first is just a typo, that prevents it from suppressing "via_audio:=20
ignoring drain playback error -512" errors. =20

The other bug (which I don't know the correct way to fix) in this same=20
area is the "via_audio: ignoring drain playback error -11", which is=20
caused when the via_dsp_drain_playback is called with nonblock !=3D 0, =
and=20
the function returns -EAGAIN.  Setting nonblock to zero certainly=20
supresses the error, but I'm not sure what the dangers of blocking in =
the=20
release function would be when an application specifically requests non-
blocking.  Ignoring this error as with -ERESTARTSYS is also possible =
(and=20
would cause no more harm than currently happens).

Both bugs are pretty minor, I was just getting annoyed with my logfiles =
filling up with useless messages.

------_=_NextPart_001_01C3BE7F.6ED5FAF8
Content-Type: application/octet-stream;
	name="viaaud.diff"
Content-Transfer-Encoding: base64
Content-Description: viaaud.diff
Content-Disposition: attachment;
	filename="viaaud.diff"

LS0tIGxpbnV4LTIuNC4yMi9kcml2ZXJzL3NvdW5kL3ZpYTgyY3h4eF9hdWRpby5jLm9yaWcJMjAw
My0xMi0wOSAxMTo0OTowMy4wMDAwMDAwMDAgLTA2MDAKKysrIGxpbnV4LTIuNC4yMi9kcml2ZXJz
L3NvdW5kL3ZpYTgyY3h4eF9hdWRpby5jCTIwMDMtMTItMDkgMTE6NDk6MjEuMDAwMDAwMDAwIC0w
NjAwCkBAIC0zMzYzLDcgKzMzNjMsNyBAQAogCiAJaWYgKGZpbGUtPmZfbW9kZSAmIEZNT0RFX1dS
SVRFKSB7CiAJCXJjID0gdmlhX2RzcF9kcmFpbl9wbGF5YmFjayAoY2FyZCwgJmNhcmQtPmNoX291
dCwgbm9uYmxvY2spOwotCQlpZiAocmMgJiYgcmMgIT0gRVJFU1RBUlRTWVMpCS8qIE5vYm9keSBu
ZWVkcyB0byBrbm93IGFib3V0IF5DICovCisJCWlmIChyYyAmJiByYyAhPSAtRVJFU1RBUlRTWVMp
CS8qIE5vYm9keSBuZWVkcyB0byBrbm93IGFib3V0IF5DICovCiAJCQlwcmludGsgKEtFUk5fREVC
VUcgInZpYV9hdWRpbzogaWdub3JpbmcgZHJhaW4gcGxheWJhY2sgZXJyb3IgJWRcbiIsIHJjKTsK
IAogCQl2aWFfY2hhbl9mcmVlIChjYXJkLCAmY2FyZC0+Y2hfb3V0KTsK

------_=_NextPart_001_01C3BE7F.6ED5FAF8--
