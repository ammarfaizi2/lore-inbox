Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVCAN5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVCAN5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVCAN5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:57:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21519 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261815AbVCANzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:55:36 -0500
Date: Tue, 1 Mar 2005 13:55:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Valdis.Kletnieks@vt.edu, Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1
Message-ID: <20050301135529.A1940@flint.arm.linux.org.uk>
Mail-Followup-To: Valdis.Kletnieks@vt.edu, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050301012741.1d791cd2.akpm@osdl.org> <200503011336.j21DaaqC008164@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200503011336.j21DaaqC008164@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Tue, Mar 01, 2005 at 08:36:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 08:36:36AM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 01 Mar 2005 01:27:41 PST, Andrew Morton said:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc5/2.6.11-rc5-mm1/
> 
> > - A pcmcia update which obsoletes cardmgr (although cardmgr still works) and
> >   makes pcmcia work more like regular hotpluggable devices.  See the
> >   changelong in pcmcia-dont-send-eject-request-events-to-userspace.patch for
> >   details.
> 
> This is still showing the same 'cs: unable to map card memory!' issue on my
> Dell laptop.  Backing out bk-pci.patch makes it work again.
> 
> For what it's worth, the hotplug system wasn't able to initialize the wireless
> card (TrueMobile 1150) at boot - still needed cardmgr to get it started up.
> But that might just me being an idiot...

It's probably a clash between the PCI updates and the PCMCIA updates.

The PCI updates change the prototype of a helper function for 
pci_bus_alloc_resource(), but don't touch the actual helper function
in PCMCIA.

This means that the PCI update is actually broken - if it's merged as
is into Linus' tree, PCMCIA will break there as well.

Can whoever did the PCI update please resolve this mismatch.  Moreover,
if 2.6.11 appears, please do not merge the PCI updates until this has
been resolved.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
