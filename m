Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUEAFxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUEAFxB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 01:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUEAFxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 01:53:01 -0400
Received: from mail.kroah.org ([65.200.24.183]:39572 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262003AbUEAFvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 01:51:45 -0400
Date: Fri, 30 Apr 2004 22:50:27 -0700
From: Greg KH <greg@kroah.com>
To: Brian King <brking@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: userspace pci config space accesses
Message-ID: <20040501055027.GI21431@kroah.com>
References: <409026CE.8050905@us.ibm.com> <20040428225236.GA27250@kroah.com> <40903DBD.1000704@us.ibm.com> <20040428233812.GA365@kroah.com> <40904E72.7020308@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40904E72.7020308@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 07:38:10PM -0500, Brian King wrote:
> Greg KH wrote:
> >>>What driver is doing this?
> >>
> >>The ipr driver, a scsi device driver for ppc64.
> >>
> >>http://marc.theaimsgroup.com/?l=linux-scsi&m=108144942527994&w=2
> >>
> >>The driver runs BIST at device initialization time to ensure that the 
> >>device
> >>is in a clean state.
> >
> >
> >Ick.  It sounds like "clean state" isn't always true if userspace can
> >mess the device up by simply reading its config space :)
> 
> Yeah, its not so much the device, bus the way pSeries PCI bridges work. 
> Other adapters would have the same problem, but after a quick grep it 
> doesn't look like running BIST is a very common thing to do in most 
> Linux drivers.

Not really.

> >Worse case thing, stop the whole machine while doing BIST if you want to
> >prevent this from happening (not that I'm actually suggesting you do it,
> >but if you really think it's the only way...)
> 
> Yeah, mdelay(2000) kind of sticks out in a code review;)

And, as pointed out by others, will not work :)

> Two ideas I had would either be to create interfaces in the pci layer 
> that a device driver could call to disable all pci adapter accesses and 
> one to re-enable them. We could probably just make all pci accesses fail 
> when disabled. These interfaces could then grab the lock and set the 
> state on the pci_dev, then the read/write interfaces would check the 
> state after acquiring the lock.

Ick, we currently don't keep track of the mapping of things to do this
very easily.

I don't know what to suggest.

Good luck,

greg k-h
