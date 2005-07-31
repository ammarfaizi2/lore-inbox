Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVHAIXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVHAIXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 04:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbVHAIX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 04:23:29 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:2823 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S262042AbVHAIWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 04:22:37 -0400
Date: Sun, 31 Jul 2005 20:36:53 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Greg KH <greg@kroah.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
       matthew@wil.cx, grundler@parisc-linux.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: [patch 2.6.13-rc3] pci: restore BAR values after D3hot->D0 for devices that need it
Message-ID: <20050731193653.GA4501@linux-mips.org>
References: <20050708095104.A612@den.park.msu.ru> <20050707.233530.85417983.davem@davemloft.net> <20050708110358.A8491@jurassic.park.msu.ru> <20050708.003333.28789082.davem@davemloft.net> <20050708122043.A8779@jurassic.park.msu.ru> <20050708183452.GB13445@tuxdriver.com> <20050726234934.GA6584@kroah.com> <20050727013601.GA13958@tuxdriver.com> <20050727141202.GA22686@tuxdriver.com> <20050727141942.GB22686@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727141942.GB22686@tuxdriver.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 10:19:44AM -0400, John W. Linville wrote:

> Some PCI devices (e.g. 3c905B, 3c556B) lose all configuration
> (including BARs) when transitioning from D3hot->D0.  This leaves such
> a device in an inaccessible state.  The patch below causes the BARs
> to be restored when enabling such a device, so that its driver will
> be able to access it.
> 
> The patch also adds pci_restore_bars as a new global symbol, and adds a
> correpsonding EXPORT_SYMBOL_GPL for that.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> ---
> Some firmware (e.g. Thinkpad T21) leaves devices in D3hot after a
> (re)boot.  Most drivers call pci_enable_device very early, so devices
> left in D3hot that lose configuration during the D3hot->D0 transition
> will be inaccessible to their drivers.

Tested with the 3com 3c556B Hurricane mini-PCI card in the IBM A21P.  Without
this patch the 3c59x driver has not been able to read the MAC address of
the card's EEPROM with ACPI enabled, now it works with and without ACPI
support.  This patch should settle at least some of the issues in
http://bugzilla.kernel.org/show_bug.cgi?id=1188.

  Ralf
