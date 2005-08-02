Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVHBRe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVHBRe2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 13:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVHBRe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 13:34:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:46751 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261681AbVHBReP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 13:34:15 -0400
Date: Tue, 2 Aug 2005 10:31:46 -0700
From: Greg KH <greg@kroah.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
       matthew@wil.cx, grundler@parisc-linux.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: [patch 2.6.13-rc3] pci: restore BAR values after D3hot->D0 for devices that need it
Message-ID: <20050802173146.GA1799@kroah.com>
References: <20050707.233530.85417983.davem@davemloft.net> <20050708110358.A8491@jurassic.park.msu.ru> <20050708.003333.28789082.davem@davemloft.net> <20050708122043.A8779@jurassic.park.msu.ru> <20050708183452.GB13445@tuxdriver.com> <20050726234934.GA6584@kroah.com> <20050727013601.GA13958@tuxdriver.com> <20050727141202.GA22686@tuxdriver.com> <20050727141942.GB22686@tuxdriver.com> <20050731193653.GA4501@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731193653.GA4501@linux-mips.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 08:36:53PM +0100, Ralf Baechle wrote:
> On Wed, Jul 27, 2005 at 10:19:44AM -0400, John W. Linville wrote:
> 
> > Some PCI devices (e.g. 3c905B, 3c556B) lose all configuration
> > (including BARs) when transitioning from D3hot->D0.  This leaves such
> > a device in an inaccessible state.  The patch below causes the BARs
> > to be restored when enabling such a device, so that its driver will
> > be able to access it.
> > 
> > The patch also adds pci_restore_bars as a new global symbol, and adds a
> > correpsonding EXPORT_SYMBOL_GPL for that.
> > 
> > Signed-off-by: John W. Linville <linville@tuxdriver.com>
> > ---
> > Some firmware (e.g. Thinkpad T21) leaves devices in D3hot after a
> > (re)boot.  Most drivers call pci_enable_device very early, so devices
> > left in D3hot that lose configuration during the D3hot->D0 transition
> > will be inaccessible to their drivers.
> 
> Tested with the 3com 3c556B Hurricane mini-PCI card in the IBM A21P.  Without
> this patch the 3c59x driver has not been able to read the MAC address of
> the card's EEPROM with ACPI enabled, now it works with and without ACPI
> support.  This patch should settle at least some of the issues in
> http://bugzilla.kernel.org/show_bug.cgi?id=1188.

Thanks for testing.  I'm still going to hold off sending this in for
2.6.13 and wait for 2.6.14, unless people really think it should go in
now.

greg k-h
