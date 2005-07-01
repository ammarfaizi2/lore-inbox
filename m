Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVGAT65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVGAT65 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 15:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVGAT65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 15:58:57 -0400
Received: from cpe-24-93-204-161.neo.res.rr.com ([24.93.204.161]:40842 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262292AbVGAT6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 15:58:48 -0400
Date: Fri, 1 Jul 2005 15:52:32 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC] PCI: clean up the dynamic pci id logic
Message-ID: <20050701195232.GB3742@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	Matt_Domsch@dell.com, linux-pci@atrey.karlin.mff.cuni.cz
References: <20050630091812.GA25285@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630091812.GA25285@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 02:18:12AM -0700, Greg KH wrote:
> Hi,
> 
> The dynamic pci id logic has been bothering me for a while, and now that
> I started to look into how to move some of this to the driver core, I
> thought it was time to clean it all up.
> 
> So here's a patch against 2.6.13-rc1 that does so.  It ends up making
> the code smaller, and easier to follow, and fixes a few bugs at the same
> time (dynamic ids were not being matched everywhere, and so could be
> missed on some call paths for new devices, semaphore not needed to be
> grabbed when adding a new id and calling the driver core, etc.)
> 
> Matt, any objection to this patch?
> 
> I also renamed the function pci_match_device() to pci_match_id() as
> that's what it really does, but maybe I should just put it back to be
> compatible.  Nah...
> 

Hi Greg,

I was wondering why we need dynamic id support in the driver core.  Is there
an issue where the bind/unbind mechanism requires this feature?  I was hoping
bind/unbind would replace it.

I understand that there are PCI drivers that use .driver_data and read from
their ID table (e.g. pci_serial), but we don't really want the user modifying
these IDs because they're often attached to some device specific tables.

It was my understanding that the *probe function should be responsible for
accepting any device, and then gracefully fail if it knows it will be unable
to support it.  For some drivers this could include failing if it's missing
from the ID table.  If the driver developer requires the driver to match to
an unknown pool of devices, then the *probe function could be made more
advanced.

Thanks,
Adam
