Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263591AbUJ2VEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbUJ2VEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbUJ2VDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:03:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:38593 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263572AbUJ2Uzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:55:51 -0400
Date: Fri, 29 Oct 2004 15:55:05 -0500
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Norbert Preining <preining@logic.at>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-mm1, class_simple_* and GPL addition
Message-ID: <20041029205505.GB30638@kroah.com>
References: <20041027135052.GE32199@gamma.logic.tuwien.ac.at> <20041027153715.GB13991@kroah.com> <200410272012.44361.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410272012.44361.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've thought about this a bunch recently.  A lot of people emailed me
privately about it too.  Here's my reasoning as to why I did this:

On Wed, Oct 27, 2004 at 08:12:44PM -0500, Dmitry Torokhov wrote:
> I wonder what are the technical merits of this change. I certainly agree
> with Pat's assertion that the rest of driver model functions should be used
> by in-kernel subsystems (such as PCI, USB, serio etc) only and not exposed
> to the outside world. This will allow freely fix/enhance the core without
> fear of silently breaking external modules.
> 
> But class_simple is itself a limited and contained interface with well-
> defined semantic. Which I believe was advertised aat one time as a wrapper
> for the objects wanting to plug into hotplug/udev model but either living
> outside of established subsystems or within subsystem not yet ready to
> implement proper refcounting needed for full-blown sysfs integration.

You are right, class_simple is merely a wrapper around the core class
and class_device functions.  It makes it easier for a driver subsystem
to implement a very common feature.

See, "wrapper" is the point here.  If we were to have someone try to
submit the class_simple code today, after the driver core had the GPL
function exports on them, we would laugh them out of the room on the
grounds that they were wrapping GPL interfaces with a looser one.  So,
because of that, I'm going to mark these functions this way.

As to people saying it's futile to try to get companies to change, I
don't buy that.  Go look up the history of the EXPORT_SYMBOL_GPL marker
and see who used it first.  I know for a fact that because of this
marking on some kernel functions a very large company totally switched
directions and rethought their policies about Linux kernel
drivers/modules.  Now that company has plays very nicely with the Linux
kernel community, and contributes a lot of very good, useful, and needed
code, all under the GPL.

So we can change things, little things like this can help everyone out,
even if I'm going to get a ton of nvidia user hate mail directed to me
after the next kernel comes out...

Remember, binary kernel modules are a leach on our community.

thanks,

greg k-h
