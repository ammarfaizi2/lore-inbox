Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWACGv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWACGv3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 01:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWACGv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 01:51:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:59589 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751180AbWACGv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 01:51:28 -0500
Date: Mon, 2 Jan 2006 22:07:19 -0800
From: Greg KH <gregkh@suse.de>
To: Mark Maule <maule@sgi.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 0/3] msi abstractions and support for altix
Message-ID: <20060103060719.GA1845@suse.de>
References: <20051222201651.2019.37913.96422@lnx-maule.americas.sgi.com> <20051222202259.GA4959@suse.de> <20051222202627.GI17552@sgi.com> <20051222203415.GA28240@suse.de> <20051222203824.GJ17552@sgi.com> <20051222205023.GK2361@parisc-linux.org> <20060103032249.GA4957@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103032249.GA4957@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 09:22:49PM -0600, Mark Maule wrote:
> On Thu, Dec 22, 2005 at 01:50:23PM -0700, Matthew Wilcox wrote:
> > On Thu, Dec 22, 2005 at 02:38:24PM -0600, Mark Maule wrote:
> > > Because on ia64 IA64_FIRST_DEVICE_VECTOR and IA64_LAST_DEVICE_VECTOR
> > > (from which MSI FIRST_DEVICE_VECTOR/LAST_DEVICE_VECTOR are derived) are not
> > > constants.  The are now global variables (see change to asm-ia64/hw_irq.h)
> > > to allow the platform to override them.  Altix uses a reduced range of
> > > vectors for devices, and this change was necessary to make assign_irq_vector()
> > > to work on altix.
> > 
> > To be honest, I think this is just adding a third layer of paper over
> > the crack in the wall.  The original code assumed x86; the ia64 port
> > added enough emulation to make it look like x86 and now altix fixes a
> > couple of assumptions.  I say: bleh.
> > 
> > What we actually need is an interface provided by the architecture that
> > allocates a new irq.  I have a hankering to implement MSI on PA-RISC but
> > haven't found the time ... 
> 
> Matt, Greg, et. al:
> 
> Did you guys have something in mind for a vector allocation interface?  It
> seems to me that assign_irq_vector() more or less does what we want,
> but what is missing is a way for the platform to prime which vectors
> are available to choose from.
> 
> One possibly better solution would be to call something in the init_IRQ path
> that would set up the vector pool available to assign_irq_vector().
> 
> Any opinions on this?  I would maintain that this effort should be done
> independently of this patchset.

Care to write a patch showing how this would work?

And why would this be independant of your other changes?

thanks,

greg k-h
