Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266715AbUHOOld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266715AbUHOOld (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266717AbUHOOld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:41:33 -0400
Received: from gprs212-247.eurotel.cz ([160.218.212.247]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266715AbUHOOlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:41:14 -0400
Date: Sat, 14 Aug 2004 22:57:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: pavouk@comp.cz
Subject: ttyS0 vs. ttyS00 confusion
Message-ID: <20040814205700.GA3453@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

According to devices.txt, serial ports are reffered as ttyS0 (and not
ttyS00). It would be nice to use that convention in printks,
too.. Please apply,
								Pavel

--- tmp/linux/arch/ia64/hp/sim/simserial.c	2004-05-20 23:08:05.000000000 +0200
+++ linux/arch/ia64/hp/sim/simserial.c	2004-08-14 22:48:20.000000000 +0200
@@ -1055,7 +1055,7 @@
 			ia64_ssc_connect_irq(KEYBOARD_INTR, state->irq);
 		}
 
-		printk(KERN_INFO "ttyS%02d at 0x%04lx (irq = %d) is a %s\n",
+		printk(KERN_INFO "ttyS%d at 0x%04lx (irq = %d) is a %s\n",
 		       state->line,
 		       state->port, state->irq,
 		       uart_config[state->type].name);
--- tmp/linux/arch/ppc/8xx_io/uart.c	2004-06-22 12:35:54.000000000 +0200
+++ linux/arch/ppc/8xx_io/uart.c	2004-08-14 22:48:48.000000000 +0200
@@ -2592,7 +2592,7 @@
 		state->icount.rx = state->icount.tx = 0;
 		state->icount.frame = state->icount.parity = 0;
 		state->icount.overrun = state->icount.brk = 0;
-		printk(KERN_INFO "ttyS%02d at 0x%04x is a %s\n",
+		printk(KERN_INFO "ttyS%d at 0x%04x is a %s\n",
 		       i, (unsigned int)(state->port),
 		       (state->smc_scc_num & NUM_IS_SCC) ? "SCC" : "SMC");
 #ifdef CONFIG_SERIAL_CONSOLE
--- tmp/linux/drivers/char/amiserial.c	2004-03-11 18:10:50.000000000 +0100
+++ linux/drivers/char/amiserial.c	2004-08-14 22:46:33.000000000 +0200
@@ -430,7 +430,7 @@
 
 	if ((info->flags & ASYNC_CHECK_CD) && (dstatus & SER_DCD)) {
 #if (defined(SERIAL_DEBUG_OPEN) || defined(SERIAL_DEBUG_INTR))
-		printk("ttyS%02d CD now %s...", info->line,
+		printk("ttyS%d CD now %s...", info->line,
 		       (!(status & SER_DCD)) ? "on" : "off");
 #endif
 		if (!(status & SER_DCD))
@@ -2095,7 +2095,7 @@
 	  continue;
 	*/
 
-	printk(KERN_INFO "ttyS%02d is the amiga builtin serial port\n",
+	printk(KERN_INFO "ttyS%d is the amiga builtin serial port\n",
 		       state->line);
 
 	/* Hardware set up */
--- tmp/linux/drivers/char/serial167.c	2004-03-11 18:10:51.000000000 +0100
+++ linux/drivers/char/serial167.c	2004-08-14 22:46:09.000000000 +0200
@@ -2379,7 +2379,7 @@
                                        | CyPARITY| CyFRAME| CyOVERRUN;
 		/* info->timeout */
 
-		printk("ttyS%1d ", info->line);
+		printk("ttyS%d ", info->line);
 		port_num++;info++;
 		if(!(port_num & 7)){
 		    printk("\n               ");
--- tmp/linux/drivers/serial/68360serial.c	2004-06-22 12:36:23.000000000 +0200
+++ linux/drivers/serial/68360serial.c	2004-08-14 22:49:13.000000000 +0200
@@ -2592,7 +2592,7 @@
 		state->icount.rx = state->icount.tx = 0;
 		state->icount.frame = state->icount.parity = 0;
 		state->icount.overrun = state->icount.brk = 0;
-		printk(KERN_INFO "ttyS%02d at irq 0x%02x is an %s\n",
+		printk(KERN_INFO "ttyS%d at irq 0x%02x is an %s\n",
 		       i, (unsigned int)(state->irq),
 		       (state->smc_scc_num & NUM_IS_SCC) ? "SCC" : "SMC");
 
--- tmp/linux/drivers/tc/zs.c	2004-05-20 23:08:23.000000000 +0200
+++ linux/drivers/tc/zs.c	2004-08-14 22:49:51.000000000 +0200
@@ -706,7 +706,7 @@
 	save_flags(flags); cli();
 
 #ifdef SERIAL_DEBUG_OPEN
-	printk("starting up ttyS%02d (irq %d)...", info->line, info->irq);
+	printk("starting up ttyS%d (irq %d)...", info->line, info->irq);
 #endif
 
 	/*
@@ -1356,7 +1356,7 @@
 	}
 	
 #ifdef SERIAL_DEBUG_OPEN
-	printk("rs_close ttyS%02d, count = %d\n", info->line, info->count);
+	printk("rs_close ttyS%d, count = %d\n", info->line, info->count);
 #endif
 	if ((tty->count == 1) && (info->count != 1)) {
 		/*
@@ -1371,7 +1371,7 @@
 		info->count = 1;
 	}
 	if (--info->count < 0) {
-		printk("rs_close: bad serial port count for ttyS%02d: %d\n",
+		printk("rs_close: bad serial port count for ttyS%d: %d\n",
 		       info->line, info->count);
 		info->count = 0;
 	}
@@ -1531,7 +1531,7 @@
 	retval = 0;
 	add_wait_queue(&info->open_wait, &wait);
 #ifdef SERIAL_DEBUG_OPEN
-	printk("block_til_ready before block: ttyS%02d, count = %d\n",
+	printk("block_til_ready before block: ttyS%d, count = %d\n",
 	       info->line, info->count);
 #endif
 	cli();
@@ -1565,7 +1565,7 @@
 			break;
 		}
 #ifdef SERIAL_DEBUG_OPEN
-		printk("block_til_ready blocking: ttyS%02d, count = %d\n",
+		printk("block_til_ready blocking: ttyS%d, count = %d\n",
 		       info->line, info->count);
 #endif
 		schedule();
@@ -1576,7 +1576,7 @@
 		info->count++;
 	info->blocked_open--;
 #ifdef SERIAL_DEBUG_OPEN
-	printk("block_til_ready after blocking: ttyS%02d, count = %d\n",
+	printk("block_til_ready after blocking: ttyS%d, count = %d\n",
 	       info->line, info->count);
 #endif
 	if (retval)
@@ -1896,7 +1896,7 @@
 		info->tqueue.data = info;
 		init_waitqueue_head(&info->open_wait);
 		init_waitqueue_head(&info->close_wait);
-		printk("ttyS%02d at 0x%08x (irq = %d)", info->line, 
+		printk("ttyS%d at 0x%08x (irq = %d)", info->line, 
 		       info->port, info->irq);
 		printk(" is a Z85C30 SCC\n");
 		tty_register_device(serial_driver, info->line, NULL);


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
