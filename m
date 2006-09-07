Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWIGJKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWIGJKx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 05:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWIGJKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 05:10:53 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:55958 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751323AbWIGJKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 05:10:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=HMXn4kzDYYGYPWA1HE6KwQ1lpIdOmiBgjOvPGRwupOJdCOIvWMyIMPA0M2XIcKhiulA0WrO8tIOaYsjmnxzimZVRZ2ywbmw1uG+3/wGl/N9LThlTa/nn9z+PvCbDFyJKemXAcllPJ3EShvwHXKqjtSyaix5QRQNL39hHUWyS9EM=
Message-ID: <b0943d9e0609070210p661a2cd6k5683d0956aaab5fe@mail.gmail.com>
Date: Thu, 7 Sep 2006 10:10:51 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.18-rc6 00/10] Kernel memory leak detector 0.10
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0609070205i27c19d3cq9fa0fc6961f28fa3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_22680_6807092.1157620251666"
References: <20060906223536.21550.55411.stgit@localhost.localdomain>
	 <6bffcb0e0609061710t3519e42dl6138cadd5ff0d3fb@mail.gmail.com>
	 <b0943d9e0609070104v1b747f79v3b10238954f389cd@mail.gmail.com>
	 <6bffcb0e0609070135i314f2740if067eeab342f29a2@mail.gmail.com>
	 <b0943d9e0609070137g5384b6dcp1ecff948661cd98@mail.gmail.com>
	 <6bffcb0e0609070140lb8dbee7pbedc0b38dc5a68b1@mail.gmail.com>
	 <b0943d9e0609070152v59c60eev3bbad18cd6d01dad@mail.gmail.com>
	 <6bffcb0e0609070205i27c19d3cq9fa0fc6961f28fa3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_22680_6807092.1157620251666
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 07/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 07/09/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > On 07/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > > On 07/09/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > > > On 07/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > > > > CONFIG_DEBUG_MEMLEAK=y
> > > > > CONFIG_DEBUG_MEMLEAK_HASH_BITS=8
> >
> > Have you tried 16?
>
> No, I haven't.

8 hash bits would lead to a really slow hash table lookup since you
would only have 256 entries and it uses linked lists to deal with
collisions (you may have tens of thousands of pointers to be stored in
the hash). Anyway, I attach a patch which allows you to set small
values but it is highly unrecommended.

-- 
Catalin

------=_Part_22680_6807092.1157620251666
Content-Type: text/x-patch; name=hash-bits-fix.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ersx6bcu
Content-Disposition: attachment; filename="hash-bits-fix.patch"

QWxsb3cgc21hbGwgdmFsdWVzIG9mIEhBU0hfQklUUyB0byBiZSBjb25maWd1cmVkCgpGcm9tOiBD
YXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPgoKVGhlIG9yaWdpbmFsIGlt
cGxlbWVudGF0aW9uIHdhcyBhc3N1bWluZyB0aGF0IHRoZSBIQVNIX0JJVFMgdmFsdWUgaXMgc21h
bGwKYmlnIGVub3VnaCBzbyB0aGF0IHRoZSBwYWdlIG9yZGVyIGlzIGF0IGxlYXN0IDAuIFRoaXMg
cGF0Y2ggY29ycmVjdHMgdGhpcy4KClNpZ25lZC1vZmYtYnk6IENhdGFsaW4gTWFyaW5hcyA8Y2F0
YWxpbi5tYXJpbmFzQGFybS5jb20+Ci0tLQoKIG1tL21lbWxlYWsuYyB8ICAgIDkgKysrKysrLS0t
CiAxIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9tbS9tZW1sZWFrLmMgYi9tbS9tZW1sZWFrLmMKaW5kZXggMGI1YWEwYy4uYTY1ZDkz
MCAxMDA2NDQKLS0tIGEvbW0vbWVtbGVhay5jCisrKyBiL21tL21lbWxlYWsuYwpAQCAtMTgwLDEy
ICsxODAsMTUgQEAgI2RlZmluZSBPQkpFQ1RfVFlQRV9HVUVTU0VECTB4MgogLyogSGFzaCBmdW5j
dGlvbnMgKi8KIHN0YXRpYyB2b2lkIGhhc2hfaW5pdCh2b2lkKQogewotCWludCBpOwotCWludCBo
YXNoX3NpemUgPSBzaXplb2YoKnBvaW50ZXJfaGFzaCkgKiAoMSA8PCBIQVNIX0JJVFMpOwotCWlu
dCBoYXNoX29yZGVyID0gZmxzKGhhc2hfc2l6ZSkgLSAxOworCXVuc2lnbmVkIGludCBpOworCXVu
c2lnbmVkIGludCBoYXNoX3NpemUgPSBzaXplb2YoKnBvaW50ZXJfaGFzaCkgKiAoMSA8PCBIQVNI
X0JJVFMpOworCXVuc2lnbmVkIGludCBoYXNoX29yZGVyID0gZmxzKGhhc2hfc2l6ZSkgLSAxOwog
CisJLyogaGFzaF9zaXplIG5vdCBhIHBvd2VyIG9mIDIgKi8KIAlpZiAoaGFzaF9zaXplICYgKCgx
IDw8IGhhc2hfb3JkZXIpIC0gMSkpCiAJCWhhc2hfb3JkZXIgKz0gMTsKKwlpZiAoaGFzaF9vcmRl
ciA8IFBBR0VfU0hJRlQpCisJCWhhc2hfb3JkZXIgPSBQQUdFX1NISUZUOwogCiAJcG9pbnRlcl9o
YXNoID0gKHN0cnVjdCBobGlzdF9oZWFkICopCiAJCV9fZ2V0X2ZyZWVfcGFnZXMoR0ZQX0FUT01J
QywgaGFzaF9vcmRlciAtIFBBR0VfU0hJRlQpOwo=
------=_Part_22680_6807092.1157620251666--
