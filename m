Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932819AbWJIQAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932819AbWJIQAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932812AbWJIQAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:00:46 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:5856 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932953AbWJIQAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:00:45 -0400
Date: Mon, 9 Oct 2006 18:00:21 +0200
Message-id: <32423443242334@muni.cz>
Subject: [PATCH 3/3] Char: mxser_new, comments cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
X-Muni-Spam-TestIP: 147.251.51.201
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, comments cleanup

- Remove commented code, since we have version control.
- Remove comments containing "following added by..." and "above added by,..".
  It's useless.
- Align other comments.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit b2ba7266295acc5a8be6427a76b52d74b2374192
tree 73cbaa51e9b09c1c4979ed4878844beccc6c4e13
parent 9c1c1abbe9e875e258bb238b74077d002414c950
author Jiri Slaby <jirislaby@gmail.com> Mon, 09 Oct 2006 15:09:16 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Mon, 09 Oct 2006 15:09:16 +0200

 drivers/char/mxser_new.c |  143 +++++-----------------------------------------
 1 files changed, 16 insertions(+), 127 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 08ad269..0bc13f7 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -346,8 +346,6 @@ static int CheckIsMoxaMust(int io)
 	return MOXA_OTHER_UART;
 }
 
-/* above is modified by Victor Yu. 08-15-2002 */
-
 static void process_txrx_fifo(struct mxser_port *info)
 {
 	int i;
@@ -581,12 +579,10 @@ static int mxser_change_speed(struct mxs
 			fcr = 0;
 	} else {
 		fcr = UART_FCR_ENABLE_FIFO;
-		/* following add by Victor Yu. 08-30-2002 */
 		if (info->board->chip_flag) {
 			fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
 			SET_MOXA_MUST_FIFO_VALUE(info);
 		} else {
-			/* above add by Victor Yu. 08-30-2002 */
 			switch (info->rx_trigger) {
 			case 1:
 				fcr |= UART_FCR_TRIGGER_1;
@@ -612,19 +608,8 @@ static int mxser_change_speed(struct mxs
 		info->IER |= UART_IER_MSI;
 		if ((info->type == PORT_16550A) || (info->board->chip_flag)) {
 			info->MCR |= UART_MCR_AFE;
-/*			status = mxser_get_msr(info->ioaddr, 0, info->port); */
-/*
-	save_flags(flags);
-	cli();
-	status = inb(baseaddr + UART_MSR);
-	restore_flags(flags);
-*/
-			/* mxser_check_modem_status(info, status); */
 		} else {
-/*			status = mxser_get_msr(info->ioaddr, 0, info->port); */
-			/* MX_LOCK(&info->slock); */
 			status = inb(info->ioaddr + UART_MSR);
-			/* MX_UNLOCK(&info->slock); */
 			if (info->tty->hw_stopped) {
 				if (status & UART_MSR_CTS) {
 					info->tty->hw_stopped = 0;
@@ -692,7 +677,6 @@ static int mxser_change_speed(struct mxs
 						UART_LSR_FE;
 		}
 	}
-	/* following add by Victor Yu. 09-02-2002 */
 	if (info->board->chip_flag) {
 		spin_lock_irqsave(&info->slock, flags);
 		SET_MOXA_MUST_XON1_VALUE(info->ioaddr, START_CHAR(info->tty));
@@ -707,18 +691,8 @@ static int mxser_change_speed(struct mxs
 		} else {
 			DISABLE_MOXA_MUST_TX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
 		}
-		/*
-		   if ( I_IXANY(info->tty) ) {
-		   info->MCR |= MOXA_MUST_MCR_XON_ANY;
-		   ENABLE_MOXA_MUST_XON_ANY_FLOW_CONTROL(info->ioaddr);
-		   } else {
-		   info->MCR &= ~MOXA_MUST_MCR_XON_ANY;
-		   DISABLE_MOXA_MUST_XON_ANY_FLOW_CONTROL(info->ioaddr);
-		   }
-		 */
 		spin_unlock_irqrestore(&info->slock, flags);
 	}
-	/* above add by Victor Yu. 09-02-2002 */
 
 
 	outb(fcr, info->ioaddr + UART_FCR);	/* set fcr */
@@ -852,12 +826,9 @@ static int mxser_startup(struct mxser_po
 	 * Finally, enable interrupts
 	 */
 	info->IER = UART_IER_MSI | UART_IER_RLSI | UART_IER_RDI;
-	/* info->IER = UART_IER_RLSI | UART_IER_RDI; */
 
-	/* following add by Victor Yu. 08-30-2002 */
 	if (info->board->chip_flag)
 		info->IER |= MOXA_MUST_IER_EGDAI;
-	/* above add by Victor Yu. 08-30-2002 */
 	outb(info->IER, info->ioaddr + UART_IER);	/* enable interrupts */
 
 	/*
@@ -917,13 +888,11 @@ static void mxser_shutdown(struct mxser_
 	outb(info->MCR, info->ioaddr + UART_MCR);
 
 	/* clear Rx/Tx FIFO's */
-	/* following add by Victor Yu. 08-30-2002 */
 	if (info->board->chip_flag)
 		outb(UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT |
 				MOXA_MUST_FCR_GDA_MODE_ENABLE,
 				info->ioaddr + UART_FCR);
 	else
-		/* above add by Victor Yu. 08-30-2002 */
 		outb(UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
 			info->ioaddr + UART_FCR);
 
@@ -935,10 +904,8 @@ static void mxser_shutdown(struct mxser_
 
 	info->flags &= ~ASYNC_INITIALIZED;
 
-	/* following add by Victor Yu. 09-23-2002 */
 	if (info->board->chip_flag)
 		SET_MOXA_MUST_NO_SOFTWARE_FLOW_CONTROL(info->ioaddr);
-	/* above add by Victor Yu. 09-23-2002 */
 
 	spin_unlock_irqrestore(&info->slock, flags);
 }
@@ -991,12 +958,7 @@ static int mxser_open(struct tty_struct 
 	info->session = current->signal->session;
 	info->pgrp = process_group(current);
 
-	/*
-	status = mxser_get_msr(info->base, 0, info->port);
-	mxser_check_modem_status(info, status);
-	*/
-
-/* unmark here for very high baud rate (ex. 921600 bps) used */
+	/* unmark here for very high baud rate (ex. 921600 bps) used */
 	tty->low_latency = 1;
 	return 0;
 }
@@ -1070,9 +1032,7 @@ static void mxser_close(struct tty_struc
 	info->IER &= ~UART_IER_RLSI;
 	if (info->board->chip_flag)
 		info->IER &= ~MOXA_MUST_RECV_ISR;
-/* by William
-	info->read_status_mask &= ~UART_LSR_DR;
-*/
+
 	if (info->flags & ASYNC_INITIALIZED) {
 		outb(info->IER, info->ioaddr + UART_IER);
 		/*
@@ -1135,8 +1095,7 @@ static int mxser_write(struct tty_struct
 		total += c;
 	}
 
-	if (info->xmit_cnt && !tty->stopped
-			/*&& !(info->IER & UART_IER_THRI)*/) {
+	if (info->xmit_cnt && !tty->stopped) {
 		if (!tty->hw_stopped ||
 				(info->type == PORT_16550A) ||
 				(info->board->chip_flag)) {
@@ -1167,7 +1126,7 @@ static void mxser_put_char(struct tty_st
 	info->xmit_head &= SERIAL_XMIT_SIZE - 1;
 	info->xmit_cnt++;
 	spin_unlock_irqrestore(&info->slock, flags);
-	if (!tty->stopped /*&& !(info->IER & UART_IER_THRI)*/) {
+	if (!tty->stopped) {
 		if (!tty->hw_stopped ||
 				(info->type == PORT_16550A) ||
 				info->board->chip_flag) {
@@ -1231,14 +1190,12 @@ static void mxser_flush_buffer(struct tt
 	spin_lock_irqsave(&info->slock, flags);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
 
-	/* below added by shinhay */
 	fcr = inb(info->ioaddr + UART_FCR);
 	outb((fcr | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT),
 		info->ioaddr + UART_FCR);
 	outb(fcr, info->ioaddr + UART_FCR);
 
 	spin_unlock_irqrestore(&info->slock, flags);
-	/* above added by shinhay */
 
 	tty_wakeup(tty);
 }
@@ -1309,10 +1266,9 @@ static int mxser_set_serial_info(struct 
 		info->closing_wait = new_serial.closing_wait * HZ / 100;
 		info->tty->low_latency =
 				(info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
-		info->tty->low_latency = 0;	/* (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0; */
+		info->tty->low_latency = 0;
 	}
 
-	/* added by casper, 3/17/2000, for mouse */
 	info->type = new_serial.type;
 
 	process_txrx_fifo(info);
@@ -1430,7 +1386,6 @@ static int mxser_tiocmset(struct tty_str
 static int mxser_program_mode(int port)
 {
 	int id, i, j, n;
-	/* unsigned long flags; */
 
 	spin_lock(&gm_lock);
 	outb(0, port);
@@ -1440,7 +1395,6 @@ static int mxser_program_mode(int port)
 	(void)inb(port);
 	outb(0, port);
 	(void)inb(port);
-	/* restore_flags(flags); */
 	spin_unlock(&gm_lock);
 
 	id = inb(port + 1) & 0x1F;
@@ -1623,7 +1577,6 @@ static int mxser_ioctl_special(unsigned 
 					continue;
 
 				status = mxser_get_msr(port->ioaddr, 0, i);
-/*				mxser_check_modem_status(port, status); */
 
 				if (status & UART_MSR_TERI)
 					port->icount.rng++;
@@ -1707,7 +1660,6 @@ static int mxser_ioctl(struct tty_struct
 	if (tty->index == MXSER_PORTS)
 		return mxser_ioctl_special(cmd, argp);
 
-	/* following add by Victor Yu. 01-05-2004 */
 	if (cmd == MOXA_SET_OP_MODE || cmd == MOXA_GET_OP_MODE) {
 		int p;
 		unsigned long opmode;
@@ -1739,7 +1691,6 @@ static int mxser_ioctl(struct tty_struct
 		}
 		return 0;
 	}
-	/* above add by Victor Yu. 01-05-2004 */
 
 	if (cmd != TIOCGSERIAL && cmd != TIOCMIWAIT && cmd != TIOCGICOUNT &&
 			test_bit(TTY_IO_ERROR, &tty->flags))
@@ -1829,7 +1780,6 @@ static int mxser_ioctl(struct tty_struct
 		cnow = info->icount;
 		spin_unlock_irqrestore(&info->slock, flags);
 		p_cuser = argp;
-		/* modified by casper 1/11/2000 */
 		if (put_user(cnow.frame, &p_cuser->frame))
 			return -EFAULT;
 		if (put_user(cnow.brk, &p_cuser->brk))
@@ -1855,7 +1805,6 @@ static int mxser_ioctl(struct tty_struct
 		info->mon_data.rxcnt = 0;
 		info->mon_data.txcnt = 0;
 		return 0;
-/* (above) added by James. */
 	case MOXA_ASPP_SETBAUD:{
 		long baud;
 		if (get_user(baud, (long __user *)argp))
@@ -1886,8 +1835,6 @@ static int mxser_ioctl(struct tty_struct
 	case MOXA_ASPP_MON: {
 		int mcr, status;
 
-		/* info->mon_data.ser_param = tty->termios->c_cflag; */
-
 		status = mxser_get_msr(info->ioaddr, 1, tty->index);
 		mxser_check_modem_status(info, status);
 
@@ -1944,7 +1891,6 @@ static void mxser_stoprx(struct tty_stru
 
 	info->ldisc_stop_rx = 1;
 	if (I_IXOFF(tty)) {
-		/* following add by Victor Yu. 09-02-2002 */
 		if (info->board->chip_flag) {
 			info->IER &= ~MOXA_MUST_RECV_ISR;
 			outb(info->IER, info->ioaddr + UART_IER);
@@ -1981,7 +1927,6 @@ static void mxser_unthrottle(struct tty_
 		if (info->x_char)
 			info->x_char = 0;
 		else {
-			/* following add by Victor Yu. 09-02-2002 */
 			if (info->board->chip_flag) {
 				info->IER |= MOXA_MUST_RECV_ISR;
 				outb(info->IER, info->ioaddr + UART_IER);
@@ -2025,8 +1970,7 @@ static void mxser_start(struct tty_struc
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
-	if (info->xmit_cnt && info->xmit_buf
-			/* && !(info->IER & UART_IER_THRI) */) {
+	if (info->xmit_cnt && info->xmit_buf) {
 		outb(info->IER & ~UART_IER_THRI, info->ioaddr + UART_IER);
 		info->IER |= UART_IER_THRI;
 		outb(info->IER, info->ioaddr + UART_IER);
@@ -2051,18 +1995,16 @@ static void mxser_set_termios(struct tty
 		}
 	}
 
-/* Handle sw stopped */
+	/* Handle sw stopped */
 	if ((old_termios->c_iflag & IXON) &&
 			!(tty->termios->c_iflag & IXON)) {
 		tty->stopped = 0;
 
-		/* following add by Victor Yu. 09-02-2002 */
 		if (info->board->chip_flag) {
 			spin_lock_irqsave(&info->slock, flags);
 			DISABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
 			spin_unlock_irqrestore(&info->slock, flags);
 		}
-		/* above add by Victor Yu. 09-02-2002 */
 
 		mxser_start(tty);
 	}
@@ -2131,7 +2073,6 @@ #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 #endif
 }
 
-
 /*
  * This routine is called by tty_hangup() when a hangup is signaled.
  */
@@ -2148,8 +2089,6 @@ void mxser_hangup(struct tty_struct *tty
 	wake_up_interruptible(&info->open_wait);
 }
 
-
-/* added by James 03-12-2004. */
 /*
  * mxser_rs_break() --- routine which turns the break handling on or off
  */
@@ -2168,8 +2107,6 @@ static void mxser_rs_break(struct tty_st
 	spin_unlock_irqrestore(&info->slock, flags);
 }
 
-/* (above) added by James. */
-
 static void mxser_receive_chars(struct mxser_port *port, int *status)
 {
 	struct tty_struct *tty = port->tty;
@@ -2183,36 +2120,26 @@ static void mxser_receive_chars(struct m
 	spin_lock_irqsave(&port->slock, flags);
 
 	recv_room = tty->receive_room;
-	if ((recv_room == 0) && (!port->ldisc_stop_rx)) {
-		/* mxser_throttle(tty); */
+	if ((recv_room == 0) && (!port->ldisc_stop_rx))
 		mxser_stoprx(tty);
-		/* return; */
-	}
 
-	/* following add by Victor Yu. 09-02-2002 */
 	if (port->board->chip_flag != MOXA_OTHER_UART) {
 
 		if (*status & UART_LSR_SPECIAL)
 			goto intr_old;
-		/* following add by Victor Yu. 02-11-2004 */
 		if (port->board->chip_flag == MOXA_MUST_MU860_HWID &&
 				(*status & MOXA_MUST_LSR_RERR))
 			goto intr_old;
-		/* above add by Victor Yu. 02-14-2004 */
 		if (*status & MOXA_MUST_LSR_RERR)
 			goto intr_old;
 
 		gdl = inb(port->ioaddr + MOXA_MUST_GDL_REGISTER);
 
-		/* add by Victor Yu. 02-11-2004 */
 		if (port->board->chip_flag == MOXA_MUST_MU150_HWID)
 			gdl &= MOXA_MUST_GDL_MASK;
 		if (gdl >= recv_room) {
-			if (!port->ldisc_stop_rx) {
-				/* mxser_throttle(tty); */
+			if (!port->ldisc_stop_rx)
 				mxser_stoprx(tty);
-			}
-			/* return; */
 		}
 		while (gdl--) {
 			ch = inb(port->ioaddr + UART_RX);
@@ -2221,20 +2148,16 @@ static void mxser_receive_chars(struct m
 		}
 		goto end_intr;
 	}
- intr_old:
-	/* above add by Victor Yu. 09-02-2002 */
+intr_old:
 
 	do {
 		if (max-- < 0)
 			break;
 
 		ch = inb(port->ioaddr + UART_RX);
-		/* following add by Victor Yu. 09-02-2002 */
-		if (port->board->chip_flag && (*status & UART_LSR_OE)
-				/*&& !(*status&UART_LSR_DR) */)
+		if (port->board->chip_flag && (*status & UART_LSR_OE))
 			outb(0x23, port->ioaddr + UART_FCR);
 		*status &= port->read_status_mask;
-		/* above add by Victor Yu. 09-02-2002 */
 		if (*status & port->ignore_status_mask) {
 			if (++ignored > 100)
 				break;
@@ -2243,50 +2166,38 @@ static void mxser_receive_chars(struct m
 			if (*status & UART_LSR_SPECIAL) {
 				if (*status & UART_LSR_BI) {
 					flag = TTY_BREAK;
-/* added by casper 1/11/2000 */
 					port->icount.brk++;
 
 					if (port->flags & ASYNC_SAK)
 						do_SAK(tty);
 				} else if (*status & UART_LSR_PE) {
 					flag = TTY_PARITY;
-/* added by casper 1/11/2000 */
 					port->icount.parity++;
 				} else if (*status & UART_LSR_FE) {
 					flag = TTY_FRAME;
-/* added by casper 1/11/2000 */
 					port->icount.frame++;
 				} else if (*status & UART_LSR_OE) {
 					flag = TTY_OVERRUN;
-/* added by casper 1/11/2000 */
 					port->icount.overrun++;
 				}
 			}
 			tty_insert_flip_char(tty, ch, flag);
 			cnt++;
 			if (cnt >= recv_room) {
-				if (!port->ldisc_stop_rx) {
-					/* mxser_throttle(tty); */
+				if (!port->ldisc_stop_rx)
 					mxser_stoprx(tty);
-				}
 				break;
 			}
 
 		}
 
-		/* following add by Victor Yu. 09-02-2002 */
 		if (port->board->chip_flag)
 			break;
 
-		/* mask by Victor Yu. 09-02-2002
-		 *status = inb(port->ioaddr + UART_LSR) & port->read_status_mask;
-		 */
-		/* following add by Victor Yu. 09-02-2002 */
 		*status = inb(port->ioaddr + UART_LSR);
-		/* above add by Victor Yu. 09-02-2002 */
 	} while (*status & UART_LSR_DR);
 
-end_intr:		/* add by Victor Yu. 09-02-2002 */
+end_intr:
 	mxvar_log.rxcnt[port->tty->index] += cnt;
 	port->mon_data.rxcnt += cnt;
 	port->mon_data.up_rxcnt += cnt;
@@ -2308,8 +2219,6 @@ static void mxser_transmit_chars(struct 
 		mxvar_log.txcnt[port->tty->index]++;
 		port->mon_data.txcnt++;
 		port->mon_data.up_txcnt++;
-
-/* added by casper 1/11/2000 */
 		port->icount.tx++;
 		goto unlock;
 	}
@@ -2337,11 +2246,8 @@ static void mxser_transmit_chars(struct 
 	} while (--count > 0);
 	mxvar_log.txcnt[port->tty->index] += (cnt - port->xmit_cnt);
 
-/* added by James 03-12-2004. */
 	port->mon_data.txcnt += (cnt - port->xmit_cnt);
 	port->mon_data.up_txcnt += (cnt - port->xmit_cnt);
-
-/* added by casper 1/11/2000 */
 	port->icount.tx += (cnt - port->xmit_cnt);
 
 	if (port->xmit_cnt < WAKEUP_CHARS) {
@@ -2369,8 +2275,6 @@ static irqreturn_t mxser_interrupt(int i
 	unsigned int int_cnt;
 	int handled = IRQ_NONE;
 
-	/* spin_lock(&gm_lock); */
-
 	for (i = 0; i < MXSER_BOARDS; i++)
 		if (dev_id == &mxser_boards[i]) {
 			brd = dev_id;
@@ -2397,7 +2301,6 @@ static irqreturn_t mxser_interrupt(int i
 
 			int_cnt = 0;
 			do {
-				/* following add by Victor Yu. 09-13-2002 */
 				iir = inb(port->ioaddr + UART_IIR);
 				if (iir & UART_IIR_NO_INT)
 					break;
@@ -2408,9 +2311,7 @@ static irqreturn_t mxser_interrupt(int i
 					inb(port->ioaddr + UART_MSR);
 					break;
 				}
-				/* above add by Victor Yu. 09-13-2002 */
 
-				/* following add by Victor Yu. 09-02-2002 */
 				status = inb(port->ioaddr + UART_LSR);
 
 				if (status & UART_LSR_PE)
@@ -2424,12 +2325,6 @@ static irqreturn_t mxser_interrupt(int i
 					port->err_shadow |= NPPI_NOTIFY_BREAK;
 
 				if (port->board->chip_flag) {
-					/*
-					   if ( (status & 0x02) && !(status & 0x01) ) {
-					   outb(port->ioaddr+UART_FCR,  0x23);
-					   continue;
-					   }
-					 */
 					if (iir == MOXA_MUST_IIR_GDA ||
 					    iir == MOXA_MUST_IIR_RDA ||
 					    iir == MOXA_MUST_IIR_RTO ||
@@ -2438,8 +2333,6 @@ static irqreturn_t mxser_interrupt(int i
 								&status);
 
 				} else {
-					/* above add by Victor Yu. 09-02-2002 */
-
 					status &= port->read_status_mask;
 					if (status & UART_LSR_DR)
 						mxser_receive_chars(port,
@@ -2449,14 +2342,11 @@ static irqreturn_t mxser_interrupt(int i
 				if (msr & UART_MSR_ANY_DELTA)
 					mxser_check_modem_status(port, msr);
 
-				/* following add by Victor Yu. 09-13-2002 */
 				if (port->board->chip_flag) {
 					if (iir == 0x02 && (status &
 								UART_LSR_THRE))
 						mxser_transmit_chars(port);
 				} else {
-					/* above add by Victor Yu. 09-13-2002 */
-
 					if (status & UART_LSR_THRE)
 						mxser_transmit_chars(port);
 				}
@@ -2466,8 +2356,7 @@ static irqreturn_t mxser_interrupt(int i
 			break;	/* Prevent infinite loops */
 	}
 
-      irq_stop:
-	/* spin_unlock(&gm_lock); */
+irq_stop:
 	return handled;
 }
 
@@ -2639,10 +2528,10 @@ static int __init mxser_get_ISA_conf(int
 	for (i = 7, bits = 0x0100; i >= 0; i--, bits <<= 1) {
 		if (regs[12] & bits) {
 			brd->ports[i].baud_base = 921600;
-			brd->ports[i].max_baud = 921600;	/* add by Victor Yu. 09-04-2002 */
+			brd->ports[i].max_baud = 921600;
 		} else {
 			brd->ports[i].baud_base = 115200;
-			brd->ports[i].max_baud = 115200;	/* add by Victor Yu. 09-04-2002 */
+			brd->ports[i].max_baud = 115200;
 		}
 	}
 	scratch2 = inb(cap + UART_LCR) & (~UART_LCR_DLAB);
