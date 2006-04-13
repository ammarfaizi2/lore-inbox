Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWDMXxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWDMXxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWDMXxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:53:10 -0400
Received: from wproxy.gmail.com ([64.233.184.226]:61154 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965052AbWDMXxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:53:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:mime-version:to:cc:subject:content-type;
        b=q4p3Cv4UMor7R0+8Ce8N/nL35t03JX8eIQT5eypI8V4HvLBVPWMuMZSC5vA+InRTXhQXHAE8D21LtvE2b5j6hpq2YuiKpnWy4YNFcSPOXDF85826lp8T3y8xiEisAU7+FiouUcrBDVMg4jviARuE5iPS0GQoBJRIiEh9ufeakJE=
Message-ID: <443EE4C3.5040409@gmail.com>
Date: Fri, 14 Apr 2006 02:54:43 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060401)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH][TAKE 3] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
Content-Type: multipart/mixed;
 boundary="------------020306040709090609040103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020306040709090609040103
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Extending the kernel parameters to a user determined size
on boot protocol >=2.02 for i386 and x86_64 architectures.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

Hello,

Current implementation allows the kernel to receive up to 
255 characters from the bootloader.

In current environment, the command-line is used in order to 
specify many values, including suspend/resume, module 
arguments, splash, initramfs and more.

255 characters are not enough anymore.

This is take 3 of this submission:

Take 1 - Patch that allows command-line size to be 
determined in menuconfig. People did not want to see a new 
config option.

Take 2 - Removed the menuconfig into a fixed 2048 size. This 
patch was rejected. This is what the 2.6.11-rc2 changelog 
has to say about the matter:

 > Revert "x86_64/i386: increase command line size" patch
 > It's a bootup dependancy, you can't just increase it
 > randomly, and it breaks booting with LILO.
 > Pointed out by Janos Farkas and Adrian Bunk.

Take 3 (current) - Back to menuconfig option, so it won't 
break LILO (Although if it is broken because of this, it 
should be fixed...).

Please consider to merge.

If any of you think that this should be applied for other
architectures, please reply.

Current architectures that have 256 limit are:
alpha, cris, i386, m64k, mips, sh, sh64, sparc, sparc64,
x86_64, xtensa

Current architectures that have 512 values are:
frv(512), h8300(512), ia64(512), m32r(512), m68knommu(512),
mips(512), powerpc(512), v850(512)

Current architectures that are OK:
arm(1024), arm26(1024), parisc(1024)

Current strange ones:
s390(896) - I guess IBM has a good reason for this constant...

Best Regards,
Alon Bar-Lev

--------------020306040709090609040103
Content-Type: text/plain;
 name="linux-2.6.16-x86-command-line.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="linux-2.6.16-x86-command-line.diff"

ZGlmZiAtdXJOcCBsaW51eC0yLjYuMTYvYXJjaC9pMzg2L0tjb25maWcgbGludXgtMi42LjE2
Lm5ldy9hcmNoL2kzODYvS2NvbmZpZwotLS0gbGludXgtMi42LjE2L2FyY2gvaTM4Ni9LY29u
ZmlnCTIwMDYtMDMtMjAgMDc6NTM6MjkuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYu
MTYubmV3L2FyY2gvaTM4Ni9LY29uZmlnCTIwMDYtMDQtMTQgMDE6MzU6MDYuMDAwMDAwMDAw
ICswMzAwCkBAIC02NDQsNiArNjQ0LDE0IEBAIGNvbmZpZyBFRkkKIAlhbnl0aGluZyBhYm91
dCBFRkkpLiAgSG93ZXZlciwgZXZlbiB3aXRoIHRoaXMgb3B0aW9uLCB0aGUgcmVzdWx0YW50
CiAJa2VybmVsIHNob3VsZCBjb250aW51ZSB0byBib290IG9uIGV4aXN0aW5nIG5vbi1FRkkg
cGxhdGZvcm1zLgogCitjb25maWcgQ09NTUFORF9MSU5FX1NJWkUKKwlpbnQgIk1heGltdW0g
a2VybmVsIGNvbW1hbmQtbGluZSBzaXplIgorCXJhbmdlIDI1NiA0MDk2CisJZGVmYXVsdCAy
NTYKKwktLS1oZWxwLS0tCisJVGhpcyBlbmFibGVzIGFkanVzdGluZyBtYXhpbXVtIGNvbW1h
bmQtbGluZSBzaXplLiBJZiB5b3UgYXJlIHVuc3VyZQorCXNwZWNpZnkgMjU2LgorCiBjb25m
aWcgSVJRQkFMQU5DRQogIAlib29sICJFbmFibGUga2VybmVsIGlycSBiYWxhbmNpbmciCiAJ
ZGVwZW5kcyBvbiBTTVAgJiYgWDg2X0lPX0FQSUMKZGlmZiAtdXJOcCBsaW51eC0yLjYuMTYv
YXJjaC94ODZfNjQvS2NvbmZpZyBsaW51eC0yLjYuMTYubmV3L2FyY2gveDg2XzY0L0tjb25m
aWcKLS0tIGxpbnV4LTIuNi4xNi9hcmNoL3g4Nl82NC9LY29uZmlnCTIwMDYtMDMtMjAgMDc6
NTM6MjkuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMTYubmV3L2FyY2gveDg2XzY0
L0tjb25maWcJMjAwNi0wNC0xNCAwMTozNTozMC4wMDAwMDAwMDAgKzAzMDAKQEAgLTQ0NSw2
ICs0NDUsMTQgQEAgY29uZmlnIFBIWVNJQ0FMX1NUQVJUCiAKIAkgIERvbid0IGNoYW5nZSB0
aGlzIHVubGVzcyB5b3Uga25vdyB3aGF0IHlvdSBhcmUgZG9pbmcuCiAKK2NvbmZpZyBDT01N
QU5EX0xJTkVfU0laRQorCWludCAiTWF4aW11bSBrZXJuZWwgY29tbWFuZC1saW5lIHNpemUi
CisJcmFuZ2UgMjU2IDQwOTYKKwlkZWZhdWx0IDI1NgorCS0tLWhlbHAtLS0KKwlUaGlzIGVu
YWJsZXMgYWRqdXN0aW5nIG1heGltdW0gY29tbWFuZC1saW5lIHNpemUuIElmIHlvdSBhcmUg
dW5zdXJlCisJc3BlY2lmeSAyNTYuCisKIGNvbmZpZyBTRUNDT01QCiAJYm9vbCAiRW5hYmxl
IHNlY2NvbXAgdG8gc2FmZWx5IGNvbXB1dGUgdW50cnVzdGVkIGJ5dGVjb2RlIgogCWRlcGVu
ZHMgb24gUFJPQ19GUwpkaWZmIC11ck5wIGxpbnV4LTIuNi4xNi9Eb2N1bWVudGF0aW9uL2kz
ODYvYm9vdC50eHQgbGludXgtMi42LjE2Lm5ldy9Eb2N1bWVudGF0aW9uL2kzODYvYm9vdC50
eHQKLS0tIGxpbnV4LTIuNi4xNi9Eb2N1bWVudGF0aW9uL2kzODYvYm9vdC50eHQJMjAwNi0w
My0yMCAwNzo1MzoyOS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xNi5uZXcvRG9j
dW1lbnRhdGlvbi9pMzg2L2Jvb3QudHh0CTIwMDYtMDQtMTQgMDE6NTU6NDcuMDAwMDAwMDAw
ICswMzAwCkBAIC0yMzUsMTEgKzIzNSw4IEBAIGxvYWRlciB0byBjb21tdW5pY2F0ZSB3aXRo
IHRoZSBrZXJuZWwuICAKIHJlbGV2YW50IHRvIHRoZSBib290IGxvYWRlciBpdHNlbGYsIHNl
ZSAic3BlY2lhbCBjb21tYW5kIGxpbmUgb3B0aW9ucyIKIGJlbG93LgogCi1UaGUga2VybmVs
IGNvbW1hbmQgbGluZSBpcyBhIG51bGwtdGVybWluYXRlZCBzdHJpbmcgY3VycmVudGx5IHVw
IHRvCi0yNTUgY2hhcmFjdGVycyBsb25nLCBwbHVzIHRoZSBmaW5hbCBudWxsLiAgQSBzdHJp
bmcgdGhhdCBpcyB0b28gbG9uZwotd2lsbCBiZSBhdXRvbWF0aWNhbGx5IHRydW5jYXRlZCBi
eSB0aGUga2VybmVsLCBhIGJvb3QgbG9hZGVyIG1heSBhbGxvdwotYSBsb25nZXIgY29tbWFu
ZCBsaW5lIHRvIGJlIHBhc3NlZCB0byBwZXJtaXQgZnV0dXJlIGtlcm5lbHMgdG8gZXh0ZW5k
Ci10aGlzIGxpbWl0LgorVGhlIGtlcm5lbCBjb21tYW5kIGxpbmUgaXMgYSBudWxsLXRlcm1p
bmF0ZWQgc3RyaW5nLiBBIHN0cmluZyB0aGF0IGlzIHRvbworbG9uZyB3aWxsIGJlIGF1dG9t
YXRpY2FsbHkgdHJ1bmNhdGVkIGJ5IHRoZSBrZXJuZWwuCiAKIElmIHRoZSBib290IHByb3Rv
Y29sIHZlcnNpb24gaXMgMi4wMiBvciBsYXRlciwgdGhlIGFkZHJlc3Mgb2YgdGhlCiBrZXJu
ZWwgY29tbWFuZCBsaW5lIGlzIGdpdmVuIGJ5IHRoZSBoZWFkZXIgZmllbGQgY21kX2xpbmVf
cHRyIChzZWUKQEAgLTI2MCw2ICsyNTcsOSBAQCBjb21tYW5kIGxpbmUgaXMgZW50ZXJlZCB1
c2luZyB0aGUgZm9sbG93CiAJY292ZXJlZCBieSBzZXR1cF9tb3ZlX3NpemUsIHNvIHlvdSBt
YXkgbmVlZCB0byBhZGp1c3QgdGhpcwogCWZpZWxkLgogCisgICAgICAgVGhlIGtlcm5lbCBj
b21tYW5kIGxpbmUgKm11c3QqIGJlIDI1NiBieXRlcyBpbmNsdWRpbmcgdGhlCisgICAgICAg
ZmluYWwgbnVsbC4KKwogCiAqKioqIFNBTVBMRSBCT09UIENPTkZJR1VSQVRJT04KIApkaWZm
IC11ck5wIGxpbnV4LTIuNi4xNi9pbmNsdWRlL2FzbS1pMzg2L3BhcmFtLmggbGludXgtMi42
LjE2Lm5ldy9pbmNsdWRlL2FzbS1pMzg2L3BhcmFtLmgKLS0tIGxpbnV4LTIuNi4xNi9pbmNs
dWRlL2FzbS1pMzg2L3BhcmFtLmgJMjAwNi0wMy0yMCAwNzo1MzoyOS4wMDAwMDAwMDAgKzAy
MDAKKysrIGxpbnV4LTIuNi4xNi5uZXcvaW5jbHVkZS9hc20taTM4Ni9wYXJhbS5oCTIwMDYt
MDQtMTQgMDI6MDA6NDUuMDAwMDAwMDAwICswMzAwCkBAIC0xOSw2ICsxOSwxNSBAQAogI2Vu
ZGlmCiAKICNkZWZpbmUgTUFYSE9TVE5BTUVMRU4JNjQJLyogbWF4IGxlbmd0aCBvZiBob3N0
bmFtZSAqLworCisvKgorICogVGhpcyBDT01NQU5EX0xJTkVfU0laRSBkZWZpbml0aW9uIHdh
cyBsZWZ0IGhlcmUKKyAqIGZvciBjb21wYXRhYmlsaXR5LCBpdHMgY29ycmVjdCBsb2NhdGlv
biBpcyBpbiBzZXR1cC5oLgorICogQm9vdCBsb2FkZXJzIHRoYXQgdXNlIHRoaXMgcGFyYW1l
dGVycyB3aWxsIGNvbnRpbnVlCisgKiB0byB1c2UgMjU2IG1heGltdW0gY29tbWFuZC1saW5l
IHNpemUuCisgKi8KKyNpZm5kZWYgQ09ORklHX0NPTU1BTkRfTElORV9TSVpFCiAjZGVmaW5l
IENPTU1BTkRfTElORV9TSVpFIDI1NgorI2VuZGlmCiAKICNlbmRpZgpkaWZmIC11ck5wIGxp
bnV4LTIuNi4xNi9pbmNsdWRlL2FzbS1pMzg2L3NldHVwLmggbGludXgtMi42LjE2Lm5ldy9p
bmNsdWRlL2FzbS1pMzg2L3NldHVwLmgKLS0tIGxpbnV4LTIuNi4xNi9pbmNsdWRlL2FzbS1p
Mzg2L3NldHVwLmgJMjAwNi0wMy0yMCAwNzo1MzoyOS4wMDAwMDAwMDAgKzAyMDAKKysrIGxp
bnV4LTIuNi4xNi5uZXcvaW5jbHVkZS9hc20taTM4Ni9zZXR1cC5oCTIwMDYtMDQtMTQgMDE6
MzI6MTYuMDAwMDAwMDAwICswMzAwCkBAIC0xNyw3ICsxNyw3IEBACiAjZGVmaW5lIE1BWF9O
T05QQUVfUEZOCSgxIDw8IDIwKQogCiAjZGVmaW5lIFBBUkFNX1NJWkUgNDA5NgotI2RlZmlu
ZSBDT01NQU5EX0xJTkVfU0laRSAyNTYKKyNkZWZpbmUgQ09NTUFORF9MSU5FX1NJWkUgQ09O
RklHX0NPTU1BTkRfTElORV9TSVpFCiAKICNkZWZpbmUgT0xEX0NMX01BR0lDX0FERFIJMHg5
MDAyMAogI2RlZmluZSBPTERfQ0xfTUFHSUMJCTB4QTMzRgpkaWZmIC11ck5wIGxpbnV4LTIu
Ni4xNi9pbmNsdWRlL2FzbS14ODZfNjQvc2V0dXAuaCBsaW51eC0yLjYuMTYubmV3L2luY2x1
ZGUvYXNtLXg4Nl82NC9zZXR1cC5oCi0tLSBsaW51eC0yLjYuMTYvaW5jbHVkZS9hc20teDg2
XzY0L3NldHVwLmgJMjAwNi0wMy0yMCAwNzo1MzoyOS4wMDAwMDAwMDAgKzAyMDAKKysrIGxp
bnV4LTIuNi4xNi5uZXcvaW5jbHVkZS9hc20teDg2XzY0L3NldHVwLmgJMjAwNi0wNC0xNCAw
MTozMzoyNy4wMDAwMDAwMDAgKzAzMDAKQEAgLTEsNiArMSw2IEBACiAjaWZuZGVmIF94ODY2
NF9TRVRVUF9ICiAjZGVmaW5lIF94ODY2NF9TRVRVUF9ICiAKLSNkZWZpbmUgQ09NTUFORF9M
SU5FX1NJWkUJMjU2CisjZGVmaW5lIENPTU1BTkRfTElORV9TSVpFCUNPTkZJR19DT01NQU5E
X0xJTkVfU0laRQogCiAjZW5kaWYK
--------------020306040709090609040103--
