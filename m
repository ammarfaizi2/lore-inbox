Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267885AbRGZMbh>; Thu, 26 Jul 2001 08:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267875AbRGZMb1>; Thu, 26 Jul 2001 08:31:27 -0400
Received: from chiara.elte.hu ([157.181.150.200]:65029 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S267904AbRGZMbO>;
	Thu, 26 Jul 2001 08:31:14 -0400
Date: Thu, 26 Jul 2001 14:29:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: highmem-2.4.7-A0 [Re: kmap() while holding spinlock]
In-Reply-To: <Pine.LNX.4.33.0107261409110.3796-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0107261423020.3796-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-338918117-996150274=:3796"
Content-ID: <Pine.LNX.4.33.0107261428370.4257@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-338918117-996150274=:3796
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0107261428371.4257@localhost.localdomain>


> [...] or to do the clearing (and copying) speculatively, after
> allocating the page but before locking the pagetable lock. This might
> lead to a bit more work in the pagefault-race case, but we dont care
> about that window. It will on the other hand reduce pagetable_lock
> contention (because the clearing/copying is done outside the lock), so
> perhaps this solution is better.

the attached highmem-2.4.7-A0 patch implements this method in both
affected functions. Comments?

	Ingo

--8323328-338918117-996150274=:3796
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="highmem-2.4.7-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0107261424340.3796@localhost.localdomain>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="highmem-2.4.7-A0"

LS0tIGxpbnV4L21tL21lbW9yeS5jLm9yaWcJVGh1IEp1bCAyNiAxMzo1Mjo0
MSAyMDAxDQorKysgbGludXgvbW0vbWVtb3J5LmMJVGh1IEp1bCAyNiAxNDow
Mjo1NCAyMDAxDQpAQCAtODY1LDcgKzg2NSw2IEBADQogc3RhdGljIGlubGlu
ZSB2b2lkIGJyZWFrX2NvdyhzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKiB2bWEs
IHN0cnVjdCBwYWdlICoJb2xkX3BhZ2UsIHN0cnVjdCBwYWdlICogbmV3X3Bh
Z2UsIHVuc2lnbmVkIGxvbmcgYWRkcmVzcywgDQogCQlwdGVfdCAqcGFnZV90
YWJsZSkNCiB7DQotCWNvcHlfY293X3BhZ2Uob2xkX3BhZ2UsbmV3X3BhZ2Us
YWRkcmVzcyk7DQogCWZsdXNoX3BhZ2VfdG9fcmFtKG5ld19wYWdlKTsNCiAJ
Zmx1c2hfY2FjaGVfcGFnZSh2bWEsIGFkZHJlc3MpOw0KIAllc3RhYmxpc2hf
cHRlKHZtYSwgYWRkcmVzcywgcGFnZV90YWJsZSwgcHRlX21rd3JpdGUocHRl
X21rZGlydHkobWtfcHRlKG5ld19wYWdlLCB2bWEtPnZtX3BhZ2VfcHJvdCkp
KSk7DQpAQCAtOTM4LDYgKzkzNyw4IEBADQogCSAqLw0KIAlzcGluX3VubG9j
aygmbW0tPnBhZ2VfdGFibGVfbG9jayk7DQogCW5ld19wYWdlID0gYWxsb2Nf
cGFnZShHRlBfSElHSFVTRVIpOw0KKwlpZiAobmV3X3BhZ2UpDQorCQljb3B5
X2Nvd19wYWdlKG9sZF9wYWdlLG5ld19wYWdlLGFkZHJlc3MpOw0KIAlzcGlu
X2xvY2soJm1tLT5wYWdlX3RhYmxlX2xvY2spOw0KIAlpZiAoIW5ld19wYWdl
KQ0KIAkJcmV0dXJuIC0xOw0KQEAgLTExNjQsNiArMTE2NSw4IEBADQogCQkv
KiBBbGxvY2F0ZSBvdXIgb3duIHByaXZhdGUgcGFnZS4gKi8NCiAJCXNwaW5f
dW5sb2NrKCZtbS0+cGFnZV90YWJsZV9sb2NrKTsNCiAJCXBhZ2UgPSBhbGxv
Y19wYWdlKEdGUF9ISUdIVVNFUik7DQorCQlpZiAocGFnZSkNCisJCQljbGVh
cl91c2VyX2hpZ2hwYWdlKHBhZ2UsIGFkZHIpOw0KIAkJc3Bpbl9sb2NrKCZt
bS0+cGFnZV90YWJsZV9sb2NrKTsNCiAJCWlmICghcGFnZSkNCiAJCQlyZXR1
cm4gLTE7DQpAQCAtMTE3Miw3ICsxMTc1LDYgQEANCiAJCQlyZXR1cm4gMTsN
CiAJCX0NCiAJCW1tLT5yc3MrKzsNCi0JCWNsZWFyX3VzZXJfaGlnaHBhZ2Uo
cGFnZSwgYWRkcik7DQogCQlmbHVzaF9wYWdlX3RvX3JhbShwYWdlKTsNCiAJ
CWVudHJ5ID0gcHRlX21rd3JpdGUocHRlX21rZGlydHkobWtfcHRlKHBhZ2Us
IHZtYS0+dm1fcGFnZV9wcm90KSkpOw0KIAl9DQo=
--8323328-338918117-996150274=:3796--
