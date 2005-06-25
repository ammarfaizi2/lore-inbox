Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263386AbVFYJ5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbVFYJ5y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 05:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbVFYJ5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 05:57:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59405 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263386AbVFYJ5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 05:57:49 -0400
Date: Sat, 25 Jun 2005 10:57:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Zankel <chris@zankel.net>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Add removal schedule of register_serial/unregister_serial to appropriate file
Message-ID: <20050625105744.B16381@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Chris Zankel <chris@zankel.net>,
	David Howells <dhowells@redhat.com>
References: <20050623142335.A5564@flint.arm.linux.org.uk> <20050625104725.A16381@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050625104725.A16381@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sat, Jun 25, 2005 at 10:47:25AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2005 at 10:47:25AM +0100, Russell King wrote:
> On Thu, Jun 23, 2005 at 02:23:35PM +0100, Russell King wrote:
> > +What:	register_serial/unregister_serial
> > +When:	December 2005
> > +Why:	This interface does not allow serial ports to be registered against
> > +	a struct device, and as such does not allow correct power management
> > +	of such ports.  8250-based ports should use serial8250_register_port
> > +	and serial8250_unregister_port instead.
> > +Who:	Russell King <rmk@arm.linux.org.uk>
> 
> Other places appear to have a prototype for these functions but do not
> use them:
> 
> arch/xtensa/platform-iss/console.c:int register_serial(struct serial_struct*);
> arch/xtensa/platform-iss/console.c:void unregister_serial(int);
> drivers/char/amiserial.c:int register_serial(struct serial_struct *req);
> drivers/char/amiserial.c:void unregister_serial(int line);
> 
> The patch which follows this message will remove these.
> 
> 
> In terms of the use of these functions, this is the state of play as of
> yesterday:
> 
> arch/frv/kernel/setup.c://      register_serial(&__frv_uart0);
> arch/frv/kernel/setup.c://      register_serial(&__frv_uart1);

I've also removed this.  The following is mostly for comment only.
I'm intending to commit this change by Monday at the latest.

[PATCH] Serial: remove unnecessary register_serial/unregister_serial

A couple of drivers declare register_serial/unregister_serial
prototypes but don't use them.  FRV contains a commented out
call to register_serial.  Since these are deprecated, remove
these unnecessary references.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Index: arch/frv/kernel/setup.c
===================================================================
--- 39040c7a05edd69381c0a25636a1a328d856cb9c/arch/frv/kernel/setup.c  (mode:100644)
+++ uncommitted/arch/frv/kernel/setup.c  (mode:100644)
@@ -790,12 +790,10 @@
 #ifndef CONFIG_GDBSTUB_UART0
 	__reg(UART0_BASE + UART_IER * 8) = 0;
 	early_serial_setup(&__frv_uart0);
-//	register_serial(&__frv_uart0);
 #endif
 #ifndef CONFIG_GDBSTUB_UART1
 	__reg(UART1_BASE + UART_IER * 8) = 0;
 	early_serial_setup(&__frv_uart1);
-//	register_serial(&__frv_uart1);
 #endif
 
 #if defined(CONFIG_CHR_DEV_FLASH) || defined(CONFIG_BLK_DEV_FLASH)
Index: arch/xtensa/platform-iss/console.c
===================================================================
--- 39040c7a05edd69381c0a25636a1a328d856cb9c/arch/xtensa/platform-iss/console.c  (mode:100644)
+++ uncommitted/arch/xtensa/platform-iss/console.c  (mode:100644)
@@ -198,9 +198,6 @@
 }
 
 
-int register_serial(struct serial_struct*);
-void unregister_serial(int);
-
 static struct tty_operations serial_ops = {
 	.open = rs_open,
 	.close = rs_close,
Index: drivers/char/amiserial.c
===================================================================
--- 39040c7a05edd69381c0a25636a1a328d856cb9c/drivers/char/amiserial.c  (mode:100644)
+++ uncommitted/drivers/char/amiserial.c  (mode:100644)
@@ -1973,10 +1973,6 @@
 }
 
 
-int register_serial(struct serial_struct *req);
-void unregister_serial(int line);
-
-
 static struct tty_operations serial_ops = {
 	.open = rs_open,
 	.close = rs_close,


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
