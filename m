Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUEFBnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUEFBnz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 21:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUEFBnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 21:43:55 -0400
Received: from fmr05.intel.com ([134.134.136.6]:26827 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261156AbUEFBnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 21:43:53 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4330B.90FE1E60"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH] bug in bigsmp CPU bringup
Date: Wed, 5 May 2004 18:43:44 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6001BFF5A9@scsmsx403.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] bug in bigsmp CPU bringup
Thread-Index: AcQzC4+PpvFMXChkRoezKxBP12GNMw==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 06 May 2004 01:43:44.0719 (UTC) FILETIME=[91373DF0:01C4330B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4330B.90FE1E60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



There is an bug in bigsmp sub-architecture, due to which it will not
enable all the CPUs when the BIOS-APICIDs are not 0 to n-1 (where n is
total number of CPUs). Particularly, only 2 CPU comes up on a system
that has 4 CPUs with BIOS APICID as (0, 1, 6, 7).=20

The bug is root caused to check_apicid_present(bit) call in smpboot.c,
when bigsmp is expecting apicid in place of bit.
check_apicid_present(bit) in bigsmp subarchitecture checks the bit with
phys_id_present_map (which is actually map representing all apicids and
not bit).

One solution is to change check_apicid_present(bit) to
check_apicid_present(apicid), in smp_boot_cpus(). But, it can affect all
the other subarchitectures in various subtle ways. So, here is a simple
alternate fix (Thanks to Martin Bligh), which solves the above problem.

Please consider for inclusion in 2.6 base.

Thanks,
Venki

------_=_NextPart_001_01C4330B.90FE1E60
Content-Type: application/octet-stream;
	name="apicid2.patch"
Content-Transfer-Encoding: base64
Content-Description: apicid2.patch
Content-Disposition: attachment;
	filename="apicid2.patch"

LS0tIGxpbnV4LTIuNi42LXJjMy1tbTEtbW9kL2luY2x1ZGUvYXNtLWkzODYvbWFjaC1iaWdzbXAv
bWFjaF9hcGljLmgub3JnCTIwMDQtMDUtMDUgMTk6MTU6MTkuMDAwMDAwMDAwIC0wNzAwCisrKyBs
aW51eC0yLjYuNi1yYzMtbW0xLW1vZC9pbmNsdWRlL2FzbS1pMzg2L21hY2gtYmlnc21wL21hY2hf
YXBpYy5oCTIwMDQtMDUtMDUgMTk6MTY6MjYuMDAwMDAwMDAwIC0wNzAwCkBAIC00NSw5ICs0NSwx
MCBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgY2hlY2tfYXBpY2lkCiAJcmV0dXJuIDA7
CiB9CiAKKy8qIHdlIGRvbid0IHVzZSB0aGUgcGh5c19jcHVfcHJlc2VudF9tYXAgdG8gaW5kaWNh
dGUgYXBpY2lkIHByZXNlbmNlICovCiBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgY2hlY2tf
YXBpY2lkX3ByZXNlbnQoaW50IGJpdCkgCiB7Ci0JcmV0dXJuIHBoeXNpZF9pc3NldChiaXQsIHBo
eXNfY3B1X3ByZXNlbnRfbWFwKTsKKwlyZXR1cm4gMTsKIH0KIAogI2RlZmluZSBhcGljaWRfY2x1
c3RlcihhcGljaWQpIChhcGljaWQgJiAweEYwKQo=

------_=_NextPart_001_01C4330B.90FE1E60--
