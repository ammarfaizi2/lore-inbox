Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWAVIde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWAVIde (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 03:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWAVIde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 03:33:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4228 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751264AbWAVIdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 03:33:33 -0500
Date: Sun, 22 Jan 2006 00:33:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: anemo@mba.ocn.ne.jp, linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH] serial: serial_txx9 driver update
Message-Id: <20060122003307.738931b7.akpm@osdl.org>
In-Reply-To: <20060122080015.GA10398@flint.arm.linux.org.uk>
References: <20060118.021901.71085469.anemo@mba.ocn.ne.jp>
	<20060121233649.51211403.akpm@osdl.org>
	<20060122080015.GA10398@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Sat, Jan 21, 2006 at 11:36:49PM -0800, Andrew Morton wrote:
> > Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > >
> > >  serial_txx9_verify_port(struct uart_port *port, struct serial_struct *ser)
> > >   {
> > >  -	if (ser->irq < 0 ||
> > >  -	    ser->baud_base < 9600 || ser->type != PORT_TXX9)
> > >  +	unsigned long new_port = (unsigned long)ser->port +
> > >  +		((unsigned long)ser->port_high << ((sizeof(long) - sizeof(int)) * 8));
> > 
> > Are you sure about this part?  Shifting something left by sizeof(something)
> > seems very strange.  It'll give different results on 64-bit machines for
> > the same hardware.  Are you sure it wasn't supposed to be an addition?
> 
> There is a definition for that constant - it's called HIGH_BITS_OFFSET.

There are two definitions, actually.  drivers/serial/serial_core.c and
drivers/serial/8250.h.

> No need to try to buggily recreate it.

Where's the bug in the proposed code?

Can you tell us what HIGH_BITS_OFFSET actually does?  Stuffing the port
address into the upper 32-bits of a ulong on 64-bit machines.  Am consumed
by curiosity.

