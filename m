Return-Path: <linux-kernel-owner+w=401wt.eu-S1161022AbWLUB3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWLUB3m (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 20:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWLUB3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 20:29:42 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:46009 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161022AbWLUB3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 20:29:41 -0500
Date: Thu, 21 Dec 2006 01:29:24 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Message-ID: <20061221012924.GC32625@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <200612192015.14587.david-b@pacbell.net> <20061220045604.GA20234@srcf.ucam.org> <200612201318.06976.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200612201318.06976.david-b@pacbell.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: [PATCH 1/2] Fix /sys/device/.../power/state
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 01:18:06PM -0800, David Brownell wrote:
> >  	/* disallow incomplete suspend sequences */
> > -	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
> > +	if (dev->bus && dev->bus->pm_has_noirq_stage 
> > +	    && dev->bus->pm_has_noirq_stage(dev))
> >  		return error;
> >  
> 
> I'm suspecting these two patches won't be merged, but this fragment has
> two bugs.  One is the whitespace bug already mentioned.

I'm a bit curious about the whitespace issue - CodingStyle doesn't seem 
to discuss what to do with if statements that end up longer than 80 
characters, which is (I think) what you're talking about?

> The other is that
> the original test must still be used if that bus primitve doesn't exist.

I dislike that. We're asking to suspend an individual device - whether 
the bus supports devices that need to suspend with interrupts disabled 
is irrelevent, it's the device that we care about. We should just make 
it necessary for every bus to support this method until the interface is 
removed.

> And in a different vein, I'm a bit surprised that the update to the
> feature-removal-schedule.txt file is a separate patch, but:

It seemed like a logically distinct change, but I'm happy to merge them.

> > +       bus->pm_has_noirq_stage()
> > -When:  July 2007
> > +When:  Once alternative functionality has been implemented
> 
> The "When" shouldn't change.

We shouldn't remove interfaces that userland uses until there's been a 
replacement for long enough that userland can switch over. Setting a 
date for removing this interface when most drivers don't implement the 
replacement isn't reasonable.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
