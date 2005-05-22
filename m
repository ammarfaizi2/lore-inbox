Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVEVK7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVEVK7P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 06:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVEVK7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 06:59:15 -0400
Received: from [203.171.93.254] ([203.171.93.254]:11220 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261782AbVEVK7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 06:59:10 -0400
Subject: Re: pm_message_t fix for radeon_pm.c
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Henrik Brix Andersen <brix@gentoo.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050522105050.GA3685@elf.ucw.cz>
References: <1116669744.14475.7.camel@sponge.fungus>
	 <20050522105050.GA3685@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1116759251.7928.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sun, 22 May 2005 20:54:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel and Henrik.

On Sun, 2005-05-22 at 20:50, Pavel Machek wrote:
> On So 21-05-05 12:02:24, Henrik Brix Andersen wrote:
> > This patch adds a missing .event to pm_message_t handling in
> > drivers/video/aty/radeon_pm.c for linux-2.6.12-rc4.
> > 
> > --- linux-2.6.12-rc4/drivers/video/aty/radeon_pm.c	2005-05-21 11:31:32.000000000 +0200
> > +++ linux-2.6.12-rc4-radeon_pm/drivers/video/aty/radeon_pm.c	2005-05-21 11:34:51.000000000 +0200
> > @@ -2526,11 +2526,11 @@ int radeonfb_pci_suspend(struct pci_dev 
> >          struct radeonfb_info *rinfo = info->par;
> >  	int i;
> >  
> > -	if (state == pdev->dev.power.power_state)
> > +	if (state.event == pdev->dev.power.power_state.event)
> >  		return 0;
> >  
> >  	printk(KERN_DEBUG "radeonfb (%s): suspending to state: %d...\n",
> > -	       pci_name(pdev), state);
> > +	       pci_name(pdev), state.event);
> >  
> >  	/* For suspend-to-disk, we cheat here. We don't suspend anything and
> >  	 * let fbcon continue drawing until we are all set. That shouldn't
> 
> Are you sure? I think you'll _break_ compilation by doing
> this. pm_message_t becoming struct is not yet merged in rc4, IIRC.

You're right. As you know, we've included this in Suspend2 for a while
now. Brix is being a bit zealous about getting it in :>

Nigel

