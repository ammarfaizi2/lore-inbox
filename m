Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVHOQle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVHOQle (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVHOQld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:41:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51469 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964842AbVHOQlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:41:31 -0400
Date: Mon, 15 Aug 2005 17:41:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "V. Ananda Krishnan" <mansarov@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: uart_port structure in serial8250_port[i]  doesn't have the port_type values
Message-ID: <20050815174126.D30479@flint.arm.linux.org.uk>
Mail-Followup-To: "V. Ananda Krishnan" <mansarov@us.ibm.com>,
	linux-kernel@vger.kernel.org, gregkh@suse.de
References: <1124115056.3694.27.camel@siliver.austin.ibm.com> <20050815155232.B30479@flint.arm.linux.org.uk> <1124121399.3694.50.camel@siliver.austin.ibm.com> <20050815171159.C30479@flint.arm.linux.org.uk> <1124123620.3694.53.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1124123620.3694.53.camel@siliver.austin.ibm.com>; from mansarov@us.ibm.com on Mon, Aug 15, 2005 at 11:33:39AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 11:33:39AM -0500, V. Ananda Krishnan wrote:
> Thanks for your guidance.  Here is the cat of /proc/tty/driver/serial:
> serinfo:1.0 driver revision:
> 0: uart:16550A port:000003F8 irq:4 tx:11963 rx:0 RTS|DTR
> 1: uart:16550A port:000002F8 irq:3 tx:11 rx:0
> 2: uart:16550A port:00000898 irq:14 tx:0 rx:0
> 3: uart:16550A port:00000890 irq:15 tx:0 rx:0
> 
> On Mon, 2005-08-15 at 17:11 +0100, Russell King wrote:
> > Without this, I can only conclude from your above description that
> > all available 8250 ports are already associated with some hardware,
> > and therefore the 8250 driver is working as designed.

and this is indeed the problem.  The 8250 driver already has 4 hardware
ports already registered.

Obviously, if you have 5 serial ports in the machine and you ask the
driver to only allow 4 ports, it's sensible that you'd get an ENOSPC
error when you try to register the 5th port.

So, if you have 5 ports in the machine, why not try setting
CONFIG_SERIAL_8250_NR_UARTS to at least 5?  Or if you have 6, set it
to at least 6. etc.

Sorry, but I feel like I'm explaining The Damned Obvious(tm) here,
especially as I've hinted towards CONFIG_SERIAL_8250_NR_UARTS twice
in this thread already.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
