Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWIZNq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWIZNq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 09:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWIZNq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 09:46:58 -0400
Received: from ns.suse.de ([195.135.220.2]:37560 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751501AbWIZNq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 09:46:57 -0400
Date: Tue, 26 Sep 2006 06:46:54 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 26/47] Driver core: add groups support to struct device
Message-ID: <20060926134654.GB11435@kroah.com>
References: <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <d120d5000609260620me5cf24bw83fc6d65fa7cb232@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000609260620me5cf24bw83fc6d65fa7cb232@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 09:20:17AM -0400, Dmitry Torokhov wrote:
> On 9/26/06, Greg KH <greg@kroah.com> wrote:
> >From: Greg Kroah-Hartman <gregkh@suse.de>
> >
> >This is needed for the network class devices in order to be able to
> >convert over to use struct device.
> >
> 
> Greg,
> 
> You keep pushing out patches that merge class devices and standard
> devices but you still have not shown the usefullness of this process.

I have not?  This has been discussed before.

> Why do you feel the need to change internal kernel structures
> (ever-expanding struct device to accomodate everything that is in
> struct class_device) when it should be possible to simply adjust sysfs
> representation of the kernel tree (moving class devices into
> /sys/device/.. part of the tree)  to udev's liking and leave the rest
> of the kernel alone. You have seen the patch, only minor changes in
> driver/base/class.c are needed to accomplish the move.

Think about suspend.  We want a single device tree so that the class
gets called when a device is about to be suspended so that it could shut
down the network queue in a common way, before the physical device is
called.

It's also needed if we want to have a single device tree in general.
class_device was the wrong thing and is really just a duplicate of
struct device in the first place (the driver core code implementing it
is pretty much just a cut and paste job.)  The fact that we were
arbritrary marking it different has caused problems (look at the mess
that input causes to the class_device code, that's just not nice).

Kay also has a long list of the reasons why, I think he's posted it here
before.  Kay, care to send that list again?

> I really disappointed that there was no discussion/review of the
> implementation at all.

There has not been any real implementation yet, only a few patches added
to the core that add a few extra functionality to struct device to allow
class_device to move that way.  The patches that move the subsystems
over will be discussed (and some already have, like networking), when
they are ready.  Right now most of that work is being done by Kay and
myself as a proof of concept to make sure that we can do this properly
and that userspace can handle it well.

thanks,

greg k-h
