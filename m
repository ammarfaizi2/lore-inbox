Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbWBHSUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWBHSUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWBHSUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:20:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:64202 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030430AbWBHSUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:20:18 -0500
Date: Wed, 8 Feb 2006 09:42:24 -0800
From: Greg KH <gregkh@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] EXPORT_SYMBOL_GPL_FUTURE()
Message-ID: <20060208174224.GD14105@suse.de>
References: <20060208062007.GA7936@kroah.com> <1139408629.26270.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139408629.26270.38.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 02:23:49PM +0000, Alan Cox wrote:
> On Maw, 2006-02-07 at 22:20 -0800, Greg KH wrote:
> > Currently we don't have a way to show people that some kernel symbols
> > will be changed in the future from EXPORT_SYMBOL() to
> > EXPORT_SYMBOL_GPL(). 
> 
> For a good reason. When Linus first accepted the _GPL changes he did so
> on the clear understanding that people wouldn't go around "privatising" 
> existing symbols.

But look at Documentation/feature-removal-schedule.txt:

	What:   RCU API moves to EXPORT_SYMBOL_GPL
	When:   April 2006
	Files:  include/linux/rcupdate.h, kernel/rcupdate.c
	Why:    Outside of Linux, the only implementations of anything even
	        vaguely resembling RCU that I am aware of are in DYNIX/ptx,
	        VM/XA, Tornado, and K42.  I do not expect anyone to port binary
	        drivers or kernel modules from any of these, since the first two
	        are owned by IBM and the last two are open-source research OSes.
	        So these will move to GPL after a grace period to allow
	        people, who might be using implementations that I am not aware
	        of, to adjust to this upcoming change.
	Who:    Paul E. McKenney <paulmck@us.ibm.com>


That's just one example.

The other example, and is what just happened last week, is for the USB
api.  We have changed enough over the years to cause a new function
call to be created, yet we offered a inline function to help with the
transition.  That new function was marked EXPORT_SYMBOL_GPL() as the USB
developers feel there has been enough change to warrant this marking.
Also because they provide a way for userspace USB drivers to be written
for those that want to do closed source stuff.

So, no matter how it is marked in this text file, people will miss it.
If we complain in the syslog, it makes it very hard to miss it, and will
allow people notice to be able to port stuff properly.

In short, due to the lack of the "unstable/stable" series cycle, we
don't have a method to mark stuff GPL only that will give enough
exposure.  This patch provides it.

I'll repost the series based on the comments in this thread, and stuff
that others have sent me privately.

thanks,

greg k-h
