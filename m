Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWAKOoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWAKOoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWAKOoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:44:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7695 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750771AbWAKOog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:44:36 -0500
Date: Wed, 11 Jan 2006 14:44:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
Subject: Re: [patch 1/5] Add MMC password protection (lock/unlock) support V3
Message-ID: <20060111144424.GA20523@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <anderson.briglia@indt.org.br>,
	linux-kernel@vger.kernel.org,
	"Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>,
	linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>,
	Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx,
	"Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
	"Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
References: <43C2E064.90500@indt.org.br> <20060109222902.GF19131@flint.arm.linux.org.uk> <43C5052C.4050804@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C5052C.4050804@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 09:16:28AM -0400, Anderson Briglia wrote:
> Russell King wrote:
> 
> >On Mon, Jan 09, 2006 at 06:15:00PM -0400, Anderson Briglia wrote:
> >  
> >
> >>When a card is locked, only commands from the "basic" and "lock card" classes
> >>are accepted. To be able to use the other commands, the card must be unlocked
> >>first.
> >>    
> >>
> >
> >I don't think this works as you intend.
> >
> >When a card is initially inserted, we discover the cards via mmc_setup()
> >and mmc_discover_cards().  This means that we'll never set the locked
> >status for newly inserted cards.
> >  
> >
> mmc_setup() calls mmc_check_cards(). Our patch adds the necessary code
> to mmc_check_cards() to set the locked state when the card is locked.

Not in Linus' kernel, it doesn't.

If you're working off the OMAP tree, bear in mind that I've found in
the past that they have a large number of wrong or inappropriate
changes to the MMC layer in there.  They don't regularly merge either,
and they certainly don't forward any bug fixes for review in a timely
manner.

mmc_rescan() is the only caller of mmc_check_cards(), and this only
happens if mmc_rescan() is called with the power already applied
(iow, cards are already known to the MMC layer.)

This call is done _before_ we call mmc_setup() to discover new cards.

Calling mmc_check_cards() from mmc_rescan() is _wrong_, and from what
I can ascertain, it's probably due to unforwarded broken changes in
the OMAP tree.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
