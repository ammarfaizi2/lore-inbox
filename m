Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUKBN5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUKBN5A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 08:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbUKBNyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:54:24 -0500
Received: from [212.209.10.221] ([212.209.10.221]:27348 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S262913AbUKBNE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:04:58 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: [PATCH 4/10] CRIS architecture update - IDE
Date: Tue, 2 Nov 2004 14:04:39 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C7488@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01D4_01C4C0E4.E514F950"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01D4_01C4C0E4.E514F950
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update CRIS IDE driver for 2.6.9.

Signed-Off-By: starvik@axis.com

/Mikael

------=_NextPart_000_01D4_01C4C0E4.E514F950
Content-Type: application/octet-stream;
	name="cris269_4.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cris269_4.patch"

diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/drivers/ide.c =
lx25/arch/cris/arch-v10/drivers/ide.c=0A=
--- ../linux/arch/cris/arch-v10/drivers/ide.c	Mon Oct 18 23:54:08 2004=0A=
+++ lx25/arch/cris/arch-v10/drivers/ide.c	Tue Oct 12 09:55:48 2004=0A=
@@ -1,4 +1,4 @@=0A=
-/* $Id: ide.c,v 1.1 2004/01/22 08:22:58 starvik Exp $=0A=
+/* $Id: ide.c,v 1.4 2004/10/12 07:55:48 starvik Exp $=0A=
  *=0A=
  * Etrax specific IDE functions, like init and PIO-mode setting etc.=0A=
  * Almost the entire ide.c is used for the rest of the Etrax ATA driver.=0A=
@@ -45,18 +45,13 @@=0A=
 =0A=
 #define IDE_REGISTER_TIMEOUT 300=0A=
 =0A=
-#ifdef CONFIG_ETRAX_IDE_CSE1_16_RESET=0A=
-/* address where the memory-mapped IDE reset bit lives, if used */=0A=
-static volatile unsigned long *reset_addr;=0A=
-#endif=0A=
-=0A=
 static int e100_read_command =3D 0;=0A=
 =0A=
 #define LOWDB(x)=0A=
 #define D(x)=0A=
 =0A=
 void=0A=
-etrax100_ide_outw(unsigned short data, ide_ioreg_t reg) {=0A=
+etrax100_ide_outw(unsigned short data, unsigned long reg) {=0A=
 	int timeleft;=0A=
 	LOWDB(printk("ow: data 0x%x, reg 0x%x\n", data, reg));=0A=
 =0A=
@@ -89,7 +84,7 @@=0A=
 }=0A=
 =0A=
 void=0A=
-etrax100_ide_outb(unsigned char data, ide_ioreg_t reg)=0A=
+etrax100_ide_outb(unsigned char data, unsigned long reg)=0A=
 {=0A=
 	etrax100_ide_outw(data, reg);=0A=
 }=0A=
@@ -101,7 +96,7 @@=0A=
 }=0A=
 =0A=
 unsigned short=0A=
-etrax100_ide_inw(ide_ioreg_t reg) {=0A=
+etrax100_ide_inw(unsigned long reg) {=0A=
 	int status;=0A=
 	int timeleft;=0A=
 =0A=
@@ -149,7 +144,7 @@=0A=
 }=0A=
 =0A=
 unsigned char=0A=
-etrax100_ide_inb(ide_ioreg_t reg)=0A=
+etrax100_ide_inb(unsigned long reg)=0A=
 {=0A=
 	return (unsigned char)etrax100_ide_inw(reg);=0A=
 }=0A=
@@ -336,14 +331,14 @@=0A=
 =0A=
 #ifdef CONFIG_ETRAX_IDE_G27_RESET=0A=
         REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow, 27, 0);=0A=
-#endif=0A=
+#endif =0A=
 #ifdef CONFIG_ETRAX_IDE_CSE1_16_RESET=0A=
         REG_SHADOW_SET(port_cse1_addr, port_cse1_shadow, 16, 0);=0A=
 #endif=0A=
 #ifdef CONFIG_ETRAX_IDE_CSP0_8_RESET=0A=
         REG_SHADOW_SET(port_csp0_addr, port_csp0_shadow, 8, 0);=0A=
 #endif=0A=
-#ifdef CONFIG_ETRAX_IDE_PB7_RESET=0A=
+#ifdef CONFIG_ETRAX_IDE_PB7_RESET =0A=
 	port_pb_dir_shadow =3D port_pb_dir_shadow |=0A=
 		IO_STATE(R_PORT_PB_DIR, dir7, output);=0A=
 	*R_PORT_PB_DIR =3D port_pb_dir_shadow;=0A=
@@ -424,7 +419,7 @@=0A=
 static void=0A=
 e100_atapi_input_bytes (ide_drive_t *drive, void *buffer, unsigned int =
bytecount)=0A=
 {=0A=
-	ide_ioreg_t data_reg =3D IDE_DATA_REG;=0A=
+	unsigned long data_reg =3D IDE_DATA_REG;=0A=
 =0A=
 	D(printk("atapi_input_bytes, dreg 0x%x, buffer 0x%x, count %d\n",=0A=
 		 data_reg, buffer, bytecount));=0A=
@@ -503,7 +498,7 @@=0A=
 static void=0A=
 e100_atapi_output_bytes (ide_drive_t *drive, void *buffer, unsigned int =
bytecount)=0A=
 {=0A=
-	ide_ioreg_t data_reg =3D IDE_DATA_REG;=0A=
+	unsigned long data_reg =3D IDE_DATA_REG;=0A=
 =0A=
 	D(printk("atapi_output_bytes, dreg 0x%x, buffer 0x%x, count %d\n",=0A=
 		 data_reg, buffer, bytecount));=0A=
@@ -563,7 +558,7 @@=0A=
                 IO_STATE(R_ATA_CTRL_DATA, dma_size, word);=0A=
 =0A=
         LED_DISK_WRITE(1);=0A=
-=0A=
+ =0A=
         /* Etrax will set busy =3D 1 until the multi pio transfer has =
finished=0A=
          * and tr_rdy =3D 1 after each successful word transfer.=0A=
          * When the last byte has been transferred Etrax will first set =
tr_tdy =3D 1=0A=
@@ -811,7 +806,7 @@=0A=
 			ide_set_handler(drive, &etrax_dma_intr, WAIT_CMD, NULL);=0A=
 =0A=
 			/* issue cmd to drive */=0A=
-                        if ((HWGROUP(drive)->rq->cmd =3D=3D =
IDE_DRIVE_TASKFILE) &&=0A=
+                        if ((HWGROUP(drive)->rq->flags & =
REQ_DRIVE_TASKFILE) &&=0A=
 			    (drive->addressing =3D=3D 1)) {=0A=
 				ide_task_t *args =3D HWGROUP(drive)->rq->special;=0A=
 				etrax100_ide_outb(args->tfRegister[IDE_COMMAND_OFFSET], =
IDE_COMMAND_REG);=0A=
@@ -869,7 +864,7 @@=0A=
 			ide_set_handler(drive, &etrax_dma_intr, WAIT_CMD, NULL);=0A=
 =0A=
 			/* issue cmd to drive */=0A=
-			if ((HWGROUP(drive)->rq->cmd =3D=3D IDE_DRIVE_TASKFILE) &&=0A=
+			if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&=0A=
 			    (drive->addressing =3D=3D 1)) {=0A=
 				ide_task_t *args =3D HWGROUP(drive)->rq->special;=0A=
 				etrax100_ide_outb(args->tfRegister[IDE_COMMAND_OFFSET], =
IDE_COMMAND_REG);=0A=

------=_NextPart_000_01D4_01C4C0E4.E514F950--

