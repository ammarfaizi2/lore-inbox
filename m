Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVJPW2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVJPW2F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 18:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbVJPW1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 18:27:43 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:2255 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751371AbVJPW1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 18:27:40 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Mon, 17 Oct 2005 00:27:35 +0200
In-reply-to: <200100919343.123456789ble@anxur.fi.muni.cz>
Subject: [PATCHv3 6/6] char, isicom: More whitespaces and coding style
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <20051016222734.375FD22B371@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More whitespaces and coding style

Wrap all the code to 80 chars on a line.
`}\nelse' changed to `} else'.
Clean whitespaces in header file.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

---
commit e7b981bc62212389c19670a555cb0a51ba511c13
tree 70df064b653ab4eecfea8d9973953074ee5ed0aa
parent fd5bdfc3a5c9198fd488744c102c86b10644ab28
author root <root@bellona.(none)> Mon, 17 Oct 2005 00:02:44 +0200
committer root <root@bellona.(none)> Mon, 17 Oct 2005 00:02:44 +0200

 drivers/char/isicom.c  |  112 +++++++++++++++++++++++++-----------------------
 include/linux/isicom.h |   21 ++++-----
 2 files changed, 69 insertions(+), 64 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -189,7 +189,7 @@ struct	isi_board {
 	unsigned char		irq;
 	unsigned char		port_count;
 	unsigned short		status;
-	unsigned short		port_status; /* each bit represents a single port */
+	unsigned short		port_status; /* each bit for each port */
 	unsigned short		shift_count;
 	struct isi_port		* ports;
 	signed char		count;
@@ -242,7 +242,9 @@ static int lock_card(struct isi_board *c
 			udelay(1000);   /* 1ms */
 		}
 	}
-	printk(KERN_WARNING "ISICOM: Failed to lock Card (0x%lx)\n", card->base);
+	printk(KERN_WARNING "ISICOM: Failed to lock Card (0x%lx)\n",
+		card->base);
+
 	return 0;	/* Failed to aquire the card! */
 }
 
@@ -466,33 +468,36 @@ static void isicom_tx(unsigned long _dat
 		residue = NO;
 		wrd = 0;
 		while (1) {
-			cnt = min_t(int, txcount, (SERIAL_XMIT_SIZE - port->xmit_tail));
+			cnt = min_t(int, txcount, (SERIAL_XMIT_SIZE
+					- port->xmit_tail));
 			if (residue == YES) {
 				residue = NO;
 				if (cnt > 0) {
-					wrd |= (port->xmit_buf[port->xmit_tail] << 8);
-					port->xmit_tail = (port->xmit_tail + 1) & (SERIAL_XMIT_SIZE - 1);
+					wrd |= (port->xmit_buf[port->xmit_tail]
+									<< 8);
+					port->xmit_tail = (port->xmit_tail + 1)
+						& (SERIAL_XMIT_SIZE - 1);
 					port->xmit_cnt--;
 					txcount--;
 					cnt--;
 					outw(wrd, base);
-				}
-				else {
+				} else {
 					outw(wrd, base);
 					break;
 				}
 			}
 			if (cnt <= 0) break;
 			word_count = cnt >> 1;
-			outsw(base, port->xmit_buf+port->xmit_tail, word_count);
-			port->xmit_tail = (port->xmit_tail + (word_count << 1)) &
-						(SERIAL_XMIT_SIZE - 1);
+			outsw(base, port->xmit_buf+port->xmit_tail,word_count);
+			port->xmit_tail = (port->xmit_tail
+				+ (word_count << 1)) & (SERIAL_XMIT_SIZE - 1);
 			txcount -= (word_count << 1);
 			port->xmit_cnt -= (word_count << 1);
 			if (cnt & 0x0001) {
 				residue = YES;
 				wrd = port->xmit_buf[port->xmit_tail];
-				port->xmit_tail = (port->xmit_tail + 1) & (SERIAL_XMIT_SIZE - 1);
+				port->xmit_tail = (port->xmit_tail + 1)
+					& (SERIAL_XMIT_SIZE - 1);
 				port->xmit_cnt--;
 				txcount--;
 			}
@@ -572,8 +577,8 @@ static irqreturn_t isicom_interrupt(int 
 	byte_count = header & 0xff;
 
 	if (channel + 1 > card->port_count) {
-		printk(KERN_WARNING "ISICOM: isicom_interrupt(0x%lx): %d(channel) > port_count.\n",
-				base, channel+1);
+		printk(KERN_WARNING "ISICOM: isicom_interrupt(0x%lx): "
+			"%d(channel) > port_count.\n", base, channel+1);
 		if (card->isa)
 			ClearInterrupt(base);
 		else
@@ -611,26 +616,22 @@ static irqreturn_t isicom_interrupt(int 
 		header = inw(base);
 		switch(header & 0xff) {
 		case 0:	/* Change in EIA signals */
-
 			if (port->flags & ASYNC_CHECK_CD) {
 				if (port->status & ISI_DCD) {
 					if (!(header & ISI_DCD)) {
 					/* Carrier has been lost  */
-						pr_dbg("interrupt: DCD->low.\n");
+						pr_dbg("interrupt: DCD->low.\n"
+							);
 						port->status &= ~ISI_DCD;
 						schedule_work(&port->hangup_tq);
 					}
+				} else if (header & ISI_DCD) {
+				/* Carrier has been detected */
+					pr_dbg("interrupt: DCD->high.\n");
+					port->status |= ISI_DCD;
+					wake_up_interruptible(&port->open_wait);
 				}
-				else {
-					if (header & ISI_DCD) {
-					/* Carrier has been detected */
-						pr_dbg("interrupt: DCD->high.\n");
-						port->status |= ISI_DCD;
-						wake_up_interruptible(&port->open_wait);
-					}
-				}
-			}
-			else {
+			} else {
 				if (header & ISI_DCD)
 					port->status |= ISI_DCD;
 				else
@@ -642,19 +643,16 @@ static irqreturn_t isicom_interrupt(int 
 					if (header & ISI_CTS) {
 						port->tty->hw_stopped = 0;
 						/* start tx ing */
-						port->status |= (ISI_TXOK | ISI_CTS);
+						port->status |= (ISI_TXOK
+							| ISI_CTS);
 						schedule_work(&port->bh_tqueue);
 					}
+				} else if (!(header & ISI_CTS)) {
+					port->tty->hw_stopped = 1;
+					/* stop tx ing */
+					port->status &= ~(ISI_TXOK | ISI_CTS);
 				}
-				else {
-					if (!(header & ISI_CTS)) {
-						port->tty->hw_stopped = 1;
-						/* stop tx ing */
-						port->status &= ~(ISI_TXOK | ISI_CTS);
-					}
-				}
-			}
-			else {
+			} else {
 				if (header & ISI_CTS)
 					port->status |= ISI_CTS;
 				else
@@ -673,7 +671,7 @@ static irqreturn_t isicom_interrupt(int 
 
 			break;
 
-		case 1:	/* Received Break !!!	 */
+		case 1:	/* Received Break !!! */
 			tty_insert_flip_char(tty, 0, TTY_BREAK);
 			if (port->flags & ASYNC_SAK)
 				do_SAK(tty);
@@ -688,8 +686,7 @@ static irqreturn_t isicom_interrupt(int 
 			pr_dbg("Intr: Unknown code in status packet.\n");
 			break;
 		}
-	}
-	else {				/* Data   Packet */
+	} else {				/* Data   Packet */
 
 		count = tty_prepare_flip_string(tty, &rp, byte_count & ~1);
 		pr_dbg("Intr: Can rx %d of %d bytes.\n", count, byte_count);
@@ -697,7 +694,8 @@ static irqreturn_t isicom_interrupt(int 
 		insw(base, rp, word_count);
 		byte_count -= (word_count << 1);
 		if (count & 0x0001) {
-			tty_insert_flip_char(tty,  inw(base) & 0xff, TTY_NORMAL);
+			tty_insert_flip_char(tty,  inw(base) & 0xff,
+				TTY_NORMAL);
 			byte_count -= 2;
 		}
 		if (byte_count > 0) {
@@ -714,6 +712,7 @@ static irqreturn_t isicom_interrupt(int 
 		ClearInterrupt(base);
 	else
 		outw(0x0000, base+0x04); /* enable interrupts */
+
 	return IRQ_HANDLED;
 }
 
@@ -885,7 +884,8 @@ static int isicom_setup_port(struct isi_
 	return 0;
 }
 
-static int block_til_ready(struct tty_struct *tty, struct file *filp, struct isi_port *port)
+static int block_til_ready(struct tty_struct *tty, struct file *filp,
+	struct isi_port *port)
 {
 	struct isi_board *card = port->card;
 	int do_clocal = 0, retval;
@@ -905,7 +905,8 @@ static int block_til_ready(struct tty_st
 
 	/* if non-blocking mode is set ... */
 
-	if ((filp->f_flags & O_NONBLOCK) || (tty->flags & (1 << TTY_IO_ERROR))) {
+	if ((filp->f_flags & O_NONBLOCK) ||
+			(tty->flags & (1 << TTY_IO_ERROR))) {
 		pr_dbg("block_til_ready: non-block mode.\n");
 		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
@@ -1051,7 +1052,7 @@ static void isicom_shutdown_port(struct 
 		card->count = 0;
 	}
 
-	/* last port was closed , shutdown that boad too */
+	/* last port was closed, shutdown that boad too */
 	if (C_HUPCL(tty)) {
 		if (!card->count)
 			isicom_shutdown_board(card);
@@ -1078,14 +1079,14 @@ static void isicom_close(struct tty_stru
 	}
 
 	if (tty->count == 1 && port->count != 1) {
-		printk(KERN_WARNING "ISICOM:(0x%lx) isicom_close: bad port count"
-			"tty->count = 1	port count = %d.\n",
+		printk(KERN_WARNING "ISICOM:(0x%lx) isicom_close: bad port "
+			"count tty->count = 1 port count = %d.\n",
 			card->base, port->count);
 		port->count = 1;
 	}
 	if (--port->count < 0) {
-		printk(KERN_WARNING "ISICOM:(0x%lx) isicom_close: bad port count for"
-			"channel%d = %d", card->base, port->channel,
+		printk(KERN_WARNING "ISICOM:(0x%lx) isicom_close: bad port "
+			"count for channel%d = %d", card->base, port->channel,
 			port->count);
 		port->count = 0;
 	}
@@ -1121,7 +1122,8 @@ static void isicom_close(struct tty_stru
 		spin_unlock_irqrestore(&card->card_lock, flags);
 		if (port->close_delay) {
 			pr_dbg("scheduling until time out.\n");
-			msleep_interruptible(jiffies_to_msecs(port->close_delay));
+			msleep_interruptible(
+				jiffies_to_msecs(port->close_delay));
 		}
 		spin_lock_irqsave(&card->card_lock, flags);
 		wake_up_interruptible(&port->open_wait);
@@ -1149,13 +1151,14 @@ static int isicom_write(struct tty_struc
 	spin_lock_irqsave(&card->card_lock, flags);
 
 	while(1) {
-		cnt = min_t(int, count, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
-					SERIAL_XMIT_SIZE - port->xmit_head));
+		cnt = min_t(int, count, min(SERIAL_XMIT_SIZE - port->xmit_cnt
+				- 1, SERIAL_XMIT_SIZE - port->xmit_head));
 		if (cnt <= 0)
 			break;
 
 		memcpy(port->xmit_buf + port->xmit_head, buf, cnt);
-		port->xmit_head = (port->xmit_head + cnt) & (SERIAL_XMIT_SIZE - 1);
+		port->xmit_head = (port->xmit_head + cnt) & (SERIAL_XMIT_SIZE
+			- 1);
 		port->xmit_cnt += cnt;
 		buf += cnt;
 		count -= cnt;
@@ -1200,7 +1203,8 @@ static void isicom_flush_chars(struct tt
 	if (isicom_paranoia_check(port, tty->name, "isicom_flush_chars"))
 		return;
 
-	if (port->xmit_cnt <= 0 || tty->stopped || tty->hw_stopped || !port->xmit_buf)
+	if (port->xmit_cnt <= 0 || tty->stopped || tty->hw_stopped ||
+			!port->xmit_buf)
 		return;
 
 	/* this tells the transmitter to consider this port for
@@ -1233,7 +1237,8 @@ static int isicom_chars_in_buffer(struct
 }
 
 /* ioctl et all */
-static inline void isicom_send_break(struct isi_port *port, unsigned long length)
+static inline void isicom_send_break(struct isi_port *port,
+	unsigned long length)
 {
 	struct isi_board *card = port->card;
 	unsigned long base = card->base;
@@ -1368,7 +1373,8 @@ static int isicom_ioctl(struct tty_struc
 		return 0;
 
 	case TIOCGSOFTCAR:
-		return put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long __user *)argp);
+		return put_user(C_CLOCAL(tty) ? 1 : 0,
+				(unsigned long __user *)argp);
 
 	case TIOCSSOFTCAR:
 		if (get_user(arg, (unsigned long __user *) argp))
diff --git a/include/linux/isicom.h b/include/linux/isicom.h
--- a/include/linux/isicom.h
+++ b/include/linux/isicom.h
@@ -9,7 +9,7 @@
 #define		YES	1
 #define		NO	0
 
-/*	
+/*
  *  ISICOM Driver definitions ...
  *
  */
@@ -20,8 +20,8 @@
  *      PCI definitions
  */
 
- #define        DEVID_COUNT     9
- #define        VENDOR_ID       0x10b5
+#define		DEVID_COUNT	9
+#define		VENDOR_ID	0x10b5
 
 /*
  *	These are now officially allocated numbers
@@ -31,9 +31,9 @@
 #define		ISICOM_CMAJOR	113	/* callout */
 #define		ISICOM_MAGIC	(('M' << 8) | 'T')
 
-#define		WAKEUP_CHARS	256	/* hard coded for now	*/ 
-#define		TX_SIZE		254 
- 
+#define		WAKEUP_CHARS	256	/* hard coded for now	*/
+#define		TX_SIZE		254
+
 #define		BOARD_COUNT	4
 #define		PORT_COUNT	(BOARD_COUNT*16)
 
@@ -66,12 +66,12 @@
 #define	BOARD(line)  (((line) >> 4) & 0x3)
 
 	/*	isi kill queue bitmap	*/
-	
+
 #define		ISICOM_KILLTX		0x01
 #define		ISICOM_KILLRX		0x02
 
 	/* isi_board status bitmap */
-	
+
 #define		FIRMWARE_LOADED		0x0001
 #define		BOARD_ACTIVE		0x0002
 
@@ -85,9 +85,8 @@
 #define		ISI_RTS			0x0200
 
 
-#define		ISI_TXOK		0x0001 
- 
+#define		ISI_TXOK		0x0001
+
 #endif	/*	__KERNEL__	*/
 
 #endif	/*	ISICOM_H	*/
-
