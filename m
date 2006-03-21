Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWCUWu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWCUWu2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWCUWu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:50:28 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:21779 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964878AbWCUWu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:50:27 -0500
Date: Tue, 21 Mar 2006 23:50:26 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       David Vrabel <dvrabel@arcom.com>
Subject: Re: [PATCH 04/23] driver core: platform_get_irq*(): return -ENXIO on error
Message-ID: <20060321225026.GA45303@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	David Vrabel <dvrabel@arcom.com>
References: <11428920373568-git-send-email-gregkh@suse.de> <11428920383013-git-send-email-gregkh@suse.de> <20060321001336.GB84147@dspnet.fr.eu.org> <20060321080709.GD21287@flint.arm.linux.org.uk> <20060321125049.GB83095@dspnet.fr.eu.org> <20060321203124.GC20424@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321203124.GC20424@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 08:31:25PM +0000, Russell King wrote:
> On Tue, Mar 21, 2006 at 01:50:49PM +0100, Olivier Galibert wrote:
> > On Tue, Mar 21, 2006 at 08:07:09AM +0000, Russell King wrote:
> > > On Tue, Mar 21, 2006 at 01:13:36AM +0100, Olivier Galibert wrote:
> > > > On Mon, Mar 20, 2006 at 02:00:38PM -0800, Greg Kroah-Hartman wrote:
> > > > > platform_get_irq*() cannot return 0 on error as 0 is a valid IRQ on some
> > > > > platforms, return -ENXIO instead.
> > > > 
> > > > 0 is NO_IRQ, and can not be a valid IRQ number, ever.  A
> > > > platform_get_irq*() returning 0 as a valid irq is buggy.
> > > > 
> > > > Check http://lkml.org/lkml/2005/11/21/211
> > > 
> > > No.  That's Linus' _opinion_, which is not applicable to systems without
> > > the obviously broken PCI or ISA busses.  On such systems, IRQ0 has no
> > > special meaning what so ever.
> > 
> > Do the drivers know?
> 
> If you look at the following patch in the series, the users of this function
> have been updated.  So the answer is "yes".

They've just been updated not to barf with -ENOENT, nothing more.
That's nowhere near an audit of use of the return value.

But whatever, I'm not the one who will have to debug it.

  OG.
