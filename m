Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVGEWDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVGEWDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVGEWBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:01:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54284 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261991AbVGEVqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:46:33 -0400
Date: Tue, 5 Jul 2005 22:46:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci: restore BAR values in pci_enable_device_bars
Message-ID: <20050705224620.B15292@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <matthew@wil.cx>,
	Grant Grundler <grundler@parisc-linux.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	linux-pm <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>, Adam Belay <ambx1@neo.rr.com>
References: <20050623191451.GA20572@tuxdriver.com> <20050624022807.GF28077@tuxdriver.com> <20050630171010.GD11369@kroah.com> <20050701014056.GA13710@tuxdriver.com> <20050701022634.GA5629.1@tuxdriver.com> <20050702072954.GA14091@colo.lackof.org> <20050702090913.B1506@flint.arm.linux.org.uk> <20050705200555.GA4756@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050705200555.GA4756@parcelfarce.linux.theplanet.co.uk>; from matthew@wil.cx on Tue, Jul 05, 2005 at 09:05:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 09:05:55PM +0100, Matthew Wilcox wrote:
> On Sat, Jul 02, 2005 at 09:09:13AM +0100, Russell King wrote:
> > The PCI subsystem is incomplete for 64-bit BAR support.  What it does
> > do though is ensure that 64-bit BARs will work correctly in a 32-bit
> > system.  Therefore, I think that folk who want 64-bit BAR support to
> > work need to do some code reviews on the PCI subsystem to resolve the
> > remaining issues.
> 
> 64-bit BARs work fine on 64-bit machines.  I'm ambivalent whether we
> ought to support 64-bit BARs on 32-bit machines.

This only occurs because the problematical functions (eg,
pci_update_resource) probably aren't called on 64-bit machines - if
they were, they'd zero the upper 32-bits.  Maybe 64-bit machines are
happy with that anyway?

Rather than reimplementing the internals of pci_update_resource() it
may be worth splitting the common stuff out so it gets fixed for both
pci_update_resource() and pci_enable_device().

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
