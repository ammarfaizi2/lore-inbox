Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVHOQea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVHOQea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbVHOQea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:34:30 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:27877 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964830AbVHOQe3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:34:29 -0400
Subject: Re: uart_port structure in serial8250_port[i]  doesn't have the
	port_type values
From: "V. Ananda Krishnan" <mansarov@us.ibm.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
In-Reply-To: <20050815171159.C30479@flint.arm.linux.org.uk>
References: <1124115056.3694.27.camel@siliver.austin.ibm.com>
	 <20050815155232.B30479@flint.arm.linux.org.uk>
	 <1124121399.3694.50.camel@siliver.austin.ibm.com>
	 <20050815171159.C30479@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 11:33:39 -0500
Message-Id: <1124123620.3694.53.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-15 at 17:11 +0100, Russell King wrote:
> On Mon, Aug 15, 2005 at 10:56:38AM -0500, V. Ananda Krishnan wrote:
> > On Mon, 2005-08-15 at 15:52 +0100, Russell King wrote:
> > > On Mon, Aug 15, 2005 at 09:10:56AM -0500, V. Ananda Krishnan wrote:
> > > >   The problem described here is related to the 8250_pci driver in
> > > > 2.6.12.3/2.6.12.4 kernels. When 8250_pci device driver detects a serial
> > > > port pci device and sets up the default setup (8250_pci.c), it tries to
> > > > find a match or unused port (serial8250_find_match_or_unused proc in in
> > > > 8250.c).
> > > > 
> > > > This leads to the uart_match_port with one of the parameters as
> > > > serial8250_ports[i].port. During debugging, I noticed that the none of
> > > > elements of the serial8250_ports[i].port.type was having any port value.
> > > 
> > > Every variable has a value.  In this case, they start off as PORT_UNKNOWN
> > > as expected.
> > > 
> > > > So the serial8250_register_port fails and the device driver module fails
> > > > to load.
> > > 
> > > I don't follow you here - failure of this function is not dependent on
> > > port.type being PORT_UNKNOWN.
> > 
> > Sorry for not being clear.  When 8250_pci.c invokes the function
> > serial8250_register_port(&serial_port) at line 1736 (linux-2.6.12.4), I
> > am seeing the following values: number of ports in the pci device is 1,
> > and the port structure has io_type:2, iobase:0, membase:80005000 and
> > mapbase:d6000000. In turn, The serial8250_register_port procedure in
> > 8250.c calls the serial8250_find_match_or_unused(port) routine (line
> > 2439 in 8250.c of linux-2.6.12.4) which returns 0. Hence the
> > uart_add_one_port(&serial8250_reg, &uart->port) (line 2455 in 8250.c of
> > linux-2.6.12.4) codes are not touched and serial8250_register_port
> > returns -28 (-ENOSPC) to the register_port caller.
> 
> Please consider that the person you're trying to communicate with has
> intimate knowledge of the code in question, so adding such things like
> line numbers, filenames, and versions to your explaination just adds
> extra meaningless noise which just obfuscates the rest of your
> explaination.
> 
> The problem with your explaination is that it doesn't really give me
> any idea what:
> 
> * ports are already registered with the driver
> * the value of CONFIG_SERIAL_8250_NR_UARTS is
> 
> You can provide all of this by providing the complete and entire contents
> of /proc/tty/driver/serial

Thanks for your guidance.  Here is the cat of /proc/tty/driver/serial:
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:11963 rx:0 RTS|DTR
1: uart:16550A port:000002F8 irq:3 tx:11 rx:0
2: uart:16550A port:00000898 irq:14 tx:0 rx:0
3: uart:16550A port:00000890 irq:15 tx:0 rx:0

> 
> Without this, I can only conclude from your above description that
> all available 8250 ports are already associated with some hardware,
> and therefore the 8250 driver is working as designed.
> 


