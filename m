Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVGZXw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVGZXw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVGZXwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:52:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:9376 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261818AbVGZXug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:50:36 -0400
Date: Tue, 26 Jul 2005 16:49:34 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
       matthew@wil.cx, grundler@parisc-linux.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: [patch 2.6.13-rc2] pci: restore BAR values from pci_set_power_state for D3hot->D0
Message-ID: <20050726234934.GA6584@kroah.com>
References: <20050708095104.A612@den.park.msu.ru> <20050707.233530.85417983.davem@davemloft.net> <20050708110358.A8491@jurassic.park.msu.ru> <20050708.003333.28789082.davem@davemloft.net> <20050708122043.A8779@jurassic.park.msu.ru> <20050708183452.GB13445@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708183452.GB13445@tuxdriver.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 02:34:56PM -0400, John W. Linville wrote:
> @@ -301,6 +335,16 @@ pci_set_power_state(struct pci_dev *dev,
>  		udelay(200);
>  	dev->current_state = state;
>  
> +	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
> +	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
> +	 * from D3hot to D0 _may_ perform an internal reset, thereby
> +	 * going to "D0 Uninitialized" rather than "D0 Initialized".
> +	 * In that case, we need to restore at least the BARs so that
> +	 * the device will be accessible to its driver.
> +	 */
> +	if (need_restore)
> +		pci_restore_bars(dev);
> +

This code doesn't even build, as need_restore isn't a global variable.

Care to redo this patch (and merge it with your other one) and resend
it?

thanks,

greg k-h
