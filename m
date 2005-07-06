Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVGFJuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVGFJuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 05:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVGFJuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 05:50:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50703 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262134AbVGFHqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 03:46:33 -0400
Date: Wed, 6 Jul 2005 08:46:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci: restore BAR values in pci_enable_device_bars
Message-ID: <20050706084619.A8976@flint.arm.linux.org.uk>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matthew Wilcox <matthew@wil.cx>,
	Grant Grundler <grundler@parisc-linux.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	linux-pm <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>, Adam Belay <ambx1@neo.rr.com>
References: <20050623191451.GA20572@tuxdriver.com> <20050624022807.GF28077@tuxdriver.com> <20050630171010.GD11369@kroah.com> <20050701014056.GA13710@tuxdriver.com> <20050701022634.GA5629.1@tuxdriver.com> <20050702072954.GA14091@colo.lackof.org> <20050702090913.B1506@flint.arm.linux.org.uk> <20050705200555.GA4756@parcelfarce.linux.theplanet.co.uk> <20050705224620.B15292@flint.arm.linux.org.uk> <20050706033454.A706@den.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050706033454.A706@den.park.msu.ru>; from ink@jurassic.park.msu.ru on Wed, Jul 06, 2005 at 03:34:54AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 03:34:54AM +0400, Ivan Kokshaysky wrote:
> On Tue, Jul 05, 2005 at 10:46:20PM +0100, Russell King wrote:
> > On Tue, Jul 05, 2005 at 09:05:55PM +0100, Matthew Wilcox wrote:
> > > 64-bit BARs work fine on 64-bit machines.  I'm ambivalent whether we
> > > ought to support 64-bit BARs on 32-bit machines.
> > 
> > This only occurs because the problematical functions (eg,
> > pci_update_resource) probably aren't called on 64-bit machines - if
> > they were, they'd zero the upper 32-bits.  Maybe 64-bit machines are
> > happy with that anyway?
> 
> Why problematical? It's just the way how linux has always dealt with
> 64-bit BARs - put everything below 4G in the bus address space, on *any*
> architecture. I'd be quite surprised if some firmware doesn't do the same
> thing - so far I haven't heard any complaints.

If this is so, Grant's concern about programming the top half of 64-bit
resources with zero isn't appropriate.  However, he did raise this as
an issue...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
