Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbUKCHoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUKCHoU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 02:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUKCHoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 02:44:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57604 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261437AbUKCHoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 02:44:17 -0500
Date: Wed, 3 Nov 2004 07:43:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
Message-ID: <20041103074359.A1542@flint.arm.linux.org.uk>
Mail-Followup-To: Bjorn Helgaas <bjorn.helgaas@hp.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
References: <200409301014.00725.bjorn.helgaas@hp.com> <20041006082919.B18379@flint.arm.linux.org.uk> <1099329348.13633.2192.camel@hades.cambridge.redhat.com> <200411020939.25851.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200411020939.25851.bjorn.helgaas@hp.com>; from bjorn.helgaas@hp.com on Tue, Nov 02, 2004 at 09:39:25AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 09:39:25AM -0700, Bjorn Helgaas wrote:
> On Monday 01 November 2004 10:15 am, David Woodhouse wrote:
> > The problem is that 'console=ttySx' doesn't actually do anything unless
> > port numer 'x' is already registered and working. We should fix that --
> > we ought to be able to use 'console=ttySx' on the command line and have
> > the console get registered with the core printk code later, when some
> > 8250 sub-driver (8250_platform, 8250_pci, etc.) actually registers the
> > port which becomes number 'x'. 
> 
> See serial8250_late_console_init(); does this do what you want?

This call can now be removed - for any serial device, we keep registering
the console each time a new port is added until it successfully registers.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
