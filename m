Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWGZHgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWGZHgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 03:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWGZHf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 03:35:59 -0400
Received: from cantor2.suse.de ([195.135.220.15]:39313 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751398AbWGZHf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 03:35:59 -0400
Date: Wed, 26 Jul 2006 00:31:32 -0700
From: Greg KH <gregkh@suse.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060726073132.GE6249@suse.de>
References: <20060725203028.GA1270@kroah.com> <44C6B881.7030901@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C6B881.7030901@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 02:34:09AM +0200, Stefan Richter wrote:
> Greg KH wrote:
> >During the kernel summit, I was reminded by the wish by some people to
> >do device probing in parallel, so I created the following patch.  It
> >offers up the ability for the driver core to create a new thread for
> >every driver<->device probe call.
> ...
> 
> Just FYI:
> 
> 1.) SCSI:
> There is a patch circulating at linux-scsi which adds parallelized bus 
> scanning to the SCSI subsystem. I believe this cannot be built upon 
> parallelization by driver core. But I am not too familiar with the 
> subsystem facilities which this patch expands on. The patch is from 
> Matthew Wilcox, titled "Asynchronous target discovery". 
> http://marc.theaimsgroup.com/?t=115349750400001

I don't know enough about SCSI to say if this driver core patch will
help them out or not.  At first glance it does, but the device order
gets all messed up from what users are traditionally used to, so perhaps
the scsi core will just have to stick with their own changes.

> 2.) IEEE 1394:
> There was brief preliminary discussion of parallelized probing for the 
> ieee1394 subsystem at linux1394-devel. Using driver core's 
> parallelization would achieve about 1/3rd of what would be desirable. 
> Background: After each bus reset, the 1394 core (nodemgr) has to 
> download part or all of the configuration ROM of attached devices to 
> determine their identity and capabilities. After that, either a protocol 
> driver probe (generic device hook), a protocol driver remove or suspend 
> routine (generic device hook), or a protocol driver update routine 
> (extra 1394 subsystem hook) is executed; depending on whether nodes were 
> added, removed, or in-use nodes were rediscovered. --- I.e. we better 
> have these subthreads provided by ieee1394/nodemgr itself.

That's fine, nothing in this patch precludes you from doing that at all.
I'm not thinking that all busses will enable this, rather that some
will, and some will rely on their bus code to do threaded stuff if it
can.

thanks,

greg k-h
