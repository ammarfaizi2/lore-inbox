Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVBQPhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVBQPhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVBQPhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:37:33 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:4687 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262255AbVBQPhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 10:37:05 -0500
Message-ID: <4214BA18.50604@yahoo.com.au>
Date: Fri, 18 Feb 2005 02:36:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] folded page table walkers
Content-Type: multipart/mixed;
 boundary="------------090208020201000301080607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090208020201000301080607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

(Note these are all obviously just RFCs, until after 2.6.11,
at which time I'll send them off to Andrew if they've proven
OK).

Anyway, here is the patch to fold the page table walkers
nicely for 2 and 3 level implementations... now we are getting
some good reasons why people should convert to the -nop?d.h
headers :)


We cut 35% off lmbench fork time with 2 level UP i386. This
patch gets most of the improvement.

                        plain  +ptwalk +folded +funit-at-a-time for mm/
mm/memory.o text size  10935  10679    9799    9519
lmb fork                 335    327     223     218
lmb exec                1417   1445    1228    1198
lmb shell               5483   5507    5195    5087

--------------090208020201000301080607
Content-Type: text/plain;
 name="vm-folded-walkers.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="vm-folded-walkers.patch"

CgoKLS0tCgogbGludXgtMi42LW5waWdnaW4vaW5jbHVkZS9hc20tZ2VuZXJpYy9wZ3RhYmxl
LW5vcG1kLmggfCAgICA5ICsrKysrKysrKwogbGludXgtMi42LW5waWdnaW4vaW5jbHVkZS9h
c20tZ2VuZXJpYy9wZ3RhYmxlLW5vcHVkLmggfCAgICA4ICsrKysrKysrCiBsaW51eC0yLjYt
bnBpZ2dpbi9pbmNsdWRlL2FzbS1nZW5lcmljL3BndGFibGUuaCAgICAgICB8ICAgIDQgKysr
KwogMyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC1wdU4gaW5jbHVk
ZS9hc20tZ2VuZXJpYy9wZ3RhYmxlLmh+dm0tZm9sZGVkLXdhbGtlcnMgaW5jbHVkZS9hc20t
Z2VuZXJpYy9wZ3RhYmxlLmgKLS0tIGxpbnV4LTIuNi9pbmNsdWRlL2FzbS1nZW5lcmljL3Bn
dGFibGUuaH52bS1mb2xkZWQtd2Fsa2VycwkyMDA1LTAyLTE4IDAxOjU0OjUwLjAwMDAwMDAw
MCArMTEwMAorKysgbGludXgtMi42LW5waWdnaW4vaW5jbHVkZS9hc20tZ2VuZXJpYy9wZ3Rh
YmxlLmgJMjAwNS0wMi0xOCAwMTo1NDo1MC4wMDAwMDAwMDAgKzExMDAKQEAgLTE3NSw2ICsx
NzUsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcHRlcF9ta2RpcnR5KHB0ZV90ICpwCiAgKgog
ICogc2VlIGZvcl9lYWNoX3BnZAogICovCisjaWZuZGVmIGZvcl9lYWNoX3B1ZAogI2RlZmlu
ZSBmb3JfZWFjaF9wdWQocGdkLCBzdGFydCwgZW5kLCBwdWQsIHB1ZF9zdGFydCwgcHVkX2Vu
ZCkJCVwKIAlmb3IgKAlwdWQgPSBwdWRfb2Zmc2V0KHBnZCwgc3RhcnQpLAkJCQlcCiAJCSAg
cHVkX3N0YXJ0ID0gc3RhcnQ7CQkJCQlcCkBAIC0xODMsMTIgKzE4NCwxNCBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgcHRlcF9ta2RpcnR5KHB0ZV90ICpwCiAJCSAgcHVkIDw9IHB1ZF9vZmZz
ZXQocGdkLCBlbmQtMSk7CQkJXAogCQlwdWRfc3RhcnQgPSBwdWRfZW5kLAkJCQkJXAogCQkg
IHB1ZCsrICkKKyNlbmRpZgogCiAvKgogICogZm9yX2VhY2hfcG1kIC0gaXRlcmF0ZSB0aHJv
dWdoIHBtZCBlbnRyaWVzIGluIGEgZ2l2ZW4gcHVkCiAgKgogICogc2VlIGZvcl9lYWNoX3Bn
ZAogICovCisjaWZuZGVmIGZvcl9lYWNoX3BtZAogI2RlZmluZSBmb3JfZWFjaF9wbWQocHVk
LCBzdGFydCwgZW5kLCBwbWQsIHBtZF9zdGFydCwgcG1kX2VuZCkJCVwKIAlmb3IgKAlwbWQg
PSBwbWRfb2Zmc2V0KHB1ZCwgc3RhcnQpLAkJCQlcCiAJCSAgcG1kX3N0YXJ0ID0gc3RhcnQ7
CQkJCQlcCkBAIC0xOTcsNiArMjAwLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIHB0ZXBfbWtk
aXJ0eShwdGVfdCAqcAogCQkgIHBtZCA8PSBwbWRfb2Zmc2V0KHB1ZCwgZW5kLTEpOwkJCVwK
IAkJcG1kX3N0YXJ0ID0gcG1kX2VuZCwJCQkJCVwKIAkJICBwbWQrKyApCisjZW5kaWYKIAog
LyoKICAqIGZvcl9lYWNoX3B0ZV9tYXAgLSBpdGVyYXRlIHRocm91Z2ggcHRlIGVudHJpZXMg
aW4gYSBnaXZlbiBwbWQKZGlmZiAtcHVOIGluY2x1ZGUvYXNtLWdlbmVyaWMvcGd0YWJsZS1u
b3B1ZC5ofnZtLWZvbGRlZC13YWxrZXJzIGluY2x1ZGUvYXNtLWdlbmVyaWMvcGd0YWJsZS1u
b3B1ZC5oCi0tLSBsaW51eC0yLjYvaW5jbHVkZS9hc20tZ2VuZXJpYy9wZ3RhYmxlLW5vcHVk
Lmh+dm0tZm9sZGVkLXdhbGtlcnMJMjAwNS0wMi0xOCAwMTo1NDo1MC4wMDAwMDAwMDAgKzEx
MDAKKysrIGxpbnV4LTIuNi1ucGlnZ2luL2luY2x1ZGUvYXNtLWdlbmVyaWMvcGd0YWJsZS1u
b3B1ZC5oCTIwMDUtMDItMTggMDI6MjI6NDMuMDAwMDAwMDAwICsxMTAwCkBAIC01Miw1ICs1
MiwxMyBAQCBzdGF0aWMgaW5saW5lIHB1ZF90ICogcHVkX29mZnNldChwZ2RfdCAqCiAjZGVm
aW5lIHB1ZF9mcmVlKHgpCQkJCWRvIHsgfSB3aGlsZSAoMCkKICNkZWZpbmUgX19wdWRfZnJl
ZV90bGIodGxiLCB4KQkJCWRvIHsgfSB3aGlsZSAoMCkKIAorI3VuZGVmIGZvcl9lYWNoX3B1
ZAorI2RlZmluZSBmb3JfZWFjaF9wdWQocGdkLCBzdGFydCwgZW5kLCBwdWQsIHB1ZF9zdGFy
dCwgcHVkX2VuZCkJXAorCWZvciAoCXB1ZCA9IChwdWRfdCAqKXBnZCwJCQkJXAorCQkgIHB1
ZF9zdGFydCA9IHN0YXJ0LAkJCQlcCisJCSAgcHVkX2VuZCA9IGVuZDsJCQkJXAorCQlwdWRf
c3RhcnQgPT0gc3RhcnQ7CQkJCVwKKwkJcHVkX3N0YXJ0KysgKQorCiAjZW5kaWYgLyogX19B
U1NFTUJMWV9fICovCiAjZW5kaWYgLyogX1BHVEFCTEVfTk9QVURfSCAqLwpkaWZmIC1wdU4g
aW5jbHVkZS9hc20tZ2VuZXJpYy9wZ3RhYmxlLW5vcG1kLmh+dm0tZm9sZGVkLXdhbGtlcnMg
aW5jbHVkZS9hc20tZ2VuZXJpYy9wZ3RhYmxlLW5vcG1kLmgKLS0tIGxpbnV4LTIuNi9pbmNs
dWRlL2FzbS1nZW5lcmljL3BndGFibGUtbm9wbWQuaH52bS1mb2xkZWQtd2Fsa2VycwkyMDA1
LTAyLTE4IDAxOjU0OjUwLjAwMDAwMDAwMCArMTEwMAorKysgbGludXgtMi42LW5waWdnaW4v
aW5jbHVkZS9hc20tZ2VuZXJpYy9wZ3RhYmxlLW5vcG1kLmgJMjAwNS0wMi0xOCAwMjoyMjo0
My4wMDAwMDAwMDAgKzExMDAKQEAgLTU1LDYgKzU1LDE1IEBAIHN0YXRpYyBpbmxpbmUgcG1k
X3QgKiBwbWRfb2Zmc2V0KHB1ZF90ICoKICNkZWZpbmUgcG1kX2ZyZWUoeCkJCQkJZG8geyB9
IHdoaWxlICgwKQogI2RlZmluZSBfX3BtZF9mcmVlX3RsYih0bGIsIHgpCQkJZG8geyB9IHdo
aWxlICgwKQogCisjdW5kZWYgZm9yX2VhY2hfcG1kCisjZGVmaW5lIGZvcl9lYWNoX3BtZChw
dWQsIHN0YXJ0LCBlbmQsIHBtZCwgcG1kX3N0YXJ0LCBwbWRfZW5kKQlcCisJZm9yICgJcG1k
ID0gKHBtZF90ICopcHVkLAkJCQlcCisJCSAgcG1kX3N0YXJ0ID0gc3RhcnQsCQkJCVwKKwkJ
ICBwbWRfZW5kID0gZW5kOwkJCQlcCisJCXBtZF9zdGFydCA9PSBzdGFydDsJCQkJXAorCQlw
bWRfc3RhcnQrKyApCisKKwogI2VuZGlmIC8qIF9fQVNTRU1CTFlfXyAqLwogCiAjZW5kaWYg
LyogX1BHVEFCTEVfTk9QTURfSCAqLwoKXwo=
--------------090208020201000301080607--

