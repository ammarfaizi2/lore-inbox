Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267599AbUIXAIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267599AbUIXAIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267592AbUIXAFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:05:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:21680 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267343AbUIXACq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:02:46 -0400
Date: Thu, 23 Sep 2004 16:31:47 -0700
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is there a user space pci rescan method?
Message-ID: <20040923233147.GK14868@kroah.com>
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <415211A8.8040907@ppp0.net> <20040923002649.GA28259@kroah.com> <4152E606.3070609@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4152E606.3070609@ppp0.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 05:04:38PM +0200, Jan Dittmer wrote:
> Greg KH wrote:
> > On Thu, Sep 23, 2004 at 01:58:32AM +0200, Jan Dittmer wrote:
> > 
> >>Dave Aubin wrote:
> >>
> >>>Hi,
> >>>
> >>>  I know very little about hotplug, but does make sense.
> >>>How do you motivate a hotplug insertion event?  Or should
> >>>I just go read the /docs on hotplugging?  Any help is
> >>>Appreciated:)
> >>
> >>There is a "fake" hotplug driver which works for normal pci. But last
> >>time I looked at it, it did only support hot disabling, not hot enabling
> >>- but this surely can be fixed.
> > 
> > 
> > Yes, hot "enabling" has been left for someone to add to the driver, if
> > you read the comments in it :)
> > 
> 
> I read them and started playing around with this driver. So echoing 0 in
>  /sys/bus/pci/slots/*/power disables the pci device. The problem I see
> is, that the tree with the device is disappearing. So how am I supposed
> to re-enable the device.

You need to add another sysfs file called "rescan" or something.
Writing to that file will cause the kernel to rescan pci space, and add
any devices it finds that are not already present.  The code to do that
can be taken from the pci startup code in the kernel today.

> I've no real hotplug hardware to play with, so I'm bound to reading
> the source code in drivers/pci/hotplug and testing with fakephp.

That's fine.  You don't need real hotplug pci hardware to use fakephp,
that's what the driver is for :)

> I found your utility pcihpview (v0.5) which searches for
> /sys/bus/pci/hotplug_slots. But grepping the kernel tree doesn't show
> any mentioning of it - so I suppose it is outdated.

That's a 2.4 interface.  I need to get a new version of that program out
there that works for 2.6 one of these days (the bk version of the
program has this support already in it, if you want to mess with
that...)

> Is there anywhere a current article (or Documentation/pci_hotplug.txt)
> about the state of PCI hotplug and how this is supposed to work?

Not really, sorry.

> ps: Meanwhile I found dummyphp on the pcihpd mailinglist. This doesn't
> remove the device from /sys/bus/pci/slots/*/power . Still I'd like
> to know the offical way.

That's the driver that I based fakephp on.  It's a good starting point
for what it sounds like you want to do.

Hope this helps,

greg k-h
