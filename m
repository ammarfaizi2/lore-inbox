Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVJRVFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVJRVFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVJRVFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:05:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5389 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932141AbVJRVFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:05:04 -0400
Date: Tue, 18 Oct 2005 22:04:55 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <gregkh@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Roland Dreier <rolandd@cisco.com>,
       linux-kernel@vger.kernel.org
Subject: Re: What is struct pci_driver.owner for?
Message-ID: <20051018210455.GA22928@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
	Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org
References: <52sluymu26.fsf@cisco.com> <435560D0.8050205@pobox.com> <20051018205908.GA32435@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018205908.GA32435@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 01:59:08PM -0700, Greg KH wrote:
> On Tue, Oct 18, 2005 at 04:53:36PM -0400, Jeff Garzik wrote:
> > Roland Dreier wrote:
> > >I just noticed that at some point, struct pci_driver grew a .owner
> > >member.  However, only a handful of drivers set it:
> > >
> > >    $ grep -r -A10 pci_driver drivers/ | grep owner
> > >    drivers/block/sx8.c-    .owner          = THIS_MODULE,
> > >    drivers/ieee1394/pcilynx.c-     .owner =           THIS_MODULE,
> > >    drivers/net/spider_net.c-       .owner          = THIS_MODULE,
> > >    drivers/video/imsttfb.c-        .owner          = THIS_MODULE,
> > >    drivers/video/kyro/fbdev.c-     .owner          = THIS_MODULE,
> > >    drivers/video/tridentfb.c-      .owner  = THIS_MODULE,
> > >
> > >Should all drivers be setting .owner = THIS_MODULE?  Is this a good
> > >kernel janitors task?
> > 
> > In theory its for module refcounting.  With so many PCI drivers and so 
> > few pci_driver::owner users, it makes me wonder how needed it is.
> 
> It might in the future be needed for refcounting, I originally added it
> when I thought it was needed.

Note that both pci_driver and pci_driver.driver both have an "owner"
field.  One should go - there's no point needlessly duplicating stuff
like this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
