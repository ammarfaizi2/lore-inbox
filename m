Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267861AbUHKAHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267861AbUHKAHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 20:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267851AbUHKAHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 20:07:38 -0400
Received: from fmr06.intel.com ([134.134.136.7]:22184 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267868AbUHKAGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 20:06:19 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C47F36.BA048659"
Subject: RE: [PATCH][2.6] fix i386 idle routine selection
Date: Tue, 10 Aug 2004 17:04:09 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB600296CC37@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6] fix i386 idle routine selection
Thread-Index: AcR/Nrm2bTSNtEjPQ7+smX4EuAB5TA==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Zwane Mwaikambo" <zwane@fsmlabs.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Aug 2004 00:04:10.0552 (UTC) FILETIME=[BA677380:01C47F36]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C47F36.BA048659
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

The original idea of setting it back to default_idle(),
was to handle the cases:
1) CPU 0 says it can do mwait and CPU 1 later says it=20
cannot do mwait
2) CPU 0 says it cannot do mwait and later CPU 1 says
that it can do mwait

Not that I know of any system like that. But, ideally=20
mwait_idle should be set only when all CPUs say that=20
they can do it.

So how about this patch.

Thanks,
Venki


>-----Original Message-----
>From: robomod@news.nic.it [mailto:robomod@news.nic.it] On=20
>Behalf Of Zwane Mwaikambo
>Sent: Sunday, August 08, 2004 11:20 AM
>Subject: [PATCH][2.6] fix i386 idle routine selection
>
>This was broken when the mwait stuff went in since it executes=20
>after the
>initial idle_setup() has already selected an idle routine and=20
>overrides it
>with default_idle.
>
>Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>
>
>Index: linux-2.6.8-rc3-mm1-amd64/arch/i386/kernel/process.c
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>RCS file:=20
>/home/cvsroot/linux-2.6.8-rc3-mm1/arch/i386/kernel/process.c,v
>retrieving revision 1.1.1.1
>diff -u -p -B -r1.1.1.1 process.c
>--- linux-2.6.8-rc3-mm1-amd64/arch/i386/kernel/process.c=09
>5 Aug 2004 16:37:39 -0000	1.1.1.1
>+++ linux-2.6.8-rc3-mm1-amd64/arch/i386/kernel/process.c=09
>8 Aug 2004 18:14:32 -0000
>@@ -226,10 +226,7 @@ void __init select_idle_routine(const st
> 			printk("using mwait in idle threads.\n");
> 			pm_idle =3D mwait_idle;
> 		}
>-		return;
> 	}
>-	pm_idle =3D default_idle;
>-	return;
> }
>
> static int __init idle_setup (char *str)
>Index: linux-2.6.8-rc3-mm1-amd64/arch/x86_64/kernel/process.c
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>RCS file:=20
>/home/cvsroot/linux-2.6.8-rc3-mm1/arch/x86_64/kernel/process.c,v
>retrieving revision 1.1.1.1
>diff -u -p -B -r1.1.1.1 process.c
>--- linux-2.6.8-rc3-mm1-amd64/arch/x86_64/kernel/process.c=09
>5 Aug 2004 16:37:48 -0000	1.1.1.1
>+++ linux-2.6.8-rc3-mm1-amd64/arch/x86_64/kernel/process.c=09
>8 Aug 2004 18:12:22 -0000
>@@ -180,10 +180,7 @@ void __init select_idle_routine(const st
> 			}
> 			pm_idle =3D mwait_idle;
> 		}
>-		return;
> 	}
>-	pm_idle =3D default_idle;
>-	return;
> }
>
> static int __init idle_setup (char *str)
>-
>To unsubscribe from this list: send the line "unsubscribe=20
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

------_=_NextPart_001_01C47F36.BA048659
Content-Type: application/octet-stream;
	name="mwait_bug.patch"
Content-Transfer-Encoding: base64
Content-Description: mwait_bug.patch
Content-Disposition: attachment;
	filename="mwait_bug.patch"

CkJyb2tlbiBtd2FpdCBpbml0aWFsaXphdGlvbiwgYXMgaXQgZXhlY3V0ZXMgYWZ0ZXIgaW5pdGlh
bCBpZGxlX3NldHVwKCkgCmFuZCB0aGlzIHJvdXRpbmUgY2FuIG92ZXJyaWRlIHRoYXQgaW5pdGlh
bCBzZXR1cC4KClNpZ25lZC1vZmYtYnk6IFZlbmthdGVzaCBQYWxsaXBhZGkgPHZlbmthdGVzaC5w
YWxsaXBhZGlAaW50ZWwuY29tPgoKLS0tIGxpbnV4LTIuNi44LXJjMi8vYXJjaC9pMzg2L2tlcm5l
bC9wcm9jZXNzLmMub3JnCTIwMDQtMDgtMTAgMTk6MTA6MzAuMDAwMDAwMDAwIC0wNzAwCisrKyBs
aW51eC0yLjYuOC1yYzIvL2FyY2gvaTM4Ni9rZXJuZWwvcHJvY2Vzcy5jCTIwMDQtMDgtMTAgMTk6
MTg6MzUuMDAwMDAwMDAwIC0wNzAwCkBAIC0yMjYsMTAgKzIyNiwxMiBAQCB2b2lkIF9faW5pdCBz
ZWxlY3RfaWRsZV9yb3V0aW5lKGNvbnN0IHN0CiAJCQlwcmludGsoInVzaW5nIG13YWl0IGluIGlk
bGUgdGhyZWFkcy5cbiIpOwogCQkJcG1faWRsZSA9IG13YWl0X2lkbGU7CiAJCX0KLQkJcmV0dXJu
OwotCX0KLQlwbV9pZGxlID0gZGVmYXVsdF9pZGxlOwotCXJldHVybjsKKwl9IGVsc2UgaWYgKHBt
X2lkbGUgPT0gbXdhaXRfaWRsZSkgeworCQlwcmludGsoIkFsbCBDUFVzIGRvIG5vdCBzdXBwb3J0
IG13YWl0X2lkbGUuIGZhbGxiYWNrLlxuIik7CisJCXBtX2lkbGUgPSBkZWZhdWx0X2lkbGU7CisJ
fSBlbHNlIGlmICghcG1faWRsZSkKKwkJcG1faWRsZSA9IGRlZmF1bHRfaWRsZTsKKwogfQogCiBz
dGF0aWMgaW50IF9faW5pdCBpZGxlX3NldHVwIChjaGFyICpzdHIpCi0tLSBsaW51eC0yLjYuOC1y
YzIvL2FyY2gveDg2XzY0L2tlcm5lbC9wcm9jZXNzLmMub3JnCTIwMDQtMDgtMTAgMTk6MTg6NDgu
MDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjYuOC1yYzIvL2FyY2gveDg2XzY0L2tlcm5lbC9w
cm9jZXNzLmMJMjAwNC0wOC0xMCAxOToxOTo1Ny4wMDAwMDAwMDAgLTA3MDAKQEAgLTE4MCwxMCAr
MTgwLDEyIEBAIHZvaWQgX19pbml0IHNlbGVjdF9pZGxlX3JvdXRpbmUoY29uc3Qgc3QKIAkJCX0K
IAkJCXBtX2lkbGUgPSBtd2FpdF9pZGxlOwogCQl9Ci0JCXJldHVybjsKLQl9Ci0JcG1faWRsZSA9
IGRlZmF1bHRfaWRsZTsKLQlyZXR1cm47CisJfSBlbHNlIGlmIChwbV9pZGxlID09IG13YWl0X2lk
bGUpIHsKKwkJcHJpbnRrKCJBbGwgQ1BVcyBkbyBub3Qgc3VwcG9ydCBtd2FpdF9pZGxlLiBmYWxs
YmFjay5cbiIpOworCQlwbV9pZGxlID0gZGVmYXVsdF9pZGxlOworCX0gZWxzZSBpZiAoIXBtX2lk
bGUpCisJCXBtX2lkbGUgPSBkZWZhdWx0X2lkbGU7CisKIH0KIAogc3RhdGljIGludCBfX2luaXQg
aWRsZV9zZXR1cCAoY2hhciAqc3RyKQo=

------_=_NextPart_001_01C47F36.BA048659--
