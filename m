Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271467AbUJVQhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271467AbUJVQhg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271469AbUJVQhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:37:36 -0400
Received: from fmr05.intel.com ([134.134.136.6]:64181 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S271467AbUJVQhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:37:25 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4B855.4F2D60EB"
Subject: RE: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 22 Oct 2004 09:36:40 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6003287C77@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Thread-Index: AcS31/YNXOgdupVtRnyrDPvtBzC5xwAe8rZA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       <stefandoesinger@gmx.at>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Oct 2004 16:36:42.0544 (UTC) FILETIME=[4FE64B00:01C4B855]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4B855.4F2D60EB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>-----Original Message-----
>From: Matthew Garrett [mailto:mgarrett@chiark.greenend.org.uk]=20
>Sent: Thursday, October 21, 2004 6:39 PM
>To: Pallipadi, Venkatesh
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer=20
>driver and Video card BOOT?
>
>Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
>
>Hi,
>
>> Even I thought so. But, with the emulator it doesn't hang. It brings=20
>> back my video. I double checked this using another vm86=20
>emulator too.=20
>> No hang even there. I couldn't figure out why Ole's patch won't work=20
>> though. Right now I am using call_usermodehelper() to call the=20
>> emulator during resume and the video comes back just fine on this=20
>> system where Ole's patch didn't work.
>
>Is it possible to get this patch and code off you? I'd be interested in
>testing this solution on various bits of hardware I've been working on.
>

Actually I sent the kernel patch to call some userlevel vgapost utility=20
on this same thread around a week back. I am sending it here again.=20

I don't think sending a big userlevel code tar file is appropriate on
lkml.=20
I will send that in a separate mail to Matthew and Stefan. If anyone
else=20
wants to play with it, just let me know.

It works for me on various systems with Radeon card. It didn't help on=20
systems with Intel Graphics card.

Stefan: Yes. Usermodehelper won't work during the driver resume. But, it

works later after the kernel threads are woken up. With attached patch
and
with user level vgapost I can get video back, both on X and VGA console.
It doesn't help with framebuffer, as the framebuffer reinitialization=20
happens during the driver resume, which is earlier than this vgapost
call.


Thanks,
Venki

------_=_NextPart_001_01C4B855.4F2D60EB
Content-Type: application/octet-stream;
	name="vgapost2.patch"
Content-Transfer-Encoding: base64
Content-Description: vgapost2.patch
Content-Disposition: attachment;
	filename="vgapost2.patch"

LS0tIGxpbnV4LTIuNi45L2tlcm5lbC9wb3dlci9tYWluLmMub3JnCTIwMDQtMTAtMjIgMTE6MTE6
NTguMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjYuOS9rZXJuZWwvcG93ZXIvbWFpbi5jCTIw
MDQtMTAtMjIgMTE6MTU6NDUuMDAwMDAwMDAwIC0wNzAwCkBAIC05Myw2ICs5MywxOSBAQCBzdGF0
aWMgaW50IHN1c3BlbmRfZW50ZXIodTMyIHN0YXRlKQogCXJldHVybiBlcnJvcjsKIH0KIAoraW50
IHZnYXBvc3RfdXNlcm1vZGUodm9pZCkKK3sKKyAgICAgIGNoYXIgICAgKmFyZ3ZbM10gPSB7TlVM
TCwgTlVMTCwgTlVMTH07CisgICAgICBjaGFyICAgICplbnZwWzNdID0ge05VTEwsIE5VTEwsIE5V
TEx9OworCisgICAgICBhcmd2WzBdID0gIi9yb290L2VtdS92aWRlb19wb3N0IjsKKworICAgICAg
LyogbWluaW1hbCBjb21tYW5kIGVudmlyb25tZW50ICovCisgICAgICBlbnZwWzBdID0gIkhPTUU9
LyI7CisgICAgICBlbnZwWzFdID0gIlBBVEg9L3NiaW46L2JpbjovdXNyL3NiaW46L3Vzci9iaW4i
OworCisgICAgICByZXR1cm4gY2FsbF91c2VybW9kZWhlbHBlcihhcmd2WzBdLCBhcmd2LCBlbnZw
LCAxKTsKK30KIAogLyoqCiAgKglzdXNwZW5kX2ZpbmlzaCAtIERvIGZpbmFsIHdvcmsgYmVmb3Jl
IGV4aXRpbmcgc3VzcGVuZCBzZXF1ZW5jZS4KQEAgLTEwNyw2ICsxMjAsMTAgQEAgc3RhdGljIHZv
aWQgc3VzcGVuZF9maW5pc2godTMyIHN0YXRlKQogCWRldmljZV9yZXN1bWUoKTsKIAlpZiAocG1f
b3BzICYmIHBtX29wcy0+ZmluaXNoKQogCQlwbV9vcHMtPmZpbmlzaChzdGF0ZSk7CisKKyAgICAg
ICAgdGhhd19wcm9jZXNzZXNfa2VybmVsKCk7CisgICAgICAgIHZnYXBvc3RfdXNlcm1vZGUoKTsK
KwogCXRoYXdfcHJvY2Vzc2VzKCk7CiAJcG1fcmVzdG9yZV9jb25zb2xlKCk7CiB9Ci0tLSBsaW51
eC0yLjYuOS9rZXJuZWwvcG93ZXIvcHJvY2Vzcy5jLm9yZwkyMDA0LTEwLTIyIDExOjEyOjE0LjAw
MDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42Ljkva2VybmVsL3Bvd2VyL3Byb2Nlc3MuYwkyMDA0
LTEwLTIyIDExOjIwOjM3LjAwMDAwMDAwMCAtMDcwMApAQCAtOTcsNiArOTcsMjkgQEAgaW50IGZy
ZWV6ZV9wcm9jZXNzZXModm9pZCkKIAlyZXR1cm4gMDsKIH0KIAordm9pZCB0aGF3X3Byb2Nlc3Nl
c19rZXJuZWwodm9pZCkKK3sKKwlzdHJ1Y3QgdGFza19zdHJ1Y3QgKmcsICpwOworCisJcHJpbnRr
KCAiUmVzdGFydGluZyBrZXJuZWwgdGFza3MuLi4iICk7CisJcmVhZF9sb2NrKCZ0YXNrbGlzdF9s
b2NrKTsKKwlkb19lYWNoX3RocmVhZChnLCBwKSB7CisJCWlmICghZnJlZXplYWJsZShwKSkKKwkJ
CWNvbnRpbnVlOworCQlpZiAocC0+cGFyZW50LT5waWQgIT0gMSkKKwkJCWNvbnRpbnVlOworCQlp
ZiAocC0+ZmxhZ3MgJiBQRl9GUk9aRU4pIHsKKwkJCXAtPmZsYWdzICY9IH5QRl9GUk9aRU47CisJ
CQl3YWtlX3VwX3Byb2Nlc3MocCk7CisJCX0gZWxzZQorCQkJcHJpbnRrKEtFUk5fSU5GTyAiIFN0
cmFuZ2UsICVzIG5vdCBzdG9wcGVkXG4iLCBwLT5jb21tICk7CisJfSB3aGlsZV9lYWNoX3RocmVh
ZChnLCBwKTsKKworCXJlYWRfdW5sb2NrKCZ0YXNrbGlzdF9sb2NrKTsKKwlzY2hlZHVsZSgpOwor
CXByaW50ayggIiBkb25lXG4iICk7Cit9CisKIHZvaWQgdGhhd19wcm9jZXNzZXModm9pZCkKIHsK
IAlzdHJ1Y3QgdGFza19zdHJ1Y3QgKmcsICpwOwpAQCAtMTA2LDYgKzEyOSw4IEBAIHZvaWQgdGhh
d19wcm9jZXNzZXModm9pZCkKIAlkb19lYWNoX3RocmVhZChnLCBwKSB7CiAJCWlmICghZnJlZXpl
YWJsZShwKSkKIAkJCWNvbnRpbnVlOworCQlpZiAocC0+cGFyZW50LT5waWQgPT0gMSkKKwkJCWNv
bnRpbnVlOwogCQlpZiAocC0+ZmxhZ3MgJiBQRl9GUk9aRU4pIHsKIAkJCXAtPmZsYWdzICY9IH5Q
Rl9GUk9aRU47CiAJCQl3YWtlX3VwX3Byb2Nlc3MocCk7Cgo=

------_=_NextPart_001_01C4B855.4F2D60EB--
