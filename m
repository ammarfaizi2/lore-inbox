Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbTFZAlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbTFZAko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:40:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29121 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265261AbTFZAjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:39:05 -0400
Date: Thu, 26 Jun 2003 01:53:15 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] pci_name()
Message-ID: <20030626005315.GD451@parcelfarce.linux.theplanet.co.uk>
References: <20030625233525.GB451@parcelfarce.linux.theplanet.co.uk> <20030626003620.GB13892@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030626003620.GB13892@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 05:36:20PM -0700, Greg KH wrote:
> On Thu, Jun 26, 2003 at 12:35:25AM +0100, Matthew Wilcox wrote:
> > 
> > I'd kind of like to get rid of pci_dev->slot_name.  It's redundant with
> > pci_dev->dev.bus_id, but that's one hell of a search and replace job.
> > So let me propose pci_name(pci_dev) as a replacement.  That has the
> 
> That sounds reasonable.  But do we really need to do this for 2.6?
> 
> Just trying to keep things sane...

I think we really do need to introduce pci_name() for 2.6 (and put it
in 2.4 too).  We don't need to eliminate pci_dev->slot_name for 2.6,
but drivers that care need to be able to tell the user which card is
a message is referring to.  With overlapping pci bus numbers, the 8
bytes of bus:device.func is no longer unique, so we need to report the
domain number too.

That information's already placed in bus_id, but as I said, I don't
want to start converting all the drivers.  We could just make slot_name
larger (Anton posted a patch for this) but I don't want to make pci_dev
even bigger.  Having a nice interface like pci_name() makes drivers more
portable between 2.4, 2.6 and 2.8 (as Jeff pointed out).

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
