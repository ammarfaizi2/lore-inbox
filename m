Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315551AbSECEmp>; Fri, 3 May 2002 00:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315552AbSECEmo>; Fri, 3 May 2002 00:42:44 -0400
Received: from sm10.texas.rr.com ([24.93.35.222]:52411 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S315551AbSECEmn>;
	Fri, 3 May 2002 00:42:43 -0400
Subject: [PATCH] trivial patch for fixme in ide-pci.c
From: Gerald Champagne <gerald@io.com>
To: linux-kernel@vger.kernel.org
Cc: dalecki@evision-ventures.com
Content-Type: multipart/mixed; boundary="=-lkbSeEnQmZpm0J/jvwT7"
X-Mailer: Ximian Evolution 1.0.4 
Date: 02 May 2002 23:42:55 -0500
Message-Id: <1020400975.5905.63.camel@wiley>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lkbSeEnQmZpm0J/jvwT7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following cleanup patch gets rid of a FIXME in ide-pci.c.  It
compiles, but it's untested since I don't have that hardware.  

Gerald


--=-lkbSeEnQmZpm0J/jvwT7
Content-Disposition: attachment; filename=hpt366fixme.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=hpt366fixme.patch; charset=ISO-8859-1

diff -urN linux-2.5.13.orig/drivers/ide/hpt366.c linux-2.5.13/drivers/ide/h=
pt366.c
--- linux-2.5.13.orig/drivers/ide/hpt366.c	Thu May  2 19:22:42 2002
+++ linux-2.5.13/drivers/ide/hpt366.c	Thu May  2 21:29:32 2002
@@ -346,8 +346,6 @@
 static unsigned int pci_rev_check_hpt3xx(struct pci_dev *dev);
 static unsigned int pci_rev2_check_hpt3xx(struct pci_dev *dev);
 byte hpt366_proc =3D 0;
-byte hpt363_shared_irq;
-byte hpt363_shared_pin;
 extern char *ide_xfer_verbose (byte xfer_rate);
=20
 #if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
diff -urN linux-2.5.13.orig/drivers/ide/ide-pci.c linux-2.5.13/drivers/ide/=
ide-pci.c
--- linux-2.5.13.orig/drivers/ide/ide-pci.c	Thu May  2 19:22:56 2002
+++ linux-2.5.13/drivers/ide/ide-pci.c	Thu May  2 21:53:01 2002
@@ -81,17 +81,10 @@
 #endif
=20
 #ifdef CONFIG_BLK_DEV_HPT366
-extern byte hpt363_shared_irq;
-extern byte hpt363_shared_pin;
-
 extern unsigned int pci_init_hpt366(struct pci_dev *);
 extern unsigned int ata66_hpt366(struct ata_channel *);
 extern void ide_init_hpt366(struct ata_channel *);
 extern void ide_dmacapable_hpt366(struct ata_channel *, unsigned long);
-#else
-/* FIXME: those have to be killed */
-static byte hpt363_shared_irq;
-static byte hpt363_shared_pin;
 #endif
=20
 #ifdef CONFIG_BLK_DEV_NS87415
@@ -843,9 +836,7 @@
 		    (PCI_FUNC(findev->devfn) & 1)) {
 			dev2 =3D findev;
 			pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin2);
-			hpt363_shared_pin =3D (pin1 !=3D pin2) ? 1 : 0;
-			hpt363_shared_irq =3D (dev->irq =3D=3D dev2->irq) ? 1 : 0;
-			if (hpt363_shared_pin && hpt363_shared_irq) {
+			if (pin1 !=3D pin2 && dev->irq =3D=3D dev2->irq) {
 				d->bootable =3D ON_BOARD;
 				printk("%s: onboard version of chipset, pin1=3D%d pin2=3D%d\n", dev->n=
ame, pin1, pin2);
 			}

--=-lkbSeEnQmZpm0J/jvwT7--

