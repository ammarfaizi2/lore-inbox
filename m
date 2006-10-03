Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030591AbWJCWG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030591AbWJCWG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030594AbWJCWG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:06:26 -0400
Received: from av1.karneval.cz ([81.27.192.123]:51026 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1030592AbWJCWGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:06:17 -0400
Message-id: <125432123123@karneval.cz>
Subject: [PATCH 5/6] Char: mxser_new, code upside down
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Date: Wed,  4 Oct 2006 00:06:08 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, code upside down

Reorder functions upside down not to have too many prototypes of each
function and have some order (similar to other drivers).

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit b4f8f18a380e652a92f0dbd41622b5f536a00bed
tree cca50ad3262bc6e67efb643a820e4ca39fd3d961
parent 209164b6d9a593c402764e2735e9c3ff2d878835
author Jiri Slaby <jirislaby@gmail.com> Tue, 03 Oct 2006 23:57:51 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Tue, 03 Oct 2006 23:57:51 +0200

 drivers/char/mxser_new.c | 3045 ++++++++++++++++++++++------------------------
 1 files changed, 1488 insertions(+), 1557 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 465314b..d4cb2d8 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -191,7 +191,6 @@ static const struct mxpciuart_info Gpci_
 	{MOXA_MUST_MU860_HWID, 128, 128, 128, 96, 96, 32, 921600L}
 };
 
-
 static struct pci_device_id mxser_pcibrds[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C168),
 		.driver_data = MXSER_BOARD_C168_PCI },
@@ -377,57 +376,6 @@ static struct mxser_mon_ext mon_data_ext
 static int mxser_set_baud_method[MXSER_PORTS + 1];
 static spinlock_t gm_lock;
 
-/*
- * static functions:
- */
-
-static int mxser_init(void);
-
-/* static void   mxser_poll(unsigned long); */
-static int mxser_get_ISA_conf(int, struct mxser_board *);
-static void mxser_do_softint(void *);
-static int mxser_open(struct tty_struct *, struct file *);
-static void mxser_close(struct tty_struct *, struct file *);
-static int mxser_write(struct tty_struct *, const unsigned char *, int);
-static int mxser_write_room(struct tty_struct *);
-static void mxser_flush_buffer(struct tty_struct *);
-static int mxser_chars_in_buffer(struct tty_struct *);
-static void mxser_flush_chars(struct tty_struct *);
-static void mxser_put_char(struct tty_struct *, unsigned char);
-static int mxser_ioctl(struct tty_struct *, struct file *, uint, ulong);
-static int mxser_ioctl_special(unsigned int, void __user *);
-static void mxser_throttle(struct tty_struct *);
-static void mxser_unthrottle(struct tty_struct *);
-static void mxser_set_termios(struct tty_struct *, struct termios *);
-static void mxser_stop(struct tty_struct *);
-static void mxser_start(struct tty_struct *);
-static void mxser_hangup(struct tty_struct *);
-static void mxser_rs_break(struct tty_struct *, int);
-static irqreturn_t mxser_interrupt(int, void *, struct pt_regs *);
-static void mxser_receive_chars(struct mxser_port *, int *);
-static void mxser_transmit_chars(struct mxser_port *);
-static void mxser_check_modem_status(struct mxser_port *, int);
-static int mxser_block_til_ready(struct tty_struct *, struct file *,
-		struct mxser_port *);
-static int mxser_startup(struct mxser_port *);
-static void mxser_shutdown(struct mxser_port *);
-static int mxser_change_speed(struct mxser_port *, struct termios *);
-static int mxser_get_serial_info(struct mxser_port *,
-		struct serial_struct __user *);
-static int mxser_set_serial_info(struct mxser_port *,
-		struct serial_struct __user *);
-static int mxser_get_lsr_info(struct mxser_port *, unsigned int __user *);
-static void mxser_send_break(struct mxser_port *, int);
-static int mxser_tiocmget(struct tty_struct *, struct file *);
-static int mxser_tiocmset(struct tty_struct *, struct file *, unsigned int,
-		unsigned int);
-static int mxser_set_baud(struct mxser_port *, long);
-static void mxser_wait_until_sent(struct tty_struct *, int);
-
-static void mxser_startrx(struct tty_struct *);
-static void mxser_stoprx(struct tty_struct *);
-
-
 static int CheckIsMoxaMust(int io)
 {
 	u8 oldmcr, hwid;
@@ -453,75 +401,6 @@ static int CheckIsMoxaMust(int io)
 
 /* above is modified by Victor Yu. 08-15-2002 */
 
-static const struct tty_operations mxser_ops = {
-	.open = mxser_open,
-	.close = mxser_close,
-	.write = mxser_write,
-	.put_char = mxser_put_char,
-	.flush_chars = mxser_flush_chars,
-	.write_room = mxser_write_room,
-	.chars_in_buffer = mxser_chars_in_buffer,
-	.flush_buffer = mxser_flush_buffer,
-	.ioctl = mxser_ioctl,
-	.throttle = mxser_throttle,
-	.unthrottle = mxser_unthrottle,
-	.set_termios = mxser_set_termios,
-	.stop = mxser_stop,
-	.start = mxser_start,
-	.hangup = mxser_hangup,
-	.break_ctl = mxser_rs_break,
-	.wait_until_sent = mxser_wait_until_sent,
-	.tiocmget = mxser_tiocmget,
-	.tiocmset = mxser_tiocmset,
-};
-
-/*
- * The MOXA Smartio/Industio serial driver boot-time initialization code!
- */
-
-static int __init mxser_module_init(void)
-{
-	int ret;
-
-	pr_debug("Loading module mxser ...\n");
-	ret = mxser_init();
-	pr_debug("Done.\n");
-	return ret;
-}
-
-static void __exit mxser_module_exit(void)
-{
-	int i, err;
-
-	pr_debug("Unloading module mxser ...\n");
-
-	err = tty_unregister_driver(mxvar_sdriver);
-	if (!err)
-		put_tty_driver(mxvar_sdriver);
-	else
-		printk(KERN_ERR "Couldn't unregister MOXA Smartio/Industio family serial driver\n");
-
-	for (i = 0; i < MXSER_BOARDS; i++) {
-		struct pci_dev *pdev;
-
-		if (mxser_boards[i].board_type == -1)
-			continue;
-		else {
-			pdev = mxser_boards[i].pdev;
-			free_irq(mxser_boards[i].irq, &mxser_boards[i]);
-			if (pdev != NULL) {	/* PCI */
-				pci_release_region(pdev, 2);
-				pci_release_region(pdev, 3);
-				pci_dev_put(pdev);
-			} else {
-				release_region(mxser_boards[i].ports[0].ioaddr, 8 * mxser_boards[i].nports);
-				release_region(mxser_boards[i].vector, 1);
-			}
-		}
-	}
-	pr_debug("Done.\n");
-}
-
 static void process_txrx_fifo(struct mxser_port *info)
 {
 	int i;
@@ -542,349 +421,581 @@ static void process_txrx_fifo(struct mxs
 			}
 }
 
-static int __devinit mxser_initbrd(struct mxser_board *brd)
+static void mxser_do_softint(void *private_)
 {
-	struct mxser_port *info;
-	unsigned int i;
-	int retval;
+	struct mxser_port *info = private_;
+	struct tty_struct *tty;
 
-	printk(KERN_INFO "max. baud rate = %d bps.\n", brd->ports[0].max_baud);
+	tty = info->tty;
 
-	for (i = 0; i < brd->nports; i++) {
-		info = &brd->ports[i];
-		info->board = brd;
-		info->stop_rx = 0;
-		info->ldisc_stop_rx = 0;
+	if (test_and_clear_bit(MXSER_EVENT_TXLOW, &info->event))
+		tty_wakeup(tty);
+	if (test_and_clear_bit(MXSER_EVENT_HANGUP, &info->event))
+		tty_hangup(tty);
+}
 
-		/* Enhance mode enabled here */
-		if (brd->chip_flag != MOXA_OTHER_UART)
-			ENABLE_MOXA_MUST_ENCHANCE_MODE(info->ioaddr);
+static unsigned char mxser_get_msr(int baseaddr, int mode, int port)
+{
+	unsigned char status = 0;
 
-		info->flags = ASYNC_SHARE_IRQ;
-		info->type = brd->uart_type;
+	status = inb(baseaddr + UART_MSR);
 
-		process_txrx_fifo(info);
+	mxser_msr[port] &= 0x0F;
+	mxser_msr[port] |= status;
+	status = mxser_msr[port];
+	if (mode)
+		mxser_msr[port] = 0;
 
-		info->custom_divisor = info->baud_base * 16;
-		info->close_delay = 5 * HZ / 10;
-		info->closing_wait = 30 * HZ;
-		INIT_WORK(&info->tqueue, mxser_do_softint, info);
-		info->normal_termios = mxvar_sdriver->init_termios;
-		init_waitqueue_head(&info->open_wait);
-		init_waitqueue_head(&info->close_wait);
-		init_waitqueue_head(&info->delta_msr_wait);
-		memset(&info->mon_data, 0, sizeof(struct mxser_mon));
-		info->err_shadow = 0;
-		spin_lock_init(&info->slock);
+	return status;
+}
 
-		/* before set INT ISR, disable all int */
-		outb(inb(info->ioaddr + UART_IER) & 0xf0,
-			info->ioaddr + UART_IER);
+static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp,
+		struct mxser_port *port)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	int retval;
+	int do_clocal = 0;
+	unsigned long flags;
+
+	/*
+	 * If non-blocking mode is set, or the port is not enabled,
+	 * then make the check up front and then exit.
+	 */
+	if ((filp->f_flags & O_NONBLOCK) || (tty->flags & (1 << TTY_IO_ERROR))) {
+		port->flags |= ASYNC_NORMAL_ACTIVE;
+		return 0;
 	}
+
+	if (tty->termios->c_cflag & CLOCAL)
+		do_clocal = 1;
+
 	/*
-	 * Allocate the IRQ if necessary
+	 * Block waiting for the carrier detect and the line to become
+	 * free (i.e., not in use by the callout).  While we are in
+	 * this loop, port->count is dropped by one, so that
+	 * mxser_close() knows when to free things.  We restore it upon
+	 * exit, either normal or abnormal.
 	 */
+	retval = 0;
+	add_wait_queue(&port->open_wait, &wait);
 
-	retval = request_irq(brd->irq, mxser_interrupt,
-			(brd->ports[0].flags & ASYNC_SHARE_IRQ) ? IRQF_SHARED :
-			IRQF_DISABLED, "mxser", brd);
-	if (retval) {
-		printk(KERN_ERR "Board %s: Request irq failed, IRQ (%d) may "
-			"conflict with another device.\n",
-			mxser_brdname[brd->board_type - 1], brd->irq);
-		return retval;
+	spin_lock_irqsave(&port->slock, flags);
+	if (!tty_hung_up_p(filp))
+		port->count--;
+	spin_unlock_irqrestore(&port->slock, flags);
+	port->blocked_open++;
+	while (1) {
+		spin_lock_irqsave(&port->slock, flags);
+		outb(inb(port->ioaddr + UART_MCR) |
+			UART_MCR_DTR | UART_MCR_RTS, port->ioaddr + UART_MCR);
+		spin_unlock_irqrestore(&port->slock, flags);
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) {
+			if (port->flags & ASYNC_HUP_NOTIFY)
+				retval = -EAGAIN;
+			else
+				retval = -ERESTARTSYS;
+			break;
+		}
+		if (!(port->flags & ASYNC_CLOSING) &&
+				(do_clocal ||
+				(inb(port->ioaddr + UART_MSR) & UART_MSR_DCD)))
+			break;
+		if (signal_pending(current)) {
+			retval = -ERESTARTSYS;
+			break;
+		}
+		schedule();
 	}
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&port->open_wait, &wait);
+	if (!tty_hung_up_p(filp))
+		port->count++;
+	port->blocked_open--;
+	if (retval)
+		return retval;
+	port->flags |= ASYNC_NORMAL_ACTIVE;
 	return 0;
 }
 
-static int __init mxser_get_PCI_conf(int board_type, struct mxser_board *brd,
-		struct pci_dev *pdev)
+static int mxser_set_baud(struct mxser_port *info, long newspd)
 {
-	unsigned int i, j;
-	unsigned long ioaddress;
-	int retval;
+	int quot = 0;
+	unsigned char cval;
+	int ret = 0;
+	unsigned long flags;
 
-	/* io address */
-	brd->board_type = board_type;
-	brd->nports = mxser_numports[board_type - 1];
-	ioaddress = pci_resource_start(pdev, 2);
-	retval = pci_request_region(pdev, 2, "mxser(IO)");
-	if (retval)
-		goto err;
+	if (!info->tty || !info->tty->termios)
+		return ret;
 
-	for (i = 0; i < brd->nports; i++)
-		brd->ports[i].ioaddr = ioaddress + 8 * i;
+	if (!(info->ioaddr))
+		return ret;
 
-	/* vector */
-	ioaddress = pci_resource_start(pdev, 3);
-	retval = pci_request_region(pdev, 3, "mxser(vector)");
-	if (retval)
-		goto err_relio;
-	brd->vector = ioaddress;
+	if (newspd > info->max_baud)
+		return 0;
 
-	/* irq */
-	brd->irq = pdev->irq;
+	info->realbaud = newspd;
+	if (newspd == 134) {
+		quot = (2 * info->baud_base / 269);
+	} else if (newspd) {
+		quot = info->baud_base / newspd;
+		if (quot == 0)
+			quot = 1;
+	} else {
+		quot = 0;
+	}
 
-	brd->chip_flag = CheckIsMoxaMust(brd->ports[0].ioaddr);
-	brd->uart_type = PORT_16550A;
-	brd->vector_mask = 0;
+	info->timeout = ((info->xmit_fifo_size * HZ * 10 * quot) / info->baud_base);
+	info->timeout += HZ / 50;	/* Add .02 seconds of slop */
 
-	for (i = 0; i < brd->nports; i++) {
-		for (j = 0; j < UART_INFO_NUM; j++) {
-			if (Gpci_uart_info[j].type == brd->chip_flag) {
-				brd->ports[i].max_baud =
-					Gpci_uart_info[j].max_baud;
+	if (quot) {
+		spin_lock_irqsave(&info->slock, flags);
+		info->MCR |= UART_MCR_DTR;
+		outb(info->MCR, info->ioaddr + UART_MCR);
+		spin_unlock_irqrestore(&info->slock, flags);
+	} else {
+		spin_lock_irqsave(&info->slock, flags);
+		info->MCR &= ~UART_MCR_DTR;
+		outb(info->MCR, info->ioaddr + UART_MCR);
+		spin_unlock_irqrestore(&info->slock, flags);
+		return ret;
+	}
 
-				/* exception....CP-102 */
-				if (board_type == MXSER_BOARD_CP102)
-					brd->ports[i].max_baud = 921600;
+	cval = inb(info->ioaddr + UART_LCR);
+
+	outb(cval | UART_LCR_DLAB, info->ioaddr + UART_LCR);	/* set DLAB */
+
+	outb(quot & 0xff, info->ioaddr + UART_DLL);	/* LS of divisor */
+	outb(quot >> 8, info->ioaddr + UART_DLM);	/* MS of divisor */
+	outb(cval, info->ioaddr + UART_LCR);	/* reset DLAB */
+
+
+	return ret;
+}
+
+/*
+ * This routine is called to set the UART divisor registers to match
+ * the specified baud rate for a serial port.
+ */
+static int mxser_change_speed(struct mxser_port *info,
+		struct termios *old_termios)
+{
+	unsigned cflag, cval, fcr;
+	int ret = 0;
+	unsigned char status;
+	long baud;
+	unsigned long flags;
+
+	if (!info->tty || !info->tty->termios)
+		return ret;
+	cflag = info->tty->termios->c_cflag;
+	if (!(info->ioaddr))
+		return ret;
+
+#ifndef B921600
+#define B921600 (B460800 +1)
+#endif
+	if (mxser_set_baud_method[info->tty->index] == 0) {
+		baud = tty_get_baud_rate(info->tty);
+		mxser_set_baud(info, baud);
+	}
+
+	/* byte size and parity */
+	switch (cflag & CSIZE) {
+	case CS5:
+		cval = 0x00;
+		break;
+	case CS6:
+		cval = 0x01;
+		break;
+	case CS7:
+		cval = 0x02;
+		break;
+	case CS8:
+		cval = 0x03;
+		break;
+	default:
+		cval = 0x00;
+		break;		/* too keep GCC shut... */
+	}
+	if (cflag & CSTOPB)
+		cval |= 0x04;
+	if (cflag & PARENB)
+		cval |= UART_LCR_PARITY;
+	if (!(cflag & PARODD))
+		cval |= UART_LCR_EPAR;
+	if (cflag & CMSPAR)
+		cval |= UART_LCR_SPAR;
+
+	if ((info->type == PORT_8250) || (info->type == PORT_16450)) {
+		if (info->board->chip_flag) {
+			fcr = UART_FCR_ENABLE_FIFO;
+			fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
+			SET_MOXA_MUST_FIFO_VALUE(info);
+		} else
+			fcr = 0;
+	} else {
+		fcr = UART_FCR_ENABLE_FIFO;
+		/* following add by Victor Yu. 08-30-2002 */
+		if (info->board->chip_flag) {
+			fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
+			SET_MOXA_MUST_FIFO_VALUE(info);
+		} else {
+			/* above add by Victor Yu. 08-30-2002 */
+			switch (info->rx_trigger) {
+			case 1:
+				fcr |= UART_FCR_TRIGGER_1;
+				break;
+			case 4:
+				fcr |= UART_FCR_TRIGGER_4;
+				break;
+			case 8:
+				fcr |= UART_FCR_TRIGGER_8;
+				break;
+			default:
+				fcr |= UART_FCR_TRIGGER_14;
 				break;
 			}
 		}
 	}
 
-	if (brd->chip_flag == MOXA_MUST_MU860_HWID) {
-		for (i = 0; i < brd->nports; i++) {
-			if (i < 4)
-				brd->ports[i].opmode_ioaddr = ioaddress + 4;
-			else
-				brd->ports[i].opmode_ioaddr = ioaddress + 0x0c;
+	/* CTS flow control flag and modem status interrupts */
+	info->IER &= ~UART_IER_MSI;
+	info->MCR &= ~UART_MCR_AFE;
+	if (cflag & CRTSCTS) {
+		info->flags |= ASYNC_CTS_FLOW;
+		info->IER |= UART_IER_MSI;
+		if ((info->type == PORT_16550A) || (info->board->chip_flag)) {
+			info->MCR |= UART_MCR_AFE;
+/*			status = mxser_get_msr(info->ioaddr, 0, info->port); */
+/*
+	save_flags(flags);
+	cli();
+	status = inb(baseaddr + UART_MSR);
+	restore_flags(flags);
+*/
+			/* mxser_check_modem_status(info, status); */
+		} else {
+/*			status = mxser_get_msr(info->ioaddr, 0, info->port); */
+			/* MX_LOCK(&info->slock); */
+			status = inb(info->ioaddr + UART_MSR);
+			/* MX_UNLOCK(&info->slock); */
+			if (info->tty->hw_stopped) {
+				if (status & UART_MSR_CTS) {
+					info->tty->hw_stopped = 0;
+					if (info->type != PORT_16550A &&
+							!info->board->chip_flag) {
+						outb(info->IER & ~UART_IER_THRI,
+							info->ioaddr +
+							UART_IER);
+						info->IER |= UART_IER_THRI;
+						outb(info->IER, info->ioaddr +
+								UART_IER);
+					}
+					set_bit(MXSER_EVENT_TXLOW, &info->event);
+					schedule_work(&info->tqueue);				}
+			} else {
+				if (!(status & UART_MSR_CTS)) {
+					info->tty->hw_stopped = 1;
+					if ((info->type != PORT_16550A) &&
+							(!info->board->chip_flag)) {
+						info->IER &= ~UART_IER_THRI;
+						outb(info->IER, info->ioaddr +
+								UART_IER);
+					}
+				}
+			}
 		}
-		outb(0, ioaddress + 4);	/* default set to RS232 mode */
-		outb(0, ioaddress + 0x0c);	/* default set to RS232 mode */
+	} else {
+		info->flags &= ~ASYNC_CTS_FLOW;
 	}
-
-	for (i = 0; i < brd->nports; i++) {
-		brd->vector_mask |= (1 << i);
-		brd->ports[i].baud_base = 921600;
+	outb(info->MCR, info->ioaddr + UART_MCR);
+	if (cflag & CLOCAL) {
+		info->flags &= ~ASYNC_CHECK_CD;
+	} else {
+		info->flags |= ASYNC_CHECK_CD;
+		info->IER |= UART_IER_MSI;
 	}
-	return 0;
-err_relio:
-	pci_release_region(pdev, 2);
-err:
-	return retval;
-}
-
-static int __init mxser_init(void)
-{
-	struct pci_dev *pdev = NULL;
-	struct mxser_board *brd;
-	unsigned int i, m;
-	int retval, b, n;
-
-	mxvar_sdriver = alloc_tty_driver(MXSER_PORTS + 1);
-	if (!mxvar_sdriver)
-		return -ENOMEM;
-	spin_lock_init(&gm_lock);
+	outb(info->IER, info->ioaddr + UART_IER);
 
-	for (i = 0; i < MXSER_BOARDS; i++)
-		mxser_boards[i].board_type = -1;
+	/*
+	 * Set up parity check flag
+	 */
+	info->read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
+	if (I_INPCK(info->tty))
+		info->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
+	if (I_BRKINT(info->tty) || I_PARMRK(info->tty))
+		info->read_status_mask |= UART_LSR_BI;
 
-	printk(KERN_INFO "MOXA Smartio/Industio family driver version %s\n",
-		MXSER_VERSION);
+	info->ignore_status_mask = 0;
 
-	/* Initialize the tty_driver structure */
-	mxvar_sdriver->magic = TTY_DRIVER_MAGIC;
-	mxvar_sdriver->name = "ttyM";
-	mxvar_sdriver->major = ttymajor;
-	mxvar_sdriver->minor_start = 0;
-	mxvar_sdriver->num = MXSER_PORTS + 1;
-	mxvar_sdriver->type = TTY_DRIVER_TYPE_SERIAL;
-	mxvar_sdriver->subtype = SERIAL_TYPE_NORMAL;
-	mxvar_sdriver->init_termios = tty_std_termios;
-	mxvar_sdriver->init_termios.c_cflag = B9600|CS8|CREAD|HUPCL|CLOCAL;
-	mxvar_sdriver->flags = TTY_DRIVER_REAL_RAW;
-	tty_set_operations(mxvar_sdriver, &mxser_ops);
-	mxvar_sdriver->ttys = mxvar_tty;
-	mxvar_sdriver->termios = mxvar_termios;
-	mxvar_sdriver->termios_locked = mxvar_termios_locked;
+	if (I_IGNBRK(info->tty)) {
+		info->ignore_status_mask |= UART_LSR_BI;
+		info->read_status_mask |= UART_LSR_BI;
+		/*
+		 * If we're ignore parity and break indicators, ignore
+		 * overruns too.  (For real raw support).
+		 */
+		if (I_IGNPAR(info->tty)) {
+			info->ignore_status_mask |=
+						UART_LSR_OE |
+						UART_LSR_PE |
+						UART_LSR_FE;
+			info->read_status_mask |=
+						UART_LSR_OE |
+						UART_LSR_PE |
+						UART_LSR_FE;
+		}
+	}
+	/* following add by Victor Yu. 09-02-2002 */
+	if (info->board->chip_flag) {
+		spin_lock_irqsave(&info->slock, flags);
+		SET_MOXA_MUST_XON1_VALUE(info->ioaddr, START_CHAR(info->tty));
+		SET_MOXA_MUST_XOFF1_VALUE(info->ioaddr, STOP_CHAR(info->tty));
+		if (I_IXON(info->tty)) {
+			ENABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
+		} else {
+			DISABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
+		}
+		if (I_IXOFF(info->tty)) {
+			ENABLE_MOXA_MUST_TX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
+		} else {
+			DISABLE_MOXA_MUST_TX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
+		}
+		/*
+		   if ( I_IXANY(info->tty) ) {
+		   info->MCR |= MOXA_MUST_MCR_XON_ANY;
+		   ENABLE_MOXA_MUST_XON_ANY_FLOW_CONTROL(info->ioaddr);
+		   } else {
+		   info->MCR &= ~MOXA_MUST_MCR_XON_ANY;
+		   DISABLE_MOXA_MUST_XON_ANY_FLOW_CONTROL(info->ioaddr);
+		   }
+		 */
+		spin_unlock_irqrestore(&info->slock, flags);
+	}
+	/* above add by Victor Yu. 09-02-2002 */
 
-	mxvar_diagflag = 0;
 
-	m = 0;
-	/* Start finding ISA boards here */
-	for (b = 0; b < MXSER_BOARDS && m < MXSER_BOARDS; b++) {
-		int cap;
+	outb(fcr, info->ioaddr + UART_FCR);	/* set fcr */
+	outb(cval, info->ioaddr + UART_LCR);
 
-		if (!(cap = mxserBoardCAP[b]))
-			continue;
+	return ret;
+}
 
-		brd = &mxser_boards[m];
-		retval = mxser_get_ISA_conf(cap, brd);
+static void mxser_check_modem_status(struct mxser_port *port, int status)
+{
+	/* update input line counters */
+	if (status & UART_MSR_TERI)
+		port->icount.rng++;
+	if (status & UART_MSR_DDSR)
+		port->icount.dsr++;
+	if (status & UART_MSR_DDCD)
+		port->icount.dcd++;
+	if (status & UART_MSR_DCTS)
+		port->icount.cts++;
+	port->mon_data.modem_status = status;
+	wake_up_interruptible(&port->delta_msr_wait);
 
-		if (retval != 0)
-			printk(KERN_INFO "Found MOXA %s board (CAP=0x%x)\n",
-				mxser_brdname[brd->board_type - 1], ioaddr[b]);
+	if ((port->flags & ASYNC_CHECK_CD) && (status & UART_MSR_DDCD)) {
+		if (status & UART_MSR_DCD)
+			wake_up_interruptible(&port->open_wait);
+		schedule_work(&port->tqueue);
+	}
 
-		if (retval <= 0) {
-			if (retval == MXSER_ERR_IRQ)
-				printk(KERN_ERR "Invalid interrupt number, "
-					"board not configured\n");
-			else if (retval == MXSER_ERR_IRQ_CONFLIT)
-				printk(KERN_ERR "Invalid interrupt number, "
-					"board not configured\n");
-			else if (retval == MXSER_ERR_VECTOR)
-				printk(KERN_ERR "Invalid interrupt vector, "
-					"board not configured\n");
-			else if (retval == MXSER_ERR_IOADDR)
-				printk(KERN_ERR "Invalid I/O address, "
-					"board not configured\n");
+	if (port->flags & ASYNC_CTS_FLOW) {
+		if (port->tty->hw_stopped) {
+			if (status & UART_MSR_CTS) {
+				port->tty->hw_stopped = 0;
 
-			continue;
+				if ((port->type != PORT_16550A) &&
+						(!port->board->chip_flag)) {
+					outb(port->IER & ~UART_IER_THRI,
+						port->ioaddr + UART_IER);
+					port->IER |= UART_IER_THRI;
+					outb(port->IER, port->ioaddr +
+							UART_IER);
+				}
+				set_bit(MXSER_EVENT_TXLOW, &port->event);
+				schedule_work(&port->tqueue);
+			}
+		} else {
+			if (!(status & UART_MSR_CTS)) {
+				port->tty->hw_stopped = 1;
+				if (port->type != PORT_16550A &&
+						!port->board->chip_flag) {
+					port->IER &= ~UART_IER_THRI;
+					outb(port->IER, port->ioaddr +
+							UART_IER);
+				}
+			}
 		}
+	}
+}
 
-		brd->pdev = NULL;
+static int mxser_startup(struct mxser_port *info)
+{
+	unsigned long page;
+	unsigned long flags;
 
-		/* mxser_initbrd will hook ISR. */
-		if (mxser_initbrd(brd) < 0)
-			continue;
+	page = __get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
 
-		m++;
-	}
+	spin_lock_irqsave(&info->slock, flags);
 
-	/* Start finding ISA boards from module arg */
-	for (b = 0; b < MXSER_BOARDS && m < MXSER_BOARDS; b++) {
-		unsigned long cap;
+	if (info->flags & ASYNC_INITIALIZED) {
+		free_page(page);
+		spin_unlock_irqrestore(&info->slock, flags);
+		return 0;
+	}
 
-		if (!(cap = ioaddr[b]))
-			continue;
+	if (!info->ioaddr || !info->type) {
+		if (info->tty)
+			set_bit(TTY_IO_ERROR, &info->tty->flags);
+		free_page(page);
+		spin_unlock_irqrestore(&info->slock, flags);
+		return 0;
+	}
+	if (info->xmit_buf)
+		free_page(page);
+	else
+		info->xmit_buf = (unsigned char *) page;
 
-		brd = &mxser_boards[m];
-		retval = mxser_get_ISA_conf(cap, &mxser_boards[m]);
+	/*
+	 * Clear the FIFO buffers and disable them
+	 * (they will be reenabled in mxser_change_speed())
+	 */
+	if (info->board->chip_flag)
+		outb((UART_FCR_CLEAR_RCVR |
+			UART_FCR_CLEAR_XMIT |
+			MOXA_MUST_FCR_GDA_MODE_ENABLE), info->ioaddr + UART_FCR);
+	else
+		outb((UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT),
+			info->ioaddr + UART_FCR);
 
-		if (retval != 0)
-			printk(KERN_INFO "Found MOXA %s board (CAP=0x%x)\n",
-				mxser_brdname[brd->board_type - 1], ioaddr[b]);
+	/*
+	 * At this point there's no way the LSR could still be 0xFF;
+	 * if it is, then bail out, because there's likely no UART
+	 * here.
+	 */
+	if (inb(info->ioaddr + UART_LSR) == 0xff) {
+		spin_unlock_irqrestore(&info->slock, flags);
+		if (capable(CAP_SYS_ADMIN)) {
+			if (info->tty)
+				set_bit(TTY_IO_ERROR, &info->tty->flags);
+			return 0;
+		} else
+			return -ENODEV;
+	}
 
-		if (retval <= 0) {
-			if (retval == MXSER_ERR_IRQ)
-				printk(KERN_ERR "Invalid interrupt number, "
-					"board not configured\n");
-			else if (retval == MXSER_ERR_IRQ_CONFLIT)
-				printk(KERN_ERR "Invalid interrupt number, "
-					"board not configured\n");
-			else if (retval == MXSER_ERR_VECTOR)
-				printk(KERN_ERR "Invalid interrupt vector, "
-					"board not configured\n");
-			else if (retval == MXSER_ERR_IOADDR)
-				printk(KERN_ERR "Invalid I/O address, "
-					"board not configured\n");
+	/*
+	 * Clear the interrupt registers.
+	 */
+	(void) inb(info->ioaddr + UART_LSR);
+	(void) inb(info->ioaddr + UART_RX);
+	(void) inb(info->ioaddr + UART_IIR);
+	(void) inb(info->ioaddr + UART_MSR);
 
-			continue;
-		}
+	/*
+	 * Now, initialize the UART
+	 */
+	outb(UART_LCR_WLEN8, info->ioaddr + UART_LCR);	/* reset DLAB */
+	info->MCR = UART_MCR_DTR | UART_MCR_RTS;
+	outb(info->MCR, info->ioaddr + UART_MCR);
 
-		brd->pdev = NULL;
-		/* mxser_initbrd will hook ISR. */
-		if (mxser_initbrd(brd) < 0)
-			continue;
+	/*
+	 * Finally, enable interrupts
+	 */
+	info->IER = UART_IER_MSI | UART_IER_RLSI | UART_IER_RDI;
+	/* info->IER = UART_IER_RLSI | UART_IER_RDI; */
 
-		m++;
-	}
+	/* following add by Victor Yu. 08-30-2002 */
+	if (info->board->chip_flag)
+		info->IER |= MOXA_MUST_IER_EGDAI;
+	/* above add by Victor Yu. 08-30-2002 */
+	outb(info->IER, info->ioaddr + UART_IER);	/* enable interrupts */
 
-	/* start finding PCI board here */
-	n = ARRAY_SIZE(mxser_pcibrds) - 1;
-	b = 0;
-	while (b < n) {
-		pdev = pci_get_device(mxser_pcibrds[b].vendor,
-				mxser_pcibrds[b].device, pdev);
-		if (pdev == NULL) {
-			b++;
-			continue;
-		}
-		printk(KERN_INFO "Found MOXA %s board(BusNo=%d,DevNo=%d)\n",
-			mxser_brdname[(int) (mxser_pcibrds[b].driver_data) - 1],
-			pdev->bus->number, PCI_SLOT(pdev->devfn));
-		if (m >= MXSER_BOARDS)
-			printk(KERN_ERR
-				"Too many Smartio/Industio family boards find "
-				"(maximum %d), board not configured\n",
-				MXSER_BOARDS);
-		else {
-			if (pci_enable_device(pdev)) {
-				printk(KERN_ERR "Moxa SmartI/O PCI enable "
-					"fail !\n");
-				continue;
-			}
-			brd = &mxser_boards[m];
-			brd->pdev = pdev;
-			retval = mxser_get_PCI_conf(
-					(int)mxser_pcibrds[b].driver_data,
-					brd, pdev);
-			if (retval < 0) {
-				if (retval == MXSER_ERR_IRQ)
-					printk(KERN_ERR
-						"Invalid interrupt number, "
-						"board not configured\n");
-				else if (retval == MXSER_ERR_IRQ_CONFLIT)
-					printk(KERN_ERR
-						"Invalid interrupt number, "
-						"board not configured\n");
-				else if (retval == MXSER_ERR_VECTOR)
-					printk(KERN_ERR
-						"Invalid interrupt vector, "
-						"board not configured\n");
-				else if (retval == MXSER_ERR_IOADDR)
-					printk(KERN_ERR
-						"Invalid I/O address, "
-						"board not configured\n");
-				continue;
-			}
-			/* mxser_initbrd will hook ISR. */
-			if (mxser_initbrd(brd) < 0)
-				continue;
-			m++;
-			/* Keep an extra reference if we succeeded. It will
-			   be returned at unload time */
-			pci_dev_get(pdev);
-		}
-	}
+	/*
+	 * And clear the interrupt registers again for luck.
+	 */
+	(void) inb(info->ioaddr + UART_LSR);
+	(void) inb(info->ioaddr + UART_RX);
+	(void) inb(info->ioaddr + UART_IIR);
+	(void) inb(info->ioaddr + UART_MSR);
 
-	retval = tty_register_driver(mxvar_sdriver);
-	if (retval) {
-		printk(KERN_ERR "Couldn't install MOXA Smartio/Industio family"
-				" driver !\n");
-		put_tty_driver(mxvar_sdriver);
+	if (info->tty)
+		clear_bit(TTY_IO_ERROR, &info->tty->flags);
+	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
 
-		for (i = 0; i < MXSER_BOARDS; i++) {
-			if (mxser_boards[i].board_type == -1)
-				continue;
-			else {
-				free_irq(mxser_boards[i].irq, &mxser_boards[i]);
-				/* todo: release io, vector */
-			}
-		}
-		return retval;
-	}
+	/*
+	 * and set the speed of the serial port
+	 */
+	spin_unlock_irqrestore(&info->slock, flags);
+	mxser_change_speed(info, NULL);
 
+	info->flags |= ASYNC_INITIALIZED;
 	return 0;
 }
 
-static void mxser_do_softint(void *private_)
+/*
+ * This routine will shutdown a serial port; interrupts maybe disabled, and
+ * DTR is dropped if the hangup on close termio flag is on.
+ */
+static void mxser_shutdown(struct mxser_port *info)
 {
-	struct mxser_port *info = private_;
-	struct tty_struct *tty;
+	unsigned long flags;
 
-	tty = info->tty;
+	if (!(info->flags & ASYNC_INITIALIZED))
+		return;
 
-	if (test_and_clear_bit(MXSER_EVENT_TXLOW, &info->event))
-		tty_wakeup(tty);
-	if (test_and_clear_bit(MXSER_EVENT_HANGUP, &info->event))
-		tty_hangup(tty);
-}
+	spin_lock_irqsave(&info->slock, flags);
 
-static unsigned char mxser_get_msr(int baseaddr, int mode, int port)
-{
-	unsigned char status = 0;
+	/*
+	 * clear delta_msr_wait queue to avoid mem leaks: we may free the irq
+	 * here so the queue might never be waken up
+	 */
+	wake_up_interruptible(&info->delta_msr_wait);
 
-	status = inb(baseaddr + UART_MSR);
+	/*
+	 * Free the IRQ, if necessary
+	 */
+	if (info->xmit_buf) {
+		free_page((unsigned long) info->xmit_buf);
+		info->xmit_buf = NULL;
+	}
 
-	mxser_msr[port] &= 0x0F;
-	mxser_msr[port] |= status;
-	status = mxser_msr[port];
-	if (mode)
-		mxser_msr[port] = 0;
+	info->IER = 0;
+	outb(0x00, info->ioaddr + UART_IER);
 
-	return status;
+	if (!info->tty || (info->tty->termios->c_cflag & HUPCL))
+		info->MCR &= ~(UART_MCR_DTR | UART_MCR_RTS);
+	outb(info->MCR, info->ioaddr + UART_MCR);
+
+	/* clear Rx/Tx FIFO's */
+	/* following add by Victor Yu. 08-30-2002 */
+	if (info->board->chip_flag)
+		outb(UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT |
+				MOXA_MUST_FCR_GDA_MODE_ENABLE,
+				info->ioaddr + UART_FCR);
+	else
+		/* above add by Victor Yu. 08-30-2002 */
+		outb(UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+			info->ioaddr + UART_FCR);
+
+	/* read data port to reset things */
+	(void) inb(info->ioaddr + UART_RX);
+
+	if (info->tty)
+		set_bit(TTY_IO_ERROR, &info->tty->flags);
+
+	info->flags &= ~ASYNC_INITIALIZED;
+
+	/* following add by Victor Yu. 09-23-2002 */
+	if (info->board->chip_flag)
+		SET_MOXA_MUST_NO_SOFTWARE_FLOW_CONTROL(info->ioaddr);
+	/* above add by Victor Yu. 09-23-2002 */
+
+	spin_unlock_irqrestore(&info->slock, flags);
 }
 
 /*
@@ -1200,250 +1311,295 @@ static void mxser_flush_buffer(struct tt
 		(tty->ldisc.write_wakeup) (tty);
 }
 
-static int mxser_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg)
+/*
+ * ------------------------------------------------------------
+ * friends of mxser_ioctl()
+ * ------------------------------------------------------------
+ */
+static int mxser_get_serial_info(struct mxser_port *info,
+		struct serial_struct __user *retinfo)
 {
-	struct mxser_port *info = tty->driver_data;
-	int retval;
-	struct async_icount cprev, cnow;	/* kernel counter temps */
-	struct serial_icounter_struct __user *p_cuser;
-	unsigned long templ;
-	unsigned long flags;
-	void __user *argp = (void __user *)arg;
+	struct serial_struct tmp;
 
-	if (tty->index == MXSER_PORTS)
-		return mxser_ioctl_special(cmd, argp);
+	if (!retinfo)
+		return -EFAULT;
+	memset(&tmp, 0, sizeof(tmp));
+	tmp.type = info->type;
+	tmp.line = info->tty->index;
+	tmp.port = info->ioaddr;
+	tmp.irq = info->board->irq;
+	tmp.flags = info->flags;
+	tmp.baud_base = info->baud_base;
+	tmp.close_delay = info->close_delay;
+	tmp.closing_wait = info->closing_wait;
+	tmp.custom_divisor = info->custom_divisor;
+	tmp.hub6 = 0;
+	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
+		return -EFAULT;
+	return 0;
+}
 
-	/* following add by Victor Yu. 01-05-2004 */
-	if (cmd == MOXA_SET_OP_MODE || cmd == MOXA_GET_OP_MODE) {
-		int p;
-		unsigned long opmode;
-		static unsigned char ModeMask[] = { 0xfc, 0xf3, 0xcf, 0x3f };
-		int shiftbit;
-		unsigned char val, mask;
+static int mxser_set_serial_info(struct mxser_port *info,
+		struct serial_struct __user *new_info)
+{
+	struct serial_struct new_serial;
+	unsigned int flags;
+	int retval = 0;
 
-		p = tty->index % 4;
-		if (cmd == MOXA_SET_OP_MODE) {
-			if (get_user(opmode, (int __user *) argp))
-				return -EFAULT;
-			if (opmode != RS232_MODE &&
-					opmode != RS485_2WIRE_MODE &&
-					opmode != RS422_MODE &&
-					opmode != RS485_4WIRE_MODE)
-				return -EFAULT;
-			mask = ModeMask[p];
-			shiftbit = p * 2;
-			val = inb(info->opmode_ioaddr);
-			val &= mask;
-			val |= (opmode << shiftbit);
-			outb(val, info->opmode_ioaddr);
-		} else {
-			shiftbit = p * 2;
-			opmode = inb(info->opmode_ioaddr) >> shiftbit;
-			opmode &= OP_MODE_MASK;
-			if (copy_to_user(argp, &opmode, sizeof(int)))
-				return -EFAULT;
-		}
-		return 0;
-	}
-	/* above add by Victor Yu. 01-05-2004 */
+	if (!new_info || !info->ioaddr)
+		return -EFAULT;
+	if (copy_from_user(&new_serial, new_info, sizeof(new_serial)))
+		return -EFAULT;
 
-	if ((cmd != TIOCGSERIAL) && (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
-			return -EIO;
-	}
-	switch (cmd) {
-	case TCSBRK:		/* SVID version: non-zero arg --> no break */
-		retval = tty_check_change(tty);
-		if (retval)
-			return retval;
-		tty_wait_until_sent(tty, 0);
-		if (!arg)
-			mxser_send_break(info, HZ / 4);	/* 1/4 second */
-		return 0;
-	case TCSBRKP:		/* support for POSIX tcsendbreak() */
-		retval = tty_check_change(tty);
-		if (retval)
-			return retval;
-		tty_wait_until_sent(tty, 0);
-		mxser_send_break(info, arg ? arg * (HZ / 10) : HZ / 4);
-		return 0;
-	case TIOCGSOFTCAR:
-		return put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long __user *)argp);
-	case TIOCSSOFTCAR:
-		if (get_user(templ, (unsigned long __user *) argp))
-			return -EFAULT;
-		arg = templ;
-		tty->termios->c_cflag = ((tty->termios->c_cflag & ~CLOCAL) | (arg ? CLOCAL : 0));
-		return 0;
-	case TIOCGSERIAL:
-		return mxser_get_serial_info(info, argp);
-	case TIOCSSERIAL:
-		return mxser_set_serial_info(info, argp);
-	case TIOCSERGETLSR:	/* Get line status register */
-		return mxser_get_lsr_info(info, argp);
-		/*
-		 * Wait for any of the 4 modem inputs (DCD,RI,DSR,CTS) to change
-		 * - mask passed in arg for lines of interest
-		 *   (use |'ed TIOCM_RNG/DSR/CD/CTS for masking)
-		 * Caller should use TIOCGICOUNT to see which one it was
-		 */
-	case TIOCMIWAIT: {
-			DECLARE_WAITQUEUE(wait, current);
-			int ret;
-			spin_lock_irqsave(&info->slock, flags);
-			cprev = info->icount;	/* note the counters on entry */
-			spin_unlock_irqrestore(&info->slock, flags);
+	if ((new_serial.irq != info->board->irq) ||
+			(new_serial.port != info->ioaddr) ||
+			(new_serial.custom_divisor != info->custom_divisor) ||
+			(new_serial.baud_base != info->baud_base))
+		return -EPERM;
 
-			add_wait_queue(&info->delta_msr_wait, &wait);
-			while (1) {
-				spin_lock_irqsave(&info->slock, flags);
-				cnow = info->icount;	/* atomic copy */
-				spin_unlock_irqrestore(&info->slock, flags);
-
-				set_current_state(TASK_INTERRUPTIBLE);
-				if (((arg & TIOCM_RNG) &&
-						(cnow.rng != cprev.rng)) ||
-						((arg & TIOCM_DSR) &&
-						(cnow.dsr != cprev.dsr)) ||
-						((arg & TIOCM_CD) &&
-						(cnow.dcd != cprev.dcd)) ||
-						((arg & TIOCM_CTS) &&
-						(cnow.cts != cprev.cts))) {
-					ret = 0;
-					break;
-				}
-				/* see if a signal did it */
-				if (signal_pending(current)) {
-					ret = -ERESTARTSYS;
-					break;
-				}
-				cprev = cnow;
-			}
-			current->state = TASK_RUNNING;
-			remove_wait_queue(&info->delta_msr_wait, &wait);
-			break;
-		}
-		/* NOTREACHED */
+	flags = info->flags & ASYNC_SPD_MASK;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		if ((new_serial.baud_base != info->baud_base) ||
+				(new_serial.close_delay != info->close_delay) ||
+				((new_serial.flags & ~ASYNC_USR_MASK) != (info->flags & ~ASYNC_USR_MASK)))
+			return -EPERM;
+		info->flags = ((info->flags & ~ASYNC_USR_MASK) |
+				(new_serial.flags & ASYNC_USR_MASK));
+	} else {
 		/*
-		 * Get counter of input serial line interrupts (DCD,RI,DSR,CTS)
-		 * Return: write counters to the user passed counter struct
-		 * NB: both 1->0 and 0->1 transitions are counted except for
-		 *     RI where only 0->1 is counted.
+		 * OK, past this point, all the error checking has been done.
+		 * At this point, we start making changes.....
 		 */
-	case TIOCGICOUNT:
-		spin_lock_irqsave(&info->slock, flags);
-		cnow = info->icount;
-		spin_unlock_irqrestore(&info->slock, flags);
-		p_cuser = argp;
-		/* modified by casper 1/11/2000 */
-		if (put_user(cnow.frame, &p_cuser->frame))
-			return -EFAULT;
-		if (put_user(cnow.brk, &p_cuser->brk))
-			return -EFAULT;
-		if (put_user(cnow.overrun, &p_cuser->overrun))
-			return -EFAULT;
-		if (put_user(cnow.buf_overrun, &p_cuser->buf_overrun))
-			return -EFAULT;
-		if (put_user(cnow.parity, &p_cuser->parity))
-			return -EFAULT;
-		if (put_user(cnow.rx, &p_cuser->rx))
-			return -EFAULT;
-		if (put_user(cnow.tx, &p_cuser->tx))
-			return -EFAULT;
-		put_user(cnow.cts, &p_cuser->cts);
-		put_user(cnow.dsr, &p_cuser->dsr);
-		put_user(cnow.rng, &p_cuser->rng);
-		put_user(cnow.dcd, &p_cuser->dcd);
-		return 0;
-	case MOXA_HighSpeedOn:
-		return put_user(info->baud_base != 115200 ? 1 : 0, (int __user *)argp);
-	case MOXA_SDS_RSTICOUNTER: {
-			info->mon_data.rxcnt = 0;
-			info->mon_data.txcnt = 0;
-			return 0;
-		}
-/* (above) added by James. */
-	case MOXA_ASPP_SETBAUD:{
-			long baud;
-			if (get_user(baud, (long __user *)argp))
-				return -EFAULT;
-			mxser_set_baud(info, baud);
-			return 0;
-		}
-	case MOXA_ASPP_GETBAUD:
-		if (copy_to_user(argp, &info->realbaud, sizeof(long)))
-			return -EFAULT;
+		info->flags = ((info->flags & ~ASYNC_FLAGS) |
+				(new_serial.flags & ASYNC_FLAGS));
+		info->close_delay = new_serial.close_delay * HZ / 100;
+		info->closing_wait = new_serial.closing_wait * HZ / 100;
+		info->tty->low_latency =
+				(info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
+		info->tty->low_latency = 0;	/* (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0; */
+	}
 
-		return 0;
+	/* added by casper, 3/17/2000, for mouse */
+	info->type = new_serial.type;
 
-	case MOXA_ASPP_OQUEUE:{
-			int len, lsr;
+	process_txrx_fifo(info);
 
-			len = mxser_chars_in_buffer(tty);
+	if (info->flags & ASYNC_INITIALIZED) {
+		if (flags != (info->flags & ASYNC_SPD_MASK))
+			mxser_change_speed(info, NULL);
+	} else
+		retval = mxser_startup(info);
 
-			lsr = inb(info->ioaddr + UART_LSR) & UART_LSR_TEMT;
+	return retval;
+}
 
-			len += (lsr ? 0 : 1);
+/*
+ * mxser_get_lsr_info - get line status register info
+ *
+ * Purpose: Let user call ioctl() to get info when the UART physically
+ *	    is emptied.  On bus types like RS485, the transmitter must
+ *	    release the bus after transmitting. This must be done when
+ *	    the transmit shift register is empty, not be done when the
+ *	    transmit holding register is empty.  This functionality
+ *	    allows an RS485 driver to be written in user space.
+ */
+static int mxser_get_lsr_info(struct mxser_port *info,
+		unsigned int __user *value)
+{
+	unsigned char status;
+	unsigned int result;
+	unsigned long flags;
 
-			if (copy_to_user(argp, &len, sizeof(int)))
-				return -EFAULT;
+	spin_lock_irqsave(&info->slock, flags);
+	status = inb(info->ioaddr + UART_LSR);
+	spin_unlock_irqrestore(&info->slock, flags);
+	result = ((status & UART_LSR_TEMT) ? TIOCSER_TEMT : 0);
+	return put_user(result, value);
+}
 
-			return 0;
-		}
-	case MOXA_ASPP_MON: {
-			int mcr, status;
+/*
+ * This routine sends a break character out the serial port.
+ */
+static void mxser_send_break(struct mxser_port *info, int duration)
+{
+	unsigned long flags;
 
-			/* info->mon_data.ser_param = tty->termios->c_cflag; */
+	if (!info->ioaddr)
+		return;
+	set_current_state(TASK_INTERRUPTIBLE);
+	spin_lock_irqsave(&info->slock, flags);
+	outb(inb(info->ioaddr + UART_LCR) | UART_LCR_SBC,
+		info->ioaddr + UART_LCR);
+	spin_unlock_irqrestore(&info->slock, flags);
+	schedule_timeout(duration);
+	spin_lock_irqsave(&info->slock, flags);
+	outb(inb(info->ioaddr + UART_LCR) & ~UART_LCR_SBC,
+		info->ioaddr + UART_LCR);
+	spin_unlock_irqrestore(&info->slock, flags);
+}
 
-			status = mxser_get_msr(info->ioaddr, 1, tty->index);
-			mxser_check_modem_status(info, status);
+static int mxser_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	struct mxser_port *info = tty->driver_data;
+	unsigned char control, status;
+	unsigned long flags;
 
-			mcr = inb(info->ioaddr + UART_MCR);
-			if (mcr & MOXA_MUST_MCR_XON_FLAG)
-				info->mon_data.hold_reason &= ~NPPI_NOTIFY_XOFFHOLD;
-			else
-				info->mon_data.hold_reason |= NPPI_NOTIFY_XOFFHOLD;
 
-			if (mcr & MOXA_MUST_MCR_TX_XON)
-				info->mon_data.hold_reason &= ~NPPI_NOTIFY_XOFFXENT;
-			else
-				info->mon_data.hold_reason |= NPPI_NOTIFY_XOFFXENT;
+	if (tty->index == MXSER_PORTS)
+		return -ENOIOCTLCMD;
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
 
-			if (info->tty->hw_stopped)
-				info->mon_data.hold_reason |= NPPI_NOTIFY_CTSHOLD;
-			else
-				info->mon_data.hold_reason &= ~NPPI_NOTIFY_CTSHOLD;
+	control = info->MCR;
 
-			if (copy_to_user(argp, &info->mon_data,
-					sizeof(struct mxser_mon)))
-				return -EFAULT;
+	spin_lock_irqsave(&info->slock, flags);
+	status = inb(info->ioaddr + UART_MSR);
+	if (status & UART_MSR_ANY_DELTA)
+		mxser_check_modem_status(info, status);
+	spin_unlock_irqrestore(&info->slock, flags);
+	return ((control & UART_MCR_RTS) ? TIOCM_RTS : 0) |
+		    ((control & UART_MCR_DTR) ? TIOCM_DTR : 0) |
+		    ((status & UART_MSR_DCD) ? TIOCM_CAR : 0) |
+		    ((status & UART_MSR_RI) ? TIOCM_RNG : 0) |
+		    ((status & UART_MSR_DSR) ? TIOCM_DSR : 0) |
+		    ((status & UART_MSR_CTS) ? TIOCM_CTS : 0);
+}
 
-			return 0;
-		}
+static int mxser_tiocmset(struct tty_struct *tty, struct file *file,
+		unsigned int set, unsigned int clear)
+{
+	struct mxser_port *info = tty->driver_data;
+	unsigned long flags;
 
-	case MOXA_ASPP_LSTATUS: {
-			if (copy_to_user(argp, &info->err_shadow,
-					sizeof(unsigned char)))
-				return -EFAULT;
 
-			info->err_shadow = 0;
-			return 0;
-		}
-	case MOXA_SET_BAUD_METHOD: {
-			int method;
+	if (tty->index == MXSER_PORTS)
+		return -ENOIOCTLCMD;
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
 
-			if (get_user(method, (int __user *)argp))
-				return -EFAULT;
-			mxser_set_baud_method[tty->index] = method;
-			if (copy_to_user(argp, &method, sizeof(int)))
-				return -EFAULT;
+	spin_lock_irqsave(&info->slock, flags);
 
-			return 0;
+	if (set & TIOCM_RTS)
+		info->MCR |= UART_MCR_RTS;
+	if (set & TIOCM_DTR)
+		info->MCR |= UART_MCR_DTR;
+
+	if (clear & TIOCM_RTS)
+		info->MCR &= ~UART_MCR_RTS;
+	if (clear & TIOCM_DTR)
+		info->MCR &= ~UART_MCR_DTR;
+
+	outb(info->MCR, info->ioaddr + UART_MCR);
+	spin_unlock_irqrestore(&info->slock, flags);
+	return 0;
+}
+
+static int mxser_program_mode(int port)
+{
+	int id, i, j, n;
+	/* unsigned long flags; */
+
+	spin_lock(&gm_lock);
+	outb(0, port);
+	outb(0, port);
+	outb(0, port);
+	(void)inb(port);
+	(void)inb(port);
+	outb(0, port);
+	(void)inb(port);
+	/* restore_flags(flags); */
+	spin_unlock(&gm_lock);
+
+	id = inb(port + 1) & 0x1F;
+	if ((id != C168_ASIC_ID) &&
+			(id != C104_ASIC_ID) &&
+			(id != C102_ASIC_ID) &&
+			(id != CI132_ASIC_ID) &&
+			(id != CI134_ASIC_ID) &&
+			(id != CI104J_ASIC_ID))
+		return -1;
+	for (i = 0, j = 0; i < 4; i++) {
+		n = inb(port + 2);
+		if (n == 'M') {
+			j = 1;
+		} else if ((j == 1) && (n == 1)) {
+			j = 2;
+			break;
+		} else
+			j = 0;
+	}
+	if (j != 2)
+		id = -2;
+	return id;
+}
+
+static void mxser_normal_mode(int port)
+{
+	int i, n;
+
+	outb(0xA5, port + 1);
+	outb(0x80, port + 3);
+	outb(12, port + 0);	/* 9600 bps */
+	outb(0, port + 1);
+	outb(0x03, port + 3);	/* 8 data bits */
+	outb(0x13, port + 4);	/* loop back mode */
+	for (i = 0; i < 16; i++) {
+		n = inb(port + 5);
+		if ((n & 0x61) == 0x60)
+			break;
+		if ((n & 1) == 1)
+			(void)inb(port);
+	}
+	outb(0x00, port + 4);
+}
+
+#define CHIP_SK 	0x01	/* Serial Data Clock  in Eprom */
+#define CHIP_DO 	0x02	/* Serial Data Output in Eprom */
+#define CHIP_CS 	0x04	/* Serial Chip Select in Eprom */
+#define CHIP_DI 	0x08	/* Serial Data Input  in Eprom */
+#define EN_CCMD 	0x000	/* Chip's command register     */
+#define EN0_RSARLO	0x008	/* Remote start address reg 0  */
+#define EN0_RSARHI	0x009	/* Remote start address reg 1  */
+#define EN0_RCNTLO	0x00A	/* Remote byte count reg WR    */
+#define EN0_RCNTHI	0x00B	/* Remote byte count reg WR    */
+#define EN0_DCFG	0x00E	/* Data configuration reg WR   */
+#define EN0_PORT	0x010	/* Rcv missed frame error counter RD */
+#define ENC_PAGE0	0x000	/* Select page 0 of chip registers   */
+#define ENC_PAGE3	0x0C0	/* Select page 3 of chip registers   */
+static int mxser_read_register(int port, unsigned short *regs)
+{
+	int i, k, value, id;
+	unsigned int j;
+
+	id = mxser_program_mode(port);
+	if (id < 0)
+		return id;
+	for (i = 0; i < 14; i++) {
+		k = (i & 0x3F) | 0x180;
+		for (j = 0x100; j > 0; j >>= 1) {
+			outb(CHIP_CS, port);
+			if (k & j) {
+				outb(CHIP_CS | CHIP_DO, port);
+				outb(CHIP_CS | CHIP_DO | CHIP_SK, port);	/* A? bit of read */
+			} else {
+				outb(CHIP_CS, port);
+				outb(CHIP_CS | CHIP_SK, port);	/* A? bit of read */
+			}
 		}
-	default:
-		return -ENOIOCTLCMD;
+		(void)inb(port);
+		value = 0;
+		for (k = 0, j = 0x8000; k < 16; k++, j >>= 1) {
+			outb(CHIP_CS, port);
+			outb(CHIP_CS | CHIP_SK, port);
+			if (inb(port) & CHIP_DI)
+				value |= j;
+		}
+		regs[i] = value;
+		outb(0, port);
 	}
-	return 0;
+	mxser_normal_mode(port);
+	return id;
 }
 
 #ifndef CMSPAR
@@ -1609,6 +1765,251 @@ static int mxser_ioctl_special(unsigned 
 	return 0;
 }
 
+static int mxser_ioctl(struct tty_struct *tty, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	struct mxser_port *info = tty->driver_data;
+	struct async_icount cprev, cnow;	/* kernel counter temps */
+	struct serial_icounter_struct __user *p_cuser;
+	unsigned long templ;
+	unsigned long flags;
+	void __user *argp = (void __user *)arg;
+	int retval;
+
+	if (tty->index == MXSER_PORTS)
+		return mxser_ioctl_special(cmd, argp);
+
+	/* following add by Victor Yu. 01-05-2004 */
+	if (cmd == MOXA_SET_OP_MODE || cmd == MOXA_GET_OP_MODE) {
+		int p;
+		unsigned long opmode;
+		static unsigned char ModeMask[] = { 0xfc, 0xf3, 0xcf, 0x3f };
+		int shiftbit;
+		unsigned char val, mask;
+
+		p = tty->index % 4;
+		if (cmd == MOXA_SET_OP_MODE) {
+			if (get_user(opmode, (int __user *) argp))
+				return -EFAULT;
+			if (opmode != RS232_MODE &&
+					opmode != RS485_2WIRE_MODE &&
+					opmode != RS422_MODE &&
+					opmode != RS485_4WIRE_MODE)
+				return -EFAULT;
+			mask = ModeMask[p];
+			shiftbit = p * 2;
+			val = inb(info->opmode_ioaddr);
+			val &= mask;
+			val |= (opmode << shiftbit);
+			outb(val, info->opmode_ioaddr);
+		} else {
+			shiftbit = p * 2;
+			opmode = inb(info->opmode_ioaddr) >> shiftbit;
+			opmode &= OP_MODE_MASK;
+			if (copy_to_user(argp, &opmode, sizeof(int)))
+				return -EFAULT;
+		}
+		return 0;
+	}
+	/* above add by Victor Yu. 01-05-2004 */
+
+	if ((cmd != TIOCGSERIAL) && (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
+		if (tty->flags & (1 << TTY_IO_ERROR))
+			return -EIO;
+	}
+	switch (cmd) {
+	case TCSBRK:		/* SVID version: non-zero arg --> no break */
+		retval = tty_check_change(tty);
+		if (retval)
+			return retval;
+		tty_wait_until_sent(tty, 0);
+		if (!arg)
+			mxser_send_break(info, HZ / 4);	/* 1/4 second */
+		return 0;
+	case TCSBRKP:		/* support for POSIX tcsendbreak() */
+		retval = tty_check_change(tty);
+		if (retval)
+			return retval;
+		tty_wait_until_sent(tty, 0);
+		mxser_send_break(info, arg ? arg * (HZ / 10) : HZ / 4);
+		return 0;
+	case TIOCGSOFTCAR:
+		return put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long __user *)argp);
+	case TIOCSSOFTCAR:
+		if (get_user(templ, (unsigned long __user *) argp))
+			return -EFAULT;
+		arg = templ;
+		tty->termios->c_cflag = ((tty->termios->c_cflag & ~CLOCAL) | (arg ? CLOCAL : 0));
+		return 0;
+	case TIOCGSERIAL:
+		return mxser_get_serial_info(info, argp);
+	case TIOCSSERIAL:
+		return mxser_set_serial_info(info, argp);
+	case TIOCSERGETLSR:	/* Get line status register */
+		return mxser_get_lsr_info(info, argp);
+		/*
+		 * Wait for any of the 4 modem inputs (DCD,RI,DSR,CTS) to change
+		 * - mask passed in arg for lines of interest
+		 *   (use |'ed TIOCM_RNG/DSR/CD/CTS for masking)
+		 * Caller should use TIOCGICOUNT to see which one it was
+		 */
+	case TIOCMIWAIT: {
+		DECLARE_WAITQUEUE(wait, current);
+		int ret;
+		spin_lock_irqsave(&info->slock, flags);
+		cprev = info->icount;	/* note the counters on entry */
+		spin_unlock_irqrestore(&info->slock, flags);
+
+		add_wait_queue(&info->delta_msr_wait, &wait);
+		while (1) {
+			spin_lock_irqsave(&info->slock, flags);
+			cnow = info->icount;	/* atomic copy */
+			spin_unlock_irqrestore(&info->slock, flags);
+
+			set_current_state(TASK_INTERRUPTIBLE);
+			if (((arg & TIOCM_RNG) &&
+					(cnow.rng != cprev.rng)) ||
+					((arg & TIOCM_DSR) &&
+					(cnow.dsr != cprev.dsr)) ||
+					((arg & TIOCM_CD) &&
+					(cnow.dcd != cprev.dcd)) ||
+					((arg & TIOCM_CTS) &&
+					(cnow.cts != cprev.cts))) {
+				ret = 0;
+				break;
+			}
+			/* see if a signal did it */
+			if (signal_pending(current)) {
+				ret = -ERESTARTSYS;
+				break;
+			}
+			cprev = cnow;
+		}
+		current->state = TASK_RUNNING;
+		remove_wait_queue(&info->delta_msr_wait, &wait);
+		break;
+	}
+	/* NOTREACHED */
+	/*
+	 * Get counter of input serial line interrupts (DCD,RI,DSR,CTS)
+	 * Return: write counters to the user passed counter struct
+	 * NB: both 1->0 and 0->1 transitions are counted except for
+	 *     RI where only 0->1 is counted.
+	 */
+	case TIOCGICOUNT:
+		spin_lock_irqsave(&info->slock, flags);
+		cnow = info->icount;
+		spin_unlock_irqrestore(&info->slock, flags);
+		p_cuser = argp;
+		/* modified by casper 1/11/2000 */
+		if (put_user(cnow.frame, &p_cuser->frame))
+			return -EFAULT;
+		if (put_user(cnow.brk, &p_cuser->brk))
+			return -EFAULT;
+		if (put_user(cnow.overrun, &p_cuser->overrun))
+			return -EFAULT;
+		if (put_user(cnow.buf_overrun, &p_cuser->buf_overrun))
+			return -EFAULT;
+		if (put_user(cnow.parity, &p_cuser->parity))
+			return -EFAULT;
+		if (put_user(cnow.rx, &p_cuser->rx))
+			return -EFAULT;
+		if (put_user(cnow.tx, &p_cuser->tx))
+			return -EFAULT;
+		put_user(cnow.cts, &p_cuser->cts);
+		put_user(cnow.dsr, &p_cuser->dsr);
+		put_user(cnow.rng, &p_cuser->rng);
+		put_user(cnow.dcd, &p_cuser->dcd);
+		return 0;
+	case MOXA_HighSpeedOn:
+		return put_user(info->baud_base != 115200 ? 1 : 0, (int __user *)argp);
+	case MOXA_SDS_RSTICOUNTER:
+		info->mon_data.rxcnt = 0;
+		info->mon_data.txcnt = 0;
+		return 0;
+/* (above) added by James. */
+	case MOXA_ASPP_SETBAUD:{
+		long baud;
+		if (get_user(baud, (long __user *)argp))
+			return -EFAULT;
+		mxser_set_baud(info, baud);
+		return 0;
+	}
+	case MOXA_ASPP_GETBAUD:
+		if (copy_to_user(argp, &info->realbaud, sizeof(long)))
+			return -EFAULT;
+
+		return 0;
+
+	case MOXA_ASPP_OQUEUE:{
+		int len, lsr;
+
+		len = mxser_chars_in_buffer(tty);
+
+		lsr = inb(info->ioaddr + UART_LSR) & UART_LSR_TEMT;
+
+		len += (lsr ? 0 : 1);
+
+		if (copy_to_user(argp, &len, sizeof(int)))
+			return -EFAULT;
+
+		return 0;
+	}
+	case MOXA_ASPP_MON: {
+		int mcr, status;
+
+		/* info->mon_data.ser_param = tty->termios->c_cflag; */
+
+		status = mxser_get_msr(info->ioaddr, 1, tty->index);
+		mxser_check_modem_status(info, status);
+
+		mcr = inb(info->ioaddr + UART_MCR);
+		if (mcr & MOXA_MUST_MCR_XON_FLAG)
+			info->mon_data.hold_reason &= ~NPPI_NOTIFY_XOFFHOLD;
+		else
+			info->mon_data.hold_reason |= NPPI_NOTIFY_XOFFHOLD;
+
+		if (mcr & MOXA_MUST_MCR_TX_XON)
+			info->mon_data.hold_reason &= ~NPPI_NOTIFY_XOFFXENT;
+		else
+			info->mon_data.hold_reason |= NPPI_NOTIFY_XOFFXENT;
+
+		if (info->tty->hw_stopped)
+			info->mon_data.hold_reason |= NPPI_NOTIFY_CTSHOLD;
+		else
+			info->mon_data.hold_reason &= ~NPPI_NOTIFY_CTSHOLD;
+
+		if (copy_to_user(argp, &info->mon_data,
+				sizeof(struct mxser_mon)))
+			return -EFAULT;
+
+		return 0;
+	}
+	case MOXA_ASPP_LSTATUS: {
+		if (copy_to_user(argp, &info->err_shadow,
+				sizeof(unsigned char)))
+			return -EFAULT;
+
+		info->err_shadow = 0;
+		return 0;
+	}
+	case MOXA_SET_BAUD_METHOD: {
+		int method;
+
+		if (get_user(method, (int __user *)argp))
+			return -EFAULT;
+		mxser_set_baud_method[tty->index] = method;
+		if (copy_to_user(argp, &method, sizeof(int)))
+			return -EFAULT;
+
+		return 0;
+	}
+	default:
+		return -ENOIOCTLCMD;
+	}
+	return 0;
+}
+
 static void mxser_stoprx(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
@@ -1633,10 +2034,20 @@ static void mxser_stoprx(struct tty_stru
 	}
 }
 
-static void mxser_startrx(struct tty_struct *tty)
+/*
+ * This routine is called by the upper-layer tty layer to signal that
+ * incoming characters should be throttled.
+ */
+static void mxser_throttle(struct tty_struct *tty)
+{
+	mxser_stoprx(tty);
+}
+
+static void mxser_unthrottle(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 
+	/* startrx */
 	info->ldisc_stop_rx = 0;
 	if (I_IXOFF(tty)) {
 		if (info->x_char)
@@ -1662,17 +2073,37 @@ static void mxser_startrx(struct tty_str
 }
 
 /*
- * This routine is called by the upper-layer tty layer to signal that
- * incoming characters should be throttled.
+ * mxser_stop() and mxser_start()
+ *
+ * This routines are called before setting or resetting tty->stopped.
+ * They enable or disable transmitter interrupts, as necessary.
  */
-static void mxser_throttle(struct tty_struct *tty)
+static void mxser_stop(struct tty_struct *tty)
 {
-	mxser_stoprx(tty);
+	struct mxser_port *info = tty->driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&info->slock, flags);
+	if (info->IER & UART_IER_THRI) {
+		info->IER &= ~UART_IER_THRI;
+		outb(info->IER, info->ioaddr + UART_IER);
+	}
+	spin_unlock_irqrestore(&info->slock, flags);
 }
 
-static void mxser_unthrottle(struct tty_struct *tty)
+static void mxser_start(struct tty_struct *tty)
 {
-	mxser_startrx(tty);
+	struct mxser_port *info = tty->driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&info->slock, flags);
+	if (info->xmit_cnt && info->xmit_buf
+			/* && !(info->IER & UART_IER_THRI) */) {
+		outb(info->IER & ~UART_IER_THRI, info->ioaddr + UART_IER);
+		info->IER |= UART_IER_THRI;
+		outb(info->IER, info->ioaddr + UART_IER);
+	}
+	spin_unlock_irqrestore(&info->slock, flags);
 }
 
 static void mxser_set_termios(struct tty_struct *tty, struct termios *old_termios)
@@ -1710,40 +2141,6 @@ static void mxser_set_termios(struct tty
 }
 
 /*
- * mxser_stop() and mxser_start()
- *
- * This routines are called before setting or resetting tty->stopped.
- * They enable or disable transmitter interrupts, as necessary.
- */
-static void mxser_stop(struct tty_struct *tty)
-{
-	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
-
-	spin_lock_irqsave(&info->slock, flags);
-	if (info->IER & UART_IER_THRI) {
-		info->IER &= ~UART_IER_THRI;
-		outb(info->IER, info->ioaddr + UART_IER);
-	}
-	spin_unlock_irqrestore(&info->slock, flags);
-}
-
-static void mxser_start(struct tty_struct *tty)
-{
-	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
-
-	spin_lock_irqsave(&info->slock, flags);
-	if (info->xmit_cnt && info->xmit_buf
-			/* && !(info->IER & UART_IER_THRI) */) {
-		outb(info->IER & ~UART_IER_THRI, info->ioaddr + UART_IER);
-		info->IER |= UART_IER_THRI;
-		outb(info->IER, info->ioaddr + UART_IER);
-	}
-	spin_unlock_irqrestore(&info->slock, flags);
-}
-
-/*
  * mxser_wait_until_sent() --- wait until the transmitter is empty
  */
 static void mxser_wait_until_sent(struct tty_struct *tty, int timeout)
@@ -1845,122 +2242,6 @@ static void mxser_rs_break(struct tty_st
 
 /* (above) added by James. */
 
-
-/*
- * This is the serial driver's generic interrupt routine
- */
-static irqreturn_t mxser_interrupt(int irq, void *dev_id, struct pt_regs *regs)
-{
-	int status, iir, i;
-	struct mxser_board *brd = NULL;
-	struct mxser_port *port;
-	int max, irqbits, bits, msr;
-	int pass_counter = 0;
-	unsigned int int_cnt;
-	int handled = IRQ_NONE;
-
-	/* spin_lock(&gm_lock); */
-
-	for (i = 0; i < MXSER_BOARDS; i++)
-		if (dev_id == &mxser_boards[i]) {
-			brd = dev_id;
-			break;
-		}
-
-	if (i == MXSER_BOARDS)
-		goto irq_stop;
-	if (brd == NULL)
-		goto irq_stop;
-	max = mxser_numports[brd->board_type - 1];
-	while (1) {
-		irqbits = inb(brd->vector) & brd->vector_mask;
-		if (irqbits == brd->vector_mask)
-			break;
-
-		handled = IRQ_HANDLED;
-		for (i = 0, bits = 1; i < max; i++, irqbits |= bits, bits <<= 1) {
-			if (irqbits == brd->vector_mask)
-				break;
-			if (bits & irqbits)
-				continue;
-			port = &brd->ports[i];
-
-			int_cnt = 0;
-			do {
-				/* following add by Victor Yu. 09-13-2002 */
-				iir = inb(port->ioaddr + UART_IIR);
-				if (iir & UART_IIR_NO_INT)
-					break;
-				iir &= MOXA_MUST_IIR_MASK;
-				if (!port->tty) {
-					status = inb(port->ioaddr + UART_LSR);
-					outb(0x27, port->ioaddr + UART_FCR);
-					inb(port->ioaddr + UART_MSR);
-					break;
-				}
-				/* above add by Victor Yu. 09-13-2002 */
-
-				/* following add by Victor Yu. 09-02-2002 */
-				status = inb(port->ioaddr + UART_LSR);
-
-				if (status & UART_LSR_PE)
-					port->err_shadow |= NPPI_NOTIFY_PARITY;
-				if (status & UART_LSR_FE)
-					port->err_shadow |= NPPI_NOTIFY_FRAMING;
-				if (status & UART_LSR_OE)
-					port->err_shadow |=
-						NPPI_NOTIFY_HW_OVERRUN;
-				if (status & UART_LSR_BI)
-					port->err_shadow |= NPPI_NOTIFY_BREAK;
-
-				if (port->board->chip_flag) {
-					/*
-					   if ( (status & 0x02) && !(status & 0x01) ) {
-					   outb(port->ioaddr+UART_FCR,  0x23);
-					   continue;
-					   }
-					 */
-					if (iir == MOXA_MUST_IIR_GDA ||
-					    iir == MOXA_MUST_IIR_RDA ||
-					    iir == MOXA_MUST_IIR_RTO ||
-					    iir == MOXA_MUST_IIR_LSR)
-						mxser_receive_chars(port,
-								&status);
-
-				} else {
-					/* above add by Victor Yu. 09-02-2002 */
-
-					status &= port->read_status_mask;
-					if (status & UART_LSR_DR)
-						mxser_receive_chars(port,
-								&status);
-				}
-				msr = inb(port->ioaddr + UART_MSR);
-				if (msr & UART_MSR_ANY_DELTA)
-					mxser_check_modem_status(port, msr);
-
-				/* following add by Victor Yu. 09-13-2002 */
-				if (port->board->chip_flag) {
-					if (iir == 0x02 && (status &
-								UART_LSR_THRE))
-						mxser_transmit_chars(port);
-				} else {
-					/* above add by Victor Yu. 09-13-2002 */
-
-					if (status & UART_LSR_THRE)
-						mxser_transmit_chars(port);
-				}
-			} while (int_cnt++ < MXSER_ISR_PASS_LIMIT);
-		}
-		if (pass_counter++ > MXSER_ISR_PASS_LIMIT)
-			break;	/* Prevent infinite loops */
-	}
-
-      irq_stop:
-	/* spin_unlock(&gm_lock); */
-	return handled;
-}
-
 static void mxser_receive_chars(struct mxser_port *port, int *status)
 {
 	struct tty_struct *tty = port->tty;
@@ -2155,744 +2436,202 @@ unlock:
 	spin_unlock_irqrestore(&port->slock, flags);
 }
 
-static void mxser_check_modem_status(struct mxser_port *port, int status)
+/*
+ * This is the serial driver's generic interrupt routine
+ */
+static irqreturn_t mxser_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	/* update input line counters */
-	if (status & UART_MSR_TERI)
-		port->icount.rng++;
-	if (status & UART_MSR_DDSR)
-		port->icount.dsr++;
-	if (status & UART_MSR_DDCD)
-		port->icount.dcd++;
-	if (status & UART_MSR_DCTS)
-		port->icount.cts++;
-	port->mon_data.modem_status = status;
-	wake_up_interruptible(&port->delta_msr_wait);
-
-	if ((port->flags & ASYNC_CHECK_CD) && (status & UART_MSR_DDCD)) {
-		if (status & UART_MSR_DCD)
-			wake_up_interruptible(&port->open_wait);
-		schedule_work(&port->tqueue);
-	}
+	int status, iir, i;
+	struct mxser_board *brd = NULL;
+	struct mxser_port *port;
+	int max, irqbits, bits, msr;
+	int pass_counter = 0;
+	unsigned int int_cnt;
+	int handled = IRQ_NONE;
 
-	if (port->flags & ASYNC_CTS_FLOW) {
-		if (port->tty->hw_stopped) {
-			if (status & UART_MSR_CTS) {
-				port->tty->hw_stopped = 0;
+	/* spin_lock(&gm_lock); */
 
-				if ((port->type != PORT_16550A) &&
-						(!port->board->chip_flag)) {
-					outb(port->IER & ~UART_IER_THRI,
-						port->ioaddr + UART_IER);
-					port->IER |= UART_IER_THRI;
-					outb(port->IER, port->ioaddr +
-							UART_IER);
-				}
-				set_bit(MXSER_EVENT_TXLOW, &port->event);
-				schedule_work(&port->tqueue);
-			}
-		} else {
-			if (!(status & UART_MSR_CTS)) {
-				port->tty->hw_stopped = 1;
-				if (port->type != PORT_16550A &&
-						!port->board->chip_flag) {
-					port->IER &= ~UART_IER_THRI;
-					outb(port->IER, port->ioaddr +
-							UART_IER);
-				}
-			}
+	for (i = 0; i < MXSER_BOARDS; i++)
+		if (dev_id == &mxser_boards[i]) {
+			brd = dev_id;
+			break;
 		}
-	}
-}
-
-static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp, struct mxser_port *port)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	int retval;
-	int do_clocal = 0;
-	unsigned long flags;
 
-	/*
-	 * If non-blocking mode is set, or the port is not enabled,
-	 * then make the check up front and then exit.
-	 */
-	if ((filp->f_flags & O_NONBLOCK) || (tty->flags & (1 << TTY_IO_ERROR))) {
-		port->flags |= ASYNC_NORMAL_ACTIVE;
-		return 0;
-	}
-
-	if (tty->termios->c_cflag & CLOCAL)
-		do_clocal = 1;
-
-	/*
-	 * Block waiting for the carrier detect and the line to become
-	 * free (i.e., not in use by the callout).  While we are in
-	 * this loop, port->count is dropped by one, so that
-	 * mxser_close() knows when to free things.  We restore it upon
-	 * exit, either normal or abnormal.
-	 */
-	retval = 0;
-	add_wait_queue(&port->open_wait, &wait);
-
-	spin_lock_irqsave(&port->slock, flags);
-	if (!tty_hung_up_p(filp))
-		port->count--;
-	spin_unlock_irqrestore(&port->slock, flags);
-	port->blocked_open++;
+	if (i == MXSER_BOARDS)
+		goto irq_stop;
+	if (brd == NULL)
+		goto irq_stop;
+	max = mxser_numports[brd->board_type - 1];
 	while (1) {
-		spin_lock_irqsave(&port->slock, flags);
-		outb(inb(port->ioaddr + UART_MCR) |
-			UART_MCR_DTR | UART_MCR_RTS, port->ioaddr + UART_MCR);
-		spin_unlock_irqrestore(&port->slock, flags);
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) {
-			if (port->flags & ASYNC_HUP_NOTIFY)
-				retval = -EAGAIN;
-			else
-				retval = -ERESTARTSYS;
-			break;
-		}
-		if (!(port->flags & ASYNC_CLOSING) &&
-				(do_clocal ||
-				(inb(port->ioaddr + UART_MSR) & UART_MSR_DCD)))
-			break;
-		if (signal_pending(current)) {
-			retval = -ERESTARTSYS;
+		irqbits = inb(brd->vector) & brd->vector_mask;
+		if (irqbits == brd->vector_mask)
 			break;
-		}
-		schedule();
-	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&port->open_wait, &wait);
-	if (!tty_hung_up_p(filp))
-		port->count++;
-	port->blocked_open--;
-	if (retval)
-		return retval;
-	port->flags |= ASYNC_NORMAL_ACTIVE;
-	return 0;
-}
-
-static int mxser_startup(struct mxser_port *info)
-{
-	unsigned long page;
-	unsigned long flags;
-
-	page = __get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	spin_lock_irqsave(&info->slock, flags);
-
-	if (info->flags & ASYNC_INITIALIZED) {
-		free_page(page);
-		spin_unlock_irqrestore(&info->slock, flags);
-		return 0;
-	}
 
-	if (!info->ioaddr || !info->type) {
-		if (info->tty)
-			set_bit(TTY_IO_ERROR, &info->tty->flags);
-		free_page(page);
-		spin_unlock_irqrestore(&info->slock, flags);
-		return 0;
-	}
-	if (info->xmit_buf)
-		free_page(page);
-	else
-		info->xmit_buf = (unsigned char *) page;
-
-	/*
-	 * Clear the FIFO buffers and disable them
-	 * (they will be reenabled in mxser_change_speed())
-	 */
-	if (info->board->chip_flag)
-		outb((UART_FCR_CLEAR_RCVR |
-			UART_FCR_CLEAR_XMIT |
-			MOXA_MUST_FCR_GDA_MODE_ENABLE), info->ioaddr + UART_FCR);
-	else
-		outb((UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT),
-			info->ioaddr + UART_FCR);
-
-	/*
-	 * At this point there's no way the LSR could still be 0xFF;
-	 * if it is, then bail out, because there's likely no UART
-	 * here.
-	 */
-	if (inb(info->ioaddr + UART_LSR) == 0xff) {
-		spin_unlock_irqrestore(&info->slock, flags);
-		if (capable(CAP_SYS_ADMIN)) {
-			if (info->tty)
-				set_bit(TTY_IO_ERROR, &info->tty->flags);
-			return 0;
-		} else
-			return -ENODEV;
-	}
-
-	/*
-	 * Clear the interrupt registers.
-	 */
-	(void) inb(info->ioaddr + UART_LSR);
-	(void) inb(info->ioaddr + UART_RX);
-	(void) inb(info->ioaddr + UART_IIR);
-	(void) inb(info->ioaddr + UART_MSR);
-
-	/*
-	 * Now, initialize the UART
-	 */
-	outb(UART_LCR_WLEN8, info->ioaddr + UART_LCR);	/* reset DLAB */
-	info->MCR = UART_MCR_DTR | UART_MCR_RTS;
-	outb(info->MCR, info->ioaddr + UART_MCR);
-
-	/*
-	 * Finally, enable interrupts
-	 */
-	info->IER = UART_IER_MSI | UART_IER_RLSI | UART_IER_RDI;
-	/* info->IER = UART_IER_RLSI | UART_IER_RDI; */
-
-	/* following add by Victor Yu. 08-30-2002 */
-	if (info->board->chip_flag)
-		info->IER |= MOXA_MUST_IER_EGDAI;
-	/* above add by Victor Yu. 08-30-2002 */
-	outb(info->IER, info->ioaddr + UART_IER);	/* enable interrupts */
-
-	/*
-	 * And clear the interrupt registers again for luck.
-	 */
-	(void) inb(info->ioaddr + UART_LSR);
-	(void) inb(info->ioaddr + UART_RX);
-	(void) inb(info->ioaddr + UART_IIR);
-	(void) inb(info->ioaddr + UART_MSR);
-
-	if (info->tty)
-		clear_bit(TTY_IO_ERROR, &info->tty->flags);
-	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
-
-	/*
-	 * and set the speed of the serial port
-	 */
-	spin_unlock_irqrestore(&info->slock, flags);
-	mxser_change_speed(info, NULL);
-
-	info->flags |= ASYNC_INITIALIZED;
-	return 0;
-}
-
-/*
- * This routine will shutdown a serial port; interrupts maybe disabled, and
- * DTR is dropped if the hangup on close termio flag is on.
- */
-static void mxser_shutdown(struct mxser_port *info)
-{
-	unsigned long flags;
-
-	if (!(info->flags & ASYNC_INITIALIZED))
-		return;
-
-	spin_lock_irqsave(&info->slock, flags);
-
-	/*
-	 * clear delta_msr_wait queue to avoid mem leaks: we may free the irq
-	 * here so the queue might never be waken up
-	 */
-	wake_up_interruptible(&info->delta_msr_wait);
-
-	/*
-	 * Free the IRQ, if necessary
-	 */
-	if (info->xmit_buf) {
-		free_page((unsigned long) info->xmit_buf);
-		info->xmit_buf = NULL;
-	}
-
-	info->IER = 0;
-	outb(0x00, info->ioaddr + UART_IER);
-
-	if (!info->tty || (info->tty->termios->c_cflag & HUPCL))
-		info->MCR &= ~(UART_MCR_DTR | UART_MCR_RTS);
-	outb(info->MCR, info->ioaddr + UART_MCR);
-
-	/* clear Rx/Tx FIFO's */
-	/* following add by Victor Yu. 08-30-2002 */
-	if (info->board->chip_flag)
-		outb(UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT |
-				MOXA_MUST_FCR_GDA_MODE_ENABLE,
-				info->ioaddr + UART_FCR);
-	else
-		/* above add by Victor Yu. 08-30-2002 */
-		outb(UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
-			info->ioaddr + UART_FCR);
-
-	/* read data port to reset things */
-	(void) inb(info->ioaddr + UART_RX);
-
-	if (info->tty)
-		set_bit(TTY_IO_ERROR, &info->tty->flags);
-
-	info->flags &= ~ASYNC_INITIALIZED;
-
-	/* following add by Victor Yu. 09-23-2002 */
-	if (info->board->chip_flag)
-		SET_MOXA_MUST_NO_SOFTWARE_FLOW_CONTROL(info->ioaddr);
-	/* above add by Victor Yu. 09-23-2002 */
-
-	spin_unlock_irqrestore(&info->slock, flags);
-}
-
-/*
- * This routine is called to set the UART divisor registers to match
- * the specified baud rate for a serial port.
- */
-static int mxser_change_speed(struct mxser_port *info,
-		struct termios *old_termios)
-{
-	unsigned cflag, cval, fcr;
-	int ret = 0;
-	unsigned char status;
-	long baud;
-	unsigned long flags;
-
-	if (!info->tty || !info->tty->termios)
-		return ret;
-	cflag = info->tty->termios->c_cflag;
-	if (!(info->ioaddr))
-		return ret;
-
-#ifndef B921600
-#define B921600 (B460800 +1)
-#endif
-	if (mxser_set_baud_method[info->tty->index] == 0) {
-		baud = tty_get_baud_rate(info->tty);
-		mxser_set_baud(info, baud);
-	}
-
-	/* byte size and parity */
-	switch (cflag & CSIZE) {
-	case CS5:
-		cval = 0x00;
-		break;
-	case CS6:
-		cval = 0x01;
-		break;
-	case CS7:
-		cval = 0x02;
-		break;
-	case CS8:
-		cval = 0x03;
-		break;
-	default:
-		cval = 0x00;
-		break;		/* too keep GCC shut... */
-	}
-	if (cflag & CSTOPB)
-		cval |= 0x04;
-	if (cflag & PARENB)
-		cval |= UART_LCR_PARITY;
-	if (!(cflag & PARODD))
-		cval |= UART_LCR_EPAR;
-	if (cflag & CMSPAR)
-		cval |= UART_LCR_SPAR;
-
-	if ((info->type == PORT_8250) || (info->type == PORT_16450)) {
-		if (info->board->chip_flag) {
-			fcr = UART_FCR_ENABLE_FIFO;
-			fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
-			SET_MOXA_MUST_FIFO_VALUE(info);
-		} else
-			fcr = 0;
-	} else {
-		fcr = UART_FCR_ENABLE_FIFO;
-		/* following add by Victor Yu. 08-30-2002 */
-		if (info->board->chip_flag) {
-			fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
-			SET_MOXA_MUST_FIFO_VALUE(info);
-		} else {
-			/* above add by Victor Yu. 08-30-2002 */
-			switch (info->rx_trigger) {
-			case 1:
-				fcr |= UART_FCR_TRIGGER_1;
-				break;
-			case 4:
-				fcr |= UART_FCR_TRIGGER_4;
-				break;
-			case 8:
-				fcr |= UART_FCR_TRIGGER_8;
-				break;
-			default:
-				fcr |= UART_FCR_TRIGGER_14;
+		handled = IRQ_HANDLED;
+		for (i = 0, bits = 1; i < max; i++, irqbits |= bits, bits <<= 1) {
+			if (irqbits == brd->vector_mask)
 				break;
-			}
-		}
-	}
+			if (bits & irqbits)
+				continue;
+			port = &brd->ports[i];
 
-	/* CTS flow control flag and modem status interrupts */
-	info->IER &= ~UART_IER_MSI;
-	info->MCR &= ~UART_MCR_AFE;
-	if (cflag & CRTSCTS) {
-		info->flags |= ASYNC_CTS_FLOW;
-		info->IER |= UART_IER_MSI;
-		if ((info->type == PORT_16550A) || (info->board->chip_flag)) {
-			info->MCR |= UART_MCR_AFE;
-/*			status = mxser_get_msr(info->ioaddr, 0, info->port); */
-/*
-	save_flags(flags);
-	cli();
-	status = inb(baseaddr + UART_MSR);
-	restore_flags(flags);
-*/
-			/* mxser_check_modem_status(info, status); */
-		} else {
-/*			status = mxser_get_msr(info->ioaddr, 0, info->port); */
-			/* MX_LOCK(&info->slock); */
-			status = inb(info->ioaddr + UART_MSR);
-			/* MX_UNLOCK(&info->slock); */
-			if (info->tty->hw_stopped) {
-				if (status & UART_MSR_CTS) {
-					info->tty->hw_stopped = 0;
-					if (info->type != PORT_16550A &&
-							!info->board->chip_flag) {
-						outb(info->IER & ~UART_IER_THRI,
-							info->ioaddr +
-							UART_IER);
-						info->IER |= UART_IER_THRI;
-						outb(info->IER, info->ioaddr +
-								UART_IER);
-					}
-					set_bit(MXSER_EVENT_TXLOW, &info->event);
-					schedule_work(&info->tqueue);				}
-			} else {
-				if (!(status & UART_MSR_CTS)) {
-					info->tty->hw_stopped = 1;
-					if ((info->type != PORT_16550A) &&
-							(!info->board->chip_flag)) {
-						info->IER &= ~UART_IER_THRI;
-						outb(info->IER, info->ioaddr +
-								UART_IER);
-					}
+			int_cnt = 0;
+			do {
+				/* following add by Victor Yu. 09-13-2002 */
+				iir = inb(port->ioaddr + UART_IIR);
+				if (iir & UART_IIR_NO_INT)
+					break;
+				iir &= MOXA_MUST_IIR_MASK;
+				if (!port->tty) {
+					status = inb(port->ioaddr + UART_LSR);
+					outb(0x27, port->ioaddr + UART_FCR);
+					inb(port->ioaddr + UART_MSR);
+					break;
 				}
-			}
-		}
-	} else {
-		info->flags &= ~ASYNC_CTS_FLOW;
-	}
-	outb(info->MCR, info->ioaddr + UART_MCR);
-	if (cflag & CLOCAL) {
-		info->flags &= ~ASYNC_CHECK_CD;
-	} else {
-		info->flags |= ASYNC_CHECK_CD;
-		info->IER |= UART_IER_MSI;
-	}
-	outb(info->IER, info->ioaddr + UART_IER);
-
-	/*
-	 * Set up parity check flag
-	 */
-	info->read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
-	if (I_INPCK(info->tty))
-		info->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
-	if (I_BRKINT(info->tty) || I_PARMRK(info->tty))
-		info->read_status_mask |= UART_LSR_BI;
-
-	info->ignore_status_mask = 0;
-
-	if (I_IGNBRK(info->tty)) {
-		info->ignore_status_mask |= UART_LSR_BI;
-		info->read_status_mask |= UART_LSR_BI;
-		/*
-		 * If we're ignore parity and break indicators, ignore
-		 * overruns too.  (For real raw support).
-		 */
-		if (I_IGNPAR(info->tty)) {
-			info->ignore_status_mask |=
-						UART_LSR_OE |
-						UART_LSR_PE |
-						UART_LSR_FE;
-			info->read_status_mask |=
-						UART_LSR_OE |
-						UART_LSR_PE |
-						UART_LSR_FE;
-		}
-	}
-	/* following add by Victor Yu. 09-02-2002 */
-	if (info->board->chip_flag) {
-		spin_lock_irqsave(&info->slock, flags);
-		SET_MOXA_MUST_XON1_VALUE(info->ioaddr, START_CHAR(info->tty));
-		SET_MOXA_MUST_XOFF1_VALUE(info->ioaddr, STOP_CHAR(info->tty));
-		if (I_IXON(info->tty)) {
-			ENABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
-		} else {
-			DISABLE_MOXA_MUST_RX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
-		}
-		if (I_IXOFF(info->tty)) {
-			ENABLE_MOXA_MUST_TX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
-		} else {
-			DISABLE_MOXA_MUST_TX_SOFTWARE_FLOW_CONTROL(info->ioaddr);
-		}
-		/*
-		   if ( I_IXANY(info->tty) ) {
-		   info->MCR |= MOXA_MUST_MCR_XON_ANY;
-		   ENABLE_MOXA_MUST_XON_ANY_FLOW_CONTROL(info->ioaddr);
-		   } else {
-		   info->MCR &= ~MOXA_MUST_MCR_XON_ANY;
-		   DISABLE_MOXA_MUST_XON_ANY_FLOW_CONTROL(info->ioaddr);
-		   }
-		 */
-		spin_unlock_irqrestore(&info->slock, flags);
-	}
-	/* above add by Victor Yu. 09-02-2002 */
-
-
-	outb(fcr, info->ioaddr + UART_FCR);	/* set fcr */
-	outb(cval, info->ioaddr + UART_LCR);
-
-	return ret;
-}
-
-
-static int mxser_set_baud(struct mxser_port *info, long newspd)
-{
-	int quot = 0;
-	unsigned char cval;
-	int ret = 0;
-	unsigned long flags;
-
-	if (!info->tty || !info->tty->termios)
-		return ret;
-
-	if (!(info->ioaddr))
-		return ret;
-
-	if (newspd > info->max_baud)
-		return 0;
-
-	info->realbaud = newspd;
-	if (newspd == 134) {
-		quot = (2 * info->baud_base / 269);
-	} else if (newspd) {
-		quot = info->baud_base / newspd;
-		if (quot == 0)
-			quot = 1;
-	} else {
-		quot = 0;
-	}
-
-	info->timeout = ((info->xmit_fifo_size * HZ * 10 * quot) / info->baud_base);
-	info->timeout += HZ / 50;	/* Add .02 seconds of slop */
-
-	if (quot) {
-		spin_lock_irqsave(&info->slock, flags);
-		info->MCR |= UART_MCR_DTR;
-		outb(info->MCR, info->ioaddr + UART_MCR);
-		spin_unlock_irqrestore(&info->slock, flags);
-	} else {
-		spin_lock_irqsave(&info->slock, flags);
-		info->MCR &= ~UART_MCR_DTR;
-		outb(info->MCR, info->ioaddr + UART_MCR);
-		spin_unlock_irqrestore(&info->slock, flags);
-		return ret;
-	}
-
-	cval = inb(info->ioaddr + UART_LCR);
-
-	outb(cval | UART_LCR_DLAB, info->ioaddr + UART_LCR);	/* set DLAB */
-
-	outb(quot & 0xff, info->ioaddr + UART_DLL);	/* LS of divisor */
-	outb(quot >> 8, info->ioaddr + UART_DLM);	/* MS of divisor */
-	outb(cval, info->ioaddr + UART_LCR);	/* reset DLAB */
-
-
-	return ret;
-}
+				/* above add by Victor Yu. 09-13-2002 */
 
-/*
- * ------------------------------------------------------------
- * friends of mxser_ioctl()
- * ------------------------------------------------------------
- */
-static int mxser_get_serial_info(struct mxser_port *info,
-		struct serial_struct __user *retinfo)
-{
-	struct serial_struct tmp;
+				/* following add by Victor Yu. 09-02-2002 */
+				status = inb(port->ioaddr + UART_LSR);
 
-	if (!retinfo)
-		return -EFAULT;
-	memset(&tmp, 0, sizeof(tmp));
-	tmp.type = info->type;
-	tmp.line = info->tty->index;
-	tmp.port = info->ioaddr;
-	tmp.irq = info->board->irq;
-	tmp.flags = info->flags;
-	tmp.baud_base = info->baud_base;
-	tmp.close_delay = info->close_delay;
-	tmp.closing_wait = info->closing_wait;
-	tmp.custom_divisor = info->custom_divisor;
-	tmp.hub6 = 0;
-	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
-		return -EFAULT;
-	return 0;
-}
+				if (status & UART_LSR_PE)
+					port->err_shadow |= NPPI_NOTIFY_PARITY;
+				if (status & UART_LSR_FE)
+					port->err_shadow |= NPPI_NOTIFY_FRAMING;
+				if (status & UART_LSR_OE)
+					port->err_shadow |=
+						NPPI_NOTIFY_HW_OVERRUN;
+				if (status & UART_LSR_BI)
+					port->err_shadow |= NPPI_NOTIFY_BREAK;
 
-static int mxser_set_serial_info(struct mxser_port *info,
-		struct serial_struct __user *new_info)
-{
-	struct serial_struct new_serial;
-	unsigned int flags;
-	int retval = 0;
+				if (port->board->chip_flag) {
+					/*
+					   if ( (status & 0x02) && !(status & 0x01) ) {
+					   outb(port->ioaddr+UART_FCR,  0x23);
+					   continue;
+					   }
+					 */
+					if (iir == MOXA_MUST_IIR_GDA ||
+					    iir == MOXA_MUST_IIR_RDA ||
+					    iir == MOXA_MUST_IIR_RTO ||
+					    iir == MOXA_MUST_IIR_LSR)
+						mxser_receive_chars(port,
+								&status);
 
-	if (!new_info || !info->ioaddr)
-		return -EFAULT;
-	if (copy_from_user(&new_serial, new_info, sizeof(new_serial)))
-		return -EFAULT;
+				} else {
+					/* above add by Victor Yu. 09-02-2002 */
 
-	if ((new_serial.irq != info->board->irq) ||
-			(new_serial.port != info->ioaddr) ||
-			(new_serial.custom_divisor != info->custom_divisor) ||
-			(new_serial.baud_base != info->baud_base))
-		return -EPERM;
+					status &= port->read_status_mask;
+					if (status & UART_LSR_DR)
+						mxser_receive_chars(port,
+								&status);
+				}
+				msr = inb(port->ioaddr + UART_MSR);
+				if (msr & UART_MSR_ANY_DELTA)
+					mxser_check_modem_status(port, msr);
 
-	flags = info->flags & ASYNC_SPD_MASK;
+				/* following add by Victor Yu. 09-13-2002 */
+				if (port->board->chip_flag) {
+					if (iir == 0x02 && (status &
+								UART_LSR_THRE))
+						mxser_transmit_chars(port);
+				} else {
+					/* above add by Victor Yu. 09-13-2002 */
 
-	if (!capable(CAP_SYS_ADMIN)) {
-		if ((new_serial.baud_base != info->baud_base) ||
-				(new_serial.close_delay != info->close_delay) ||
-				((new_serial.flags & ~ASYNC_USR_MASK) != (info->flags & ~ASYNC_USR_MASK)))
-			return -EPERM;
-		info->flags = ((info->flags & ~ASYNC_USR_MASK) |
-				(new_serial.flags & ASYNC_USR_MASK));
-	} else {
-		/*
-		 * OK, past this point, all the error checking has been done.
-		 * At this point, we start making changes.....
-		 */
-		info->flags = ((info->flags & ~ASYNC_FLAGS) |
-				(new_serial.flags & ASYNC_FLAGS));
-		info->close_delay = new_serial.close_delay * HZ / 100;
-		info->closing_wait = new_serial.closing_wait * HZ / 100;
-		info->tty->low_latency =
-				(info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
-		info->tty->low_latency = 0;	/* (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0; */
+					if (status & UART_LSR_THRE)
+						mxser_transmit_chars(port);
+				}
+			} while (int_cnt++ < MXSER_ISR_PASS_LIMIT);
+		}
+		if (pass_counter++ > MXSER_ISR_PASS_LIMIT)
+			break;	/* Prevent infinite loops */
 	}
 
-	/* added by casper, 3/17/2000, for mouse */
-	info->type = new_serial.type;
-
-	process_txrx_fifo(info);
-
-	if (info->flags & ASYNC_INITIALIZED) {
-		if (flags != (info->flags & ASYNC_SPD_MASK))
-			mxser_change_speed(info, NULL);
-	} else
-		retval = mxser_startup(info);
-
-	return retval;
+      irq_stop:
+	/* spin_unlock(&gm_lock); */
+	return handled;
 }
 
-/*
- * mxser_get_lsr_info - get line status register info
- *
- * Purpose: Let user call ioctl() to get info when the UART physically
- *	    is emptied.  On bus types like RS485, the transmitter must
- *	    release the bus after transmitting. This must be done when
- *	    the transmit shift register is empty, not be done when the
- *	    transmit holding register is empty.  This functionality
- *	    allows an RS485 driver to be written in user space.
- */
-static int mxser_get_lsr_info(struct mxser_port *info,
-		unsigned int __user *value)
-{
-	unsigned char status;
-	unsigned int result;
-	unsigned long flags;
-
-	spin_lock_irqsave(&info->slock, flags);
-	status = inb(info->ioaddr + UART_LSR);
-	spin_unlock_irqrestore(&info->slock, flags);
-	result = ((status & UART_LSR_TEMT) ? TIOCSER_TEMT : 0);
-	return put_user(result, value);
-}
+static const struct tty_operations mxser_ops = {
+	.open = mxser_open,
+	.close = mxser_close,
+	.write = mxser_write,
+	.put_char = mxser_put_char,
+	.flush_chars = mxser_flush_chars,
+	.write_room = mxser_write_room,
+	.chars_in_buffer = mxser_chars_in_buffer,
+	.flush_buffer = mxser_flush_buffer,
+	.ioctl = mxser_ioctl,
+	.throttle = mxser_throttle,
+	.unthrottle = mxser_unthrottle,
+	.set_termios = mxser_set_termios,
+	.stop = mxser_stop,
+	.start = mxser_start,
+	.hangup = mxser_hangup,
+	.break_ctl = mxser_rs_break,
+	.wait_until_sent = mxser_wait_until_sent,
+	.tiocmget = mxser_tiocmget,
+	.tiocmset = mxser_tiocmset,
+};
 
 /*
- * This routine sends a break character out the serial port.
+ * The MOXA Smartio/Industio serial driver boot-time initialization code!
  */
-static void mxser_send_break(struct mxser_port *info, int duration)
-{
-	unsigned long flags;
 
-	if (!info->ioaddr)
-		return;
-	set_current_state(TASK_INTERRUPTIBLE);
-	spin_lock_irqsave(&info->slock, flags);
-	outb(inb(info->ioaddr + UART_LCR) | UART_LCR_SBC,
-		info->ioaddr + UART_LCR);
-	spin_unlock_irqrestore(&info->slock, flags);
-	schedule_timeout(duration);
-	spin_lock_irqsave(&info->slock, flags);
-	outb(inb(info->ioaddr + UART_LCR) & ~UART_LCR_SBC,
-		info->ioaddr + UART_LCR);
-	spin_unlock_irqrestore(&info->slock, flags);
-}
-
-static int mxser_tiocmget(struct tty_struct *tty, struct file *file)
+static int __devinit mxser_initbrd(struct mxser_board *brd)
 {
-	struct mxser_port *info = tty->driver_data;
-	unsigned char control, status;
-	unsigned long flags;
-
-
-	if (tty->index == MXSER_PORTS)
-		return -ENOIOCTLCMD;
-	if (tty->flags & (1 << TTY_IO_ERROR))
-		return -EIO;
-
-	control = info->MCR;
+	struct mxser_port *info;
+	unsigned int i;
+	int retval;
 
-	spin_lock_irqsave(&info->slock, flags);
-	status = inb(info->ioaddr + UART_MSR);
-	if (status & UART_MSR_ANY_DELTA)
-		mxser_check_modem_status(info, status);
-	spin_unlock_irqrestore(&info->slock, flags);
-	return ((control & UART_MCR_RTS) ? TIOCM_RTS : 0) |
-		    ((control & UART_MCR_DTR) ? TIOCM_DTR : 0) |
-		    ((status & UART_MSR_DCD) ? TIOCM_CAR : 0) |
-		    ((status & UART_MSR_RI) ? TIOCM_RNG : 0) |
-		    ((status & UART_MSR_DSR) ? TIOCM_DSR : 0) |
-		    ((status & UART_MSR_CTS) ? TIOCM_CTS : 0);
-}
+	printk(KERN_INFO "max. baud rate = %d bps.\n", brd->ports[0].max_baud);
 
-static int mxser_tiocmset(struct tty_struct *tty, struct file *file,
-		unsigned int set, unsigned int clear)
-{
-	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
+	for (i = 0; i < brd->nports; i++) {
+		info = &brd->ports[i];
+		info->board = brd;
+		info->stop_rx = 0;
+		info->ldisc_stop_rx = 0;
 
+		/* Enhance mode enabled here */
+		if (brd->chip_flag != MOXA_OTHER_UART)
+			ENABLE_MOXA_MUST_ENCHANCE_MODE(info->ioaddr);
 
-	if (tty->index == MXSER_PORTS)
-		return -ENOIOCTLCMD;
-	if (tty->flags & (1 << TTY_IO_ERROR))
-		return -EIO;
+		info->flags = ASYNC_SHARE_IRQ;
+		info->type = brd->uart_type;
 
-	spin_lock_irqsave(&info->slock, flags);
+		process_txrx_fifo(info);
 
-	if (set & TIOCM_RTS)
-		info->MCR |= UART_MCR_RTS;
-	if (set & TIOCM_DTR)
-		info->MCR |= UART_MCR_DTR;
+		info->custom_divisor = info->baud_base * 16;
+		info->close_delay = 5 * HZ / 10;
+		info->closing_wait = 30 * HZ;
+		INIT_WORK(&info->tqueue, mxser_do_softint, info);
+		info->normal_termios = mxvar_sdriver->init_termios;
+		init_waitqueue_head(&info->open_wait);
+		init_waitqueue_head(&info->close_wait);
+		init_waitqueue_head(&info->delta_msr_wait);
+		memset(&info->mon_data, 0, sizeof(struct mxser_mon));
+		info->err_shadow = 0;
+		spin_lock_init(&info->slock);
 
-	if (clear & TIOCM_RTS)
-		info->MCR &= ~UART_MCR_RTS;
-	if (clear & TIOCM_DTR)
-		info->MCR &= ~UART_MCR_DTR;
+		/* before set INT ISR, disable all int */
+		outb(inb(info->ioaddr + UART_IER) & 0xf0,
+			info->ioaddr + UART_IER);
+	}
+	/*
+	 * Allocate the IRQ if necessary
+	 */
 
-	outb(info->MCR, info->ioaddr + UART_MCR);
-	spin_unlock_irqrestore(&info->slock, flags);
+	retval = request_irq(brd->irq, mxser_interrupt,
+			(brd->ports[0].flags & ASYNC_SHARE_IRQ) ? IRQF_SHARED :
+			IRQF_DISABLED, "mxser", brd);
+	if (retval) {
+		printk(KERN_ERR "Board %s: Request irq failed, IRQ (%d) may "
+			"conflict with another device.\n",
+			mxser_brdname[brd->board_type - 1], brd->irq);
+		return retval;
+	}
 	return 0;
 }
 
-
-static int mxser_read_register(int, unsigned short *);
-static int mxser_program_mode(int);
-static void mxser_normal_mode(int);
-
 static int __init mxser_get_ISA_conf(int cap, struct mxser_board *brd)
 {
 	int id, i, bits;
@@ -2988,111 +2727,303 @@ static int __init mxser_get_ISA_conf(int
 	return brd->nports;
 }
 
-#define CHIP_SK 	0x01	/* Serial Data Clock  in Eprom */
-#define CHIP_DO 	0x02	/* Serial Data Output in Eprom */
-#define CHIP_CS 	0x04	/* Serial Chip Select in Eprom */
-#define CHIP_DI 	0x08	/* Serial Data Input  in Eprom */
-#define EN_CCMD 	0x000	/* Chip's command register     */
-#define EN0_RSARLO	0x008	/* Remote start address reg 0  */
-#define EN0_RSARHI	0x009	/* Remote start address reg 1  */
-#define EN0_RCNTLO	0x00A	/* Remote byte count reg WR    */
-#define EN0_RCNTHI	0x00B	/* Remote byte count reg WR    */
-#define EN0_DCFG	0x00E	/* Data configuration reg WR   */
-#define EN0_PORT	0x010	/* Rcv missed frame error counter RD */
-#define ENC_PAGE0	0x000	/* Select page 0 of chip registers   */
-#define ENC_PAGE3	0x0C0	/* Select page 3 of chip registers   */
-static int mxser_read_register(int port, unsigned short *regs)
+static int __init mxser_get_PCI_conf(int board_type, struct mxser_board *brd,
+		struct pci_dev *pdev)
 {
-	int i, k, value, id;
-	unsigned int j;
+	unsigned int i, j;
+	unsigned long ioaddress;
+	int retval;
 
-	id = mxser_program_mode(port);
-	if (id < 0)
-		return id;
-	for (i = 0; i < 14; i++) {
-		k = (i & 0x3F) | 0x180;
-		for (j = 0x100; j > 0; j >>= 1) {
-			outb(CHIP_CS, port);
-			if (k & j) {
-				outb(CHIP_CS | CHIP_DO, port);
-				outb(CHIP_CS | CHIP_DO | CHIP_SK, port);	/* A? bit of read */
-			} else {
-				outb(CHIP_CS, port);
-				outb(CHIP_CS | CHIP_SK, port);	/* A? bit of read */
+	/* io address */
+	brd->board_type = board_type;
+	brd->nports = mxser_numports[board_type - 1];
+	ioaddress = pci_resource_start(pdev, 2);
+	retval = pci_request_region(pdev, 2, "mxser(IO)");
+	if (retval)
+		goto err;
+
+	for (i = 0; i < brd->nports; i++)
+		brd->ports[i].ioaddr = ioaddress + 8 * i;
+
+	/* vector */
+	ioaddress = pci_resource_start(pdev, 3);
+	retval = pci_request_region(pdev, 3, "mxser(vector)");
+	if (retval)
+		goto err_relio;
+	brd->vector = ioaddress;
+
+	/* irq */
+	brd->irq = pdev->irq;
+
+	brd->chip_flag = CheckIsMoxaMust(brd->ports[0].ioaddr);
+	brd->uart_type = PORT_16550A;
+	brd->vector_mask = 0;
+
+	for (i = 0; i < brd->nports; i++) {
+		for (j = 0; j < UART_INFO_NUM; j++) {
+			if (Gpci_uart_info[j].type == brd->chip_flag) {
+				brd->ports[i].max_baud =
+					Gpci_uart_info[j].max_baud;
+
+				/* exception....CP-102 */
+				if (board_type == MXSER_BOARD_CP102)
+					brd->ports[i].max_baud = 921600;
+				break;
 			}
 		}
-		(void)inb(port);
-		value = 0;
-		for (k = 0, j = 0x8000; k < 16; k++, j >>= 1) {
-			outb(CHIP_CS, port);
-			outb(CHIP_CS | CHIP_SK, port);
-			if (inb(port) & CHIP_DI)
-				value |= j;
+	}
+
+	if (brd->chip_flag == MOXA_MUST_MU860_HWID) {
+		for (i = 0; i < brd->nports; i++) {
+			if (i < 4)
+				brd->ports[i].opmode_ioaddr = ioaddress + 4;
+			else
+				brd->ports[i].opmode_ioaddr = ioaddress + 0x0c;
 		}
-		regs[i] = value;
-		outb(0, port);
+		outb(0, ioaddress + 4);	/* default set to RS232 mode */
+		outb(0, ioaddress + 0x0c);	/* default set to RS232 mode */
 	}
-	mxser_normal_mode(port);
-	return id;
+
+	for (i = 0; i < brd->nports; i++) {
+		brd->vector_mask |= (1 << i);
+		brd->ports[i].baud_base = 921600;
+	}
+	return 0;
+err_relio:
+	pci_release_region(pdev, 2);
+err:
+	return retval;
 }
 
-static int mxser_program_mode(int port)
+static int __init mxser_module_init(void)
 {
-	int id, i, j, n;
-	/* unsigned long flags; */
+	struct pci_dev *pdev = NULL;
+	struct mxser_board *brd;
+	unsigned int i, m;
+	int retval, b, n;
 
-	spin_lock(&gm_lock);
-	outb(0, port);
-	outb(0, port);
-	outb(0, port);
-	(void)inb(port);
-	(void)inb(port);
-	outb(0, port);
-	(void)inb(port);
-	/* restore_flags(flags); */
-	spin_unlock(&gm_lock);
+	pr_debug("Loading module mxser ...\n");
 
-	id = inb(port + 1) & 0x1F;
-	if ((id != C168_ASIC_ID) &&
-			(id != C104_ASIC_ID) &&
-			(id != C102_ASIC_ID) &&
-			(id != CI132_ASIC_ID) &&
-			(id != CI134_ASIC_ID) &&
-			(id != CI104J_ASIC_ID))
-		return -1;
-	for (i = 0, j = 0; i < 4; i++) {
-		n = inb(port + 2);
-		if (n == 'M') {
-			j = 1;
-		} else if ((j == 1) && (n == 1)) {
-			j = 2;
-			break;
-		} else
-			j = 0;
+	mxvar_sdriver = alloc_tty_driver(MXSER_PORTS + 1);
+	if (!mxvar_sdriver)
+		return -ENOMEM;
+	spin_lock_init(&gm_lock);
+
+	for (i = 0; i < MXSER_BOARDS; i++)
+		mxser_boards[i].board_type = -1;
+
+	printk(KERN_INFO "MOXA Smartio/Industio family driver version %s\n",
+		MXSER_VERSION);
+
+	/* Initialize the tty_driver structure */
+	mxvar_sdriver->magic = TTY_DRIVER_MAGIC;
+	mxvar_sdriver->name = "ttyM";
+	mxvar_sdriver->major = ttymajor;
+	mxvar_sdriver->minor_start = 0;
+	mxvar_sdriver->num = MXSER_PORTS + 1;
+	mxvar_sdriver->type = TTY_DRIVER_TYPE_SERIAL;
+	mxvar_sdriver->subtype = SERIAL_TYPE_NORMAL;
+	mxvar_sdriver->init_termios = tty_std_termios;
+	mxvar_sdriver->init_termios.c_cflag = B9600|CS8|CREAD|HUPCL|CLOCAL;
+	mxvar_sdriver->flags = TTY_DRIVER_REAL_RAW;
+	tty_set_operations(mxvar_sdriver, &mxser_ops);
+	mxvar_sdriver->ttys = mxvar_tty;
+	mxvar_sdriver->termios = mxvar_termios;
+	mxvar_sdriver->termios_locked = mxvar_termios_locked;
+
+	mxvar_diagflag = 0;
+
+	m = 0;
+	/* Start finding ISA boards here */
+	for (b = 0; b < MXSER_BOARDS && m < MXSER_BOARDS; b++) {
+		int cap;
+
+		if (!(cap = mxserBoardCAP[b]))
+			continue;
+
+		brd = &mxser_boards[m];
+		retval = mxser_get_ISA_conf(cap, brd);
+
+		if (retval != 0)
+			printk(KERN_INFO "Found MOXA %s board (CAP=0x%x)\n",
+				mxser_brdname[brd->board_type - 1], ioaddr[b]);
+
+		if (retval <= 0) {
+			if (retval == MXSER_ERR_IRQ)
+				printk(KERN_ERR "Invalid interrupt number, "
+					"board not configured\n");
+			else if (retval == MXSER_ERR_IRQ_CONFLIT)
+				printk(KERN_ERR "Invalid interrupt number, "
+					"board not configured\n");
+			else if (retval == MXSER_ERR_VECTOR)
+				printk(KERN_ERR "Invalid interrupt vector, "
+					"board not configured\n");
+			else if (retval == MXSER_ERR_IOADDR)
+				printk(KERN_ERR "Invalid I/O address, "
+					"board not configured\n");
+
+			continue;
+		}
+
+		brd->pdev = NULL;
+
+		/* mxser_initbrd will hook ISR. */
+		if (mxser_initbrd(brd) < 0)
+			continue;
+
+		m++;
 	}
-	if (j != 2)
-		id = -2;
-	return id;
+
+	/* Start finding ISA boards from module arg */
+	for (b = 0; b < MXSER_BOARDS && m < MXSER_BOARDS; b++) {
+		unsigned long cap;
+
+		if (!(cap = ioaddr[b]))
+			continue;
+
+		brd = &mxser_boards[m];
+		retval = mxser_get_ISA_conf(cap, &mxser_boards[m]);
+
+		if (retval != 0)
+			printk(KERN_INFO "Found MOXA %s board (CAP=0x%x)\n",
+				mxser_brdname[brd->board_type - 1], ioaddr[b]);
+
+		if (retval <= 0) {
+			if (retval == MXSER_ERR_IRQ)
+				printk(KERN_ERR "Invalid interrupt number, "
+					"board not configured\n");
+			else if (retval == MXSER_ERR_IRQ_CONFLIT)
+				printk(KERN_ERR "Invalid interrupt number, "
+					"board not configured\n");
+			else if (retval == MXSER_ERR_VECTOR)
+				printk(KERN_ERR "Invalid interrupt vector, "
+					"board not configured\n");
+			else if (retval == MXSER_ERR_IOADDR)
+				printk(KERN_ERR "Invalid I/O address, "
+					"board not configured\n");
+
+			continue;
+		}
+
+		brd->pdev = NULL;
+		/* mxser_initbrd will hook ISR. */
+		if (mxser_initbrd(brd) < 0)
+			continue;
+
+		m++;
+	}
+
+	/* start finding PCI board here */
+	n = ARRAY_SIZE(mxser_pcibrds) - 1;
+	b = 0;
+	while (b < n) {
+		pdev = pci_get_device(mxser_pcibrds[b].vendor,
+				mxser_pcibrds[b].device, pdev);
+		if (pdev == NULL) {
+			b++;
+			continue;
+		}
+		printk(KERN_INFO "Found MOXA %s board(BusNo=%d,DevNo=%d)\n",
+			mxser_brdname[(int) (mxser_pcibrds[b].driver_data) - 1],
+			pdev->bus->number, PCI_SLOT(pdev->devfn));
+		if (m >= MXSER_BOARDS)
+			printk(KERN_ERR
+				"Too many Smartio/Industio family boards find "
+				"(maximum %d), board not configured\n",
+				MXSER_BOARDS);
+		else {
+			if (pci_enable_device(pdev)) {
+				printk(KERN_ERR "Moxa SmartI/O PCI enable "
+					"fail !\n");
+				continue;
+			}
+			brd = &mxser_boards[m];
+			brd->pdev = pdev;
+			retval = mxser_get_PCI_conf(
+					(int)mxser_pcibrds[b].driver_data,
+					brd, pdev);
+			if (retval < 0) {
+				if (retval == MXSER_ERR_IRQ)
+					printk(KERN_ERR
+						"Invalid interrupt number, "
+						"board not configured\n");
+				else if (retval == MXSER_ERR_IRQ_CONFLIT)
+					printk(KERN_ERR
+						"Invalid interrupt number, "
+						"board not configured\n");
+				else if (retval == MXSER_ERR_VECTOR)
+					printk(KERN_ERR
+						"Invalid interrupt vector, "
+						"board not configured\n");
+				else if (retval == MXSER_ERR_IOADDR)
+					printk(KERN_ERR
+						"Invalid I/O address, "
+						"board not configured\n");
+				continue;
+			}
+			/* mxser_initbrd will hook ISR. */
+			if (mxser_initbrd(brd) < 0)
+				continue;
+			m++;
+			/* Keep an extra reference if we succeeded. It will
+			   be returned at unload time */
+			pci_dev_get(pdev);
+		}
+	}
+
+	retval = tty_register_driver(mxvar_sdriver);
+	if (retval) {
+		printk(KERN_ERR "Couldn't install MOXA Smartio/Industio family"
+				" driver !\n");
+		put_tty_driver(mxvar_sdriver);
+
+		for (i = 0; i < MXSER_BOARDS; i++) {
+			if (mxser_boards[i].board_type == -1)
+				continue;
+			else {
+				free_irq(mxser_boards[i].irq, &mxser_boards[i]);
+				/* todo: release io, vector */
+			}
+		}
+		return retval;
+	}
+
+	pr_debug("Done.\n");
+
+	return retval;
 }
 
-static void mxser_normal_mode(int port)
+static void __exit mxser_module_exit(void)
 {
-	int i, n;
+	int i, err;
 
-	outb(0xA5, port + 1);
-	outb(0x80, port + 3);
-	outb(12, port + 0);	/* 9600 bps */
-	outb(0, port + 1);
-	outb(0x03, port + 3);	/* 8 data bits */
-	outb(0x13, port + 4);	/* loop back mode */
-	for (i = 0; i < 16; i++) {
-		n = inb(port + 5);
-		if ((n & 0x61) == 0x60)
-			break;
-		if ((n & 1) == 1)
-			(void)inb(port);
+	pr_debug("Unloading module mxser ...\n");
+
+	err = tty_unregister_driver(mxvar_sdriver);
+	if (!err)
+		put_tty_driver(mxvar_sdriver);
+	else
+		printk(KERN_ERR "Couldn't unregister MOXA Smartio/Industio family serial driver\n");
+
+	for (i = 0; i < MXSER_BOARDS; i++) {
+		struct pci_dev *pdev;
+
+		if (mxser_boards[i].board_type == -1)
+			continue;
+		else {
+			pdev = mxser_boards[i].pdev;
+			free_irq(mxser_boards[i].irq, &mxser_boards[i]);
+			if (pdev != NULL) {	/* PCI */
+				pci_release_region(pdev, 2);
+				pci_release_region(pdev, 3);
+				pci_dev_put(pdev);
+			} else {
+				release_region(mxser_boards[i].ports[0].ioaddr, 8 * mxser_boards[i].nports);
+				release_region(mxser_boards[i].vector, 1);
+			}
+		}
 	}
-	outb(0x00, port + 4);
+	pr_debug("Done.\n");
 }
 
 module_init(mxser_module_init);
