Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWAKOp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWAKOp6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWAKOp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:45:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11279 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750816AbWAKOp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:45:57 -0500
Date: Wed, 11 Jan 2006 14:45:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: ext David Brownell <david-b@PACBELL.NET>, linux@arm.linux.org.uk,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       drzeus-list@drzeus.cx,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/5] Add MMC password protection (lock/unlock) support V3
Message-ID: <20060111144547.GB20523@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <anderson.briglia@indt.org.br>,
	ext David Brownell <david-b@PACBELL.NET>, linux@arm.linux.org.uk,
	"Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
	drzeus-list@drzeus.cx,
	"Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>,
	linux-kernel@vger.kernel.org
References: <43C2E0A2.3090701@indt.org.br> <20060109224204.GH19131@flint.arm.linux.org.uk> <43C42B00.60206@indt.org.br> <43C50EEB.9060501@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C50EEB.9060501@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 09:58:03AM -0400, Anderson Briglia wrote:
> Anderson Briglia wrote:
> > Russell King wrote:
> > 
> > 
> >>On Mon, Jan 09, 2006 at 06:16:02PM -0400, Anderson Briglia wrote:
> >> 
> >>
> >>
> >>>+	dev = bus_find_device(&mmc_bus_type, NULL, NULL, mmc_match_lockable);
> >>>+	if (!dev)
> >>>+		goto error;
> >>>+	card = dev_to_mmc_card(dev);
> >>>+	
> >>>+	if (operation == KEY_OP_INSTANTIATE) { /* KEY_OP_INSTANTIATE */
> >>>+               if (mmc_card_locked(card)) {
> >>>+                       ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_UNLOCK);
> >>>+                       mmc_remove_card(card);
> >>>+                       mmc_register_card(card);
> >>>+               }
> >>>+	       else
> >>>+		       ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_SET_PWD);
> >>>   
> > 
> >>Also, removing and re-registering a card is an offence.  These
> >>things are ref-counted, and mmc_remove_card() will drop the last
> >>reference - so the memory associated with it will be freed.  Then
> >>you re-register it.  Whoops.
> >>
> >>If you merely want to try to attach a driver, use device_attach()
> >>instead.
> >>
> We changed the mmc_remove_card() and mmc_register_card() by
> device_release_driver() and device_attach(), supposedly avoiding
> ref-counts issues.

As per my previous mail - I think this probably comes down to differences
between mainline and the omap tree.  My suggestion should work fine
in mainline.  I can only suspect that the OMAP tree is doing something
it shouldn't.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
