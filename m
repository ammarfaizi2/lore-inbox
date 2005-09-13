Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbVIMQxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVIMQxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVIMQxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:53:16 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:57992 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S964886AbVIMQxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:53:14 -0400
Date: Tue, 13 Sep 2005 18:52:57 +0200
Message-Id: <200509131652.j8DGqv1x022123@localhost.localdomain>
In-reply-to: <200509131649.j8DGnNnw021871@localhost.localdomain>
Subject: [PATCH 5/5] isicom: more whitespace
From: Jiri Slaby <jirislaby@gmail.com>
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 drivers/char/isicom.c  |  150 +++++++++++++++++++++++--------------------------
 include/linux/isicom.h |   21 +++---
 2 files changed, 83 insertions(+), 88 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -469,33 +469,36 @@ static void isicom_tx(unsigned long _dat
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
+							<< 8);
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
@@ -614,30 +617,24 @@ static irqreturn_t isicom_interrupt(int 
 		header = inw(base);
 		switch(header & 0xff) {
 		case 0:	/* Change in EIA signals */
-
 			if (port->flags & ASYNC_CHECK_CD) {
-				if (port->status & ISI_DCD) {
+				if (port->status & ISI_DCD)
 					if (!(header & ISI_DCD)) {
 					/* Carrier has been lost  */
-#ifdef ISICOM_DEBUG
-						printk(KERN_DEBUG "ISICOM: interrupt: DCD->low.\n");
-#endif
+						pr_deb(KERN_DEBUG "ISICOM: "
+							"interrupt: "
+							"DCD->low.\n");
 						port->status &= ~ISI_DCD;
 						schedule_work(&port->hangup_tq);
 					}
-				}
-				else {
-					if (header & ISI_DCD) {
+				else if (header & ISI_DCD) {
 					/* Carrier has been detected */
-#ifdef ISICOM_DEBUG
-						printk(KERN_DEBUG "ISICOM: interrupt: DCD->high.\n");
-#endif
-						port->status |= ISI_DCD;
-						wake_up_interruptible(&port->open_wait);
-					}
+					printk(KERN_DEBUG "ISICOM: interrupt: "
+						"DCD->high.\n");
+					port->status |= ISI_DCD;
+					wake_up_interruptible(&port->open_wait);
 				}
-			}
-			else {
+			} else {
 				if (header & ISI_DCD)
 					port->status |= ISI_DCD;
 				else
@@ -649,19 +646,16 @@ static irqreturn_t isicom_interrupt(int 
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
@@ -680,7 +674,7 @@ static irqreturn_t isicom_interrupt(int 
 
 			break;
 
-		case 1:	/* Received Break !!!	 */
+		case 1:	/* Received Break !!! */
 			tty_insert_flip_char(tty, 0, TTY_BREAK);
 			if (port->flags & ASYNC_SAK)
 				do_SAK(tty);
@@ -688,31 +682,31 @@ static irqreturn_t isicom_interrupt(int 
 			break;
 
 		case 2:	/* Statistics		 */
-			printk(KERN_DEBUG "ISICOM: isicom_interrupt: stats!!!.\n");
+			printk(KERN_DEBUG "ISICOM: isicom_interrupt: "
+				"stats!!!.\n");
 			break;
 
 		default:
-			printk(KERN_WARNING "ISICOM: Intr: Unknown code in status packet.\n");
+			printk(KERN_WARNING "ISICOM: Intr: Unknown code in "
+				"status packet.\n");
 			break;
 		}
-	}
-	else {				/* Data   Packet */
-
+	} else {			/* Data   Packet */
 		count = tty_prepare_flip_string(tty, &rp, byte_count & ~1);
-#ifdef ISICOM_DEBUG
-		printk(KERN_DEBUG "ISICOM: Intr: Can rx %d of %d bytes.\n",
-					count, byte_count);
-#endif
+		pr_deb(KERN_DEBUG "ISICOM: Intr: Can rx %d of %d bytes.\n",
+			count, byte_count);
 		word_count = count >> 1;
 		insw(base, rp, word_count);
 		byte_count -= (word_count << 1);
 		if (count & 0x0001) {
-			tty_insert_flip_char(tty,  inw(base) & 0xff, TTY_NORMAL);
+			tty_insert_flip_char(tty,  inw(base) & 0xff,
+				TTY_NORMAL);
 			byte_count -= 2;
 		}
 		if (byte_count > 0) {
-			printk(KERN_DEBUG "ISICOM: Intr(0x%x:%d): Flip buffer overflow! dropping bytes...\n",
-					base, channel+1);
+			printk(KERN_DEBUG "ISICOM: Intr(0x%x:%d): Flip buffer "
+				"overflow! dropping bytes...\n", base,
+				channel + 1);
 			while(byte_count > 0) { /* drain out unread xtra data */
 				inw(base);
 				byte_count -= 2;
@@ -724,6 +718,7 @@ static irqreturn_t isicom_interrupt(int 
 		ClearInterrupt(base);
 	else
 		outw(0x0000, base+0x04); /* enable interrupts */
+
 	return IRQ_HANDLED;
 }
 
@@ -894,7 +889,8 @@ static int isicom_setup_port(struct isi_
 	return 0;
 }
 
-static int block_til_ready(struct tty_struct *tty, struct file *filp, struct isi_port *port)
+static int block_til_ready(struct tty_struct *tty, struct file *filp,
+	struct isi_port *port)
 {
 	struct isi_board *card = port->card;
 	int do_clocal = 0, retval;
@@ -904,9 +900,8 @@ static int block_til_ready(struct tty_st
 	/* block if port is in the process of being closed */
 
 	if (tty_hung_up_p(filp) || port->flags & ASYNC_CLOSING) {
-#ifdef ISICOM_DEBUG
-		printk(KERN_DEBUG "ISICOM: block_til_ready: close in progress.\n");
-#endif
+		pr_deb(KERN_DEBUG "ISICOM: block_til_ready: close in "
+			"progress.\n");
 		interruptible_sleep_on(&port->close_wait);
 		if (port->flags & ASYNC_HUP_NOTIFY)
 			return -EAGAIN;
@@ -916,10 +911,9 @@ static int block_til_ready(struct tty_st
 
 	/* if non-blocking mode is set ... */
 
-	if ((filp->f_flags & O_NONBLOCK) || (tty->flags & (1 << TTY_IO_ERROR))) {
-#ifdef ISICOM_DEBUG
-		printk(KERN_DEBUG "ISICOM: block_til_ready: non-block mode.\n");
-#endif
+	if ((filp->f_flags & O_NONBLOCK) ||
+			(tty->flags & (1 << TTY_IO_ERROR))) {
+		pr_deb(KERN_DEBUG "ISICOM: block_til_ready: non-block mode.\n");
 		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
@@ -1059,12 +1053,12 @@ static void isicom_shutdown_port(struct 
 		set_bit(TTY_IO_ERROR, &tty->flags);
 
 	if (--card->count < 0) {
-		printk(KERN_DEBUG "ISICOM: isicom_shutdown_port: bad board(0x%x) count %d.\n",
-			card->base, card->count);
+		printk(KERN_DEBUG "ISICOM: isicom_shutdown_port: bad "
+			"board(0x%x) count %d.\n", card->base, card->count);
 		card->count = 0;
 	}
 
-	/* last port was closed , shutdown that boad too */
+	/* last port was closed, shutdown that boad too */
 	if (C_HUPCL(tty)) {
 		if (!card->count)
 			isicom_shutdown_board(card);
@@ -1082,9 +1076,7 @@ static void isicom_close(struct tty_stru
 	if (isicom_paranoia_check(port, tty->name, "isicom_close"))
 		return;
 
-#ifdef ISICOM_DEBUG
-	printk(KERN_DEBUG "ISICOM: Close start!!!.\n");
-#endif
+	pr_deb(KERN_DEBUG "ISICOM: Close start!!!.\n");
 
 	spin_lock_irqsave(&card->card_lock, flags);
 	if (tty_hung_up_p(filp)) {
@@ -1093,14 +1085,14 @@ static void isicom_close(struct tty_stru
 	}
 
 	if (tty->count == 1 && port->count != 1) {
-		printk(KERN_WARNING "ISICOM:(0x%x) isicom_close: bad port count"
-			"tty->count = 1	port count = %d.\n",
-			card->base, port->count);
+		printk(KERN_WARNING "ISICOM:(0x%x) isicom_close: bad port "
+			"count tty->count = 1 port count = %d.\n", card->base,
+			port->count);
 		port->count = 1;
 	}
 	if (--port->count < 0) {
-		printk(KERN_WARNING "ISICOM:(0x%x) isicom_close: bad port count for"
-			"channel%d = %d", card->base, port->channel,
+		printk(KERN_WARNING "ISICOM:(0x%x) isicom_close: bad port "
+			"count for channel%d = %d", card->base, port->channel,
 			port->count);
 		port->count = 0;
 	}
@@ -1135,10 +1127,10 @@ static void isicom_close(struct tty_stru
 	if (port->blocked_open) {
 		spin_unlock_irqrestore(&card->card_lock, flags);
 		if (port->close_delay) {
-#ifdef ISICOM_DEBUG
-			printk(KERN_DEBUG "ISICOM: scheduling until time out.\n");
-#endif
-			msleep_interruptible(jiffies_to_msecs(port->close_delay));
+			printk(KERN_DEBUG "ISICOM: scheduling until time "
+				"out.\n");
+			msleep_interruptible(
+				jiffies_to_msecs(port->close_delay));
 		}
 		spin_lock_irqsave(&card->card_lock, flags);
 		wake_up_interruptible(&port->open_wait);
@@ -1166,13 +1158,14 @@ static int isicom_write(struct tty_struc
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
@@ -1217,7 +1210,8 @@ static void isicom_flush_chars(struct tt
 	if (isicom_paranoia_check(port, tty->name, "isicom_flush_chars"))
 		return;
 
-	if (port->xmit_cnt <= 0 || tty->stopped || tty->hw_stopped || !port->xmit_buf)
+	if (port->xmit_cnt <= 0 || tty->stopped || tty->hw_stopped ||
+			!port->xmit_buf)
 		return;
 
 	/* this tells the transmitter to consider this port for
@@ -1250,7 +1244,8 @@ static int isicom_chars_in_buffer(struct
 }
 
 /* ioctl et all */
-static inline void isicom_send_break(struct isi_port *port, unsigned long length)
+static inline void isicom_send_break(struct isi_port *port,
+	unsigned long length)
 {
 	struct isi_board *card = port->card;
 	u16 base = card->base;
@@ -1385,7 +1380,8 @@ static int isicom_ioctl(struct tty_struc
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
