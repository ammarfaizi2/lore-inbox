Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWEENgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWEENgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 09:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWEENgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 09:36:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:61100 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751551AbWEENgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 09:36:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type;
        b=azkNoXwUHo57J19Eg0GvTSjw4vEUsmr5Zi+WyYCL/RrGMTy3UhqVYzelUsN14UZgx+7A0TKZLKBJ/tWwi7XpHVqad3A8bDAPdSX7Q+SCEu8cB2pi3GOQgIqKoo6iJW1cmZdQlstAgEu5qAh8FPWVff85MgCUiqr6imk5vcqgAfE=
Message-ID: <445B5524.2090001@gmail.com>
Date: Fri, 05 May 2006 16:37:40 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       "H. Peter Anvin" <hpa@zytor.com>, Riley@Williams.Name,
       tony.luck@intel.com, johninsd@san.rr.com
Subject: [PATCH][TAKE 4] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
Content-Type: multipart/mixed;
 boundary="------------050707040009010101080202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050707040009010101080202
Content-Type: text/plain; charset=UTF-8
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

This is take 4 of this submission.

Take 4 (current), no reply of what is the problem in LILO.
Can someone please reply Peter questions? I understand that
people don't want the new kernel config option... But fixing
LILO should be more complex.

Take 3 - Back to menuconfig option, so it won't
break LILO (Although if it is broken because of this, it
should be fixed...).

Here are the comments from H. Peter Anvin:
> Does anyone know the actual details of the LILO breakage?
> If the problem is that LILO doesn't null-terminate the string when it's too long,
> then we can deal with this automatically, without introducing compile-time options
> (which were already once rejected.)
> 
> If the problem is with LILO booting *old* kernels, then that's going to have to require
> some LILO changes, and probably a boot revision bump.

Take 2 - Removed the menuconfig into a fixed 2048 size. This
patch was rejected. This is what the 2.6.11-rc2 changelog
has to say about the matter:

> Revert "x86_64/i386: increase command line size" patch
> It's a bootup dependancy, you can't just increase it
> randomly, and it breaks booting with LILO.
> Pointed out by Janos Farkas and Adrian Bunk.

Take 1 - Patch that allows command-line size to be
determined in menuconfig. People did not want to see a new
config option.

---

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


--------------050707040009010101080202
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
ZHMgb24gUFJPQ19GUwpkaWZmIC11ck5wIGxpbnV4LTIuNi4xNi9pbmNsdWRlL2FzbS1pMzg2
L3BhcmFtLmggbGludXgtMi42LjE2Lm5ldy9pbmNsdWRlL2FzbS1pMzg2L3BhcmFtLmgKLS0t
IGxpbnV4LTIuNi4xNi9pbmNsdWRlL2FzbS1pMzg2L3BhcmFtLmgJMjAwNi0wMy0yMCAwNzo1
MzoyOS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xNi5uZXcvaW5jbHVkZS9hc20t
aTM4Ni9wYXJhbS5oCTIwMDYtMDQtMTQgMDI6MDA6NDUuMDAwMDAwMDAwICswMzAwCkBAIC0x
OSw2ICsxOSwxNSBAQAogI2VuZGlmCiAKICNkZWZpbmUgTUFYSE9TVE5BTUVMRU4JNjQJLyog
bWF4IGxlbmd0aCBvZiBob3N0bmFtZSAqLworCisvKgorICogVGhpcyBDT01NQU5EX0xJTkVf
U0laRSBkZWZpbml0aW9uIHdhcyBsZWZ0IGhlcmUKKyAqIGZvciBjb21wYXRhYmlsaXR5LCBp
dHMgY29ycmVjdCBsb2NhdGlvbiBpcyBpbiBzZXR1cC5oLgorICogQm9vdCBsb2FkZXJzIHRo
YXQgdXNlIHRoaXMgcGFyYW1ldGVycyB3aWxsIGNvbnRpbnVlCisgKiB0byB1c2UgMjU2IG1h
eGltdW0gY29tbWFuZC1saW5lIHNpemUuCisgKi8KKyNpZm5kZWYgQ09ORklHX0NPTU1BTkRf
TElORV9TSVpFCiAjZGVmaW5lIENPTU1BTkRfTElORV9TSVpFIDI1NgorI2VuZGlmCiAKICNl
bmRpZgpkaWZmIC11ck5wIGxpbnV4LTIuNi4xNi9pbmNsdWRlL2FzbS1pMzg2L3NldHVwLmgg
bGludXgtMi42LjE2Lm5ldy9pbmNsdWRlL2FzbS1pMzg2L3NldHVwLmgKLS0tIGxpbnV4LTIu
Ni4xNi9pbmNsdWRlL2FzbS1pMzg2L3NldHVwLmgJMjAwNi0wMy0yMCAwNzo1MzoyOS4wMDAw
MDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xNi5uZXcvaW5jbHVkZS9hc20taTM4Ni9zZXR1
cC5oCTIwMDYtMDQtMTQgMDE6MzI6MTYuMDAwMDAwMDAwICswMzAwCkBAIC0xNyw3ICsxNyw3
IEBACiAjZGVmaW5lIE1BWF9OT05QQUVfUEZOCSgxIDw8IDIwKQogCiAjZGVmaW5lIFBBUkFN
X1NJWkUgNDA5NgotI2RlZmluZSBDT01NQU5EX0xJTkVfU0laRSAyNTYKKyNkZWZpbmUgQ09N
TUFORF9MSU5FX1NJWkUgQ09ORklHX0NPTU1BTkRfTElORV9TSVpFCiAKICNkZWZpbmUgT0xE
X0NMX01BR0lDX0FERFIJMHg5MDAyMAogI2RlZmluZSBPTERfQ0xfTUFHSUMJCTB4QTMzRgpk
aWZmIC11ck5wIGxpbnV4LTIuNi4xNi9pbmNsdWRlL2FzbS14ODZfNjQvc2V0dXAuaCBsaW51
eC0yLjYuMTYubmV3L2luY2x1ZGUvYXNtLXg4Nl82NC9zZXR1cC5oCi0tLSBsaW51eC0yLjYu
MTYvaW5jbHVkZS9hc20teDg2XzY0L3NldHVwLmgJMjAwNi0wMy0yMCAwNzo1MzoyOS4wMDAw
MDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xNi5uZXcvaW5jbHVkZS9hc20teDg2XzY0L3Nl
dHVwLmgJMjAwNi0wNC0xNCAwMTozMzoyNy4wMDAwMDAwMDAgKzAzMDAKQEAgLTEsNiArMSw2
IEBACiAjaWZuZGVmIF94ODY2NF9TRVRVUF9ICiAjZGVmaW5lIF94ODY2NF9TRVRVUF9ICiAK
LSNkZWZpbmUgQ09NTUFORF9MSU5FX1NJWkUJMjU2CisjZGVmaW5lIENPTU1BTkRfTElORV9T
SVpFCUNPTkZJR19DT01NQU5EX0xJTkVfU0laRQogCiAjZW5kaWYK
--------------050707040009010101080202--
