Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVA1Qz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVA1Qz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 11:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVA1Qz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 11:55:28 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:38619 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261478AbVA1QzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 11:55:15 -0500
Date: Fri, 28 Jan 2005 11:55:13 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@localhost.localdomain
To: discuss@x86-64.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Move HPET options from top level, enable HPET_TIMER prompt
Message-ID: <Pine.LNX.4.62.0501281143040.3332@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1711292520-1106931313=:3332"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1711292520-1106931313=:3332
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hello!

"make menuconfig" for x86_64 looks somewhat funky:

[ ] Provide RTC interrupt (NEW)
     Code maturity level options  --->
     General setup  --->
...

I believe all x86_64 specific options for HPET timer should be moved to 
the "Processor type and features" menu.  That's where they are located for 
i386.  There are two such options - HPET_TIMER and HPET_EMULATE_RTC.

Also, there is no prompt for HPET_TIMER, so it's always set.  However, the 
help text ends with "If unsure, say Y".  Kind of pointless, isn't it?  I 
enabled the prompt and deselected HPET_TIMER.  The kernel compiled and 
booted just fine.  Kernel messages don't indicate that HPET is used, but 
they said so when HPET_TIMER was enabled.

The patch does two things:

- HPET_TIMER and HPET_EMULATE_RTC are moved from the top-level to
   "Processor type and features"
- HPET_TIMER can be deselected (just like on i386)

The patch is against current Linux snapshot (svn revision 26268).

-- 
Regards,
Pavel Roskin
--8323328-1711292520-1106931313=:3332
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=hpet.diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0501281155130.3332@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename=hpet.diff

SW5kZXg6IGFyY2gveDg2XzY0L0tjb25maWcNCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCi0tLSBhcmNoL3g4Nl82NC9LY29uZmlnCShyZXZpc2lvbiAyNjI2
OCkNCisrKyBhcmNoL3g4Nl82NC9LY29uZmlnCSh3b3JraW5nIGNvcHkpDQpA
QCAtNjIsMjMgKzYyLDYgQEANCiAJICB3aXRoIGtsb2dkL3N5c2xvZ2Qgb3Ig
dGhlIFggc2VydmVyLiBZb3Ugc2hvdWxkIG5vcm1hbGx5IE4gaGVyZSwNCiAJ
ICB1bmxlc3MgeW91IHdhbnQgdG8gZGVidWcgc3VjaCBhIGNyYXNoLg0KIA0K
LWNvbmZpZyBIUEVUX1RJTUVSDQotCWJvb2wNCi0JZGVmYXVsdCB5DQotCWhl
bHANCi0JICBVc2UgdGhlIElBLVBDIEhQRVQgKEhpZ2ggUHJlY2lzaW9uIEV2
ZW50IFRpbWVyKSB0byBtYW5hZ2UNCi0JICB0aW1lIGluIHByZWZlcmVuY2Ug
dG8gdGhlIFBJVCBhbmQgUlRDLCBpZiBhIEhQRVQgaXMNCi0JICBwcmVzZW50
LiAgVGhlIEhQRVQgcHJvdmlkZXMgYSBzdGFibGUgdGltZSBiYXNlIG9uIFNN
UA0KLQkgIHN5c3RlbXMsIHVubGlrZSB0aGUgUlRDLCBidXQgaXQgaXMgbW9y
ZSBleHBlbnNpdmUgdG8gYWNjZXNzLA0KLQkgIGFzIGl0IGlzIG9mZi1jaGlw
LiAgWW91IGNhbiBmaW5kIHRoZSBIUEVUIHNwZWMgYXQNCi0JICA8aHR0cDov
L3d3dy5pbnRlbC5jb20vbGFicy9wbGF0Y29tcC9ocGV0L2hwZXRzcGVjLmh0
bT4uDQotDQotCSAgSWYgdW5zdXJlLCBzYXkgWS4NCi0NCi1jb25maWcgSFBF
VF9FTVVMQVRFX1JUQw0KLQlib29sICJQcm92aWRlIFJUQyBpbnRlcnJ1cHQi
DQotCWRlcGVuZHMgb24gSFBFVF9USU1FUiAmJiBSVEM9eQ0KLQ0KIGNvbmZp
ZyBHRU5FUklDX0lTQV9ETUENCiAJYm9vbA0KIAlkZWZhdWx0IHkNCkBAIC0x
OTMsNiArMTc2LDIzIEBADQogCWJvb2wNCiAJZGVmYXVsdCB5DQogDQorY29u
ZmlnIEhQRVRfVElNRVINCisJYm9vbCAiSFBFVCBUaW1lciBTdXBwb3J0Ig0K
KwlkZWZhdWx0IHkNCisJaGVscA0KKwkgIFVzZSB0aGUgSUEtUEMgSFBFVCAo
SGlnaCBQcmVjaXNpb24gRXZlbnQgVGltZXIpIHRvIG1hbmFnZQ0KKwkgIHRp
bWUgaW4gcHJlZmVyZW5jZSB0byB0aGUgUElUIGFuZCBSVEMsIGlmIGEgSFBF
VCBpcw0KKwkgIHByZXNlbnQuICBUaGUgSFBFVCBwcm92aWRlcyBhIHN0YWJs
ZSB0aW1lIGJhc2Ugb24gU01QDQorCSAgc3lzdGVtcywgdW5saWtlIHRoZSBS
VEMsIGJ1dCBpdCBpcyBtb3JlIGV4cGVuc2l2ZSB0byBhY2Nlc3MsDQorCSAg
YXMgaXQgaXMgb2ZmLWNoaXAuICBZb3UgY2FuIGZpbmQgdGhlIEhQRVQgc3Bl
YyBhdA0KKwkgIDxodHRwOi8vd3d3LmludGVsLmNvbS9sYWJzL3BsYXRjb21w
L2hwZXQvaHBldHNwZWMuaHRtPi4NCisNCisJICBJZiB1bnN1cmUsIHNheSBZ
Lg0KKw0KK2NvbmZpZyBIUEVUX0VNVUxBVEVfUlRDDQorCWJvb2wgIlByb3Zp
ZGUgUlRDIGludGVycnVwdCINCisJZGVwZW5kcyBvbiBIUEVUX1RJTUVSICYm
IFJUQz15DQorDQogY29uZmlnIE1UUlINCiAJYm9vbCAiTVRSUiAoTWVtb3J5
IFR5cGUgUmFuZ2UgUmVnaXN0ZXIpIHN1cHBvcnQiDQogCS0tLWhlbHAtLS0N
Cg==

--8323328-1711292520-1106931313=:3332--
