Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVEWJKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVEWJKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 05:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVEWJKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 05:10:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7867 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261871AbVEWJKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 05:10:36 -0400
Date: Mon, 23 May 2005 11:10:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Henrik Brix Andersen <brix@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: pm_message_t fix for radeon_pm.c
Message-ID: <20050523091018.GA1965@elf.ucw.cz>
References: <1116669744.14475.7.camel@sponge.fungus> <20050522105050.GA3685@elf.ucw.cz> <1116759251.7928.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116759251.7928.26.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 22-05-05 20:54:11, Nigel Cunningham wrote:
> Hi Pavel and Henrik.
> 
> On Sun, 2005-05-22 at 20:50, Pavel Machek wrote:
> > On So 21-05-05 12:02:24, Henrik Brix Andersen wrote:
> > > This patch adds a missing .event to pm_message_t handling in
> > > drivers/video/aty/radeon_pm.c for linux-2.6.12-rc4.
> > > 
> > > --- linux-2.6.12-rc4/drivers/video/aty/radeon_pm.c	2005-05-21 11:31:32.000000000 +0200
> > > +++ linux-2.6.12-rc4-radeon_pm/drivers/video/aty/radeon_pm.c	2005-05-21 11:34:51.000000000 +0200
> > > @@ -2526,11 +2526,11 @@ int radeonfb_pci_suspend(struct pci_dev 
> > >          struct radeonfb_info *rinfo = info->par;
> > >  	int i;
> > >  
> > > -	if (state == pdev->dev.power.power_state)
> > > +	if (state.event == pdev->dev.power.power_state.event)
> > >  		return 0;
> > >  
> > >  	printk(KERN_DEBUG "radeonfb (%s): suspending to state: %d...\n",
> > > -	       pci_name(pdev), state);
> > > +	       pci_name(pdev), state.event);
> > >  
> > >  	/* For suspend-to-disk, we cheat here. We don't suspend anything and
> > >  	 * let fbcon continue drawing until we are all set. That shouldn't
> > 
> > Are you sure? I think you'll _break_ compilation by doing
> > this. pm_message_t becoming struct is not yet merged in rc4, IIRC.
> 
> You're right. As you know, we've included this in Suspend2 for a while
> now. Brix is being a bit zealous about getting it in :>

I hope to get turn pm_message_t into struct shortly after 2.6.12, so
this kind of confusion ends... [Or perhaps I should just do it in the
-mm tree?]
								Pavel
