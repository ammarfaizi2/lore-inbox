Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUFZKPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUFZKPj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 06:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266918AbUFZKPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 06:15:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30991 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266348AbUFZKPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 06:15:32 -0400
Date: Sat, 26 Jun 2004 11:15:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Matt Tolentino <matthew.e.tolentino@intel.com>,
       David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] Add PCDP console detection support
Message-ID: <20040626111527.B21799@flint.arm.linux.org.uk>
Mail-Followup-To: Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Tolentino <matthew.e.tolentino@intel.com>,
	David Mosberger <davidm@hpl.hp.com>
References: <200406251504.50579.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200406251504.50579.bjorn.helgaas@hp.com>; from bjorn.helgaas@hp.com on Fri, Jun 25, 2004 at 03:04:50PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 03:04:50PM -0600, Bjorn Helgaas wrote:
> This moves the code from drivers/serial/8250_hcdp.[ch] to
> drivers/firmware/pcdp.[ch], since it's no longer 8250-specific.
> It also obsoletes CONFIG_SERIAL_8250_HCDP, replacing it with
> CONFIG_EFI_PCDP (which defaults to Y for ia64).

I'm happy with this.  The only thing I spotted on a quick read through
was:

> +static void __init
> +setup_serial_console(int rev, struct pcdp_uart *uart)
> +{
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
>...
> +	if (uart->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +		port.mapbase = uart->addr.address;
> +		port.membase = ioremap(port.mapbase, 64);

What if ioremap fails (can it fail here?)

> +		port.iotype = SERIAL_IO_MEM;

Should be UPIO_MEM please.  Seems I missed this in the HCDP code...

> +	} else if (uart->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> +		port.iobase = uart->addr.address;
> +		port.iotype = SERIAL_IO_PORT;

Likewise should be UPIO_PORT please.


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
