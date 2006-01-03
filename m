Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWACDXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWACDXK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 22:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWACDXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 22:23:10 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:18851 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750980AbWACDXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 22:23:09 -0500
Date: Mon, 2 Jan 2006 21:22:49 -0600
From: Mark Maule <maule@sgi.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <gregkh@suse.de>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 0/3] msi abstractions and support for altix
Message-ID: <20060103032249.GA4957@sgi.com>
References: <20051222201651.2019.37913.96422@lnx-maule.americas.sgi.com> <20051222202259.GA4959@suse.de> <20051222202627.GI17552@sgi.com> <20051222203415.GA28240@suse.de> <20051222203824.GJ17552@sgi.com> <20051222205023.GK2361@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222205023.GK2361@parisc-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 01:50:23PM -0700, Matthew Wilcox wrote:
> On Thu, Dec 22, 2005 at 02:38:24PM -0600, Mark Maule wrote:
> > Because on ia64 IA64_FIRST_DEVICE_VECTOR and IA64_LAST_DEVICE_VECTOR
> > (from which MSI FIRST_DEVICE_VECTOR/LAST_DEVICE_VECTOR are derived) are not
> > constants.  The are now global variables (see change to asm-ia64/hw_irq.h)
> > to allow the platform to override them.  Altix uses a reduced range of
> > vectors for devices, and this change was necessary to make assign_irq_vector()
> > to work on altix.
> 
> To be honest, I think this is just adding a third layer of paper over
> the crack in the wall.  The original code assumed x86; the ia64 port
> added enough emulation to make it look like x86 and now altix fixes a
> couple of assumptions.  I say: bleh.
> 
> What we actually need is an interface provided by the architecture that
> allocates a new irq.  I have a hankering to implement MSI on PA-RISC but
> haven't found the time ... 

Matt, Greg, et. al:

Did you guys have something in mind for a vector allocation interface?  It
seems to me that assign_irq_vector() more or less does what we want,
but what is missing is a way for the platform to prime which vectors
are available to choose from.

One possibly better solution would be to call something in the init_IRQ path
that would set up the vector pool available to assign_irq_vector().

Any opinions on this?  I would maintain that this effort should be done
independently of this patchset.

thanks
Mark
