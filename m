Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268889AbUJFH3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268889AbUJFH3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 03:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268900AbUJFH3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 03:29:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37386 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268889AbUJFH31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 03:29:27 -0400
Date: Wed, 6 Oct 2004 08:29:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
Message-ID: <20041006082919.B18379@flint.arm.linux.org.uk>
Mail-Followup-To: Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
References: <200409301014.00725.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200409301014.00725.bjorn.helgaas@hp.com>; from bjorn.helgaas@hp.com on Thu, Sep 30, 2004 at 10:14:00AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 10:14:00AM -0600, Bjorn Helgaas wrote:
> > What I propose is a way for the arch to provide it's own table along
> > with the size of it via a function call. It's optional, based on a
> > #ifdef defined by the arch in it's asm/serial.h. The only remaining
> > tricky point is the fact that you used to size your static array of
> > UART's based on the size of the table. So with my path, an arch
> > that defines ARCH_HAS_GET_LEGACY_SERIAL_PORTS is supposed to provide
> > both the new get_legacy_serial_ports() function, but also to define
> > UART_NR to something sensible. I hope one day, we'll be able to
> > convert 8250 to more dynamic allocation though.
> 
> This looks like a reasonable short-term fix, but I think the whole
> serial8250_isa_init_ports() should go away.  I like dwmw2's suggestion
> of an 8250_platform.c that could use register_serial() for each port
> in some platform-supplied old_serial_port[] table, which is probably
> what you mean by moving to a more dynamic allocation.

The only reason it exists in its current form is because Alan says
we can't get rid of the serial port initialisation due to the x86
requirement for serial console to be initialised reasonably early.

Unfortunately the early console stuff (afaik) never made it in to
the kernel, so we've had to keep this hanging around.

Maybe once this problem is solved we can consider dwmw2's suggestion.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
