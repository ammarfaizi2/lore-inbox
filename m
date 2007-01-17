Return-Path: <linux-kernel-owner+w=401wt.eu-S1751459AbXAQW4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbXAQW4g (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbXAQW4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:56:36 -0500
Received: from mx1.suse.de ([195.135.220.2]:58881 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbXAQW4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:56:34 -0500
Date: Wed, 17 Jan 2007 14:55:48 -0800
From: Greg KH <greg@kroah.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Brainard, Jim" <jim.brainard@hp.com>,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: PME_Turn_Off in Linux
Message-ID: <20070117225548.GA18857@kroah.com>
References: <20070117213318.GA2525@kroah.com> <E717642AF17E744CA95C070CA815AE550116BB82@cceexc23.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E717642AF17E744CA95C070CA815AE550116BB82@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 04:35:02PM -0600, Miller, Mike (OS Dev) wrote:
> > On Wed, Jan 17, 2007 at 10:43:14AM -0600, Miller, Mike (OS Dev) wrote:
> > > Hello,
> > > We've been seeing some nasty data corruption issues on some 
> > platforms.
> > > We've been capturing PCI-E traces looking for something 
> > nasty but we 
> > > haven't found anything yet. One of the hardware guys if asking if 
> > > there is a call in Linux to issue a PME_Turn_Off broadcast message.
> > >  
> > > PME_Turn_Off Broadcast Message
> > > Before main component power and reference clocks are turned 
> > off, the 
> > > Root Complex or Switch Downstream Port must issue a 
> > broadcast Message 
> > > that instructs all agents downstream of that point within the 
> > > hierarchy to cease initiation of any subsequent PM_PME Messages, 
> > > effective immediately upon receipt of the PME_Turn_Off Message.
> > > 
> > > This must be initiated from the root complex. Is there such 
> > a call in 
> > > linux?
> > 
> > This firmware that implements the PCI-E connection should do 
> > this, I don't think there is anything that the Operating 
> > system can do to control this, as PCI-E should be transparant 
> > to the OS.
> 
> Hmmm, the hw folks tell me that "other" os'es implement that. But I
> would tend to agree that system firmware should probably be doing this.

Where would the "other" oses implement this, as they don't even know the
pci device is a pci-e port?  How can the os send a PCI-E message without
talking directly to the chipset-specific controller chip?

> > 
> > Unless this is on a PCI-E Hotplug system?  What is the 
> 
> No hotplug.

That's good :)

> > sequence of events that cause the data corruption?
> 
> Install rhel4 u4 on ia64, at the reboot prompt let the system sit idle
> for several hours or overnight. Then after rebooting the filesystems are
> totally trashed. I usually get a message that the kernel is not a valid
> compressed file format. If I try to rescue the system I cannot mount any
> filesystems. I don't have the message handy but it complains about an
> invalid Verneed record, whatever that is.

The RHEL4 kernel is pretty old as far as PCI-E goes.  Can you try this
on a kernel.org release?  2.6.19.2 would be great at the least.  If not,
you're going to have to get your support from Red Hat on this issue :(

Any kernel log messages while the machine is idle before rebooting?

What tasks are running overnight that would cause writes to the disk?

thanks,

greg k-h
