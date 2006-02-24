Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWBXBtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWBXBtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWBXBtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:49:08 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:43416
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932509AbWBXBtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:49:07 -0500
Date: Thu, 23 Feb 2006 17:47:55 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, kristen.c.accardi@intel.com
Cc: Bernhard Kaindl <bk@suse.de>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [PATCH] PCI/Cardbus cards hidden, needs pci=assign-busses to fix
Message-ID: <20060224014755.GD25787@kroah.com>
References: <Pine.LNX.4.44.0601051533430.27220-100000@www.fnordora.org> <1136555288.30498.12.camel@localhost.localdomain> <Pine.LNX.4.64.0602162054020.13089@jbgna.fhfr.qr> <20060218014102.0647c0ce.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218014102.0647c0ce.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 01:41:02AM -0800, Andrew Morton wrote:
> Bernhard Kaindl <bk@suse.de> wrote:
> >
> > "In some cases, especially on modern laptops with a lot of PCI and cardbus
> >  bridges, we're unable to assign correct secondary/subordinate bus numbers
> >  to all cardbus bridges due to BIOS limitations unless we are using
> >  "pci=assign-busses" boot option." -- Ivan Kokshaysky (from a patch comment)
> > 
> >  Without it, Cardbus cards inserted are never seen by PCI because the
> >  parent PCI-PCI Bridge of the Cardbus bridge will not pass and translate
> >  Type 1 PCI configuration cycles correctly and the system will fail to
> >  find and initialise the PCI devices in the system.
> > 
> >  Reference: PCI-PCI Bridges: PCI Configuration Cycles and PCI Bus Numbering:
> >  http://www.science.unitn.it/~fiorella/guidelinux/tlk/node72.html
> > 
> >  The reason for this is that:
> >   ``All PCI busses located behind a PCI-PCI bridge must reside between the
> >  secondary bus number and the subordinate bus number (inclusive).''
> > 
> >  "pci=assign-busses" makes pcibios_assign_all_busses return 1 and this
> >  turns on PCI renumbering during PCI probing.
> > 
> >  Alan suggested to use DMI to make that function cause that on problem systems:
> >
> > [ snip patch which uses a DMI table to auto-set "pci=assign-busses" ]
> >
> 
> I guess if this is the only way in which we can do this, and nobody has any
> better solutions then sure, it'll get people's machines going.  We'll be
> forever patching that table though.
> 
> But _does_ anyone have any better solutions?

This patch might not be needed at all, as per Kristen's recent comments
on the linux-pci mailing list, and her small patch that is already in
the -mm tree.

I'll let the discussion continue on that list.

thanks,

greg k-h
