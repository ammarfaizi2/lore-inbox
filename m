Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131408AbRAADtr>; Sun, 31 Dec 2000 22:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbRAADti>; Sun, 31 Dec 2000 22:49:38 -0500
Received: from [139.102.15.42] ([139.102.15.42]:57241 "EHLO
	online.indstate.edu") by vger.kernel.org with ESMTP
	id <S131461AbRAADtc>; Sun, 31 Dec 2000 22:49:32 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: linux-kernel@vger.kernel.org
Date: Sun, 31 Dec 2000 22:16:25 -0500
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-9043
Subject: [PATCH] fix for ACPI compile warnings in 2.4.0prerelease
Reply-to: richbaum@acm.org
CC: torvalds@transmeta.com, andy_henroid@yahoo.com
Message-ID: <3A4FB039.13836.114540@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Message-Boundary-9043
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

	When I compile 2.4.0-prerelease with the 200012252 gcc 
snapshot I get the following warnings:

make[3]: Entering directory `/usr/src/linux/drivers/acpi/hardware'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-
prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -
mpreferred-stack-boundary=2 -march=k6  -I../include -D_LINUX  -c -
o hwcpu32.o hwcpu32.c
hwcpu32.c:711:1: warning: no newline at end of file
make[3]: Leaving directory `/usr/src/linux/drivers/acpi/hardware'
make[3]: Entering directory `/usr/src/linux/drivers/acpi/namespace'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-
prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -
mpreferred-stack-boundary=2 -march=k6  -I../include -D_LINUX  -c -
o nsxfobj.o nsxfobj.c
nsxfobj.c:697:1: warning: no newline at end of file
make[3]: Leaving directory `/usr/src/linux/drivers/acpi/namespace'

Attached is a patch that removes these warnings.  Please consider 
this patch for the final release.

Rich


--Message-Boundary-9043
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'acpi.patch'

diff -urN linux/drivers/acpi/hardware/hwcpu32.c rb/drivers/acpi/hardware/hwcpu32.c
--- linux/drivers/acpi/hardware/hwcpu32.c	Sun Dec 31 19:19:05 2000
+++ rb/drivers/acpi/hardware/hwcpu32.c	Sun Dec 31 20:44:11 2000
@@ -708,4 +708,4 @@
 	return;
 }
 
- 
\ No newline at end of file
+
diff -urN linux/drivers/acpi/namespace/nsxfobj.c rb/drivers/acpi/namespace/nsxfobj.c
--- linux/drivers/acpi/namespace/nsxfobj.c	Sun Dec 31 19:19:05 2000
+++ rb/drivers/acpi/namespace/nsxfobj.c	Sun Dec 31 20:44:51 2000
@@ -694,4 +694,5 @@
 	acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
 
 	return (status);
-}
\ No newline at end of file
+}
+


--Message-Boundary-9043--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
