Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTDLFli (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 01:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbTDLFli (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 01:41:38 -0400
Received: from granite.he.net ([216.218.226.66]:16659 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263171AbTDLFlh (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 01:41:37 -0400
Date: Fri, 11 Apr 2003 22:54:17 -0700
From: Greg KH <greg@kroah.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Miquel van Smoorenburg'" <miquels@cistron-office.nl>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Simple Kernel-User Event Interface (Was: RE: [ANNOUNCE] udev 0.1 release)
Message-ID: <20030412055417.GA1966@kroah.com>
References: <A46BBDB345A7D5118EC90002A5072C780BEBAB1B@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780BEBAB1B@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 09:16:02PM -0700, Perez-Gonzalez, Inaky wrote:
> 
> Okay, so what about this:
> 
> I started playing with a simple event interface, that would allow:
> 
> - queuing events and recalling-queued events
> - not consume (almost) memory when two bazillion events are queued
> - be accessible by different processes at the same time on 
>   different fds

Have you looked at relayfs?  I think it might do much the same thing as
this, but through a fs interface, instead of a char device node.

> Now, each fd keeps a pointer to the queue list and only when the
> event has been read by all the open fds, it is then disposed.

I don't think you can just count the number of open fds, like your patch
does to get a count of who all read this message (fds can close and
others can open, so newer fds might not have read the message before it
is removed.)

Looks like a good start, but I'm not moving the hotplug interface over
to it :)

thanks,

greg k-h
