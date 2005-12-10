Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932757AbVLJPqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbVLJPqg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 10:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbVLJPqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 10:46:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18705 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932682AbVLJPqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 10:46:35 -0500
Date: Sat, 10 Dec 2005 15:46:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jason Dravet <dravet@hotmail.com>
Cc: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Message-ID: <20051210154628.GA22707@flint.arm.linux.org.uk>
Mail-Followup-To: Jason Dravet <dravet@hotmail.com>, bjorn.helgaas@hp.com,
	linux-kernel@vger.kernel.org
References: <20051210103538.GB16104@flint.arm.linux.org.uk> <BAY103-F409E732E88BC156791C026DF440@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY103-F409E732E88BC156791C026DF440@phx.gbl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2005 at 08:24:59AM -0600, Jason Dravet wrote:
> How is this for an idea?  The serial driver enumerates ACPI, PNPBIOS, or 
> whaterver it needs for the onboard serial ports.  If you have a PCI based 
> serial card it would show up in the emuneration of the PCI bus, right?  For 
> the case of ISA serial cards couldn't they have an option in modprobe.conf 
> to tell the kernel about the ISA serial card and the proper number of 
> serial ports on the card itself?

That's already thought about and rejected.

If you want to pass a string telling the serial module where the ports
are, you could be looking at a very _long_ string.  You need to specify
the IO address, IRQ and base baud as a minimum for every port, along
with optional flags.

Assuming 5 characters for the IO address, 1 for the IRQ, and 6 for
the baud base, plus 2 for separators between each of these, and one
character separator per group, you're looking at 15 characters
minimum per port.  For 8 ports, that's 120 characters.  16 would
be 240 characters.  If the driver is built-in to the kernel, you're
limited to 255 characters to describe all kernel options, so you
couldn't hope to describe 32 ports.

Note that the above figures are without passing any additional
options which may be needed per port.  So this is most definitely
out of the question.

The alternative is something like Dave's patch which allows you to
tell the driver the number of ports you want to support and setserial.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
