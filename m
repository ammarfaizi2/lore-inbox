Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVFGUH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVFGUH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 16:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVFGUH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 16:07:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28869 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261960AbVFGUB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 16:01:59 -0400
Date: Tue, 7 Jun 2005 17:10:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Karsten Keil <kkeil@suse.de>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tulip suspend/resume
Message-ID: <20050607151026.GA2950@openzaurus.ucw.cz>
References: <20050606224645.GA23989@pingi3.kke.suse.de> <1118110545.6850.31.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118110545.6850.31.camel@gaston>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > following patch fix the suspend/resume for tulip based
> > cards, so suspend on disk work now for me and tulip based
> > cardbus cards.
> > 
> > 
> > Signed-off-by: Karsten Keil <kkeil@suse.de>
> > 
> >  static int tulip_suspend (struct pci_dev *pdev, pm_message_t state)
> >  {
> >  	struct net_device *dev = pci_get_drvdata(pdev);
> > +	int err;
> >  
> > +	pci_save_state(pdev);
> >  	if (dev && netif_running (dev) && netif_device_present (dev)) {
> >  		netif_device_detach (dev);
> >  		tulip_down (dev);
> >  		/* pci_power_off(pdev, -1); */
> >  	}
> > +	if ((err = pci_set_power_state(pdev, PCI_D3hot)))
> > +		printk(KERN_ERR "%s: pci_set_power_state D3hot return %d\n", dev->name, err);
> >  	return 0;
> >  }
> 
> It should probably test for message state, it's not worth doing
> pci_set_power_state(D3) if PMSG_FREEZE is passed... (just slows down
> suspend to disk)

How long does powering down netcard take? I am not sure speedup is worth added complexity.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

