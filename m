Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280891AbRKOPKF>; Thu, 15 Nov 2001 10:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280892AbRKOPJz>; Thu, 15 Nov 2001 10:09:55 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:49832 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S280891AbRKOPJo>;
	Thu, 15 Nov 2001 10:09:44 -0500
Date: Thu, 15 Nov 2001 16:08:29 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: <igmar@jdi.jdimedia.nl>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] request_module[scsi_hostadapter]: Root fs not mounted
Message-ID: <Pine.LNX.4.33.0111151603540.22669-200000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-858508352-771233746-1005836909=:22669"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---858508352-771233746-1005836909=:22669
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi,

drivers/scsi/scsi.c : scsi_register_module() is called by drivers which
need the midlevel SCSI layer. When no hostadapters are found, it calls
request_module("scsi_hostadapter").

When scsi drivers are compiled in and not found, the request_module()
fails because the root FS is not mounted (not the case when a ramdisk is
loaded I guess), so request_module() logs a warning.

Applied fix fixes the warning by only calling request_module() when the
root FS is mounted.



	Regards,


		Igmar


-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

---858508352-771233746-1005836909=:22669
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4.14-scsi-kmod.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0111151608290.22669@jdi.jdimedia.nl>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.4.14-scsi-kmod.patch"

LS0tIGxpbnV4LTIuNC4xNC9kcml2ZXJzL3Njc2kvc2NzaS5jLm9yaWcJVGh1
IE5vdiAxNSAxNTo1MToxNSAyMDAxDQorKysgbGludXgtMi40LjE0L2RyaXZl
cnMvc2NzaS9zY3NpLmMJVGh1IE5vdiAxNSAxNTo1MTo0MSAyMDAxDQpAQCAt
MjM0Nyw3ICsyMzQ3LDcgQEANCiAJCS8qIExvYWQgdXBwZXIgbGV2ZWwgZGV2
aWNlIGhhbmRsZXIgb2Ygc29tZSBraW5kICovDQogCWNhc2UgTU9EVUxFX1ND
U0lfREVWOg0KICNpZmRlZiBDT05GSUdfS01PRA0KLQkJaWYgKHNjc2lfaG9z
dHMgPT0gTlVMTCkNCisJCWlmIChzY3NpX2hvc3RzID09IE5VTEwgJiYgY3Vy
cmVudC0+ZnMtPnJvb3QgIT0gTlVMTCkNCiAJCQlyZXF1ZXN0X21vZHVsZSgi
c2NzaV9ob3N0YWRhcHRlciIpOw0KICNlbmRpZg0KIAkJcmV0dXJuIHNjc2lf
cmVnaXN0ZXJfZGV2aWNlX21vZHVsZSgoc3RydWN0IFNjc2lfRGV2aWNlX1Rl
bXBsYXRlICopIHB0cik7DQo=
---858508352-771233746-1005836909=:22669--
