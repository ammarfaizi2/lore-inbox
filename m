Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbUKBPK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbUKBPK6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbUKBN5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:57:12 -0500
Received: from [212.209.10.221] ([212.209.10.221]:18900 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S262905AbUKBNE5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:04:57 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: [PATCH 2/10] CRIS architecture update - Drivers
Date: Tue, 2 Nov 2004 14:04:33 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C7486@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01CE_01C4C0E4.E0EA6270"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01CE_01C4C0E4.E0EA6270
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Patches for the simple character based drivers. 

Signed-Off-By: starvik@axis.com

/Mikael

------=_NextPart_000_01CE_01C4C0E4.E0EA6270
Content-Type: application/octet-stream;
	name="cris269_2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cris269_2.patch"

diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/drivers/axisflashmap.c =
lx25/arch/cris/arch-v10/drivers/axisflashmap.c=0A=
--- ../linux/arch/cris/arch-v10/drivers/axisflashmap.c	Mon Oct 18 =
23:54:54 2004=0A=
+++ lx25/arch/cris/arch-v10/drivers/axisflashmap.c	Mon Aug 16 14:37:22 =
2004=0A=
@@ -11,6 +11,9 @@=0A=
  * partition split defined below.=0A=
  *=0A=
  * $Log: axisflashmap.c,v $=0A=
+ * Revision 1.10  2004/08/16 12:37:22  starvik=0A=
+ * Merge of Linux 2.6.8=0A=
+ *=0A=
  * Revision 1.8  2004/05/14 07:58:03  starvik=0A=
  * Merge of changes from 2.4=0A=
  *=0A=
@@ -153,6 +156,14 @@=0A=
 #define FLASH_CACHED_ADDR    KSEG_F=0A=
 #endif=0A=
 =0A=
+#if CONFIG_ETRAX_FLASH_BUSWIDTH=3D=3D1=0A=
+#define flash_data __u8=0A=
+#elif CONFIG_ETRAX_FLASH_BUSWIDTH=3D=3D2=0A=
+#define flash_data __u16=0A=
+#elif CONFIG_ETRAX_FLASH_BUSWIDTH=3D=3D4=0A=
+#define flash_data __u16=0A=
+#endif=0A=
+=0A=
 /* From head.S */=0A=
 extern unsigned long romfs_start, romfs_length, romfs_in_flash;=0A=
 =0A=
@@ -161,19 +172,11 @@=0A=
 =0A=
 /* Map driver functions. */=0A=
 =0A=
-static __u8 flash_read8(struct map_info *map, unsigned long ofs)=0A=
-{=0A=
-	return *(__u8 *)(map->map_priv_1 + ofs);=0A=
-}=0A=
-=0A=
-static __u16 flash_read16(struct map_info *map, unsigned long ofs)=0A=
+static map_word flash_read(struct map_info *map, unsigned long ofs)=0A=
 {=0A=
-	return *(__u16 *)(map->map_priv_1 + ofs);=0A=
-}=0A=
-=0A=
-static __u32 flash_read32(struct map_info *map, unsigned long ofs)=0A=
-{=0A=
-	return *(volatile unsigned int *)(map->map_priv_1 + ofs);=0A=
+	map_word tmp;=0A=
+	tmp.x[0] =3D *(flash_data *)(map->map_priv_1 + ofs);=0A=
+	return tmp;=0A=
 }=0A=
 =0A=
 static void flash_copy_from(struct map_info *map, void *to,=0A=
@@ -182,19 +185,9 @@=0A=
 	memcpy(to, (void *)(map->map_priv_1 + from), len);=0A=
 }=0A=
 =0A=
-static void flash_write8(struct map_info *map, __u8 d, unsigned long =
adr)=0A=
-{=0A=
-	*(__u8 *)(map->map_priv_1 + adr) =3D d;=0A=
-}=0A=
-=0A=
-static void flash_write16(struct map_info *map, __u16 d, unsigned long =
adr)=0A=
-{=0A=
-	*(__u16 *)(map->map_priv_1 + adr) =3D d;=0A=
-}=0A=
-=0A=
-static void flash_write32(struct map_info *map, __u32 d, unsigned long =
adr)=0A=
+static void flash_write(struct map_info *map, map_word d, unsigned long =
adr)=0A=
 {=0A=
-	*(__u32 *)(map->map_priv_1 + adr) =3D d;=0A=
+	*(flash_data *)(map->map_priv_1 + adr) =3D (flash_data)d.x[0];=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -215,14 +208,10 @@=0A=
 static struct map_info map_cse0 =3D {=0A=
 	.name =3D "cse0",=0A=
 	.size =3D MEM_CSE0_SIZE,=0A=
-	.buswidth =3D CONFIG_ETRAX_FLASH_BUSWIDTH,=0A=
-	.read8 =3D flash_read8,=0A=
-	.read16 =3D flash_read16,=0A=
-	.read32 =3D flash_read32,=0A=
+	.bankwidth =3D CONFIG_ETRAX_FLASH_BUSWIDTH,=0A=
+	.read =3D flash_read,=0A=
 	.copy_from =3D flash_copy_from,=0A=
-	.write8 =3D flash_write8,=0A=
-	.write16 =3D flash_write16,=0A=
-	.write32 =3D flash_write32,=0A=
+	.write =3D flash_write,=0A=
 	.map_priv_1 =3D FLASH_UNCACHED_ADDR=0A=
 };=0A=
 =0A=
@@ -235,14 +224,10 @@=0A=
 static struct map_info map_cse1 =3D {=0A=
 	.name =3D "cse1",=0A=
 	.size =3D MEM_CSE1_SIZE,=0A=
-	.buswidth =3D CONFIG_ETRAX_FLASH_BUSWIDTH,=0A=
-	.read8 =3D flash_read8,=0A=
-	.read16 =3D flash_read16,=0A=
-	.read32 =3D flash_read32,=0A=
+	.bankwidth =3D CONFIG_ETRAX_FLASH_BUSWIDTH,=0A=
+	.read =3D flash_read,=0A=
 	.copy_from =3D flash_copy_from,=0A=
-	.write8 =3D flash_write8,=0A=
-	.write16 =3D flash_write16,=0A=
-	.write32 =3D flash_write32,=0A=
+	.write =3D flash_write,=0A=
 	.map_priv_1 =3D FLASH_UNCACHED_ADDR + MEM_CSE0_SIZE=0A=
 };=0A=
 =0A=
=0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/drivers/ds1302.c =
lx25/arch/cris/arch-v10/drivers/ds1302.c=0A=
--- ../linux/arch/cris/arch-v10/drivers/ds1302.c	Mon Oct 18 23:55:07 2004=0A=
+++ lx25/arch/cris/arch-v10/drivers/ds1302.c	Tue Aug 24 08:48:43 2004=0A=
@@ -7,6 +7,9 @@=0A=
 *! Functions exported: ds1302_readreg, ds1302_writereg, ds1302_init=0A=
 *!=0A=
 *! $Log: ds1302.c,v $=0A=
+*! Revision 1.14  2004/08/24 06:48:43  starvik=0A=
+*! Whitespace cleanup=0A=
+*!=0A=
 *! Revision 1.13  2004/05/28 09:26:59  starvik=0A=
 *! Modified I2C initialization to work in 2.6.=0A=
 *!=0A=
@@ -123,7 +126,7 @@=0A=
 *!=0A=
 *! (C) Copyright 1999, 2000, 2001  Axis Communications AB, LUND, SWEDEN=0A=
 *!=0A=
-*! $Id: ds1302.c,v 1.13 2004/05/28 09:26:59 starvik Exp $=0A=
+*! $Id: ds1302.c,v 1.14 2004/08/24 06:48:43 starvik Exp $=0A=
 *!=0A=
 =
*!***********************************************************************=
****/=0A=
 =0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/drivers/gpio.c =
lx25/arch/cris/arch-v10/drivers/gpio.c=0A=
--- ../linux/arch/cris/arch-v10/drivers/gpio.c	Mon Oct 18 23:53:06 2004=0A=
+++ lx25/arch/cris/arch-v10/drivers/gpio.c	Tue Aug 24 09:19:59 2004=0A=
@@ -1,4 +1,4 @@=0A=
-/* $Id: gpio.c,v 1.11 2004/05/14 07:58:03 starvik Exp $=0A=
+/* $Id: gpio.c,v 1.12 2004/08/24 07:19:59 starvik Exp $=0A=
  *=0A=
  * Etrax general port I/O device=0A=
  *=0A=
@@ -9,6 +9,9 @@=0A=
  *             Johan Adolfsson  (read/set directions, write, port G)=0A=
  *=0A=
  * $Log: gpio.c,v $=0A=
+ * Revision 1.12  2004/08/24 07:19:59  starvik=0A=
+ * Whitespace cleanup=0A=
+ *=0A=
  * Revision 1.11  2004/05/14 07:58:03  starvik=0A=
  * Merge of changes from 2.4=0A=
  *=0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/drivers/i2c.c =
lx25/arch/cris/arch-v10/drivers/i2c.c=0A=
--- ../linux/arch/cris/arch-v10/drivers/i2c.c	Mon Oct 18 23:53:11 2004=0A=
+++ lx25/arch/cris/arch-v10/drivers/i2c.c	Tue Aug 24 08:49:14 2004=0A=
@@ -12,6 +12,12 @@=0A=
 *!                                 don't use PB_I2C if DS1302 uses same =
bits,=0A=
 *!                                 use PB.=0A=
 *! $Log: i2c.c,v $=0A=
+*! Revision 1.9  2004/08/24 06:49:14  starvik=0A=
+*! Whitespace cleanup=0A=
+*!=0A=
+*! Revision 1.8  2004/06/08 08:48:26  starvik=0A=
+*! Removed unused code=0A=
+*!=0A=
 *! Revision 1.7  2004/05/28 09:26:59  starvik=0A=
 *! Modified I2C initialization to work in 2.6.=0A=
 *!=0A=
@@ -69,7 +75,7 @@=0A=
 *! (C) Copyright 1999-2002 Axis Communications AB, LUND, SWEDEN=0A=
 *!=0A=
 =
*!***********************************************************************=
****/=0A=
-/* $Id: i2c.c,v 1.7 2004/05/28 09:26:59 starvik Exp $ */=0A=
+/* $Id: i2c.c,v 1.9 2004/08/24 06:49:14 starvik Exp $ */=0A=
 =0A=
 /****************** INCLUDE FILES SECTION =
***********************************/=0A=
 =0A=
@@ -110,14 +116,6 @@=0A=
 #define I2C_DATA_HIGH 1=0A=
 #define I2C_DATA_LOW 0=0A=
 =0A=
-#if 0=0A=
-/* TODO: fix this so the CONFIG_ETRAX_I2C_USES... is set in Config.in =
instead */=0A=
-#if defined(CONFIG_DS1302) && (CONFIG_DS1302_SDABIT=3D=3D0) && \=0A=
-           (CONFIG_DS1302_SCLBIT =3D=3D 1)=0A=
-#define CONFIG_ETRAX_I2C_USES_PB_NOT_PB_I2C=0A=
-#endif=0A=
-#endif=0A=
-=0A=
 #ifdef CONFIG_ETRAX_I2C_USES_PB_NOT_PB_I2C=0A=
 /* Use PB and not PB_I2C */=0A=
 #ifndef CONFIG_ETRAX_I2C_DATA_PORT=0A=
@@ -441,7 +439,7 @@=0A=
 	 */=0A=
 	i2c_data(I2C_DATA_HIGH);=0A=
 	i2c_delay(CLOCK_LOW_TIME);=0A=
-	=0A=
+=0A=
 	i2c_dir_in();=0A=
 }=0A=
 =0A=
@@ -472,7 +470,7 @@=0A=
 	i2c_delay(CLOCK_HIGH_TIME);=0A=
 	i2c_clk(I2C_CLOCK_LOW);=0A=
 	i2c_delay(CLOCK_LOW_TIME);=0A=
-=0A=
+	=0A=
 	i2c_dir_in();=0A=
 }=0A=
 =0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/drivers/pcf8563.c =
lx25/arch/cris/arch-v10/drivers/pcf8563.c=0A=
--- ../linux/arch/cris/arch-v10/drivers/pcf8563.c	Mon Oct 18 23:53:46 =
2004=0A=
+++ lx25/arch/cris/arch-v10/drivers/pcf8563.c	Tue Aug 24 08:42:51 2004=0A=
@@ -15,7 +15,7 @@=0A=
  *=0A=
  * Author: Tobias Anderberg <tobiasa@axis.com>.=0A=
  *=0A=
- * $Id: pcf8563.c,v 1.4 2004/05/28 09:26:59 starvik Exp $=0A=
+ * $Id: pcf8563.c,v 1.8 2004/08/24 06:42:51 starvik Exp $=0A=
  */=0A=
 =0A=
 #include <linux/config.h>=0A=
@@ -40,7 +40,7 @@=0A=
 #define PCF8563_MAJOR 121		/* Local major number. */=0A=
 #define DEVICE_NAME "rtc"		/* Name which is registered in =
/proc/devices. */=0A=
 #define PCF8563_NAME "PCF8563"=0A=
-#define DRIVER_VERSION "$Revision: 1.4 $"=0A=
+#define DRIVER_VERSION "$Revision: 1.8 $"=0A=
 =0A=
 /* I2C bus slave registers. */=0A=
 #define RTC_I2C_READ		0xa3=0A=
@@ -295,7 +295,7 @@=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-static int __init=0A=
+static int __init =0A=
 pcf8563_register(void)=0A=
 {=0A=
 	pcf8563_init();=0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/drivers/serial.c =
lx25/arch/cris/arch-v10/drivers/serial.c=0A=
--- ../linux/arch/cris/arch-v10/drivers/serial.c	Mon Oct 18 23:54:38 2004=0A=
+++ lx25/arch/cris/arch-v10/drivers/serial.c	Wed Sep 29 12:33:49 2004=0A=
@@ -1,4 +1,4 @@=0A=
-/* $Id: serial.c,v 1.20 2004/05/24 12:00:20 starvik Exp $=0A=
+/* $Id: serial.c,v 1.25 2004/09/29 10:33:49 starvik Exp $=0A=
  *=0A=
  * Serial port driver for the ETRAX 100LX chip=0A=
  *=0A=
@@ -7,6 +7,20 @@=0A=
  *    Many, many authors. Based once upon a time on serial.c for 16x50.=0A=
  *=0A=
  * $Log: serial.c,v $=0A=
+ * Revision 1.25  2004/09/29 10:33:49  starvik=0A=
+ * Resolved a dealock when printing debug from kernel.=0A=
+ *=0A=
+ * Revision 1.24  2004/08/27 23:25:59  johana=0A=
+ * rs_set_termios() must call change_speed() if c_iflag has changed or=0A=
+ * automatic XOFF handling will be enabled and transmitter will stop=0A=
+ * if 0x13 is received.=0A=
+ *=0A=
+ * Revision 1.23  2004/08/24 06:57:13  starvik=0A=
+ * More whitespace cleanup=0A=
+ *=0A=
+ * Revision 1.22  2004/08/24 06:12:20  starvik=0A=
+ * Whitespace cleanup=0A=
+ *=0A=
  * Revision 1.20  2004/05/24 12:00:20  starvik=0A=
  * Big merge of stuff from Linux 2.4 (e.g. manual mode for the serial =
port).=0A=
  *=0A=
@@ -409,7 +423,7 @@=0A=
  *=0A=
  */=0A=
 =0A=
-static char *serial_version =3D "$Revision: 1.20 $";=0A=
+static char *serial_version =3D "$Revision: 1.25 $";=0A=
 =0A=
 #include <linux/config.h>=0A=
 #include <linux/version.h>=0A=
@@ -647,7 +661,7 @@=0A=
 #ifdef CONFIG_ETRAX_SERIAL_PORT3=0A=
 | IO_MASK(R_IRQ_MASK1_RD, ser3_data) | IO_MASK(R_IRQ_MASK1_RD, =
ser3_ready)=0A=
 #endif=0A=
-;=0A=
+; =0A=
 unsigned long r_alt_ser_baudrate_shadow =3D 0;=0A=
 =0A=
 /* this is the data for the four serial ports in the etrax100 */=0A=
@@ -2541,7 +2555,7 @@=0A=
 			DFLOW(DEBUG_LOG(info->line,"flush_to_flip throttles again! %lu\n", =
max_flip_size));=0A=
 			rs_throttle(tty);=0A=
 		}=0A=
-#endif=0A=
+#endif	=0A=
 	}=0A=
 =0A=
 	if (max_flip_size > TTY_FLIPBUF_SIZE)=0A=
@@ -2560,7 +2574,7 @@=0A=
 		length +=3D count;=0A=
 		info->recv_cnt -=3D count;=0A=
 		DFLIP(DEBUG_LOG(info->line,"flip: %i\n", length));=0A=
-=0A=
+	=0A=
 		if (count =3D=3D buffer->length) {=0A=
 			info->first_recv_buffer =3D buffer->next;=0A=
 			kfree(buffer);=0A=
@@ -3460,7 +3474,7 @@=0A=
 			u16 divisor =3D info->custom_divisor;=0A=
 			/* R_SERIAL_PRESCALE (upper 16 bits of R_CLOCK_PRESCALE) */=0A=
 			/* baudrate is 3.125MHz/custom_divisor */=0A=
-			alt_source =3D=0A=
+			alt_source =3D =0A=
 				IO_STATE(R_ALT_SER_BAUDRATE, ser0_rec, prescale) |=0A=
 				IO_STATE(R_ALT_SER_BAUDRATE, ser0_tr, prescale);=0A=
 			alt_source =3D 0x11;=0A=
@@ -3684,7 +3698,7 @@=0A=
 		up(&tmp_buf_sem);=0A=
 	} else {=0A=
 		cli();	=0A=
-		while (1) {=0A=
+		while (count) {=0A=
 			c =3D CIRC_SPACE_TO_END(info->xmit.head,=0A=
 					      info->xmit.tail,=0A=
 					      SERIAL_XMIT_SIZE);=0A=
@@ -3980,12 +3994,12 @@=0A=
 	=0A=
 	if (info->count > 1)=0A=
 		return -EBUSY;=0A=
-	=0A=
+=0A=
 	/*=0A=
 	 * OK, past this point, all the error checking has been done.=0A=
 	 * At this point, we start making changes.....=0A=
 	 */=0A=
-	=0A=
+=0A=
 	info->baud_base =3D new_serial.baud_base;=0A=
 	info->flags =3D ((info->flags & ~ASYNC_FLAGS) |=0A=
 		       (new_serial.flags & ASYNC_FLAGS));=0A=
@@ -4252,7 +4266,8 @@=0A=
 {=0A=
 	struct e100_serial *info =3D (struct e100_serial *)tty->driver_data;=0A=
 =0A=
-	if (tty->termios->c_cflag =3D=3D old_termios->c_cflag)=0A=
+	if (tty->termios->c_cflag =3D=3D old_termios->c_cflag &&=0A=
+	    tty->termios->c_iflag =3D=3D old_termios->c_iflag)=0A=
 		return;=0A=
 =0A=
 	change_speed(info);=0A=
@@ -4276,6 +4291,7 @@=0A=
 static int rs_debug_write_function(int i, const char *buf, unsigned int =
len)=0A=
 {=0A=
 	int cnt;=0A=
+	int written =3D 0;=0A=
         struct tty_struct *tty;=0A=
         static int recurse_cnt =3D 0;=0A=
 =0A=
@@ -4287,14 +4303,17 @@=0A=
 =0A=
 		local_irq_save(flags);=0A=
 		recurse_cnt++;=0A=
+		local_irq_restore(flags);=0A=
                 do {=0A=
-                        cnt =3D rs_write(tty, 0, buf, len);=0A=
+                        cnt =3D rs_write(tty, 0, buf + written, len);=0A=
                         if (cnt >=3D 0) {=0A=
+				written +=3D cnt;=0A=
                                 buf +=3D cnt;=0A=
                                 len -=3D cnt;=0A=
                         } else=0A=
                                 len =3D cnt;=0A=
                 } while(len > 0);=0A=
+		local_irq_save(flags);=0A=
 		recurse_cnt--;=0A=
 		local_irq_restore(flags);=0A=
                 return 1;=0A=

------=_NextPart_000_01CE_01C4C0E4.E0EA6270--

