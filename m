Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWJXMBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWJXMBV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWJXMBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:01:21 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:5064 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030372AbWJXMBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:01:20 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pci_set_power_state() failure and breaking suspend
Date: Tue, 24 Oct 2006 14:00:04 +0200
User-Agent: KMail/1.9.1
Cc: linux1394-devel@lists.sourceforge.net,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>
References: <1161672898.10524.596.camel@localhost.localdomain>
In-Reply-To: <1161672898.10524.596.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610241400.06047.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 October 2006 08:54, Benjamin Herrenschmidt wrote:
> So I noticed a small regression that I think might uncover a deeper
> issue...
> 
> Recently, ohci1394 grew some "proper" error handling in its suspend
> function, something that looks like:
> 
>         err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
>         if (err)
>                 goto out;
> 
> First, it breaks some old PowerBooks where the internal OHCI had PM
> feature exposed on PCI (the pmac specific code that follows those lines
> is enough on those machines).
> 
> That can easily be fixed by removing the if (err) goto out; statement
> and having the pmac code set err to 0 in certain conditions, and I'll be
> happy to submit a patch for this.
> 
> However, this raises the question of do we actually want to prevent
> machines to suspend when they have a PCI device that don't have the PCI
> PM capability ? I'm asking that because I can easily imagine that sort
> of construct growing into more drivers (sounds logical if you don't
> think) and I can even imagine somebody thinking it's a good idea to slap
> a __must_check on pci_set_power_state() ... 

As far as the suspend to RAM is concerned, I don't know.

For the suspend to disk we can ignore the error if we know that the device
in question won't do anything like a DMA transfer into memory while we're
creating the suspend image.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
