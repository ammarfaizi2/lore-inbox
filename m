Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276135AbRI1Pvs>; Fri, 28 Sep 2001 11:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276139AbRI1Pvj>; Fri, 28 Sep 2001 11:51:39 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:41504 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S276135AbRI1Pvc>; Fri, 28 Sep 2001 11:51:32 -0400
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide drive problem? RFC
Date: Fri, 28 Sep 2001 17:48:18 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15myH3-00076i-00@the-village.bc.nu>
In-Reply-To: <E15myH3-00076i-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_IKQDKYEFXTV600MCIGZL"
Message-Id: <E15mzu9-0005xJ-00@mrvdom00.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_IKQDKYEFXTV600MCIGZL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> > > hde: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> > > hde: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> >
> > Hmmm, I get this message as well about once a day (though it seems it
> > could not cause any damage ... yet ...)
>
> BadCRC is a transmission error on the IDE cable. It will be retried so
> it isnt a problem.

I read this error message very often in the LKML. Why not making the erro=
r message more detailed, pointing to a FAQ entry or an help file or a hin=
t to check the IDE cable?

As a aimple example, I made a patch against 2.4.9-ac14.


diff -ur linux/drivers/ide/ide.c linux-new/drivers/ide/ide.c
--- linux/drivers/ide/ide.c     Thu Sep 27 17:53:09 2001
+++ linux-new/drivers/ide/ide.c Fri Sep 28 17:26:16 2001
@@ -910,7 +910,8 @@
                if (drive->media =3D=3D ide_disk) {
                        printk(" { ");
                        if (err & ABRT_ERR)     printk("DriveStatusError =
");
-                       if (err & ICRC_ERR)     printk("%s", (err & ABRT_=
ERR) ? "BadCRC " : "BadSector ");
+                       if (err & ICRC_ERR)     printk("%s", (err & ABRT_=
ERR) ? "BadCRC.\
+Please check your IDE-cable." : "BadSector ");
                        if (err & ECC_ERR)      printk("UncorrectableErro=
r ");
                        if (err & ID_ERR)       printk("SectorIdNotFound =
");
                        if (err & TRK0_ERR)     printk("TrackZeroNotFound=
 ");







--------------Boundary-00=_IKQDKYEFXTV600MCIGZL
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="message.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="message.patch"

diff -ur linux/drivers/ide/ide.c linux-new/drivers/ide/ide.c
--- linux/drivers/ide/ide.c	Thu Sep 27 17:53:09 2001
+++ linux-new/drivers/ide/ide.c	Fri Sep 28 17:26:16 2001
@@ -910,7 +910,8 @@
 		if (drive->media == ide_disk) {
 			printk(" { ");
 			if (err & ABRT_ERR)	printk("DriveStatusError ");
-			if (err & ICRC_ERR)	printk("%s", (err & ABRT_ERR) ? "BadCRC " : "BadSector ");
+			if (err & ICRC_ERR)	printk("%s", (err & ABRT_ERR) ? "BadCRC.\
+Please check your IDE-cable." : "BadSector ");
 			if (err & ECC_ERR)	printk("UncorrectableError ");
 			if (err & ID_ERR)	printk("SectorIdNotFound ");
 			if (err & TRK0_ERR)	printk("TrackZeroNotFound ");

--------------Boundary-00=_IKQDKYEFXTV600MCIGZL--
