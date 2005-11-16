Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbVKPSX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbVKPSX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbVKPSX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:23:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:37295 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030413AbVKPSX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:23:28 -0500
Date: Wed, 16 Nov 2005 10:07:48 -0800
From: Greg KH <gregkh@suse.de>
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/6] PCI PM: capability probing and setup
Message-ID: <20051116180748.GD6908@suse.de>
References: <1132111878.9809.52.camel@localhost.localdomain> <20051116062154.GB31375@suse.de> <1132125661.3656.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132125661.3656.7.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 02:21:01AM -0500, Adam Belay wrote:
> On Tue, 2005-11-15 at 22:21 -0800, Greg KH wrote:
> > On Tue, Nov 15, 2005 at 10:31:17PM -0500, Adam Belay wrote:
> > > +int pci_setup_device_pm(struct pci_dev *dev)
> > 
> > Care to give kernel doc for this new function?
> 
> Absolutely.  I was planing to do this but must have forgotten.
> 
> > > +	unsigned char	state_mask;	/* a mask of supported power states */
> > > +	unsigned char	pme_mask;	/* a mask of power states that allow #PME */ 
> > 
> > Trailing space, use quilt it strips this :)
> 
> Sorry about that :)
> 
> > 
> > > +	struct pci_dev_pm *pm;		/* power management information */
> > 
> > Why make this a pointer and not just part of this structure?  Don't all
> > pci devices need this?
> 
> Actually, not every PCI device supports the PCI PM spec.  There are many
> devices, even in modern systems, that can only be in D0.  I was thinking
> we could save some memory and allocate this structure when PCI PM is
> detected.  Would that be ok?

That would be ok, but you better remember to check for the pointer when
doing things like suspend and resume of the config space.

thanks,

greg k-h
