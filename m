Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSHHAO2>; Wed, 7 Aug 2002 20:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317003AbSHHAO2>; Wed, 7 Aug 2002 20:14:28 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:15302 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316935AbSHHAO0>;
	Wed, 7 Aug 2002 20:14:26 -0400
Subject: [TRIVIAL][PATCH] cpu_has_tsc cleanup
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-1YLy2anB32euMk9cKsUk"
X-Mailer: Ximian Evolution 1.0.8 
Date: 07 Aug 2002 17:03:49 -0700
Message-Id: <1028765030.22918.166.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1YLy2anB32euMk9cKsUk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Marcelo, 

Here is a trivial cleanup patch that replaces:
	test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability) 
w/ the cpu_has_tsc macro.

I believe this was originally by Brian Gerst for 2.5

thanks
-john



--=-1YLy2anB32euMk9cKsUk
Content-Disposition: attachment; filename=linux-2.4.20-pre1_tsc-cleanup_A0.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=linux-2.4.20-pre1_tsc-cleanup_A0.patch;
	charset=ISO-8859-1

diff -Nru a/drivers/char/joystick/analog.c b/drivers/char/joystick/analog.c
--- a/drivers/char/joystick/analog.c	Wed Aug  7 16:35:44 2002
+++ b/drivers/char/joystick/analog.c	Wed Aug  7 16:35:44 2002
@@ -137,10 +137,9 @@
  */
=20
 #ifdef __i386__
-#define TSC_PRESENT	(test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capabili=
ty))
-#define GET_TIME(x)	do { if (TSC_PRESENT) rdtscl(x); else { outb(0, 0x43);=
 x =3D inb(0x40); x |=3D inb(0x40) << 8; } } while (0)
-#define DELTA(x,y)	(TSC_PRESENT?((y)-(x)):((x)-(y)+((x)<(y)?1193180L/HZ:0)=
))
-#define TIME_NAME	(TSC_PRESENT?"TSC":"PIT")
+#define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else { outb(0, 0x43);=
 x =3D inb(0x40); x |=3D inb(0x40) << 8; } } while (0)
+#define DELTA(x,y)	(cpu_has_tsc?((y)-(x)):((x)-(y)+((x)<(y)?1193180L/HZ:0)=
))
+#define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
 #elif __x86_64__
 #define GET_TIME(x)	rdtscl(x)
 #define DELTA(x,y)	((y)-(x))
diff -Nru a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	Wed Aug  7 16:35:44 2002
+++ b/drivers/char/random.c	Wed Aug  7 16:35:44 2002
@@ -735,7 +735,7 @@
 	int		entropy =3D 0;
=20
 #if defined (__i386__)
-	if ( test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability) ) {
+	if (cpu_has_tsc) {
 		__u32 high;
 		rdtsc(time, high);
 		num ^=3D high;

--=-1YLy2anB32euMk9cKsUk--

