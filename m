Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTITNjd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 09:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTITNjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 09:39:33 -0400
Received: from web12811.mail.yahoo.com ([216.136.174.128]:27231 "HELO
	web12811.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261889AbTITNjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 09:39:31 -0400
Message-ID: <20030920133930.17399.qmail@web12811.mail.yahoo.com>
Date: Sat, 20 Sep 2003 06:39:30 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: A couple of 2.4.23-pre4 VM nits
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030830050111.GD640@wind.cocodriloo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-395039124-1064065170=:17117"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-395039124-1064065170=:17117
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hi Andrea,

The VM fixes perform rather well in my testing
(thanks!), but I noticed a couple of glitches that the
attached patch addresses.

1. max_scan is never decremented in shrink_cache().  I
am assuming this is a typo.

2. The second part of the patch makes sure that
inode/dentry caches are shrunk at least once every 5
secs.  On a machine with a heavy inode stat/directory
lookup load (e.g. NFS server), most of the memory
winds up sitting idle in unused inodes/dentry.  The
present code only reclaims these when a swap_out()
happens or shrink_caches() fails.  This can take a
while on a machine will very few mapped pages such as
an NFS server.

Thanks,
Shantanu

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
--0-395039124-1064065170=:17117
Content-Type: application/octet-stream; name="vmscan.patch"
Content-Transfer-Encoding: base64
Content-Description: vmscan.patch
Content-Disposition: attachment; filename="vmscan.patch"

LS0tIHZtc2Nhbi5jLn4xfgkyMDAzLTA5LTE2IDIwOjQ0OjE0LjAwMDAwMDAw
MCAtMDQwMAorKysgdm1zY2FuLmMJMjAwMy0wOS0xNyAxODoyMzowMy4wMDAw
MDAwMDAgLTA0MDAKQEAgLTM2NCw2ICszNjQsMjAgQEAKIAlyZXR1cm4gMDsK
IH0KIAorc3RhdGljIHZvaWQgc2hyaW5rX3Zmc19jYWNoZXMoaW50IGZvcmNl
LCB1bnNpZ25lZCBpbnQgZ2ZwX21hc2spCit7CisJc3RhdGljIHVuc2lnbmVk
IGxvbmcgbGFzdF9zY2FuID0gMDsKKworCWlmIChmb3JjZSB8fCB0aW1lX2Fm
dGVyKGppZmZpZXMsIGxhc3Rfc2NhbiArIDUqSFopKSB7CisJCXNocmlua19k
Y2FjaGVfbWVtb3J5KHZtX3Zmc19zY2FuX3JhdGlvLCBnZnBfbWFzayk7CisJ
CXNocmlua19pY2FjaGVfbWVtb3J5KHZtX3Zmc19zY2FuX3JhdGlvLCBnZnBf
bWFzayk7CisjaWZkZWYgQ09ORklHX1FVT1RBCisJCXNocmlua19kcWNhY2hl
X21lbW9yeSh2bV92ZnNfc2Nhbl9yYXRpbywgZ2ZwX21hc2spOworI2VuZGlm
CisJCWxhc3Rfc2NhbiA9IGppZmZpZXM7CisJfQorfQorCiBzdGF0aWMgdm9p
ZCBGQVNUQ0FMTChyZWZpbGxfaW5hY3RpdmUoaW50IG5yX3BhZ2VzLCB6b25l
X3QgKiBjbGFzc3pvbmUpKTsKIHN0YXRpYyBpbnQgRkFTVENBTEwoc2hyaW5r
X2NhY2hlKGludCBucl9wYWdlcywgem9uZV90ICogY2xhc3N6b25lLCB1bnNp
Z25lZCBpbnQgZ2ZwX21hc2ssIGludCAqIGZhaWxlZF9zd2Fwb3V0KSk7CiBz
dGF0aWMgaW50IHNocmlua19jYWNoZShpbnQgbnJfcGFnZXMsIHpvbmVfdCAq
IGNsYXNzem9uZSwgdW5zaWduZWQgaW50IGdmcF9tYXNrLCBpbnQgKiBmYWls
ZWRfc3dhcG91dCkKQEAgLTM3Miw3ICszODYsNyBAQAogCWludCBtYXhfc2Nh
biA9IChjbGFzc3pvbmUtPm5yX2luYWN0aXZlX3BhZ2VzICsgY2xhc3N6b25l
LT5ucl9hY3RpdmVfcGFnZXMpIC8gdm1fY2FjaGVfc2Nhbl9yYXRpbzsKIAlp
bnQgbWF4X21hcHBlZCA9IHZtX21hcHBlZF9yYXRpbyAqIG5yX3BhZ2VzOwog
Ci0Jd2hpbGUgKG1heF9zY2FuICYmIGNsYXNzem9uZS0+bnJfaW5hY3RpdmVf
cGFnZXMgJiYgKGVudHJ5ID0gaW5hY3RpdmVfbGlzdC5wcmV2KSAhPSAmaW5h
Y3RpdmVfbGlzdCkgeworCXdoaWxlICgtLW1heF9zY2FuID49IDAgJiYgY2xh
c3N6b25lLT5ucl9pbmFjdGl2ZV9wYWdlcyAmJiAoZW50cnkgPSBpbmFjdGl2
ZV9saXN0LnByZXYpICE9ICZpbmFjdGl2ZV9saXN0KSB7CiAJCXN0cnVjdCBw
YWdlICogcGFnZTsKIAogCQlpZiAodW5saWtlbHkoY3VycmVudC0+bmVlZF9y
ZXNjaGVkKSkgewpAQCAtNTE2LDExICs1MzAsNyBAQAogCQkJCWlmIChucl9w
YWdlcyA8PSAwKQogCQkJCQlnb3RvIG91dDsKIAotCQkJCXNocmlua19kY2Fj
aGVfbWVtb3J5KHZtX3Zmc19zY2FuX3JhdGlvLCBnZnBfbWFzayk7Ci0JCQkJ
c2hyaW5rX2ljYWNoZV9tZW1vcnkodm1fdmZzX3NjYW5fcmF0aW8sIGdmcF9t
YXNrKTsKLSNpZmRlZiBDT05GSUdfUVVPVEEKLQkJCQlzaHJpbmtfZHFjYWNo
ZV9tZW1vcnkodm1fdmZzX3NjYW5fcmF0aW8sIGdmcF9tYXNrKTsKLSNlbmRp
ZgorCQkJCXNocmlua192ZnNfY2FjaGVzKCpmYWlsZWRfc3dhcG91dCwgZ2Zw
X21hc2spOwogCiAJCQkJaWYgKCEqZmFpbGVkX3N3YXBvdXQpCiAJCQkJCSpm
YWlsZWRfc3dhcG91dCA9ICFzd2FwX291dChjbGFzc3pvbmUpOwpAQCAtNjE0
LDYgKzYyNCw4IEBACiAJaWYgKG5yX3BhZ2VzIDw9IDApCiAJCWdvdG8gb3V0
OwogCisJc2hyaW5rX3Zmc19jYWNoZXMoMCwgZ2ZwX21hc2spOworCiAJc3Bp
bl9sb2NrKCZwYWdlbWFwX2xydV9sb2NrKTsKIAlyZWZpbGxfaW5hY3RpdmUo
bnJfcGFnZXMsIGNsYXNzem9uZSk7CiAKQEAgLTYzOCwxMSArNjUwLDkgQEAK
IAkJCW5yX3BhZ2VzID0gc2hyaW5rX2NhY2hlcyhjbGFzc3pvbmUsIGdmcF9t
YXNrLCBucl9wYWdlcywgJmZhaWxlZF9zd2Fwb3V0KTsKIAkJCWlmIChucl9w
YWdlcyA8PSAwKQogCQkJCXJldHVybiAxOwotCQkJc2hyaW5rX2RjYWNoZV9t
ZW1vcnkodm1fdmZzX3NjYW5fcmF0aW8sIGdmcF9tYXNrKTsKLQkJCXNocmlu
a19pY2FjaGVfbWVtb3J5KHZtX3Zmc19zY2FuX3JhdGlvLCBnZnBfbWFzayk7
Ci0jaWZkZWYgQ09ORklHX1FVT1RBCi0JCQlzaHJpbmtfZHFjYWNoZV9tZW1v
cnkodm1fdmZzX3NjYW5fcmF0aW8sIGdmcF9tYXNrKTsKLSNlbmRpZgorCisJ
CQlzaHJpbmtfdmZzX2NhY2hlcygxLCBnZnBfbWFzayk7CisKIAkJCWlmICgh
ZmFpbGVkX3N3YXBvdXQpCiAJCQkJZmFpbGVkX3N3YXBvdXQgPSAhc3dhcF9v
dXQoY2xhc3N6b25lKTsKIAkJfSB3aGlsZSAoLS10cmllcyk7Cg==

--0-395039124-1064065170=:17117--
