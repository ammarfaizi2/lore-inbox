Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130779AbQK1VSE>; Tue, 28 Nov 2000 16:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131061AbQK1VR4>; Tue, 28 Nov 2000 16:17:56 -0500
Received: from web.sajt.cz ([212.71.160.9]:62985 "EHLO web.sajt.cz")
        by vger.kernel.org with ESMTP id <S130779AbQK1VRi>;
        Tue, 28 Nov 2000 16:17:38 -0500
Date: Tue, 28 Nov 2000 21:44:59 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mad16 old OSS config
Message-ID: <Pine.LNX.4.21.0011282138540.30061-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following patch is removing old config stuff which probably survived from
OSS.

Pavel Rabel

--- linux/drivers/sound/mad16.c.old	Tue Nov 28 20:34:52 2000
+++ linux/drivers/sound/mad16.c	Tue Nov 28 20:47:05 2000
@@ -20,38 +20,6 @@
  * issues of the card, using the OTI-605 chip, have an MPU-401 compatable Midi
  * port. This port is configured differently to that of the OPTi audio chips.
  *
- * NOTE! If you want to set CD-ROM address and/or joystick enable, define
- *       MAD16_CONF in local.h as combination of the following bits:
- *
- *      0x01    - joystick disabled
- *
- *      CD-ROM type selection (select just one):
- *      0x00    - none
- *      0x02    - Sony 31A
- *      0x04    - Mitsumi
- *      0x06    - Panasonic (type "LaserMate", not "Sound Blaster")
- *      0x08    - Secondary IDE (address 0x170)
- *      0x0a    - Primary IDE (address 0x1F0)
- *      
- *      For example Mitsumi with joystick disabled = 0x04|0x01 = 0x05
- *      For example LaserMate (for use with sbpcd) plus joystick = 0x06
- *      
- *    MAD16_CDSEL:
- *      This defaults to CD I/O 0x340, no IRQ and DMA3 
- *      (DMA5 with Mitsumi or IDE). If you like to change these, define
- *      MAD16_CDSEL with the following bits:
- *
- *      CD-ROM port: 0x00=340, 0x40=330, 0x80=360 or 0xc0=320
- *      OPL4 select: 0x20=OPL4, 0x00=OPL3
- *      CD-ROM irq: 0x00=disabled, 0x04=IRQ5, 0x08=IRQ7, 0x0c=IRQ3, 0x10=IRQ9,
- *                  0x14=IRQ10 and 0x18=IRQ11.
- *
- *      CD-ROM DMA (Sony or Panasonic): 0x00=DMA3, 0x01=DMA2, 0x02=DMA1 or 0x03=disabled
- *   or
- *      CD-ROM DMA (Mitsumi or IDE):    0x00=DMA5, 0x01=DMA6, 0x02=DMA7 or 0x03=disabled
- *
- *      For use with sbpcd, address 0x340, set MAD16_CDSEL to 0x03 or 0x23.
- *
  *	Changes
  *	
  *	Alan Cox		Clean up, added module selections.
@@ -67,6 +35,8 @@
  *								25-Nov-1999
  *	Christoph Hellwig	Adapted to module_init/module_exit.
  *	Arnaldo C. de Melo	got rid of attach_uart401       21-Sep-2000
+ *
+ *	Pavel Rabel		Clean up                           Nov-2000
  */
 
 #include <linux/config.h>
@@ -395,10 +365,6 @@
 {
 	unsigned char cfg = 0;
 
-#ifdef MAD16_CONF
-	cfg |= (0x0f & MAD16_CONF);
-#endif
-
 	if(c931_detected)
 	{
 		/* Bit 0 has reversd meaning. Bits 1 and 2 sese
@@ -435,14 +401,9 @@
 	/* bit 2 of MC4 reverses it's meaning between the C930
 	   and the C931. */
 	cfg = c931_detected ? 0x04 : 0x00;
-#ifdef MAD16_CDSEL
-	if(MAD16_CDSEL & 0x20)
-		mad_write(MC4_PORT, 0x62|cfg);	/* opl4 */
-	else
-		mad_write(MC4_PORT, 0x52|cfg);	/* opl3 */
-#else
+
 	mad_write(MC4_PORT, 0x52|cfg);
-#endif
+
 	mad_write(MC5_PORT, 0x3C);	/* Init it into mode2 */
 	mad_write(MC6_PORT, 0x02);	/* Enable WSS, Disable MPU and SB */
 	mad_write(MC7_PORT, 0xCB);
@@ -590,20 +551,9 @@
 	 */
 
 	tmp &= ~0x0f;
-#if defined(MAD16_CONF)
-	tmp |= ((MAD16_CONF) & 0x0f);	/* CD-ROM and joystick bits */
-#endif
 	mad_write(MC1_PORT, tmp);
 
-#if defined(MAD16_CONF) && defined(MAD16_CDSEL)
-	tmp = MAD16_CDSEL;
-#else
 	tmp = mad_read(MC2_PORT);
-#endif
-
-#ifdef MAD16_OPL4
-	tmp |= 0x20;		/* Enable OPL4 access */
-#endif
 
 	mad_write(MC2_PORT, tmp);
 	mad_write(MC3_PORT, 0xf0);	/* Disable SB */

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
