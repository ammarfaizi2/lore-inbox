Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWGZHcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWGZHcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 03:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWGZHcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 03:32:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:41872 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932439AbWGZHcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 03:32:35 -0400
Date: Wed, 26 Jul 2006 00:28:24 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060726072824.GD6249@suse.de>
References: <20060725203028.GA1270@kroah.com> <200607251800.25328.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607251800.25328.dtor@insightbb.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 06:00:24PM -0400, Dmitry Torokhov wrote:
> On Tuesday 25 July 2006 16:30, Greg KH wrote:
> > During the kernel summit, I was reminded by the wish by some people to
> > do device probing in parallel, so I created the following patch.  It
> > offers up the ability for the driver core to create a new thread for
> > every driver<->device probe call.  To enable this, the driver needs to
> > have the multithread_probe flag set to 1, otherwise the "traditional"
> > sequencial probe happens.
> > 
> 
> Another option would be to have probing still serialized within a bus but
> serviced by a separate thread. The thread can die after let's say 1 minute
> inactivity timeout and respawned if needed.

Yes, you can do that right now if you wish, no need to mess with the
driver core.  But for busses that don't want to do something like that
(like USB and PCI probably will not), this option is now available.

thanks,

greg k-h
