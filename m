Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVCMQjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVCMQjx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 11:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVCMQjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 11:39:53 -0500
Received: from coderock.org ([193.77.147.115]:34774 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261361AbVCMQe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 11:34:29 -0500
From: Domen Puncer <domen@coderock.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, emoenke@gwdg.de, linux@rainbow-software.org,
       domen@coderock.org
In-Reply-To: <20050313163330.171476@nd47.coderock.org>
X-Mailer: Domen's patchbomb
Subject: Re: [patch 1/3] cdrom/cdu31a update
Message-Id: <20050313163332.449F31E3D8@trashy.coderock.org>
Date: Sun, 13 Mar 2005 17:33:32 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pretty trivial cleanups:
- reordered #includes
- improved some printk's (note: this actually enabled some debug printk's)
- removed ()'s from returns
- removed SONY_POLL_EACH_BYTE, as grep doesn't find it anywhere else
- removed panic() as it can't happen.


Signed-off-by: Domen Puncer <domen@coderock.org>
Acked-by: Ondrej Zary <linux@rainbow-software.org>

--- ./drivers/cdrom/cdu31a.c.orig	2005-03-06 15:55:44.000000000 +0100
+++ ./drivers/cdrom/cdu31a.c	2005-03-13 14:10:32.000000000 +0100
@@ -148,10 +148,10 @@
  *			Ondrej Zary <rainbow@rainbow-software.org>
 */
 
-#include <linux/major.h>
+#define DEBUG 1
 
+#include <linux/major.h>
 #include <linux/module.h>
-
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -166,13 +166,13 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/cdrom.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/dma.h>
 
-#include <linux/cdrom.h>
 #include "cdu31a.h"
 
 #define MAJOR_NR CDU31A_CDROM_MAJOR
@@ -180,10 +180,7 @@
 
 #define CDU31A_MAX_CONSECUTIVE_ATTENTIONS 10
 
-#define DEBUG 1
-
-/* Define the following if you have data corruption problems. */
-#undef SONY_POLL_EACH_BYTE
+#define PFX "CDU31A: "
 
 /*
 ** Edit the following data to change interrupts, DMA channels, etc.
@@ -397,37 +394,37 @@ static inline void sony_sleep(void)
  */
 static inline int is_attention(void)
 {
-	return ((inb(sony_cd_status_reg) & SONY_ATTN_BIT) != 0);
+	return (inb(sony_cd_status_reg) & SONY_ATTN_BIT) != 0;
 }
 
 static inline int is_busy(void)
 {
-	return ((inb(sony_cd_status_reg) & SONY_BUSY_BIT) != 0);
+	return (inb(sony_cd_status_reg) & SONY_BUSY_BIT) != 0;
 }
 
 static inline int is_data_ready(void)
 {
-	return ((inb(sony_cd_status_reg) & SONY_DATA_RDY_BIT) != 0);
+	return (inb(sony_cd_status_reg) & SONY_DATA_RDY_BIT) != 0;
 }
 
 static inline int is_data_requested(void)
 {
-	return ((inb(sony_cd_status_reg) & SONY_DATA_REQUEST_BIT) != 0);
+	return (inb(sony_cd_status_reg) & SONY_DATA_REQUEST_BIT) != 0;
 }
 
 static inline int is_result_ready(void)
 {
-	return ((inb(sony_cd_status_reg) & SONY_RES_RDY_BIT) != 0);
+	return (inb(sony_cd_status_reg) & SONY_RES_RDY_BIT) != 0;
 }
 
 static inline int is_param_write_rdy(void)
 {
-	return ((inb(sony_cd_fifost_reg) & SONY_PARAM_WRITE_RDY_BIT) != 0);
+	return (inb(sony_cd_fifost_reg) & SONY_PARAM_WRITE_RDY_BIT) != 0;
 }
 
 static inline int is_result_reg_not_empty(void)
 {
-	return ((inb(sony_cd_fifost_reg) & SONY_RES_REG_NOT_EMP_BIT) != 0);
+	return (inb(sony_cd_fifost_reg) & SONY_RES_REG_NOT_EMP_BIT) != 0;
 }
 
 static inline void reset_drive(void)
@@ -478,17 +475,17 @@ static inline void clear_param_reg(void)
 
 static inline unsigned char read_status_register(void)
 {
-	return (inb(sony_cd_status_reg));
+	return inb(sony_cd_status_reg);
 }
 
 static inline unsigned char read_result_register(void)
 {
-	return (inb(sony_cd_result_reg));
+	return inb(sony_cd_result_reg);
 }
 
 static inline unsigned char read_data_register(void)
 {
-	return (inb(sony_cd_read_reg));
+	return inb(sony_cd_read_reg);
 }
 
 static inline void write_param(unsigned char param)
@@ -534,8 +531,8 @@ static irqreturn_t cdu31a_interrupt(int 
 		wake_up(&cdu31a_irq_wait);
 	} else {
 		disable_interrupts();
-		printk
-		    ("CDU31A: Got an interrupt but nothing was waiting\n");
+		printk(KERN_NOTICE PFX
+				"Got an interrupt but nothing was waiting\n");
 	}
 	return IRQ_HANDLED;
 }
@@ -610,8 +607,8 @@ static void set_drive_params(int want_do
 	do_sony_cd_cmd(SONY_SET_DRIVE_PARAM_CMD,
 		       params, 2, res_reg, &res_size);
 	if ((res_size < 2) || ((res_reg[0] & 0xf0) == 0x20)) {
-		printk("  Unable to set spin-down time: 0x%2.2x\n",
-		       res_reg[1]);
+		printk(KERN_NOTICE PFX
+			"Unable to set spin-down time: 0x%2.2x\n", res_reg[1]);
 	}
 
 	params[0] = SONY_SD_MECH_CONTROL;
@@ -627,8 +624,8 @@ static void set_drive_params(int want_do
 	do_sony_cd_cmd(SONY_SET_DRIVE_PARAM_CMD,
 		       params, 2, res_reg, &res_size);
 	if ((res_size < 2) || ((res_reg[0] & 0xf0) == 0x20)) {
-		printk("  Unable to set mechanical parameters: 0x%2.2x\n",
-		       res_reg[1]);
+		printk(KERN_NOTICE PFX "Unable to set mechanical "
+				"parameters: 0x%2.2x\n", res_reg[1]);
 	}
 }
 
@@ -672,7 +669,7 @@ static void restart_on_error(void)
 	unsigned long retry_count;
 
 
-	printk("cdu31a: Resetting drive on error\n");
+	printk(KERN_NOTICE PFX "Resetting drive on error\n");
 	reset_drive();
 	retry_count = jiffies + SONY_RESET_TIMEOUT;
 	while (time_before(jiffies, retry_count) && (!is_attention())) {
@@ -681,7 +678,7 @@ static void restart_on_error(void)
 	set_drive_params(sony_speed);
 	do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg, &res_size);
 	if ((res_size < 2) || ((res_reg[0] & 0xf0) == 0x20)) {
-		printk("cdu31a: Unable to spin up drive: 0x%2.2x\n",
+		printk(KERN_NOTICE PFX "Unable to spin up drive: 0x%2.2x\n",
 		       res_reg[1]);
 	}
 
@@ -741,9 +738,7 @@ get_result(unsigned char *result_buffer,
 		while (handle_sony_cd_attention());
 	}
 	if (is_busy() || (!(is_result_ready()))) {
-#if DEBUG
-		printk("CDU31A timeout out %d\n", __LINE__);
-#endif
+		pr_debug(PFX "timeout out %d\n", __LINE__);
 		result_buffer[0] = 0x20;
 		result_buffer[1] = SONY_TIMEOUT_OP_ERR;
 		*result_size = 2;
@@ -794,10 +789,8 @@ get_result(unsigned char *result_buffer,
 					retry_count--;
 				}
 				if (!is_result_ready()) {
-#if DEBUG
-					printk("CDU31A timeout out %d\n",
+					pr_debug(PFX "timeout out %d\n",
 					       __LINE__);
-#endif
 					result_buffer[0] = 0x20;
 					result_buffer[1] =
 					    SONY_TIMEOUT_OP_ERR;
@@ -823,10 +816,8 @@ get_result(unsigned char *result_buffer,
 					retry_count--;
 				}
 				if (!is_result_ready()) {
-#if DEBUG
-					printk("CDU31A timeout out %d\n",
+					pr_debug(PFX "timeout out %d\n",
 					       __LINE__);
-#endif
 					result_buffer[0] = 0x20;
 					result_buffer[1] =
 					    SONY_TIMEOUT_OP_ERR;
@@ -896,9 +887,7 @@ retry_cd_operation:
 		while (handle_sony_cd_attention());
 	}
 	if (is_busy()) {
-#if DEBUG
-		printk("CDU31A timeout out %d\n", __LINE__);
-#endif
+		pr_debug(PFX "timeout out %d\n", __LINE__);
 		result_buffer[0] = 0x20;
 		result_buffer[1] = SONY_TIMEOUT_OP_ERR;
 		*result_size = 2;
@@ -945,21 +934,18 @@ static int handle_sony_cd_attention(void
 	volatile int val;
 
 
-#if 0*DEBUG
-	printk("Entering handle_sony_cd_attention\n");
+#if 0
+	pr_debug(PFX "Entering %s\n", __FUNCTION__);
 #endif
 	if (is_attention()) {
 		if (num_consecutive_attentions >
 		    CDU31A_MAX_CONSECUTIVE_ATTENTIONS) {
-			printk
-			    ("cdu31a: Too many consecutive attentions: %d\n",
-			     num_consecutive_attentions);
+			printk(KERN_NOTICE PFX "Too many consecutive "
+				"attentions: %d\n", num_consecutive_attentions);
 			num_consecutive_attentions = 0;
-#if DEBUG
-			printk("Leaving handle_sony_cd_attention at %d\n",
+			pr_debug(PFX "Leaving %s at %d\n", __FUNCTION__,
 			       __LINE__);
-#endif
-			return (0);
+			return 0;
 		}
 
 		clear_attention();
@@ -999,11 +985,8 @@ static int handle_sony_cd_attention(void
 		}
 
 		num_consecutive_attentions++;
-#if DEBUG
-		printk("Leaving handle_sony_cd_attention at %d\n",
-		       __LINE__);
-#endif
-		return (1);
+		pr_debug(PFX "Leaving %s at %d\n", __FUNCTION__, __LINE__);
+		return 1;
 	} else if (abort_read_started) {
 		while (is_result_reg_not_empty()) {
 			val = read_result_register();
@@ -1015,18 +998,15 @@ static int handle_sony_cd_attention(void
 			val = read_data_register();
 		}
 		abort_read_started = 0;
-#if DEBUG
-		printk("Leaving handle_sony_cd_attention at %d\n",
-		       __LINE__);
-#endif
-		return (1);
+		pr_debug(PFX "Leaving %s at %d\n", __FUNCTION__, __LINE__);
+		return 1;
 	}
 
 	num_consecutive_attentions = 0;
-#if 0*DEBUG
-	printk("Leaving handle_sony_cd_attention at %d\n", __LINE__);
+#if 0
+	pr_debug(PFX "Leaving %s at %d\n", __FUNCTION__, __LINE__);
 #endif
-	return (0);
+	return 0;
 }
 
 
@@ -1038,14 +1018,14 @@ static inline unsigned int int_to_bcd(un
 
 	retval = (val / 10) << 4;
 	retval = retval | val % 10;
-	return (retval);
+	return retval;
 }
 
 
 /* Convert from BCD to an integer from 0-99 */
 static unsigned int bcd_to_int(unsigned int bcd)
 {
-	return ((((bcd >> 4) & 0x0f) * 10) + (bcd & 0x0f));
+	return (((bcd >> 4) & 0x0f) * 10) + (bcd & 0x0f);
 }
 
 
@@ -1105,9 +1085,7 @@ start_request(unsigned int sector, unsig
 	unsigned long retry_count;
 
 
-#if DEBUG
-	printk("Entering start_request\n");
-#endif
+	pr_debug(PFX "Entering %s\n", __FUNCTION__);
 	log_to_msf(sector, params);
 	size_to_buf(nsect, &params[3]);
 
@@ -1125,11 +1103,10 @@ start_request(unsigned int sector, unsig
 	}
 
 	if (is_busy()) {
-		printk("CDU31A: Timeout while waiting to issue command\n");
-#if DEBUG
-		printk("Leaving start_request at %d\n", __LINE__);
-#endif
-		return (1);
+		printk(KERN_NOTICE PFX "Timeout while waiting "
+				"to issue command\n");
+		pr_debug(PFX "Leaving %s at %d\n", __FUNCTION__, __LINE__);
+		return 1;
 	} else {
 		/* Issue the command */
 		clear_result_ready();
@@ -1140,14 +1117,10 @@ start_request(unsigned int sector, unsig
 
 		sony_blocks_left = nsect * 4;
 		sony_next_block = sector * 4;
-#if DEBUG
-		printk("Leaving start_request at %d\n", __LINE__);
-#endif
-		return (0);
+		pr_debug(PFX "Leaving %s at %d\n", __FUNCTION__, __LINE__);
+		return 0;
 	}
-#if DEBUG
-	printk("Leaving start_request at %d\n", __LINE__);
-#endif
+	pr_debug(PFX "Leaving %s at %d\n", __FUNCTION__, __LINE__);
 }
 
 /* Abort a pending read operation.  Clear all the drive status variables. */
@@ -1160,7 +1133,7 @@ static void abort_read(void)
 
 	do_sony_cd_cmd(SONY_ABORT_CMD, NULL, 0, result_reg, &result_size);
 	if ((result_reg[0] & 0xf0) == 0x20) {
-		printk("CDU31A: Error aborting read, %s error\n",
+		printk(KERN_ERR PFX "Aborting read, %s error\n",
 		       translate_error(result_reg[1]));
 	}
 
@@ -1183,9 +1156,7 @@ static void handle_abort_timeout(unsigne
 {
 	unsigned long flags;
 
-#if DEBUG
-	printk("Entering handle_abort_timeout\n");
-#endif
+	pr_debug(PFX "Entering %s\n", __FUNCTION__);
 	save_flags(flags);
 	cli();
 	/* If it is in use, ignore it. */
@@ -1202,18 +1173,14 @@ static void handle_abort_timeout(unsigne
 		abort_read_started = 1;
 	}
 	restore_flags(flags);
-#if DEBUG
-	printk("Leaving handle_abort_timeout\n");
-#endif
+	pr_debug(PFX "Leaving %s\n", __FUNCTION__);
 }
 
 /* Actually get one sector of data from the drive. */
 static void
 input_data_sector(char *buffer)
 {
-#if DEBUG
-	printk("Entering input_data_sector\n");
-#endif
+	pr_debug(PFX "Entering %s\n", __FUNCTION__);
 
 	/* If an XA disk on a CDU31A, skip the first 12 bytes of data from
 	   the disk.  The real data is after that. We can use audio_buffer. */
@@ -1229,9 +1196,7 @@ input_data_sector(char *buffer)
 	if (sony_xa_mode)
 		insb(sony_cd_read_reg, audio_buffer, CD_XA_TAIL);
 
-#if DEBUG
-	printk("Leaving input_data_sector\n");
-#endif
+	pr_debug(PFX "Leaving %s\n", __FUNCTION__);
 }
 
 /* read data from the drive.  Note the nsect must be <= 4. */
@@ -1243,9 +1208,7 @@ read_data_block(char *buffer,
 {
 	unsigned long retry_count;
 
-#if DEBUG
-	printk("Entering read_data_block\n");
-#endif
+	pr_debug(PFX "Entering %s\n", __FUNCTION__);
 
 	res_reg[0] = 0;
 	res_reg[1] = 0;
@@ -1262,18 +1225,15 @@ read_data_block(char *buffer,
 		if (is_result_ready()) {
 			get_result(res_reg, res_size);
 			if ((res_reg[0] & 0xf0) != 0x20) {
-				printk
-				    ("CDU31A: Got result that should have been error: %d\n",
-				     res_reg[0]);
+				printk(KERN_NOTICE PFX "Got result that should"
+					" have been error: %d\n", res_reg[0]);
 				res_reg[0] = 0x20;
 				res_reg[1] = SONY_BAD_DATA_ERR;
 				*res_size = 2;
 			}
 			abort_read();
 		} else {
-#if DEBUG
-			printk("CDU31A timeout out %d\n", __LINE__);
-#endif
+			pr_debug(PFX "timeout out %d\n", __LINE__);
 			res_reg[0] = 0x20;
 			res_reg[1] = SONY_TIMEOUT_OP_ERR;
 			*res_size = 2;
@@ -1294,9 +1254,7 @@ read_data_block(char *buffer,
 		}
 
 		if (!is_result_ready()) {
-#if DEBUG
-			printk("CDU31A timeout out %d\n", __LINE__);
-#endif
+			pr_debug(PFX "timeout out %d\n", __LINE__);
 			res_reg[0] = 0x20;
 			res_reg[1] = SONY_TIMEOUT_OP_ERR;
 			*res_size = 2;
@@ -1315,9 +1273,8 @@ read_data_block(char *buffer,
 					SONY_RECOV_LECC_ERR_BLK_STAT)) {
 					/* nothing here */
 				} else {
-					printk
-					    ("CDU31A: Data block error: 0x%x\n",
-					     res_reg[0]);
+					printk(KERN_ERR PFX "Data block "
+						"error: 0x%x\n", res_reg[0]);
 					res_reg[0] = 0x20;
 					res_reg[1] = SONY_BAD_DATA_ERR;
 					*res_size = 2;
@@ -1330,9 +1287,8 @@ read_data_block(char *buffer,
 			} else if ((res_reg[0] & 0xf0) != 0x20) {
 				/* The drive gave me bad status, I don't know what to do.
 				   Reset the driver and return an error. */
-				printk
-				    ("CDU31A: Invalid block status: 0x%x\n",
-				     res_reg[0]);
+				printk(KERN_ERR PFX "Invalid block "
+					"status: 0x%x\n", res_reg[0]);
 				restart_on_error();
 				res_reg[0] = 0x20;
 				res_reg[1] = SONY_BAD_DATA_ERR;
@@ -1340,9 +1296,7 @@ read_data_block(char *buffer,
 			}
 		}
 	}
-#if DEBUG
-	printk("Leaving read_data_block at %d\n", __LINE__);
-#endif
+	pr_debug(PFX "Leaving %s at %d\n", __FUNCTION__, __LINE__);
 }
 
 
@@ -1361,12 +1315,9 @@ static void do_cdu31a_request(request_qu
 	unsigned int res_size;
 	unsigned long flags;
 
+	pr_debug(PFX "Entering %s\n", __FUNCTION__);
 
-#if DEBUG
-	printk("Entering do_cdu31a_request\n");
-#endif
-
-	/* 
+	/*
 	 * Make sure no one else is using the driver; wait for them
 	 * to finish if it is so.
 	 */
@@ -1376,10 +1327,8 @@ static void do_cdu31a_request(request_qu
 		interruptible_sleep_on(&sony_wait);
 		if (signal_pending(current)) {
 			restore_flags(flags);
-#if DEBUG
-			printk("Leaving do_cdu31a_request at %d\n",
+			pr_debug(PFX "Leaving %s at %d\n", __FUNCTION__,
 			       __LINE__);
-#endif
 			return;
 		}
 	}
@@ -1414,12 +1363,10 @@ static void do_cdu31a_request(request_qu
 
 		block = req->sector;
 		nblock = req->nr_sectors;
-#if DEBUG
-		printk("CDU31A: request at block %d, length %d blocks\n",
+		pr_debug(PFX "request at block %d, length %d blocks\n",
 			block, nblock);
-#endif
 		if (!sony_toc_read) {
-			printk("CDU31A: TOC not read\n");
+			printk(KERN_NOTICE PFX "TOC not read\n");
 			end_request(req, 0);
 			continue;
 		}
@@ -1431,14 +1378,13 @@ static void do_cdu31a_request(request_qu
 			end_request(req, 0);
 			continue;
 		}
-		if (rq_data_dir(req) != READ)
-			panic("CDU31A: Unknown cmd");
+
 		/*
 		 * If the block address is invalid or the request goes beyond the end of
 		 * the media, return an error.
 		 */
 		if (((block + nblock) / 4) >= sony_toc.lead_out_start_lba) {
-			printk("CDU31A: Request past end of media\n");
+			printk(KERN_NOTICE PFX "Request past end of media\n");
 			end_request(req, 0);
 			continue;
 		}
@@ -1451,7 +1397,7 @@ static void do_cdu31a_request(request_qu
 		while (handle_sony_cd_attention());
 
 		if (!sony_toc_read) {
-			printk("CDU31A: TOC not read\n");
+			printk(KERN_NOTICE PFX "TOC not read\n");
 			end_request(req, 0);
 			continue;
 		}
@@ -1468,18 +1414,16 @@ static void do_cdu31a_request(request_qu
 		   the driver, abort the current operation and start a
 		   new one. */
 		else if (block != sony_next_block) {
-#if DEBUG
-			printk("CDU31A Warning: Read for block %d, expected %d\n",
+			pr_debug(PFX "Read for block %d, expected %d\n",
 				 block, sony_next_block);
-#endif
 			abort_read();
 			if (!sony_toc_read) {
-				printk("CDU31A: TOC not read\n");
+				printk(KERN_NOTICE PFX "TOC not read\n");
 				end_request(req, 0);
 				continue;
 			}
 			if (start_request(block / 4, nblock / 4)) {
-				printk("CDU31a: start request failed\n");
+				printk(KERN_NOTICE PFX "start request failed\n");
 				end_request(req, 0);
 				continue;
 			}
@@ -1507,7 +1451,7 @@ static void do_cdu31a_request(request_qu
 			do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg,
 					&res_size);
 		} else {
-			printk("CDU31A: %s error for block %d, nblock %d\n",
+			printk(KERN_NOTICE PFX "%s error for block %d, nblock %d\n",
 				 translate_error(res_reg[1]), block, nblock);
 		}
 		goto try_read_again;
@@ -1528,9 +1472,7 @@ static void do_cdu31a_request(request_qu
 	sony_inuse = 0;
 	wake_up_interruptible(&sony_wait);
 	restore_flags(flags);
-#if DEBUG
-	printk("Leaving do_cdu31a_request at %d\n", __LINE__);
-#endif
+	pr_debug(PFX "Leaving %s at %d\n", __FUNCTION__, __LINE__);
 }
 
 
@@ -1549,9 +1491,7 @@ static void sony_get_toc(void)
 	int mint = 99;
 	int maxt = 0;
 
-#if DEBUG
-	printk("Entering sony_get_toc\n");
-#endif
+	pr_debug(PFX "Entering %s\n", __FUNCTION__);
 
 	num_spin_ups = 0;
 	if (!sony_toc_read) {
@@ -1602,16 +1542,12 @@ static void sony_get_toc(void)
 /* This seems to slow things down enough to make it work.  This
  * appears to be a problem in do_sony_cd_cmd.  This printk seems 
  * to address the symptoms...  -Erik */
-#if DEBUG
-			printk("cdu31a: Trying session %d\n", session);
-#endif
+			pr_debug(PFX "Trying session %d\n", session);
 			parms[0] = session;
 			do_sony_cd_cmd(SONY_READ_TOC_SPEC_CMD,
 				       parms, 1, res_reg, &res_size);
 
-#if DEBUG
-			printk("%2.2x %2.2x\n", res_reg[0], res_reg[1]);
-#endif
+			pr_debug(PFX "%2.2x %2.2x\n", res_reg[0], res_reg[1]);
 
 			if ((res_size < 2)
 			    || ((res_reg[0] & 0xf0) == 0x20)) {
@@ -1621,9 +1557,7 @@ static void sony_get_toc(void)
 					    ("Yikes! Couldn't read any sessions!");
 				break;
 			}
-#if DEBUG
-			printk("Reading session %d\n", session);
-#endif
+			pr_debug(PFX "Reading session %d\n", session);
 
 			parms[0] = session;
 			do_sony_cd_cmd(SONY_REQ_TOC_DATA_SPEC_CMD,
@@ -1634,8 +1568,8 @@ static void sony_get_toc(void)
 			if ((res_size < 2)
 			    || ((single_toc.exec_status[0] & 0xf0) ==
 				0x20)) {
-				printk
-				    ("cdu31a: Error reading session %d: %x %s\n",
+				printk(KERN_ERR PFX "Error reading "
+						"session %d: %x %s\n",
 				     session, single_toc.exec_status[0],
 				     translate_error(single_toc.
 						     exec_status[1]));
@@ -1643,29 +1577,27 @@ static void sony_get_toc(void)
 				   set. */
 				return;
 			}
-#if DEBUG
-			printk
-			    ("add0 %01x, con0 %01x, poi0 %02x, 1st trk %d, dsktyp %x, dum0 %x\n",
+			pr_debug(PFX "add0 %01x, con0 %01x, poi0 %02x, "
+					"1st trk %d, dsktyp %x, dum0 %x\n",
 			     single_toc.address0, single_toc.control0,
 			     single_toc.point0,
 			     bcd_to_int(single_toc.first_track_num),
 			     single_toc.disk_type, single_toc.dummy0);
-			printk
-			    ("add1 %01x, con1 %01x, poi1 %02x, lst trk %d, dummy1 %x, dum2 %x\n",
+			pr_debug(PFX "add1 %01x, con1 %01x, poi1 %02x, "
+					"lst trk %d, dummy1 %x, dum2 %x\n",
 			     single_toc.address1, single_toc.control1,
 			     single_toc.point1,
 			     bcd_to_int(single_toc.last_track_num),
 			     single_toc.dummy1, single_toc.dummy2);
-			printk
-			    ("add2 %01x, con2 %01x, poi2 %02x leadout start min %d, sec %d, frame %d\n",
+			pr_debug(PFX "add2 %01x, con2 %01x, poi2 %02x "
+				"leadout start min %d, sec %d, frame %d\n",
 			     single_toc.address2, single_toc.control2,
 			     single_toc.point2,
 			     bcd_to_int(single_toc.lead_out_start_msf[0]),
 			     bcd_to_int(single_toc.lead_out_start_msf[1]),
 			     bcd_to_int(single_toc.lead_out_start_msf[2]));
 			if (res_size > 18 && single_toc.pointb0 > 0xaf)
-				printk
-				    ("addb0 %01x, conb0 %01x, poib0 %02x, nextsession min %d, sec %d, frame %d\n"
+				pr_debug(PFX "addb0 %01x, conb0 %01x, poib0 %02x, nextsession min %d, sec %d, frame %d\n"
 				     "#mode5_ptrs %02d, max_start_outer_leadout_msf min %d, sec %d, frame %d\n",
 				     single_toc.addressb0,
 				     single_toc.controlb0,
@@ -1690,8 +1622,7 @@ static void sony_get_toc(void)
 						max_start_outer_leadout_msf
 						[2]));
 			if (res_size > 27 && single_toc.pointb1 > 0xaf)
-				printk
-				    ("addb1 %01x, conb1 %01x, poib1 %02x, %x %x %x %x #skipint_ptrs %d, #skiptrkassign %d %x\n",
+				pr_debug(PFX "addb1 %01x, conb1 %01x, poib1 %02x, %x %x %x %x #skipint_ptrs %d, #skiptrkassign %d %x\n",
 				     single_toc.addressb1,
 				     single_toc.controlb1,
 				     single_toc.pointb1,
@@ -1703,8 +1634,7 @@ static void sony_get_toc(void)
 				     single_toc.num_skip_track_assignments,
 				     single_toc.dummyb0_2);
 			if (res_size > 36 && single_toc.pointb2 > 0xaf)
-				printk
-				    ("addb2 %01x, conb2 %01x, poib2 %02x, %02x %02x %02x %02x %02x %02x %02x\n",
+				pr_debug(PFX "addb2 %01x, conb2 %01x, poib2 %02x, %02x %02x %02x %02x %02x %02x %02x\n",
 				     single_toc.addressb2,
 				     single_toc.controlb2,
 				     single_toc.pointb2,
@@ -1716,8 +1646,7 @@ static void sony_get_toc(void)
 				     single_toc.tracksb2[5],
 				     single_toc.tracksb2[6]);
 			if (res_size > 45 && single_toc.pointb3 > 0xaf)
-				printk
-				    ("addb3 %01x, conb3 %01x, poib3 %02x, %02x %02x %02x %02x %02x %02x %02x\n",
+				pr_debug(PFX "addb3 %01x, conb3 %01x, poib3 %02x, %02x %02x %02x %02x %02x %02x %02x\n",
 				     single_toc.addressb3,
 				     single_toc.controlb3,
 				     single_toc.pointb3,
@@ -1729,8 +1658,7 @@ static void sony_get_toc(void)
 				     single_toc.tracksb3[5],
 				     single_toc.tracksb3[6]);
 			if (res_size > 54 && single_toc.pointb4 > 0xaf)
-				printk
-				    ("addb4 %01x, conb4 %01x, poib4 %02x, %02x %02x %02x %02x %02x %02x %02x\n",
+				pr_debug(PFX "addb4 %01x, conb4 %01x, poib4 %02x, %02x %02x %02x %02x %02x %02x %02x\n",
 				     single_toc.addressb4,
 				     single_toc.controlb4,
 				     single_toc.pointb4,
@@ -1742,8 +1670,7 @@ static void sony_get_toc(void)
 				     single_toc.tracksb4[5],
 				     single_toc.tracksb4[6]);
 			if (res_size > 63 && single_toc.pointc0 > 0xaf)
-				printk
-				    ("addc0 %01x, conc0 %01x, poic0 %02x, %02x %02x %02x %02x %02x %02x %02x\n",
+				pr_debug(PFX "addc0 %01x, conc0 %01x, poic0 %02x, %02x %02x %02x %02x %02x %02x %02x\n",
 				     single_toc.addressc0,
 				     single_toc.controlc0,
 				     single_toc.pointc0,
@@ -1754,7 +1681,6 @@ static void sony_get_toc(void)
 				     single_toc.dummyc0[4],
 				     single_toc.dummyc0[5],
 				     single_toc.dummyc0[6]);
-#endif
 #undef DEBUG
 #define DEBUG 0
 
@@ -1823,8 +1749,8 @@ static void sony_get_toc(void)
 				res_size += 9;
 			}
 #if DEBUG
-			printk
-			    ("start track lba %u,  leadout start lba %u\n",
+			printk(PRINT_INFO PFX "start track lba %u,  "
+					"leadout start lba %u\n",
 			     single_toc.start_track_lba,
 			     single_toc.lead_out_start_lba);
 			{
@@ -1836,8 +1762,7 @@ static void sony_get_toc(void)
 				     -
 				     bcd_to_int(single_toc.
 						first_track_num); i++) {
-					printk
-					    ("trk %02d: add 0x%01x, con 0x%01x,  track %02d, start min %02d, sec %02d, frame %02d\n",
+					printk(KERN_INFO PFX "trk %02d: add 0x%01x, con 0x%01x,  track %02d, start min %02d, sec %02d, frame %02d\n",
 					     i,
 					     single_toc.tracks[i].address,
 					     single_toc.tracks[i].control,
@@ -1870,8 +1795,8 @@ static void sony_get_toc(void)
 							       tracks[i].
 							       track);
 				}
-				printk
-				    ("min track number %d,   max track number %d\n",
+				printk(KERN_INFO PFX "min track number %d,  "
+						"max track number %d\n",
 				     mint, maxt);
 			}
 #endif
@@ -1976,8 +1901,8 @@ static void sony_get_toc(void)
 
 			/* Let's not get carried away... */
 			if (session > 40) {
-				printk("cdu31a: too many sessions: %d\n",
-				       session);
+				printk(KERN_NOTICE PFX "too many sessions: "
+						"%d\n", session);
 				break;
 			}
 			session++;
@@ -1995,17 +1920,13 @@ static void sony_get_toc(void)
 		    sony_toc.lead_out_start_msf[2];
 
 		sony_toc_read = 1;
-#undef DEBUG
-#if DEBUG
-		printk
-		    ("Disk session %d, start track: %d, stop track: %d\n",
+
+		pr_debug(PFX "Disk session %d, start track: %d, "
+				"stop track: %d\n",
 		     session, single_toc.start_track_lba,
 		     single_toc.lead_out_start_lba);
-#endif
 	}
-#if DEBUG
-	printk("Leaving sony_get_toc\n");
-#endif
+	pr_debug(PFX "Leaving %s\n", __FUNCTION__);
 }
 
 
@@ -2060,7 +1981,7 @@ static int read_subcode(void)
 		       0, (unsigned char *) &last_sony_subcode, &res_size);
 	if ((res_size < 2)
 	    || ((last_sony_subcode.exec_status[0] & 0xf0) == 0x20)) {
-		printk("Sony CDROM error %s (read_subcode)\n",
+		printk(KERN_ERR PFX "Sony CDROM error %s (read_subcode)\n",
 		       translate_error(last_sony_subcode.exec_status[1]));
 		return -EIO;
 	}
@@ -2228,8 +2149,8 @@ read_audio_data(char *buffer, unsigned c
 			}
 			/* Invalid data from the drive.  Shut down the operation. */
 			else if ((res_reg[0] & 0xf0) != 0x20) {
-				printk
-				    ("CDU31A: Got result that should have been error: %d\n",
+				printk(KERN_WARNING PFX "Got result that "
+						"should have been error: %d\n",
 				     res_reg[0]);
 				res_reg[0] = 0x20;
 				res_reg[1] = SONY_BAD_DATA_ERR;
@@ -2237,9 +2158,7 @@ read_audio_data(char *buffer, unsigned c
 			}
 			abort_read();
 		} else {
-#if DEBUG
-			printk("CDU31A timeout out %d\n", __LINE__);
-#endif
+			pr_debug(PFX "timeout out %d\n", __LINE__);
 			res_reg[0] = 0x20;
 			res_reg[1] = SONY_TIMEOUT_OP_ERR;
 			*res_size = 2;
@@ -2269,10 +2188,7 @@ read_audio_data(char *buffer, unsigned c
 			}
 
 			if (!is_result_ready()) {
-#if DEBUG
-				printk("CDU31A timeout out %d\n",
-				       __LINE__);
-#endif
+				pr_debug(PFX "timeout out %d\n", __LINE__);
 				res_reg[0] = 0x20;
 				res_reg[1] = SONY_TIMEOUT_OP_ERR;
 				*res_size = 2;
@@ -2290,7 +2206,7 @@ read_audio_data(char *buffer, unsigned c
 			    || (res_reg[0] == SONY_NO_ERR_DETECTION_STAT)) {
 				/* Ok, nothing to do. */
 			} else {
-				printk("CDU31A: Data block error: 0x%x\n",
+				printk(KERN_ERR PFX "Data block error: 0x%x\n",
 				       res_reg[0]);
 				res_reg[0] = 0x20;
 				res_reg[1] = SONY_BAD_DATA_ERR;
@@ -2299,7 +2215,7 @@ read_audio_data(char *buffer, unsigned c
 		} else if ((res_reg[0] & 0xf0) != 0x20) {
 			/* The drive gave me bad status, I don't know what to do.
 			   Reset the driver and return an error. */
-			printk("CDU31A: Invalid block status: 0x%x\n",
+			printk(KERN_NOTICE PFX "Invalid block status: 0x%x\n",
 			       res_reg[0]);
 			restart_on_error();
 			res_reg[0] = 0x20;
@@ -2347,7 +2263,7 @@ static int read_audio(struct cdrom_read_
 	do_sony_cd_cmd(SONY_SET_DRIVE_PARAM_CMD,
 		       params, 2, res_reg, &res_size);
 	if ((res_size < 2) || ((res_reg[0] & 0xf0) == 0x20)) {
-		printk("CDU31A: Unable to set decode params: 0x%2.2x\n",
+		printk(KERN_ERR PFX "Unable to set decode params: 0x%2.2x\n",
 		       res_reg[1]);
 		return -EIO;
 	}
@@ -2368,8 +2284,8 @@ static int read_audio(struct cdrom_read_
 		read_audio_data(audio_buffer, res_reg, &res_size);
 		if ((res_reg[0] & 0xf0) == 0x20) {
 			if (res_reg[1] == SONY_BAD_DATA_ERR) {
-				printk
-				    ("CDU31A: Data error on audio sector %d\n",
+				printk(KERN_ERR PFX "Data error on audio "
+						"sector %d\n",
 				     ra->addr.lba + cframe);
 			} else if (res_reg[1] == SONY_ILL_TRACK_R_ERR) {
 				/* Illegal track type, change track types and start over. */
@@ -2384,8 +2300,8 @@ static int read_audio(struct cdrom_read_
 					       2, res_reg, &res_size);
 				if ((res_size < 2)
 				    || ((res_reg[0] & 0xf0) == 0x20)) {
-					printk
-					    ("CDU31A: Unable to set decode params: 0x%2.2x\n",
+					printk(KERN_ERR PFX "Unable to set "
+						"decode params: 0x%2.2x\n",
 					     res_reg[1]);
 					retval = -EIO;
 					goto exit_read_audio;
@@ -2407,13 +2323,12 @@ static int read_audio(struct cdrom_read_
 				if ((res_reg[0] & 0xf0) == 0x20) {
 					if (res_reg[1] ==
 					    SONY_BAD_DATA_ERR) {
-						printk
-						    ("CDU31A: Data error on audio sector %d\n",
+						printk(KERN_ERR PFX "Data error"
+							" on audio sector %d\n",
 						     ra->addr.lba +
 						     cframe);
 					} else {
-						printk
-						    ("CDU31A: Error reading audio data on sector %d: %s\n",
+						printk(KERN_ERR PFX "Error reading audio data on sector %d: %s\n",
 						     ra->addr.lba + cframe,
 						     translate_error
 						     (res_reg[1]));
@@ -2429,8 +2344,8 @@ static int read_audio(struct cdrom_read_
 					goto exit_read_audio;
 				}
 			} else {
-				printk
-				    ("CDU31A: Error reading audio data on sector %d: %s\n",
+				printk(KERN_ERR PFX "Error reading audio "
+						"data on sector %d: %s\n",
 				     ra->addr.lba + cframe,
 				     translate_error(res_reg[1]));
 				retval = -EIO;
@@ -2448,7 +2363,7 @@ static int read_audio(struct cdrom_read_
 
 	get_result(res_reg, &res_size);
 	if ((res_reg[0] & 0xf0) == 0x20) {
-		printk("CDU31A: Error return from audio read: %s\n",
+		printk(KERN_ERR PFX "Error return from audio read: %s\n",
 		       translate_error(res_reg[1]));
 		retval = -EIO;
 		goto exit_read_audio;
@@ -2466,7 +2381,7 @@ static int read_audio(struct cdrom_read_
 	do_sony_cd_cmd(SONY_SET_DRIVE_PARAM_CMD,
 		       params, 2, res_reg, &res_size);
 	if ((res_size < 2) || ((res_reg[0] & 0xf0) == 0x20)) {
-		printk("CDU31A: Unable to reset decode params: 0x%2.2x\n",
+		printk(KERN_ERR PFX "Unable to reset decode params: 0x%2.2x\n",
 		       res_reg[1]);
 		return -EIO;
 	}
@@ -2475,7 +2390,7 @@ static int read_audio(struct cdrom_read_
 	sony_inuse = 0;
 	wake_up_interruptible(&sony_wait);
 
-	return (retval);
+	return retval;
 }
 
 static int
@@ -2488,7 +2403,7 @@ do_sony_cd_cmd_chk(const char *name,
 	do_sony_cd_cmd(cmd, params, num_params, result_buffer,
 		       result_size);
 	if ((*result_size < 2) || ((result_buffer[0] & 0xf0) == 0x20)) {
-		printk("Sony CDROM error %s (CDROM%s)\n",
+		printk(KERN_ERR PFX "Error %s (CDROM%s)\n",
 		       translate_error(result_buffer[1]), name);
 		return -EIO;
 	}
@@ -2726,12 +2641,13 @@ static int scd_audio_ioctl(struct cdrom_
 
 			if ((res_size < 2)
 			    || ((res_reg[0] & 0xf0) == 0x20)) {
-				printk("Params: %x %x %x %x %x %x %x\n",
+				printk(KERN_ERR PFX
+					"Params: %x %x %x %x %x %x %x\n",
 				       params[0], params[1], params[2],
 				       params[3], params[4], params[5],
 				       params[6]);
-				printk
-				    ("Sony CDROM error %s (CDROMPLAYTRKIND)\n",
+				printk(KERN_ERR PFX
+					"Error %s (CDROMPLAYTRKIND)\n",
 				     translate_error(res_reg[1]));
 				return -EIO;
 			}
@@ -2827,10 +2743,9 @@ static int scd_dev_ioctl(struct cdrom_de
 				return -EINVAL;
 			}
 
-			return (read_audio(&ra));
+			return read_audio(&ra);
 		}
 		return 0;
-		break;
 
 	default:
 		return -EINVAL;
@@ -2851,7 +2766,7 @@ static int scd_spinup(void)
 	/* The drive sometimes returns error 0.  I don't know why, but ignore
 	   it.  It seems to mean the drive has already done the operation. */
 	if ((res_size < 2) || ((res_reg[0] != 0) && (res_reg[1] != 0))) {
-		printk("Sony CDROM %s error (scd_open, spin up)\n",
+		printk(KERN_ERR PFX "%s error (scd_open, spin up)\n",
 		       translate_error(res_reg[1]));
 		return 1;
 	}
@@ -2875,7 +2790,7 @@ static int scd_spinup(void)
 			goto respinup_on_open;
 		}
 
-		printk("Sony CDROM error %s (scd_open, read toc)\n",
+		printk(KERN_ERR PFX "Error %s (scd_open, read toc)\n",
 		       translate_error(res_reg[1]));
 		do_sony_cd_cmd(SONY_SPIN_DOWN_CMD, NULL, 0, res_reg,
 			       &res_size);
@@ -2921,9 +2836,8 @@ static int scd_open(struct cdrom_device_
 				       params, 2, res_reg, &res_size);
 			if ((res_size < 2)
 			    || ((res_reg[0] & 0xf0) == 0x20)) {
-				printk
-				    ("CDU31A: Unable to set XA params: 0x%2.2x\n",
-				     res_reg[1]);
+				printk(KERN_WARNING PFX "Unable to set "
+					"XA params: 0x%2.2x\n", res_reg[1]);
 			}
 			sony_xa_mode = 1;
 		}
@@ -2935,9 +2849,8 @@ static int scd_open(struct cdrom_device_
 				       params, 2, res_reg, &res_size);
 			if ((res_size < 2)
 			    || ((res_reg[0] & 0xf0) == 0x20)) {
-				printk
-				    ("CDU31A: Unable to reset XA params: 0x%2.2x\n",
-				     res_reg[1]);
+				printk(KERN_WARNING PFX "Unable to reset "
+					"XA params: 0x%2.2x\n", res_reg[1]);
 			}
 			sony_xa_mode = 0;
 		}
@@ -3114,7 +3027,6 @@ out_err:
 #ifndef MODULE
 /*
  * Set up base I/O and interrupts, called from main.c.
- 
  */
 
 static int __init cdu31a_setup(char *strings)
@@ -3133,7 +3045,7 @@ static int __init cdu31a_setup(char *str
 		if (strcmp(strings, "PAS") == 0) {
 			sony_pas_init = 1;
 		} else {
-			printk("CDU31A: Unknown interface type: %s\n",
+			printk(KERN_NOTICE PFX "Unknown interface type: %s\n",
 			       strings);
 		}
 	}
@@ -3225,9 +3137,8 @@ int __init cdu31a_init(void)
 		if (request_irq
 		    (cdu31a_irq, cdu31a_interrupt, SA_INTERRUPT,
 		     "cdu31a", NULL)) {
-			printk
-			    ("Unable to grab IRQ%d for the CDU31A driver\n",
-			     cdu31a_irq);
+			printk(KERN_WARNING PFX "Unable to grab IRQ%d for "
+					"the CDU31A driver\n", cdu31a_irq);
 			cdu31a_irq = 0;
 		}
 	}
@@ -3262,8 +3173,8 @@ int __init cdu31a_init(void)
 		strcat(msg, buf);
 	}
 	strcat(msg, "\n");
-	printk("%s",msg);
-	
+	printk(KERN_INFO PFX "%s",msg);
+
 	cdu31a_queue = blk_init_queue(do_cdu31a_request, &cdu31a_lock);
 	if (!cdu31a_queue)
 		goto errout0;
@@ -3280,18 +3191,18 @@ int __init cdu31a_init(void)
 	add_disk(disk);
 
 	disk_changed = 1;
-	return (0);
+	return 0;
 
 err:
 	blk_cleanup_queue(cdu31a_queue);
 errout0:
 	if (cdu31a_irq)
 		free_irq(cdu31a_irq, NULL);
-	printk("Unable to register CDU-31a with Uniform cdrom driver\n");
+	printk(KERN_ERR PFX "Unable to register with Uniform cdrom driver\n");
 	put_disk(disk);
 errout1:
 	if (unregister_blkdev(MAJOR_NR, "cdu31a")) {
-		printk("Can't unregister block device for cdu31a\n");
+		printk(KERN_WARNING PFX "Can't unregister block device\n");
 	}
 errout2:
 	release_region(cdu31a_port, 4);
@@ -3305,12 +3216,12 @@ void __exit cdu31a_exit(void)
 	del_gendisk(scd_gendisk);
 	put_disk(scd_gendisk);
 	if (unregister_cdrom(&scd_info)) {
-		printk
-		    ("Can't unregister cdu31a from Uniform cdrom driver\n");
+		printk(KERN_WARNING PFX "Can't unregister from Uniform "
+				"cdrom driver\n");
 		return;
 	}
 	if ((unregister_blkdev(MAJOR_NR, "cdu31a") == -EINVAL)) {
-		printk("Can't unregister cdu31a\n");
+		printk(KERN_WARNING PFX "Can't unregister\n");
 		return;
 	}
 
@@ -3320,7 +3231,7 @@ void __exit cdu31a_exit(void)
 		free_irq(cdu31a_irq, NULL);
 
 	release_region(cdu31a_port, 4);
-	printk(KERN_INFO "cdu31a module released.\n");
+	printk(KERN_INFO PFX "module released.\n");
 }
 
 #ifdef MODULE
