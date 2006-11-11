Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424555AbWKKLuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424555AbWKKLuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 06:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424554AbWKKLuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 06:50:25 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:35600 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1424556AbWKKLuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 06:50:24 -0500
Date: Sat, 11 Nov 2006 11:50:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ttyS0 not working any more, LSR safety check engaged
Message-ID: <20061111115016.GA24112@flint.arm.linux.org.uk>
Mail-Followup-To: Marc Haber <mh+linux-kernel@zugschlus.de>,
	linux-kernel@vger.kernel.org
References: <20061111114352.GA9206@torres.l21.ma.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061111114352.GA9206@torres.l21.ma.zugschlus.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 12:43:52PM +0100, Marc Haber wrote:
> since a few kernel versions (I unfortunately do not have logs going
> back more than two months, 2.6.17.13), the serial port on my hp compaq
> nc8000 is not working any more.
> 
> The Linux kernel logs "ttyS0: LSR safety check engaged!" whenever I
> try to use the port. Googling for this error message suggests that the
> port may either not be present or broken. I can confirm that both are
> not the case: The port is present and works fine both on Windows and
> with an older Knoppix version using a very old 2.6 kernel (I think
> 2.6.4).
> 
> Is it possible that a moderately recent update to the driver is
> broken? What can I do to debug? What information do you need?

It /does/ mean that the port went away, whether you like it or not.
The hardware was there when it was autoprobed, but when you came to
use it, it had gone.

In other words, something else in the system reconfigured something
which caused the hardware to become inaccessible at the IO address.

Maybe something to do with PNP?  Maybe ACPI?  Both of those I know
nothing about, but I suggest that if you have PNP enabled, you
build and use the 8250_pnp module, even if your port is detected
by the legacy detection methods in 8250.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
