Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263226AbTCNCJr>; Thu, 13 Mar 2003 21:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263227AbTCNCJq>; Thu, 13 Mar 2003 21:09:46 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:45320 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S263226AbTCNCJp>;
	Thu, 13 Mar 2003 21:09:45 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A347@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Mauricio Nunez '" <mauricio@chile.com>
Cc: "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>,
       "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>
Subject: RE: Problems with ide-default.c and my hdd (2.5.64-ac3)
Date: Fri, 14 Mar 2003 11:20:25 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C2E9D0.45BC8F90"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C2E9D0.45BC8F90
Content-Type: text/plain;
	charset="iso-8859-1"


-----Original Message-----
From: Mauricio Nunez
To: linux-kernel@vger.kernel.org
Sent: 2003/03/14 11:03
Subject: Problems with ide-default.c and my hdd (2.5.64-ac3)

> I'm booting 2.5.64-ac3 with hdd=none because I got a Kernel Panic
> default attach failed.

I had same trable. But my box is the PC9800 architecture.
Please test my patch attached. This may be OK for standard PC too.

Regards,
Osamu Tomita


------_=_NextPart_000_01C2E9D0.45BC8F90
Content-Type: application/octet-stream;
	name="ide-fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ide-fix.patch"

This is quick fix for boot.=0A=
=0A=
diff -Nru linux-2.5.64-ac3/drivers/ide/ide-probe.c =
linux-2.5.64-ac3-quick-fix/drivers/ide/ide-probe.c=0A=
--- linux-2.5.64-ac3/drivers/ide/ide-probe.c	2003-03-08 =
12:29:29.000000000 +0900=0A=
+++ linux-2.5.64-ac3-quick-fix/drivers/ide/ide-probe.c	2003-03-10 =
21:25:30.000000000 +0900=0A=
@@ -1392,7 +1392,8 @@=0A=
 			if (!hwif->present)=0A=
 				continue;=0A=
 			for (unit =3D 0; unit < MAX_DRIVES; ++unit)=0A=
-				ata_attach(&hwif->drives[unit]);=0A=
+				if (hwif->drives[unit].present)=0A=
+					ata_attach(&hwif->drives[unit]);=0A=
 		}=0A=
 	}=0A=
 	if (!ide_probe)=0A=
diff -Nru linux-2.5.64-ac3/drivers/ide/ide.c =
linux-2.5.64-ac3-quick-fix/drivers/ide/ide.c=0A=
--- linux-2.5.64-ac3/drivers/ide/ide.c	2003-03-08 12:29:29.000000000 =
+0900=0A=
+++ linux-2.5.64-ac3-quick-fix/drivers/ide/ide.c	2003-03-10 =
21:29:00.000000000 +0900=0A=
@@ -2377,7 +2377,8 @@=0A=
 	while (!list_empty(&list)) {=0A=
 		ide_drive_t *drive =3D list_entry(list.next, ide_drive_t, list);=0A=
 		list_del_init(&drive->list);=0A=
-		ata_attach(drive);=0A=
+		if (drive->present)=0A=
+			ata_attach(drive);=0A=
 	}=0A=
 	driver->gen_driver.name =3D (char *) driver->name;=0A=
 	driver->gen_driver.bus =3D &ide_bus_type;=0A=

------_=_NextPart_000_01C2E9D0.45BC8F90--
