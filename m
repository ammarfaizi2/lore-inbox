Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUHWPHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUHWPHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUHWPHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:07:17 -0400
Received: from [212.209.10.220] ([212.209.10.220]:50852 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264917AbUHWPCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:02:01 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] CRIS architecture update
Date: Mon, 23 Aug 2004 17:01:59 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F50E@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains changes related to drivers.

 * IDE driver compiles for >= 2.4.21
 * Fixed kernel debug console problems (random lockups)

diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/drivers/ds1302.c
linux/arch/cris/drivers/ds1302.c
--- ../linux/arch/cris/drivers/ds1302.c	Mon Jan  5 14:53:56 2004
+++ linux/arch/cris/drivers/ds1302.c	Wed Jan  7 10:49:08 2004
@@ -7,6 +7,9 @@
 *! Functions exported: ds1302_readreg, ds1302_writereg, ds1302_init
 *!
 *! $Log: ds1302.c,v $
+*! Revision 1.20  2004/01/07 09:49:08  starvik
+*! Merge of Linux 2.4.24
+*!
 *! Revision 1.19  2003/06/12 08:02:05  johana
 *! Removed faulty comma from printk.
 *! Fixed warning () -> (void)
@@ -108,7 +111,7 @@
 *!
 *! (C) Copyright 1999, 2000, 2001  Axis Communications AB, LUND, SWEDEN
 *!
-*! $Id: ds1302.c,v 1.19 2003/06/12 08:02:05 johana Exp $
+*! $Id: ds1302.c,v 1.20 2004/01/07 09:49:08 starvik Exp $
 *!
 
*!**************************************************************************
*/
 
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/drivers/eeprom.c
linux/arch/cris/drivers/eeprom.c
--- ../linux/arch/cris/drivers/eeprom.c	Sun Aug  8 01:26:04 2004
+++ linux/arch/cris/drivers/eeprom.c	Mon Aug 16 15:21:48 2004
@@ -20,6 +20,9 @@
 *!                                  in the spin-lock.
 *!
 *!  $Log: eeprom.c,v $
+*!  Revision 1.13  2004/08/16 13:21:48  starvik
+*!  Merge of Linux 2.4.27
+*!
 *!  Revision 1.12  2003/04/09 08:31:14  pkj
 *!  Typo correction (taken from Linux 2.5).
 *!
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/drivers/i2c.c
linux/arch/cris/drivers/i2c.c
--- ../linux/arch/cris/drivers/i2c.c	Mon Aug 25 13:44:39 2003
+++ linux/arch/cris/drivers/i2c.c	Tue Jun  8 10:47:54 2004
@@ -18,6 +18,9 @@
 *|                                 was high, causing DS75 to see  a stop
condition
 *|
 *! $Log: i2c.c,v $
+*! Revision 1.13  2004/06/08 08:47:54  starvik
+*! Removed unused code
+*!
 *! Revision 1.12  2003/06/23 14:43:47  oskarp
 *! * i2c_sendnack is added.
 *!   - i2c_readreg now generates nack on last received byte, instead of
ack.
@@ -72,7 +75,7 @@
 *! (C) Copyright 1999-2002 Axis Communications AB, LUND, SWEDEN
 *!
 
*!**************************************************************************
*/
-/* $Id: i2c.c,v 1.12 2003/06/23 14:43:47 oskarp Exp $ */
+/* $Id: i2c.c,v 1.13 2004/06/08 08:47:54 starvik Exp $ */
 /****************** INCLUDE FILES SECTION
***********************************/
 
 #include <linux/module.h>
@@ -112,14 +115,6 @@
 #define I2C_DATA_HIGH 1
 #define I2C_DATA_LOW 0
 
-#if 0
-/* TODO: fix this so the CONFIG_ETRAX_I2C_USES... is set in Config.in
instead */
-#if defined(CONFIG_DS1302) && (CONFIG_DS1302_SDABIT==0) && \
-           (CONFIG_DS1302_SCLBIT == 1)
-#define CONFIG_ETRAX_I2C_USES_PB_NOT_PB_I2C
-#endif
-#endif
-
 #ifdef CONFIG_ETRAX_I2C_USES_PB_NOT_PB_I2C
 /* Use PB and not PB_I2C */
 #ifndef CONFIG_ETRAX_I2C_DATA_PORT
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/drivers/ide.c
linux/arch/cris/drivers/ide.c
--- ../linux/arch/cris/drivers/ide.c	Mon Aug 25 13:44:39 2003
+++ linux/arch/cris/drivers/ide.c	Tue Jun  8 10:50:36 2004
@@ -1,4 +1,4 @@
-/* $Id: ide.c,v 1.30 2003/07/08 07:24:47 pkj Exp $
+/* $Id: ide.c,v 1.32 2004/06/08 08:50:36 starvik Exp $
  *
  * Etrax specific IDE functions, like init and PIO-mode setting etc.
  * Almost the entire ide.c is used for the rest of the Etrax ATA driver.
@@ -8,6 +8,12 @@
  *             Mikael Starvik     (pio setup stuff)
  *
  * $Log: ide.c,v $
+ * Revision 1.32  2004/06/08 08:50:36  starvik
+ * Removed unused code
+ *
+ * Revision 1.31  2004/01/21 12:14:05  starvik
+ * Updated for >= Linux 2.4.21
+ *
  * Revision 1.30  2003/07/08 07:24:47  pkj
  * Corrected spelling mistakes originally found in 2.5.x
  *
@@ -159,20 +165,15 @@
 
 #define IDE_REGISTER_TIMEOUT 300
 
-#ifdef CONFIG_ETRAX_IDE_CSE1_16_RESET
-/* address where the memory-mapped IDE reset bit lives, if used */
-static volatile unsigned long *reset_addr;
-#endif
-
 static int e100_read_command = 0;
 
 #define LOWDB(x)
 #define D(x) 
 
 void 
-OUT_BYTE(unsigned char data, ide_ioreg_t reg) {
+etrax100_ide_outw(unsigned short data, ide_ioreg_t reg) {
 	int timeleft;
-	LOWDB(printk("ob: data 0x%x, reg 0x%x\n", data, reg));
+	LOWDB(printk("ow: data 0x%x, reg 0x%x\n", data, reg));
 
 	/* note the lack of handling any timeouts. we stop waiting, but we
don't
 	 * really notify anybody.
@@ -202,8 +203,20 @@
 		timeleft--;
 }
 
-unsigned short 
-IN_BYTE(ide_ioreg_t reg) {
+void
+etrax100_ide_outb(unsigned char data, ide_ioreg_t reg)
+{
+	etrax100_ide_outw(data, reg);
+}
+
+void
+etrax100_ide_outbsync(ide_drive_t *drive, u8 addr, unsigned long port)
+{
+	etrax100_ide_outw(addr, port);
+}
+
+unsigned short
+etrax100_ide_inw(ide_ioreg_t reg) {
 	int status;
 	int timeleft;
 
@@ -247,7 +260,13 @@
 
 	LOWDB(printk("inb: 0x%x from reg 0x%x\n", status & 0xff, reg));
 
-        return (unsigned char)status;
+        return (unsigned short)status;
+}
+
+unsigned char
+etrax100_ide_inb(ide_ioreg_t reg)
+{
+	return (unsigned char)etrax100_ide_inw(reg);
 }
 
 /* PIO timing (in R_ATA_CONFIG)
@@ -311,6 +330,8 @@
 static void e100_ide_output_data (ide_drive_t *drive, void *, unsigned
int);
 static void e100_atapi_input_bytes(ide_drive_t *drive, void *, unsigned
int);
 static void e100_atapi_output_bytes(ide_drive_t *drive, void *, unsigned
int);
+static int e100_dma_off (ide_drive_t *drive);
+static int e100_dma_verbose (ide_drive_t *drive);
 
 /*
  * good_dma_drives() lists the model names (from "hdparm -i")
@@ -386,6 +407,7 @@
 	
 	for(h = 0; h < MAX_HWIFS; h++) {
 		ide_hwif_t *hwif = &ide_hwifs[h];
+		hwif->mmio = 2;
 		hwif->chipset = ide_etrax100;
 		hwif->tuneproc = &tune_e100_ide;
                 hwif->ata_input_data = &e100_ide_input_data;
@@ -397,6 +419,13 @@
 		hwif->ide_dma_write = &e100_dma_write;
 		hwif->ide_dma_read = &e100_dma_read;
 		hwif->ide_dma_begin = &e100_dma_begin;
+		hwif->OUTB = &etrax100_ide_outb;
+		hwif->OUTW = &etrax100_ide_outw;
+		hwif->OUTBSYNC = &etrax100_ide_outbsync;
+		hwif->INB = &etrax100_ide_inb;
+		hwif->INW = &etrax100_ide_inw;
+		hwif->ide_dma_off_quietly = &e100_dma_off;
+		hwif->ide_dma_verbose = &e100_dma_verbose;
 	}
 
 	/* actually reset and configure the etrax100 ide/ata interface */
@@ -484,6 +513,18 @@
 
 }
 
+static int e100_dma_off (ide_drive_t *drive)
+{
+	return 0;  
+}
+
+static int e100_dma_verbose (ide_drive_t *drive)
+{
+	printk(", DMA(mode 2)");
+	return 0;
+}
+
+
 static etrax_dma_descr mydescr;
 
 /*
@@ -729,7 +770,7 @@
 		*/
 
 		if(ata_tot_size + size > 131072) {
-			printk("too large total ATA DMA request, %d +
%d!\n", ata_tot_size, size);
+			printk("too large total ATA DMA request, %d +
%d!\n", ata_tot_size, (int)size);
 			return 1;
 		}
 
@@ -873,11 +914,11 @@
                         if ((HWGROUP(drive)->rq->cmd == IDE_DRIVE_TASKFILE)
&&
 			    (drive->addressing == 1)) {
 				ide_task_t *args =
HWGROUP(drive)->rq->special;
-
OUT_BYTE(args->tfRegister[IDE_COMMAND_OFFSET], IDE_COMMAND_REG);
+
etrax100_ide_outb(args->tfRegister[IDE_COMMAND_OFFSET], IDE_COMMAND_REG);
 			} else if (drive->addressing) {
-				OUT_BYTE(WIN_READDMA_EXT, IDE_COMMAND_REG);
+				etrax100_ide_outb(WIN_READDMA_EXT,
IDE_COMMAND_REG);
 			} else {
-				OUT_BYTE(WIN_READDMA, IDE_COMMAND_REG);
+				etrax100_ide_outb(WIN_READDMA,
IDE_COMMAND_REG);
 			}
 		}
 
@@ -931,11 +972,11 @@
 			if ((HWGROUP(drive)->rq->cmd == IDE_DRIVE_TASKFILE)
&&
 			    (drive->addressing == 1)) {
 				ide_task_t *args =
HWGROUP(drive)->rq->special;
-
OUT_BYTE(args->tfRegister[IDE_COMMAND_OFFSET], IDE_COMMAND_REG);
+
etrax100_ide_outb(args->tfRegister[IDE_COMMAND_OFFSET], IDE_COMMAND_REG);
 			} else if (drive->addressing) {
-				OUT_BYTE(WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
+				etrax100_ide_outb(WIN_WRITEDMA_EXT,
IDE_COMMAND_REG);
 			} else {
-				OUT_BYTE(WIN_WRITEDMA, IDE_COMMAND_REG);
+				etrax100_ide_outb(WIN_WRITEDMA,
IDE_COMMAND_REG);
 			}
 		}
 
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/drivers/pcf8563.c
linux/arch/cris/drivers/pcf8563.c
--- ../linux/arch/cris/drivers/pcf8563.c	Mon Jan  5 14:53:56 2004
+++ linux/arch/cris/drivers/pcf8563.c	Wed Jan  7 10:49:08 2004
@@ -38,7 +38,7 @@
 #define PCF8563_MAJOR	121	/* Local major number. */
 #define DEVICE_NAME	"rtc"	/* Name which is registered in
/proc/devices. */
 #define PCF8563_NAME	"PCF8563"
-#define DRIVER_VERSION	"$Revision: 1.15 $"
+#define DRIVER_VERSION	"$Revision: 1.16 $"
 
 /* Two simple wrapper macros, saves a few keystrokes. */
 #define rtc_read(x) i2c_readreg(RTC_I2C_READ, x)
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/drivers/serial.c
linux/arch/cris/drivers/serial.c
--- ../linux/arch/cris/drivers/serial.c	Wed Feb 18 14:36:30 2004
+++ linux/arch/cris/drivers/serial.c	Mon Aug 23 09:58:20 2004
@@ -1,4 +1,4 @@
-/* $Id: serial.c,v 1.58 2003/08/29 17:32:50 johana Exp $
+/* $Id: serial.c,v 1.64 2004/08/23 07:58:20 anderstj Exp $
  *
  * Serial port driver for the ETRAX 100LX chip
  *
@@ -7,6 +7,28 @@
  *    Many, many authors. Based once upon a time on serial.c for 16x50.
  *
  * $Log: serial.c,v $
+ * Revision 1.64  2004/08/23 07:58:20  anderstj
+ * Corrected switching of send/receive when using the LTC-chip.
+ *
+ * Revision 1.63  2004/06/23 16:56:41  anderstj
+ * Check rs485.enabled before setting the bit in PORT G as some
applications
+ * use the TIOCSERSETRS485 ioctl to disable the RS485 with the enablebit.
+ *
+ * Revision 1.62  2004/03/30 16:03:57  anderstj
+ * LTC1387 DXEN and RXEN high for both RS232 and RS485 mode.
+ * Changed name of config-option to CONFIG_ETRAX_LTC1387.
+ *
+ * Revision 1.61  2004/03/05 11:56:35  anderstj
+ * Removed debug output when enabling RS485
+ *
+ * Revision 1.60  2004/02/24 09:16:33  anderstj
+ * Use bit in G-port to enable/disable RS485.
+ * Set DXEN and RXEN in LTC1387.
+ *
+ * Revision 1.59  2004/01/27 11:48:12  starvik
+ * Added rs_debug_write_function to make it possible for other kernel code
+ * to put characters into the transmit queue. Used by the printk driver.
+ *
  * Revision 1.58  2003/08/29 17:32:50  johana
  * Fixed CMSPAR (Mark/Space) support. CMSPAR|PARODD = Mark(1) parity.
  *
@@ -455,7 +477,7 @@
  *
  */
 
-static char *serial_version = "$Revision: 1.58 $";
+static char *serial_version = "$Revision: 1.64 $";
 
 #include <linux/config.h>
 #include <linux/version.h>
@@ -509,6 +531,10 @@
 #error "Disable either ETRAX_SERIAL_FLUSH_DMA_FAST or ETRAX_FAST_TIMER"
 #endif
 
+#if defined(CONFIG_ETRAX_RS485_ON_PA) &&
defined(CONFIG_ETRAX_RS485_ON_PORT_G)
+#error "Disable either CONFIG_ETRAX_RS485_ON_PA or
CONFIG_ETRAX_RS485_ON_PORT_G"
+#endif
+
 /*
  * All of the compatibilty code so we can compile serial.c against
  * older kernels is hidden in serial_compat.h
@@ -895,6 +921,9 @@
 #if defined(CONFIG_ETRAX_RS485_ON_PA)
 static int rs485_pa_bit = CONFIG_ETRAX_RS485_ON_PA_BIT;
 #endif
+#if defined(CONFIG_ETRAX_RS485_ON_PORT_G)
+static int rs485_port_g_bit = CONFIG_ETRAX_RS485_ON_PORT_G_BIT;
+#endif
 #endif
 
 /* Info and macros needed for each ports extra control/status signals. */
@@ -1325,11 +1354,6 @@
 };
 #endif /* !CONFIG_ETRAX_SERX_DTR_RI_DSR_CD_MIXED */
 
-#if defined(CONFIG_ETRAX_RS485) && defined(CONFIG_ETRAX_RS485_ON_PA)
-unsigned char rs485_pa_port = CONFIG_ETRAX_RS485_ON_PA_BIT;
-#endif
-
-
 #define E100_RTS_MASK 0x20
 #define E100_CTS_MASK 0x40
 
@@ -1859,7 +1883,6 @@
 #if defined(CONFIG_ETRAX_RS485_ON_PA)	
 	*R_PORT_PA_DATA = port_pa_data_shadow |= (1 << rs485_pa_bit);
 #endif
-
 	info->rs485.rts_on_send = 0x01 & r->rts_on_send;
 	info->rs485.rts_after_sent = 0x01 & r->rts_after_sent;
 	if (r->delay_rts_before_send >= 1000)
@@ -1867,12 +1890,39 @@
 	else
 		info->rs485.delay_rts_before_send =
r->delay_rts_before_send;
 	info->rs485.enabled = r->enabled;
+#if defined(CONFIG_ETRAX_RS485_ON_PORT_G)
+	if(info->rs485.enabled) {
+	  REG_SHADOW_SET(R_PORT_G_DATA,  port_g_data_shadow,  
+			 rs485_port_g_bit, 1);
+	} else {
+	  REG_SHADOW_SET(R_PORT_G_DATA,  port_g_data_shadow,  
+			 rs485_port_g_bit, 0);
+	}
+#endif
+#if defined(CONFIG_ETRAX_LTC1387)
+	/* Set to receive mode */
+	if (info->line == 2) {
+		if(info->rs485.enabled) {
+			REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
+				       CONFIG_ETRAX_LTC1387_DXEN_PORT_G_BIT,

+				       0);
+		} else {
+			REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
+				       CONFIG_ETRAX_LTC1387_DXEN_PORT_G_BIT,

+				       1);
+		}
+		
+		REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
+			       CONFIG_ETRAX_LTC1387_RXEN_PORT_G_BIT, 
+			       1);
+	}
+#endif
 /*	printk("rts: on send = %i, after = %i, enabled = %i",
 		    info->rs485.rts_on_send,
 		    info->rs485.rts_after_sent,
 		    info->rs485.enabled
 	);
-*/		
+*/
 	return 0;
 }
 
@@ -3867,6 +3917,17 @@
 		del_fast_timer(&fast_timers_rs485[info->line]);
 #endif
 		e100_rts(info, info->rs485.rts_on_send);
+#if defined(CONFIG_ETRAX_LTC1387)
+	/* Set to transmit mode */
+		if (info->line == 2) {
+			REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
+				       CONFIG_ETRAX_LTC1387_DXEN_PORT_G_BIT,

+				       1);
+			REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
+				       CONFIG_ETRAX_LTC1387_RXEN_PORT_G_BIT,

+				       0);
+		}
+#endif
 #if defined(CONFIG_ETRAX_RS485_DISABLE_RECEIVER)
 		e100_disable_rx(info);
 		e100_disable_rx_irq(info);
@@ -3904,6 +3965,17 @@
 		}while (!(val & TIOCSER_TEMT));
 
 		e100_rts(info, info->rs485.rts_after_sent);
+#if defined(CONFIG_ETRAX_LTC1387)
+	/* Set to receive mode */
+		if (info->line == 2) {
+			REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
+				       CONFIG_ETRAX_LTC1387_DXEN_PORT_G_BIT,

+				       0);
+			REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
+				       CONFIG_ETRAX_LTC1387_RXEN_PORT_G_BIT,

+				       1);
+		}
+#endif
 	
 #if defined(CONFIG_ETRAX_RS485_DISABLE_RECEIVER)
 		e100_enable_rx(info);
@@ -4482,6 +4554,42 @@
 	
 }
 
+/* In debugport.c - register a console write function that uses the normal
+ * serial driver 
+ */
+typedef int (*debugport_write_function)(int i, const char *buf, unsigned
int len);
+
+extern debugport_write_function debug_write_function;
+
+static int rs_debug_write_function(int i, const char *buf, unsigned int
len)
+{
+	int cnt;
+        struct tty_struct *tty;
+        static int recurse_cnt = 0;
+
+        tty = rs_table[i].tty;
+        if (tty)  {
+		unsigned long flags;
+		if (recurse_cnt > 5) /* We skip this debug output */
+			return 1;
+
+		local_irq_save(flags); 		
+		recurse_cnt++;
+                do {
+                        cnt = rs_write(tty, 0, buf, len);
+                        if (cnt >= 0) {
+                                buf += cnt;
+                                len -= cnt;
+                        } else
+                                len = cnt;
+                } while(len > 0);
+		recurse_cnt--;
+		local_irq_restore(flags);
+                return 1;
+        }
+        return 0;
+}
+
 /*
  * ------------------------------------------------------------
  * rs_close()
@@ -4603,6 +4711,20 @@
 #if defined(CONFIG_ETRAX_RS485_ON_PA)
 		*R_PORT_PA_DATA = port_pa_data_shadow &= ~(1 <<
rs485_pa_bit);
 #endif
+#if defined(CONFIG_ETRAX_RS485_ON_PORT_G)
+		REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,  
+			       rs485_port_g_bit, 0);
+#endif
+#if defined(CONFIG_ETRAX_LTC1387)
+		if (info->line == 2) {
+			REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
+				       CONFIG_ETRAX_LTC1387_DXEN_PORT_G_BIT,

+				       0);
+			REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
+				       CONFIG_ETRAX_LTC1387_RXEN_PORT_G_BIT,

+				       0);
+		}
+#endif
 	}
 #endif
 }
@@ -4904,6 +5026,17 @@
 	DFLIP(	if (info->line == SERIAL_DEBUG_LINE) {
 			info->icount.rx = 0;
 		} );
+#if defined(CONFIG_ETRAX_LTC1387)
+	/*
+	 * Set DXEN and RXEN to enable transceiver for LTC1387
+	 */
+	if (info->line == 2) {
+		REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
+			       CONFIG_ETRAX_LTC1387_DXEN_PORT_G_BIT, 1);
+		REG_SHADOW_SET(R_PORT_G_DATA, port_g_data_shadow,
+			       CONFIG_ETRAX_LTC1387_RXEN_PORT_G_BIT, 1);
+	}
+#endif
 	
 	return 0;
 }
@@ -5255,7 +5388,7 @@
 	}
 #endif
 #endif /* CONFIG_SVINTO_SIM */
-
+	debug_write_function = rs_debug_write_function;
 	return 0;
 }
 
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/drivers/sync_serial.c
linux/arch/cris/drivers/sync_serial.c
--- ../linux/arch/cris/drivers/sync_serial.c	Wed Feb 18 14:36:30 2004
+++ linux/arch/cris/drivers/sync_serial.c	Thu Mar 11 13:55:04 2004
@@ -709,6 +709,19 @@
 		SETS(gen_config_ii_shadow, R_GEN_CONFIG_II, sermode1, sync);
 
 	*R_GEN_CONFIG_II = gen_config_ii_shadow;
+	/* Reset DMA. At readout from serial port the data could be shifted
+	 * one byte if not resetting DMA.
+	 */
+	if (port->use_dma) {
+		if (port->port_nbr == 0) {
+			RESET_DMA(9);
+			WAIT_DMA(9);
+		} else {
+			RESET_DMA(5);
+			WAIT_DMA(5);
+		}
+		start_dma_in(port);
+	}
 	restore_flags(flags);	
 	return return_val;
 }
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/kernel/debugport.c
linux/arch/cris/kernel/debugport.c
--- ../linux/arch/cris/kernel/debugport.c	Mon Aug 25 13:44:39 2003
+++ linux/arch/cris/kernel/debugport.c	Thu Aug 19 11:43:07 2004
@@ -1,6 +1,6 @@
 /* Serialport functions for debugging
  *
- * Copyright (c) 2000 Axis Communications AB
+ * Copyright (c) 2000-2004 Axis Communications AB
  *
  * Authors:  Bjorn Wesen
  *
@@ -12,6 +12,26 @@
  *    init_etrax_debug()
  *
  * $Log: debugport.c,v $
+ * Revision 1.14  2004/08/19 09:43:07  pkj
+ * * Fixed a compiler warning.
+ * * Removed __init from start_port() as it is called from a non-init
+ *   function.
+ *
+ * Revision 1.13  2004/08/17 11:04:55  starvik
+ * Make sure everything is setup correctly before accessing serial port.
+ * Makes it possible to ramboot a developer board LX again.
+ *
+ * Revision 1.12  2004/01/30 07:23:32  starvik
+ * Disable IRQs in console_write
+ *
+ * Revision 1.11  2004/01/27 12:43:29  starvik
+ * Disable serial port DMAs
+ *
+ * Revision 1.10  2004/01/27 11:45:38  starvik
+ * Removed all the ugly DMA hacks to make it work when the serial port
driver
+ * is interrupt driven. Now uses the real serial port driver if available
+ * (fallbacks to manual mode).
+ *
  * Revision 1.9  2003/02/17 07:10:34  starvik
  * Last merge was incomplete
  *
@@ -47,172 +67,162 @@
 #include <asm/system.h>
 #include <asm/svinto.h>
 #include <asm/io.h>             /* Get SIMCOUT. */
+#include <asm/hardirq.h>
 
 /* Which serial-port is our debug port ? */
 
 #if defined(CONFIG_ETRAX_DEBUG_PORT0) ||
defined(CONFIG_ETRAX_DEBUG_PORT_NULL)
 #define DEBUG_PORT_IDX 0
-#define DEBUG_OCMD R_DMA_CH6_CMD
-#define DEBUG_FIRST R_DMA_CH6_FIRST
-#define DEBUG_OCLRINT R_DMA_CH6_CLR_INTR
-#define DEBUG_STATUS R_DMA_CH6_STATUS
 #define DEBUG_READ R_SERIAL0_READ
 #define DEBUG_WRITE R_SERIAL0_TR_DATA
+#define DEBUG_XOFF R_SERIAL0_XOFF
+#define DEBUG_BAUD R_SERIAL0_BAUD
 #define DEBUG_TR_CTRL R_SERIAL0_TR_CTRL
 #define DEBUG_REC_CTRL R_SERIAL0_REC_CTRL
 #define DEBUG_IRQ IO_STATE(R_IRQ_MASK1_SET, ser0_data, set)
-#define DEBUG_DMA_IRQ_CLR IO_STATE(R_IRQ_MASK2_CLR, dma6_descr, clr)
 #endif
 
 #ifdef CONFIG_ETRAX_DEBUG_PORT1
 #define DEBUG_PORT_IDX 1
-#define DEBUG_OCMD R_DMA_CH8_CMD
-#define DEBUG_FIRST R_DMA_CH8_FIRST
-#define DEBUG_OCLRINT R_DMA_CH8_CLR_INTR
-#define DEBUG_STATUS R_DMA_CH8_STATUS
 #define DEBUG_READ R_SERIAL1_READ
 #define DEBUG_WRITE R_SERIAL1_TR_DATA
+#define DEBUG_XOFF R_SERIAL1_XOFF
+#define DEBUG_BAUD R_SERIAL1_BAUD
 #define DEBUG_TR_CTRL R_SERIAL1_TR_CTRL
 #define DEBUG_REC_CTRL R_SERIAL1_REC_CTRL
 #define DEBUG_IRQ IO_STATE(R_IRQ_MASK1_SET, ser1_data, set)
-#define DEBUG_DMA_IRQ_CLR IO_STATE(R_IRQ_MASK2_CLR, dma8_descr, clr)
 #endif
 
 #ifdef CONFIG_ETRAX_DEBUG_PORT2
 #define DEBUG_PORT_IDX 2
-#define DEBUG_OCMD R_DMA_CH2_CMD
-#define DEBUG_FIRST R_DMA_CH2_FIRST
-#define DEBUG_OCLRINT R_DMA_CH2_CLR_INTR
-#define DEBUG_STATUS R_DMA_CH2_STATUS
 #define DEBUG_READ R_SERIAL2_READ
 #define DEBUG_WRITE R_SERIAL2_TR_DATA
+#define DEBUG_XOFF R_SERIAL2_XOFF
+#define DEBUG_BAUD R_SERIAL2_BAUD
 #define DEBUG_TR_CTRL R_SERIAL2_TR_CTRL
 #define DEBUG_REC_CTRL R_SERIAL2_REC_CTRL
 #define DEBUG_IRQ IO_STATE(R_IRQ_MASK1_SET, ser2_data, set)
-#define DEBUG_DMA_IRQ_CLR IO_STATE(R_IRQ_MASK2_CLR, dma2_descr, clr)
 #endif
 
 #ifdef CONFIG_ETRAX_DEBUG_PORT3
 #define DEBUG_PORT_IDX 3
-#define DEBUG_OCMD R_DMA_CH4_CMD
-#define DEBUG_FIRST R_DMA_CH4_FIRST
-#define DEBUG_OCLRINT R_DMA_CH4_CLR_INTR
-#define DEBUG_STATUS R_DMA_CH4_STATUS
 #define DEBUG_READ R_SERIAL3_READ
 #define DEBUG_WRITE R_SERIAL3_TR_DATA
+#define DEBUG_XOFF R_SERIAL3_XOFF
+#define DEBUG_BAUD R_SERIAL3_BAUD
 #define DEBUG_TR_CTRL R_SERIAL3_TR_CTRL
 #define DEBUG_REC_CTRL R_SERIAL3_REC_CTRL
 #define DEBUG_IRQ IO_STATE(R_IRQ_MASK1_SET, ser3_data, set)
-#define DEBUG_DMA_IRQ_CLR IO_STATE(R_IRQ_MASK2_CLR, dma4_descr, clr)
 #endif
 
-#define MIN_SIZE 32 /* Size that triggers the FIFO to flush characters to
interface */
-
-/* Write a string of count length to the console (debug port) using DMA,
polled
- * for completion. Interrupts are disabled during the whole process. Some
- * caution needs to be taken to not interfere with ttyS business on this
port.
+/* Used by serial.c to register a debug_write_function so that the normal
+ * serial driver is used for kernel debug output
  */
+typedef int (*debugport_write_function)(int i, const char *buf, unsigned
int len);
+
+debugport_write_function debug_write_function = NULL;
+
+static void
+start_port(void)
+{
+	static int started = 0;
+
+	if (started)
+		return;
+	started = 1;
+
+#if DEBUG_PORT_IDX == 0
+	genconfig_shadow &= ~IO_MASK(R_GEN_CONFIG, dma6);
+	genconfig_shadow |= IO_STATE(R_GEN_CONFIG, dma6, unused);
+#elif DEBUG_PORT_IDX == 1
+	genconfig_shadow &= ~IO_MASK(R_GEN_CONFIG, dma8);
+	genconfig_shadow |= IO_STATE(R_GEN_CONFIG, dma8, usb);
+#elif DEBUG_PORT_IDX == 2
+	genconfig_shadow &= ~IO_MASK(R_GEN_CONFIG, dma2);
+	genconfig_shadow |= IO_STATE(R_GEN_CONFIG, dma2, par0);
+	genconfig_shadow &= ~IO_MASK(R_GEN_CONFIG, dma3);
+	genconfig_shadow |= IO_STATE(R_GEN_CONFIG, dma3, par0);
+	genconfig_shadow |= IO_STATE(R_GEN_CONFIG, ser2, select);
+#elif DEBUG_PORT_IDX == 3
+	genconfig_shadow &= ~IO_MASK(R_GEN_CONFIG, dma4);
+	genconfig_shadow |= IO_STATE(R_GEN_CONFIG, dma4, par1);
+	genconfig_shadow &= ~IO_MASK(R_GEN_CONFIG, dma5);
+	genconfig_shadow |= IO_STATE(R_GEN_CONFIG, dma5, par1);
+        genconfig_shadow |= IO_STATE(R_GEN_CONFIG, ser3, select);
+#endif
+	*R_GEN_CONFIG = genconfig_shadow;
+
+	*DEBUG_XOFF =
+		IO_STATE(R_SERIAL0_XOFF, tx_stop, enable) |
+		IO_STATE(R_SERIAL0_XOFF, auto_xoff, disable) |
+		IO_FIELD(R_SERIAL0_XOFF, xoff_char, 0);
+	*DEBUG_BAUD =
+		IO_STATE(R_SERIAL0_BAUD, tr_baud, c115k2Hz) |
+		IO_STATE(R_SERIAL0_BAUD, rec_baud, c115k2Hz);
+	*DEBUG_REC_CTRL =
+		IO_STATE(R_SERIAL0_REC_CTRL, dma_err, stop) |
+		IO_STATE(R_SERIAL0_REC_CTRL, rec_enable, enable) |
+		IO_STATE(R_SERIAL0_REC_CTRL, rts_, active) |
+		IO_STATE(R_SERIAL0_REC_CTRL, sampling, middle) |
+		IO_STATE(R_SERIAL0_REC_CTRL, rec_stick_par, normal) |
+		IO_STATE(R_SERIAL0_REC_CTRL, rec_par, even) |
+		IO_STATE(R_SERIAL0_REC_CTRL, rec_par_en, disable) |
+		IO_STATE(R_SERIAL0_REC_CTRL, rec_bitnr, rec_8bit);
+	*DEBUG_TR_CTRL =
+		IO_FIELD(R_SERIAL0_TR_CTRL, txd, 0) |
+		IO_STATE(R_SERIAL0_TR_CTRL, tr_enable, enable) |
+		IO_STATE(R_SERIAL0_TR_CTRL, auto_cts, disabled) |
+		IO_STATE(R_SERIAL0_TR_CTRL, stop_bits, one_bit) |
+		IO_STATE(R_SERIAL0_TR_CTRL, tr_stick_par, normal) |
+		IO_STATE(R_SERIAL0_TR_CTRL, tr_par, even) |
+		IO_STATE(R_SERIAL0_TR_CTRL, tr_par_en, disable) |
+		IO_STATE(R_SERIAL0_TR_CTRL, tr_bitnr, tr_8bit);
+}
+
+static void
+console_write_direct(struct console *co, const char *buf, unsigned int len)
+{
+	int i;
+
+	/* Send data */
+	for (i = 0; i < len; i++) {
+		/* Wait until transmitter is ready and send.*/
+		while (!(*DEBUG_READ & IO_MASK(R_SERIAL0_READ, tr_ready)))
+			;
+		*DEBUG_WRITE = buf[i];
+	}
+}
 
-static void 
+static void
 console_write(struct console *co, const char *buf, unsigned int len)
 {
-	static struct etrax_dma_descr descr;
-	static struct etrax_dma_descr descr2;
-	static char tmp_buf[MIN_SIZE];
-	static int tmp_size = 0;
+	unsigned long flags;
 
-	unsigned long flags; 
-	
 #ifdef CONFIG_ETRAX_DEBUG_PORT_NULL
-        /* no debug printout at all */
-        return;
+	/* no debug printout at all */
+	return;
 #endif
 
 #ifdef CONFIG_SVINTO_SIM
 	/* no use to simulate the serial debug output */
-	SIMCOUT(buf,len);
+	SIMCOUT(buf, len);
 	return;
 #endif
-	
-	save_flags(flags);
-	cli();
+
+	start_port();
 
 #ifdef CONFIG_ETRAX_KGDB
 	/* kgdb needs to output debug info using the gdb protocol */
 	putDebugString(buf, len);
-	restore_flags(flags);
 	return;
 #endif
-	/* To make this work together with the real serial port driver
-	 * we have to make sure that everything is flushed when we leave
-	 * here. The following steps are made to assure this:
-	 * 1. Wait until DMA stops, FIFO is empty and serial port pipeline
empty.
-	 * 2. Write at least half the FIFO to trigger flush to serial port.
-	 * 3. Wait until DMA stops, FIFO is empty and serial port pipeline
empty.
-         */
-
-	/* Do we have enough characters to make the DMA/FIFO happy? */
-	if (tmp_size + len < MIN_SIZE)
-	{
-		int size = min((int)(MIN_SIZE - tmp_size),(int)len);
-		memcpy(&tmp_buf[tmp_size], buf, size);
-		tmp_size += size;
-		len -= size;
-        
-		/* Pad with space if complete line */
-		if (tmp_buf[tmp_size-1] == '\n')
-		{
-			memset(&tmp_buf[tmp_size-1], ' ', MIN_SIZE -
tmp_size);
-			tmp_buf[MIN_SIZE - 1] = '\n';
-			tmp_size = MIN_SIZE;
-			len = 0;
-		}
-		else
-		{
-                  /* Wait for more characters */
-			restore_flags(flags);
-			return;
-		}
-	}
 
-	/* make sure the transmitter is enabled. 
-	 * NOTE: this overrides any setting done in ttySx, to 8N1, no
auto-CTS.
-	 * in the future, move the tr/rec_ctrl shadows from etrax100ser.c to
-	 * shadows.c and use it here as well...
-	 */
-
-	*DEBUG_TR_CTRL = 0x40;
-	while(*DEBUG_OCMD & 7); /* Until DMA is not running */
-	while(*DEBUG_STATUS & 0x7f); /* wait until output FIFO is empty as
well */
-	udelay(200); /* Wait for last two characters to leave the serial
transmitter */
-
-	if (tmp_size)
-	{
-		descr.ctrl = len ?  0 : d_eop | d_wait | d_eol;
-		descr.sw_len = tmp_size;
-		descr.buf = virt_to_phys(tmp_buf);
-		descr.next = virt_to_phys(&descr2);
-		descr2.ctrl = d_eop | d_wait | d_eol;
-		descr2.sw_len = len;
-		descr2.buf = virt_to_phys((char*)buf);
-	}
-	else
-	{
-		descr.ctrl = d_eop | d_wait | d_eol;
-		descr.sw_len = len;
-		descr.buf = virt_to_phys((char*)buf);
-	}
-
-	*DEBUG_FIRST = virt_to_phys(&descr); /* write to R_DMAx_FIRST */
-	*DEBUG_OCMD = 1;       /* dma command start -> R_DMAx_CMD */
-
-	/* wait until the output dma channel is ready again */
-	while(*DEBUG_OCMD & 7);
-	while(*DEBUG_STATUS & 0x7f);
-	udelay(200);
-
-	tmp_size = 0;
-	restore_flags(flags);
+	local_irq_save(flags);
+	if (debug_write_function)
+		if (debug_write_function(co->index, buf, len))
+			return;
+	console_write_direct(co, buf, len);
+	local_irq_restore(flags);
 }
 
 /* legacy function */
@@ -229,10 +239,10 @@
 getDebugChar(void)
 {
 	unsigned long readval;
-	
+
 	do {
 		readval = *DEBUG_READ;
-	} while(!(readval & IO_MASK(R_SERIAL0_READ, data_avail)));
+	} while (!(readval & IO_MASK(R_SERIAL0_READ, data_avail)));
 
 	return (readval & IO_MASK(R_SERIAL0_READ, data_in));
 }
@@ -242,8 +252,8 @@
 void
 putDebugChar(int val)
 {
-	while(!(*DEBUG_READ & IO_MASK(R_SERIAL0_READ, tr_ready))) ;
-;
+	while (!(*DEBUG_READ & IO_MASK(R_SERIAL0_READ, tr_ready)))
+		;
 	*DEBUG_WRITE = val;
 }
 
@@ -261,23 +271,23 @@
 	*DEBUG_REC_CTRL = IO_STATE(R_SERIAL0_REC_CTRL, rec_enable, enable);
 }
 
-static kdev_t 
+static kdev_t
 console_device(struct console *c)
 {
          return MKDEV(TTY_MAJOR, 64 + c->index);
 }
 
-static int __init 
+static int __init
 console_setup(struct console *co, char *options)
 {
         return 0;
 }
 
 static struct console sercons = {
-        name : "ttyS",
-        write: console_write,
-        read : NULL,
-        device : console_device,
+	name : "ttyS",
+	write: console_write,
+	read : NULL,
+	device : console_device,
 	unblank : NULL,
 	setup : console_setup,
 	flags : CON_PRINTBUFFER,
@@ -290,7 +300,7 @@
  *      Register console (for printk's etc)
  */
 
-void __init 
+void __init
 init_etrax_debug(void)
 {
 	register_console(&sercons);

