Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWAJRAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWAJRAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWAJRAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:00:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40921 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932238AbWAJRAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:00:47 -0500
Date: Tue, 10 Jan 2006 11:00:32 -0600
From: Mark Maule <maule@sgi.com>
To: Greg KH <gregkh@suse.de>
Cc: Matthew Wilcox <matthew@wil.cx>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 0/3] msi abstractions and support for altix
Message-ID: <20060110170032.GC18399@sgi.com>
References: <20051222201651.2019.37913.96422@lnx-maule.americas.sgi.com> <20051222202259.GA4959@suse.de> <20051222202627.GI17552@sgi.com> <20051222203415.GA28240@suse.de> <20051222203824.GJ17552@sgi.com> <20051222205023.GK2361@parisc-linux.org> <20060103032249.GA4957@sgi.com> <20060103060719.GA1845@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103060719.GA1845@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 10:07:19PM -0800, Greg KH wrote:
> On Mon, Jan 02, 2006 at 09:22:49PM -0600, Mark Maule wrote:
> > On Thu, Dec 22, 2005 at 01:50:23PM -0700, Matthew Wilcox wrote:
> > > On Thu, Dec 22, 2005 at 02:38:24PM -0600, Mark Maule wrote:
> > > > Because on ia64 IA64_FIRST_DEVICE_VECTOR and IA64_LAST_DEVICE_VECTOR
> > > > (from which MSI FIRST_DEVICE_VECTOR/LAST_DEVICE_VECTOR are derived) are not
> > > > constants.  The are now global variables (see change to asm-ia64/hw_irq.h)
> > > > to allow the platform to override them.  Altix uses a reduced range of
> > > > vectors for devices, and this change was necessary to make assign_irq_vector()
> > > > to work on altix.
> > > 
> > > To be honest, I think this is just adding a third layer of paper over
> > > the crack in the wall.  The original code assumed x86; the ia64 port
> > > added enough emulation to make it look like x86 and now altix fixes a
> > > couple of assumptions.  I say: bleh.
> > > 
> > > What we actually need is an interface provided by the architecture that
> > > allocates a new irq.  I have a hankering to implement MSI on PA-RISC but
> > > haven't found the time ... 
> > 
> > Matt, Greg, et. al:
> > 
> > Did you guys have something in mind for a vector allocation interface?  It
> > seems to me that assign_irq_vector() more or less does what we want,
> > but what is missing is a way for the platform to prime which vectors
> > are available to choose from.
> > 
> > One possibly better solution would be to call something in the init_IRQ path
> > that would set up the vector pool available to assign_irq_vector().
> > 
> > Any opinions on this?  I would maintain that this effort should be done
> > independently of this patchset.
> 
> Care to write a patch showing how this would work?
> 
> And why would this be independant of your other changes?
> 
> thanks,
> 
> greg k-h

Ok, looks like it's going to be a bit until I have time to work on the
vector allocation stuff.

In the mean time, would folks be recepteive to taking this portion of the
initial patchset:

[PATCH 1/4] msi archetecture init hook
http://lkml.org/lkml/2005/12/21/168

This would at least give us a graceful pci_enable_msi() failure on altix
until I find the time to work on the other stuff.

Mark
