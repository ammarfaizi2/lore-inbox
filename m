Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269119AbUJFIV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269119AbUJFIV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 04:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269093AbUJFIVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 04:21:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:17812 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269091AbUJFIVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 04:21:23 -0400
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <20041006082658.A18379@flint.arm.linux.org.uk>
References: <1096534248.32721.36.camel@gaston>
	 <20041006082658.A18379@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1097050508.21132.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 18:15:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 17:26, Russell King wrote:
> On Thu, Sep 30, 2004 at 06:50:48PM +1000, Benjamin Herrenschmidt wrote:
> > +#ifndef ARCH_HAS_GET_LEGACY_SERIAL_PORTS
> >  static struct old_serial_port old_serial_port[] = {
> >  	SERIAL_PORT_DFNS /* defined in asm/serial.h */
> >  };
> > -
> > +static inline struct old_serial_port *get_legacy_serial_ports(unsigned int *count)
> > +{
> > +	*count = ARRAY_SIZE(old_serial_port);
> > +	return old_serial_port;
> > +}
> >  #define UART_NR	(ARRAY_SIZE(old_serial_port) + CONFIG_SERIAL_8250_NR_UARTS)
> > +#endif /* ARCH_HAS_GET_LEGACY_SERIAL_PORTS */
> > +
> 
> What happens if 8250.c is built as a module and
> ARCH_HAS_GET_LEGACY_SERIAL_PORTS is defined?

It well call get_legacy_serial_ports() which is hopefully exported by
the arch code.

> serial.h is used by userspace programs.  We should not expose this
> structure to those programs.  Instead, maybe creating an 8250.h
> header, or even moving the existing 8250.h header ?

Hrm... ok. Or adding a #ifdef __KERNEL__ (sic !) :)

I'll send you a new patch later today as I had to do another fix, we
tend to "force" register_console() apparently even when we have nothing
to register because we set the "ops" to all ports even those who were
never configured and we test "ops" to decide wether to succeed or fail
in the console setup() callback.

Ben.


