Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279616AbRJXVTq>; Wed, 24 Oct 2001 17:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279604AbRJXVT0>; Wed, 24 Oct 2001 17:19:26 -0400
Received: from patan.Sun.COM ([192.18.98.43]:32707 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S279603AbRJXVTS>;
	Wed, 24 Oct 2001 17:19:18 -0400
Message-ID: <3BD7332C.ABF2B2F8@sun.com>
Date: Wed, 24 Oct 2001 14:31:24 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12C5_V i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] SMART enable early
Content-Type: multipart/mixed;
 boundary="------------DC313F297F32CE432962D02B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DC313F297F32CE432962D02B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

>From ATA spec proposal 1e:


8.55.3.8 Description (SMART ENABLE OPERATIONS)

This command enables access to all SMART capabilities within the device.
Prior to receipt of this command SMART data are neither monitored nor saved
by the device.

You HAVE to enable SMART as early as possible to have any meaningful data. 
And, as best I can tell, it is never DISABLED anywhere.  So once you read
from /proc/.../smart_values SMART is on.  

I think the patch is actually OK.  Unless you can point out where in the
spec I am missing something.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------DC313F297F32CE432962D02B
Content-Type: text/plain; charset=us-ascii;
 name="ide-smart.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-smart.diff"

diff -ruN dist-2.4.12+patches/drivers/ide/ide-disk.c cvs-2.4.12+patches/drivers/ide/ide-disk.c
--- dist-2.4.12+patches/drivers/ide/ide-disk.c	Mon Oct 15 10:21:49 2001
+++ cvs-2.4.12+patches/drivers/ide/ide-disk.c	Mon Oct 15 10:21:49 2001
@@ -569,13 +569,13 @@
 		drive->special.b.set_multmode = 1;
 }
 
-#ifdef CONFIG_PROC_FS
-
 static int smart_enable(ide_drive_t *drive)
 {
 	return ide_wait_cmd(drive, WIN_SMART, 0, SMART_ENABLE, 0, NULL);
 }
 
+#ifdef CONFIG_PROC_FS
+
 static int get_smart_values(ide_drive_t *drive, byte *buf)
 {
 	(void) smart_enable(drive);
@@ -799,6 +799,7 @@
 #endif
 	}
 	drive->no_io_32bit = id->dword_io ? 1 : 0;
+	(void) smart_enable(drive);
 }
 
 static int idedisk_reinit (ide_drive_t *drive)

--------------DC313F297F32CE432962D02B--

