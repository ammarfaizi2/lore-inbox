Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266554AbUGVGvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266554AbUGVGvq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 02:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUGVGvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 02:51:46 -0400
Received: from 209-87-233-98.storm.ca ([209.87.233.98]:22168 "EHLO
	ottawa.interneqc.com") by vger.kernel.org with ESMTP
	id S266554AbUGVGvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 02:51:42 -0400
Date: Thu, 22 Jul 2004 02:49:53 -0400
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Jesse Stockall <stockall@magma.ca>, linux-kernel@vger.kernel.org,
       rgooch@safe-mbox.com, akpm@osdl.org
Subject: Re: [PATCH] delete devfs
Message-ID: <20040722064952.GC20561@kroah.com>
References: <20040721141524.GA12564@kroah.com> <1090446817.8033.18.camel@homer.blizzard.org> <20040721220529.GB18721@kroah.com> <200407220047.53153.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407220047.53153.oliver@neukum.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 12:47:53AM +0200, Oliver Neukum wrote:
> Am Donnerstag, 22. Juli 2004 00:05 schrieb Greg KH:
> > > That's the point that Oliver and I raised, the "leave it till 2.7" (not
> > > breaking things for real world users) argument seems stronger than the
> > > "rip it now" (because it makes things cleaner, easier to code, etc)
> > > argument. 
> > 
> > The kernel development model (the whole stable/development tree thing)
> > has changed based on the discussions at the kernel summit yesterday.
> > See lwn.net for more details. That is why I sent this patch at this
> > point in time.
> 
> Interesting, but we are not talking about an _internal_ API here.
> It's about blocking the upgrade path.

There is no such block.  udev has a full devfs compatibility mode, I made
sure of that before every suggesting that a change like this happen.

> System using a stable kernel will needlessly stop working after an
> upgrade to another stable kernel.

Userspace tools need to be upgraded/added due to different kernel
changes all the time.  This is just another one of them.

Also, everyone please, consider these points about the current devfs
code:
	- it is unmaintained, and has been for years.
	- it contains known bugs (race conditions), that are pretty much
	  unsolvable with the current architecture of the code, that
	  have been pointed out many times, for years.
	- there is almost no functionality that devfs provides that is
	  not provided with udev[1]
	- no distro supports devfs
	- no active, respected, kernel developer wants to see devfs
	  remain in the kernel tree.

Yes, this has always seemed to be a hot topic.  And yes, I did really
push a lot of people's buttons by posting this patch[2], but I did it
for two reasons:
	- It was going to be my first 2.7.0 patch anyway.
	- Based on the discussions at the kernel summit, the development
	  model has changed.  This patch was a test to see if anything
	  has really changed or not :)

I'm sorry about the fact that this change in development model was not
really made public before I posted it.  That probably caused the most
confusion in this thread, and with hindsight, I should have waited a few
days for that information to have gotten out to the whole world before
submitting it[3].

Again, I apologize.

thanks,

greg k-h

[1] ok, yeah, the floppy driver will not get loaded automatically if you
try to open a /dev node that is not present at that time.  But if you
still rely on this model of behavior to properly load your modules, you
somehow missed the memo that stated that the kernel has changed from
automatically loading modules based on userspace needs (with kmod), to
one where they are loaded based on the presence of a device.  This has
all been discussed in detail many times in the past on lkml.  See the
udev FAQ for some other details about this.

[2] It was said that I rubbed the lamp with this patch, causing Richard
to suddenly appear in public at OLS within 8 hours.  I personally doubt
this, and publicly welcome Richard back to the kernel development
community.

[3] Note to self, sending patches at 2:30am after spending the evening
in deep technical discussions[4] with other kernel developers is not the
best thing to do.

[4] Ok, they weren't that deep...
