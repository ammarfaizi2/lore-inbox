Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280678AbRKBNAl>; Fri, 2 Nov 2001 08:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280681AbRKBNAc>; Fri, 2 Nov 2001 08:00:32 -0500
Received: from ns.ithnet.com ([217.64.64.10]:30219 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S280680AbRKBNAT>;
	Fri, 2 Nov 2001 08:00:19 -0500
Date: Fri, 2 Nov 2001 14:00:01 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Cc: torvalds@transmeta.com, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
Message-Id: <20011102140001.7c995186.skraw@ithnet.com>
In-Reply-To: <3.0.6.32.20011031185529.01fc4310@pop.tiscalinet.it>
In-Reply-To: <Pine.LNX.4.33L.0110311259570.2963-100000@imladris.surriel.com>
	<3.0.6.32.20011031185529.01fc4310@pop.tiscalinet.it>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__2_Nov_2001_14:00:01_+0100_087a06f0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Fri__2_Nov_2001_14:00:01_+0100_087a06f0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Lorenzo,

please find attached next vmscan.c patch which sums up the delayed swap_out
(first patch), the fix for not swapping when nr_pages is reached, and (new) the
idea to swap more pages in one call to swap_out if priority gets higher.

I have not the slightest idea what all this does to the performance. Especially
the "more" swap_out code is a pure try-and-error type of thing. Can you do some
testing please?

Thanks,
Stephan

--Multipart_Fri__2_Nov_2001_14:00:01_+0100_087a06f0
Content-Type: application/octet-stream;
 name="vmscan-patch2"
Content-Disposition: attachment;
 filename="vmscan-patch2"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LW9yaWcvbW0vdm1zY2FuLmMJVGh1IE5vdiAgMSAxNTozMzo1OCAyMDAxCisrKyBs
aW51eC9tbS92bXNjYW4uYwlGcmkgTm92ICAyIDEzOjUwOjMxIDIwMDEKQEAgLTI5MCw3ICsyOTAs
NyBAQAogc3RhdGljIGludCBGQVNUQ0FMTChzd2FwX291dCh1bnNpZ25lZCBpbnQgcHJpb3JpdHks
IHVuc2lnbmVkIGludCBnZnBfbWFzaywgem9uZV90ICogY2xhc3N6b25lKSk7CiBzdGF0aWMgaW50
IHN3YXBfb3V0KHVuc2lnbmVkIGludCBwcmlvcml0eSwgdW5zaWduZWQgaW50IGdmcF9tYXNrLCB6
b25lX3QgKiBjbGFzc3pvbmUpCiB7Ci0JaW50IGNvdW50ZXIsIG5yX3BhZ2VzID0gU1dBUF9DTFVT
VEVSX01BWDsKKwlpbnQgY291bnRlciwgbnJfcGFnZXMgPSBTV0FQX0NMVVNURVJfTUFYICogREVG
X1BSSU9SSVRZIC8gcHJpb3JpdHk7CiAJc3RydWN0IG1tX3N0cnVjdCAqbW07CiAKIAljb3VudGVy
ID0gbW1saXN0X25yOwpAQCAtMzM0LDcgKzMzNCw3IEBACiB7CiAJc3RydWN0IGxpc3RfaGVhZCAq
IGVudHJ5OwogCWludCBtYXhfc2NhbiA9IG5yX2luYWN0aXZlX3BhZ2VzIC8gcHJpb3JpdHk7Ci0J
aW50IG1heF9tYXBwZWQgPSBucl9wYWdlcyoxMDsKKwlpbnQgbWF4X21hcHBlZCA9IFNXQVBfQ0xV
U1RFUl9NQVggKiBERUZfUFJJT1JJVFkgLyBwcmlvcml0eTsKIAogCXNwaW5fbG9jaygmcGFnZW1h
cF9scnVfbG9jayk7CiAJd2hpbGUgKC0tbWF4X3NjYW4gPj0gMCAmJiAoZW50cnkgPSBpbmFjdGl2
ZV9saXN0LnByZXYpICE9ICZpbmFjdGl2ZV9saXN0KSB7CkBAIC00NjksMTYgKzQ2OSwxMCBAQAog
CQkJc3Bpbl91bmxvY2soJnBhZ2VjYWNoZV9sb2NrKTsKIAkJCVVubG9ja1BhZ2UocGFnZSk7CiBw
YWdlX21hcHBlZDoKLQkJCWlmICgtLW1heF9tYXBwZWQgPj0gMCkKLQkJCQljb250aW51ZTsKKwkJ
CWlmIChtYXhfbWFwcGVkID4gMCkKKwkJCQltYXhfbWFwcGVkLS07CisJCQljb250aW51ZTsKIAot
CQkJLyoKLQkJCSAqIEFsZXJ0ISBXZSd2ZSBmb3VuZCB0b28gbWFueSBtYXBwZWQgcGFnZXMgb24g
dGhlCi0JCQkgKiBpbmFjdGl2ZSBsaXN0LCBzbyB3ZSBzdGFydCBzd2FwcGluZyBvdXQgbm93IQot
CQkJICovCi0JCQlzcGluX3VubG9jaygmcGFnZW1hcF9scnVfbG9jayk7Ci0JCQlzd2FwX291dChw
cmlvcml0eSwgZ2ZwX21hc2ssIGNsYXNzem9uZSk7Ci0JCQlyZXR1cm4gbnJfcGFnZXM7CiAJCX0K
IAogCQkvKgpAQCAtNTE0LDYgKzUwOCwxNCBAQAogCQlicmVhazsKIAl9CiAJc3Bpbl91bmxvY2so
JnBhZ2VtYXBfbHJ1X2xvY2spOworCisJLyoKKwkgKiBBbGVydCEgV2UndmUgZm91bmQgdG9vIG1h
bnkgbWFwcGVkIHBhZ2VzIG9uIHRoZQorCSAqIGluYWN0aXZlIGxpc3QsIHNvIHdlIHN0YXJ0IHN3
YXBwaW5nIG91dCAtIGRlbGF5ZWQhCisJICogLXNrcmF3CisJICovCisJaWYgKG1heF9tYXBwZWQ9
PTAgJiYgbnJfcGFnZXM+MCkKKwkJc3dhcF9vdXQocHJpb3JpdHksIGdmcF9tYXNrLCBjbGFzc3pv
bmUpOwogCiAJcmV0dXJuIG5yX3BhZ2VzOwogfQo=

--Multipart_Fri__2_Nov_2001_14:00:01_+0100_087a06f0--
