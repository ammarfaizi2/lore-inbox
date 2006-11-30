Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030515AbWK3Pdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbWK3Pdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 10:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030528AbWK3Pdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 10:33:37 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:26349 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030515AbWK3Pdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 10:33:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=CESzCzO4OgbthoCKNBj+mc4eOs59A+Udb/LvR+6HTgnPdiW4R8NWixtqMGVmOmUmxoOKl/ElZZt3MDNY05GHov5Zd9NrtKZ5LhskLthVhmUFdWsE03KD2HG3aX3NumcbJVFJilGF59je7OsnXYTkNhxukC/7uku3RJKo+1/eULo=
Message-ID: <3a5b1be00611300733y121ef089m66bf46852ec0866d@mail.gmail.com>
Date: Thu, 30 Nov 2006 17:33:35 +0200
From: "Komal Shah" <komal.shah802003@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: =?ISO-8859-1?Q?bitmap=AD=5Ffind=5Ffree=5Fregion_?= =?ISO-8859-1?Q?and_bitmap=5Ffull_arg_doubts?=
Cc: akpm@osdl.org, lethal@linux-sh.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_36211_23856804.1164900815522"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_36211_23856804.1164900815522
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I was writing the test module, for layered bitmaps, specific to my
requirement such that I want to have control/track of 2GB virtual
address space. As per the discussion with Paul Mundt, I have taken the
approach of segmenting the virt. space with 128MB of blocks and then
to do find_next_zero_bit followed by bitmap_find_free_region on the
bitmaps.

I have attached the test module code. I have confusion about the what
to pass as second argument of bitmap_find_free_region for 2nd layer
bitmap.

Do we have to pass "total size of the block...here 128MB" as the
second argument or no. of bits in that block, which 32768 (128 >>
PAGE_SHIFT) ?

This confusion arised as store queue implementation (sq.c) of sh arch,
passes total size of the bitmap (64M) as the second argument instead
of bits.

Same is the case with bitmap_full, where I have to pass total size of
the block (here 128MB) instead of no. of bits, in-order it to make my
test module work correctly.

--
Link: sq.c
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;h=7bcc73f9b8df535ad8887383aeac71a8b2491ef5;hb=0215ffb08ce99e2bb59eca114a99499a4d06e704;f=arch/sh/kernel/cpu/sh4/sq.c

-- 
---Komal Shah
http://komalshah.blogspot.com

------=_Part_36211_23856804.1164900815522
Content-Type: text/x-csrc; name=bitmap.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ev5bhtt6
Content-Disposition: attachment; filename="bitmap.c"

LyogdGVzdCBtb2R1bGUgZm9yIGxheWVyZWQgYml0bWFwcyAqLwoKI2luY2x1ZGUgPGxpbnV4L2lu
aXQuaD4KI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgojaW5jbHVkZSA8bGludXgvZXJyLmg+CiNp
bmNsdWRlIDxsaW51eC9jbGsuaD4KI2luY2x1ZGUgPGFzbS9iaXRvcHMuaD4KI2luY2x1ZGUgPGFz
bS9zaXplcy5oPgoKI2RlZmluZSBWSVJUX1NJWkUJU1pfMkcKI2RlZmluZSBMMV9CTV9TRUdfU0la
RQkweDgwMDAwMDAJLyogMTI4TUIgKi8KI2RlZmluZSBMMV9CTV9OVU1fU0VHUwkoVklSVF9TSVpF
IC8gTDFfQk1fU0VHX1NJWkUpCiNkZWZpbmUgTDFfQk1fQklUUwlMMV9CTV9OVU1fU0VHUwkvKiAx
NiBiaXRzICovCgojZGVmaW5lIEwyX0JNX0JJVFMJKEwxX0JNX1NFR19TSVpFID4+IFBBR0VfU0hJ
RlQpCiNkZWZpbmUgTDJfQk1fU0laRQlMMV9CTV9TRUdfU0laRQojZGVmaW5lIEwyX0JNX0xPTkdT
CSgoTDJfQk1fQklUUyArIEJJVFNfUEVSX0xPTkcgLSAxKSAvIEJJVFNfUEVSX0xPTkcpCgpzdGF0
aWMgdW5zaWduZWQgbG9uZyBibV9sMSA9IDB4MDAwMDsKc3RhdGljIHVuc2lnbmVkIGxvbmcgKmJt
X2wyOwpzdGF0aWMgdW5zaWduZWQgbG9uZyBuZXh0X29mZiA9IDB4MDsKCiNkZWZpbmUgc3RhcnRf
YWRkciAweDgwMDAwMDAwCgpzdGF0aWMgdW5zaWduZWQgbG9uZyB0ZXN0X2ZpbmRfZnJlZV9yZWdp
b24odW5zaWduZWQgbG9uZyBzaXplKQp7CglpbnQgbDFfb2ZmLCBsMl9vZmY7Cgl1bnNpZ25lZCBs
b25nIGFkZHIgPSAweDA7Cgl1bnNpZ25lZCBpbnQgb3JkZXI7Cgl1bnNpZ25lZCBsb25nICp0bXBf
Ym07CgoJaWYgKHNpemUgPiBMMV9CTV9TRUdfU0laRSkgewoJCXByaW50ayhLRVJOX0VSUiAic2l6
ZSBncmVhdGVyIHRoYW4gMTI4TUIgaXMgbm90IGFsbG93ZWRcbiIpOwoJCXJldHVybiAtRUlOVkFM
OwoJfQoKCW9yZGVyID0gZ2V0X29yZGVyKHNpemUpOwoKbmV4dF9ibG9jazoKCWwxX29mZiA9IGZp
bmRfbmV4dF96ZXJvX2JpdCgmYm1fbDEsIEwxX0JNX0JJVFMsIG5leHRfb2ZmKTsKCWlmIChsMV9v
ZmYgPj0gTDFfQk1fQklUUykgewoJCXByaW50ayhLRVJOX0VSUiAibGF5ZXIxIGJpdG1hcCBpcyBm
dWxsXG4iKTsKCQlyZXR1cm4gLUVJTlZBTDsKCX0KCgl0bXBfYm0gPSBibV9sMiArIChsMV9vZmYg
KiBMMl9CTV9MT05HUyk7CglsMl9vZmYgPSBiaXRtYXBfZmluZF9mcmVlX3JlZ2lvbih0bXBfYm0s
IDMyNzY4IC8qIEwyX0JNX1NJWkUgKi8sCgkJCQkJIG9yZGVyKTsKCglwcmludGsoS0VSTl9JTkZP
ICJsMV9vZmYgJWQgbDJfb2ZmICVkXG4iLCBsMV9vZmYsIGwyX29mZik7CglpZiAobDJfb2ZmIDwg
MCkgewoJCW5leHRfb2ZmID0gKGwxX29mZiA+PSBMMV9CTV9CSVRTKSA/IDAgOiAobmV4dF9vZmYg
KyAxKTsKCQlpZiAoYml0bWFwX2Z1bGwodG1wX2JtLCBMMl9CTV9TSVpFIC8qTDJfQk1fQklUUyov
KSkgewoJCQlzZXRfYml0KGwxX29mZiwgJmJtX2wxKTsKCQl9CgkJcHJpbnRrKEtFUk5fSU5GTyAi
Z28gdG8gbmV4dF9ibG9jayAlbGRcbiIsIG5leHRfb2ZmKTsKCQlnb3RvIG5leHRfYmxvY2s7Cgl9
CgoJaWYgKGJpdG1hcF9mdWxsKHRtcF9ibSwgTDJfQk1fU0laRSAvKkwyX0JNX0JJVFMqLykpIHsK
CQlzZXRfYml0KGwxX29mZiwgJmJtX2wxKTsKCX0KCglhZGRyID0gKGwxX29mZiAqIEwxX0JNX1NF
R19TSVpFKSArIChsMl9vZmYgPDwgUEFHRV9TSElGVCk7CgoJcmV0dXJuIChhZGRyICsgc3RhcnRf
YWRkcik7Cn0KCnN0YXRpYyBpbnQgX19pbml0IHRlc3RfYWxsb2NfaW5pdCh2b2lkKQp7CgkvKnJl
cXVpcmVkIHVsb25ncyBmb3Igc3RvcmFnZSBvZiBucl9iaXRzICovCgl1bnNpZ25lZCBpbnQgc2l6
ZSA9IChMMl9CTV9CSVRTICsgKEJJVFNfUEVSX0xPTkcgLSAxKSkgLyBCSVRTX1BFUl9MT05HOwoJ
dW5zaWduZWQgbG9uZyBhZGRyOwoKCS8qIHNpeHRlZW4gMTI4TUIgbGF5ZXIgMiBiaXRtYXBzICov
CglibV9sMiA9IGt6YWxsb2Moc2l6ZSAqIEwxX0JNX05VTV9TRUdTLCBHRlBfS0VSTkVMKTsKCWlm
ICghYm1fbDIpIHsKCQlwcmludGsoS0VSTl9JTkZPICJObyBtZW1vcnkuLi5cbiIpOwoJCXJldHVy
biAtRUlOVkFMOwoJfQoJYWRkciA9IHRlc3RfZmluZF9mcmVlX3JlZ2lvbihTWl82NE0pOwoJcHJp
bnRrKEtFUk5fSU5GTyAiYWRkciBpcyAweCVseFxuIiwgYWRkcik7CgoJYWRkciA9IHRlc3RfZmlu
ZF9mcmVlX3JlZ2lvbihTWl82NE0gKyBTWl8zMk0pOwoJcHJpbnRrKEtFUk5fSU5GTyAiYWRkciBp
cyAweCVseFxuIiwgYWRkcik7CgoJYWRkciA9IHRlc3RfZmluZF9mcmVlX3JlZ2lvbihTWl8xMjhN
KTsKCXByaW50ayhLRVJOX0lORk8gImFkZHIgaXMgMHglbHhcbiIsIGFkZHIpOwoKCXJldHVybiAw
Owp9CgpzdGF0aWMgdm9pZCBfX2V4aXQgdGVzdF9hbGxvY19leGl0KHZvaWQpCnsKCS8qIFRPRE86
IGNhcmUgdG8gZnJlZSBhbGxvY2F0aW9ucyA6KSAqLwp9Cgptb2R1bGVfaW5pdCh0ZXN0X2FsbG9j
X2luaXQpOwptb2R1bGVfZXhpdCh0ZXN0X2FsbG9jX2V4aXQpOwpNT0RVTEVfTElDRU5TRSgiR1BM
Iik7Cg==
------=_Part_36211_23856804.1164900815522--
