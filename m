Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbRGPQMZ>; Mon, 16 Jul 2001 12:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267445AbRGPQMP>; Mon, 16 Jul 2001 12:12:15 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:39693 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S267441AbRGPQMI>;
	Mon, 16 Jul 2001 12:12:08 -0400
Message-ID: <938F7F15145BD311AECE00508B7152DB034C48DA@vts007.vertis.nl>
From: Rolf Fokkens <FokkensR@vertis.nl>
To: "'alan@lxorguk.ukuu.org.uk'" <alan@lxorguk.ukuu.org.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: PATCH: /proc/sys/kernel/hz
Date: Mon, 16 Jul 2001 18:11:14 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C10E11.EFF2E370"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C10E11.EFF2E370
Content-Type: text/plain;
	charset="iso-8859-1"

Hi!

Some software (like procps) needs the HZ constant in the kernel. It's
sometimes determined by counting jiffies during a second. The attached patch
just "publishes" the HZ constant in /proc/sys/kernel/hz.

Rolf


------_=_NextPart_000_01C10E11.EFF2E370
Content-Type: application/octet-stream;
	name="linux-2.4.6-sysctl.hz.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.4.6-sysctl.hz.patch"

The HZ kernel constant is not the same on all platforms. The procps =
library=0A=
seems to need it's value however, it estimates it by measuring during a =
second.=0A=
This patch publishes the HZ value in /proc/sys/kernel/hz for the =
convenience=0A=
of tools that need it's value.=0A=
=0A=
--- linux/include/linux/sysctl.h.sysctlhz	Sun May 27 14:12:56 2001=0A=
+++ linux/include/linux/sysctl.h	Mon Jul 16 11:12:45 2001=0A=
@@ -118,7 +118,9 @@=0A=
 	KERN_SHMPATH=3D48,	/* string: path to shm fs */=0A=
 	KERN_HOTPLUG=3D49,	/* string: path to hotplug policy agent */=0A=
 	KERN_IEEE_EMULATION_WARNINGS=3D50, /* int: unimplemented ieee =
instructions */=0A=
-	KERN_S390_USER_DEBUG_LOGGING=3D51  /* int: dumps of user faults */=0A=
+	KERN_S390_USER_DEBUG_LOGGING=3D51, /* int: dumps of user faults */=0A=
+=0A=
+	KERN_HZ=3D60		/* compiled in HZ value */=0A=
 };=0A=
 =0A=
 =0A=
--- linux/kernel/sysctl.c.sysctlhz	Thu Apr 12 21:20:31 2001=0A=
+++ linux/kernel/sysctl.c	Mon Jul 16 14:54:27 2001=0A=
@@ -16,6 +16,7 @@=0A=
  *  Wendling.=0A=
  * The list_for_each() macro wasn't appropriate for the sysctl =
loop.=0A=
  *  Removed it and replaced it with older style, 03/23/00, Bill =
Wendling=0A=
+ * Added hz (HZ), 07/16/01, Rolf Fokkens=0A=
  */=0A=
 =0A=
 #include <linux/config.h>=0A=
@@ -153,6 +154,8 @@=0A=
 	{0}=0A=
 };=0A=
 =0A=
+static int hz_value =3D HZ;=0A=
+=0A=
 static ctl_table kern_table[] =3D {=0A=
 	{KERN_OSTYPE, "ostype", system_utsname.sysname, 64,=0A=
 	 0444, NULL, &proc_doutsstring, &sysctl_string},=0A=
@@ -249,6 +252,8 @@=0A=
 	{KERN_S390_USER_DEBUG_LOGGING,"userprocess_debug",=0A=
 	 &sysctl_userprocess_debug,sizeof(int),0644,NULL,&proc_dointvec},=0A=
 #endif=0A=
+	{KERN_HZ, "hz", &hz_value,sizeof(int),=0A=
+	 0444, NULL, &proc_dointvec},=0A=
 	{0}=0A=
 };=0A=
 =0A=

------_=_NextPart_000_01C10E11.EFF2E370--
