Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUIMOaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUIMOaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUIMOaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:30:10 -0400
Received: from magic.adaptec.com ([216.52.22.17]:57223 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S267397AbUIMO2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:28:49 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4999D.F989AB78"
Subject: RE: 2.4.28-pre3: broken ips update
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Mon, 13 Sep 2004 10:28:44 -0400
Message-ID: <A121ABA5B472B74EB59076B8E3C8F019796579@rtpe2k01.adaptec.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.28-pre3: broken ips update
Thread-Index: AcSZX+fmpXnlRjphQyKGP17QWZaduAAN8ixA
From: "Hammer, Jack" <Jack_Hammer@adaptec.com>
To: "Adrian Bunk" <bunk@fs.tum.de>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4999D.F989AB78
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marcelo,

This trivial one line patch corrects my mistake in ips.h. I assure you
that the previous patch was compiled and tested extensively - over a
several month test cycle.  However, our testing concentrates on existing
customers and shipping distro's.  Most of those changed to the 2.6
kernel on or before 2.4.20, so we had no 2.4 kernel in our test matrix
beyond that. I apologize for the oversight - we must update our test
matrix to always check out latest 2.4 development kernel.

The concerns expressed below about this driver being "blindly submitted"
or is "untested" are completely unwarranted.

Thanks.

Jack



--- linux.orig/drivers/scsi/ips.h	Mon Sep 13 09:40:04 2004
+++ linux/drivers/scsi/ips.h	Mon Sep 13 09:40:27 2004
@@ -97,7 +97,7 @@
=20
    #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
   =20
-      #ifndef irqreturn_t
+      #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,23)
          typedef void irqreturn_t;
       #endif=20







=20

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Adrian Bunk
Sent: Monday, September 13, 2004 3:04 AM
To: Marcelo Tosatti; IpsLinux
Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
Subject: 2.4.28-pre3: broken ips update

On Sat, Sep 11, 2004 at 07:01:17PM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.28-pre2 to v2.4.28-pre3 =20
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>...
> Jack Hammer:
>   o ServeRAID driver (ips) Version 7.10.18 ...

<--  snip  -->

...
gcc-3.4 -D__KERNEL__
-I/home/bunk/linux/kernel-2.4/linux-2.4.28-pre3-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 =
-march=3Dathlon=20
-fno-unit-at-a-time   -nostdinc -iwithprefix include=20
-DKBUILD_BASENAME=3Dips  -c -o ips.o ips.c In file included from
ips.c:190:
ips.h:101: error: redefinition of typedef 'irqreturn_t'
/home/bunk/linux/kernel-2.4/linux-2.4.28-pre3-full/include/linux/interru
pt.h:16:=20
error: previous declaration of 'irqreturn_t' was here
make[3]: *** [ips.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.28-pre3-full/drivers/scsi'

<--  snip  -->


This update was obviously submitted without even testing the compilation
of the driver (not to mention testing whether it actually works).


Even worse:

We had _exactly the same problem_ with the 7.00.15 driver in=20
2.4.27-pre3, but 7.10.18 now simply reverts my (trivial) fix for this=20
compile error.


Marcelo, can you please refuse patches from people who don't bother to=20
do even the simplest compile testing when blindly submitting the latest=20
version of a driver?


TIA
Adrian

--=20

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


------_=_NextPart_001_01C4999D.F989AB78
Content-Type: application/octet-stream;
	name="patch_ips.h"
Content-Transfer-Encoding: base64
Content-Description: patch_ips.h
Content-Disposition: attachment;
	filename="patch_ips.h"

LS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9zY3NpL2lwcy5oCU1vbiBTZXAgMTMgMDk6NDA6MDQgMjAw
NAorKysgbGludXgvZHJpdmVycy9zY3NpL2lwcy5oCU1vbiBTZXAgMTMgMDk6NDA6MjcgMjAwNApA
QCAtOTcsNyArOTcsNyBAQAogCiAgICAjaWYgTElOVVhfVkVSU0lPTl9DT0RFIDwgS0VSTkVMX1ZF
UlNJT04oMiw1LDApCiAgICAKLSAgICAgICNpZm5kZWYgaXJxcmV0dXJuX3QKKyAgICAgICNpZiBM
SU5VWF9WRVJTSU9OX0NPREUgPCBLRVJORUxfVkVSU0lPTigyLDQsMjMpCiAgICAgICAgICB0eXBl
ZGVmIHZvaWQgaXJxcmV0dXJuX3Q7CiAgICAgICAjZW5kaWYgCiAgICAgICAK

------_=_NextPart_001_01C4999D.F989AB78--
