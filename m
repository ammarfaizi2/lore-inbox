Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268233AbUKARQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268233AbUKARQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 12:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUKARQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:16:47 -0500
Received: from [213.146.154.40] ([213.146.154.40]:9115 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S271669AbUKARQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:16:18 -0500
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041006082919.B18379@flint.arm.linux.org.uk>
References: <200409301014.00725.bjorn.helgaas@hp.com>
	 <20041006082919.B18379@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1099329348.13633.2192.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 01 Nov 2004 17:15:48 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 08:29 +0100, Russell King wrote:
> The only reason it exists in its current form is because Alan says
> we can't get rid of the serial port initialisation due to the x86
> requirement for serial console to be initialised reasonably early.
> 
> Unfortunately the early console stuff (afaik) never made it in to
> the kernel, so we've had to keep this hanging around.
> 
> Maybe once this problem is solved we can consider dwmw2's suggestion.

Serial console working really early isn't just a requirement for x86.
It's useful elsewhere too. 

The problem is that 'console=ttySx' doesn't actually do anything unless
port numer 'x' is already registered and working. We should fix that --
we ought to be able to use 'console=ttySx' on the command line and have
the console get registered with the core printk code later, when some
8250 sub-driver (8250_platform, 8250_pci, etc.) actually registers the
port which becomes number 'x'. 

That would allow 'early' serial consoles to have none of the horrible
special-cased 'earlyconsole' crap -- we just call register_serial() (or
early_serial_setup() or whatever) as soon as it's actually possible to
poke at the port.

It also fixes the case of serial console on a PCI device.

-- 
dwmw2

