Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265535AbUA0Agx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265594AbUA0Agx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:36:53 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:43920 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265535AbUA0Agv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:36:51 -0500
Date: Mon, 26 Jan 2004 19:22:04 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Amit Gurdasani <amitg@alumni.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EISA ID for PnP modem and resource allocation
Message-ID: <20040126192204.GA7280@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Amit Gurdasani <amitg@alumni.cmu.edu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0312261610200.1798@athena> <20031229143711.GA3176@neo.rr.com> <Pine.LNX.4.56.0312300338360.1163@athena> <20031229225037.GB3198@neo.rr.com> <20040104162654.A27227@flint.arm.linux.org.uk> <Pine.LNX.4.56.0401051713370.4783@athena.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0401051713370.4783@athena.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 05:23:27PM +0400, Amit Gurdasani wrote:
> On Sun, 4 Jan 2004, Russell King wrote:
> 
> :On Mon, Dec 29, 2003 at 10:50:37PM +0000, Adam Belay wrote:
> :> > ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
> :> > ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> :> > ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
> :> > parport0: irq 7 detected
> :>
> :> Hmm, it shouldn't be reporting irq 0.  The probbing code may be confused.
> :> I would guess it is on irq 4.
> :
> :irq0 on x86 means "I'll use polled mode".

It occured to me that we should probably check which resources the pnpbios is
reporting.  If you have a chance, could you please show me the output of this
hack.

Thanks,
Adam

--- a/drivers/serial/8250_pnp.c	2004-01-23 15:05:39.000000000 +0000
+++ b/drivers/serial/8250_pnp.c	2004-01-26 19:10:34.000000000 +0000
@@ -32,6 +32,8 @@
 
 #define UNKNOWN_DEV 0x3000
 
+#define SERIAL_DEBUG_PNP 1
+
 
 static const struct pnp_device_id pnp_dev_table[] = {
 	/* Archtek America Corp. */
@@ -402,8 +404,8 @@
 	if (HIGH_BITS_OFFSET)
 		serial_req.port = pnp_port_start(dev, 0) >> HIGH_BITS_OFFSET;
 #ifdef SERIAL_DEBUG_PNP
-	printk("Setup PNP port: port %x, irq %d, type %d\n",
-	       serial_req.port, serial_req.irq, serial_req.io_type);
+	printk("Setup PNP port: port %x, irq %d, type %d, pnp_node %x\n",
+	       serial_req.port, serial_req.irq, serial_req.io_type, dev->number);
 #endif
 
 	serial_req.flags = ASYNC_SKIP_TEST | ASYNC_AUTOPROBE;
