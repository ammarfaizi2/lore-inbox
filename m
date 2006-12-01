Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935096AbWLAHqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935096AbWLAHqY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935226AbWLAHqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:46:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:60121 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S935096AbWLAHqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:46:24 -0500
Date: Thu, 30 Nov 2006 23:04:07 -0800
From: Greg KH <gregkh@suse.de>
To: David Brownell <david-b@pacbell.net>
Cc: Kay Sievers <kay.sievers@vrfy.org>, "Marco d'Itri" <md@Linux.IT>,
       linux-kernel@vger.kernel.org
Subject: Re: [Bulk] Re: [patch 2.6.19-rc6] fix hotplug for legacy platform drivers
Message-ID: <20061201070407.GL16413@suse.de>
References: <20061122135948.GA7888@bongo.bofh.it> <200611291450.59165.david-b@pacbell.net> <20061129230219.GA11539@suse.de> <200611291727.31999.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611291727.31999.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 05:27:31PM -0800, David Brownell wrote:
> On Wednesday 29 November 2006 3:02 pm, Greg KH wrote:
> > > 
> > > Here's my fix.  ...
> > > ... I audited all the drivers using the relevant APIs, and I can't 
> > > see many (if any!) folk hitting problems from this.
> > 
> > But this still can cause the problem that your 'modalias' file in sysfs
> > contains exactly the same name as the module itself, right?
> 
> Not a problem if folk stick to the original design.  Hotplug will at
> most "modprobe $MODALIAS" (iff the device needs a driver) before doing
> a udevsend ... and only coldplug uses "modprobe $(cat modalias)".

I'm not saying that the design does not have problems, but having a
modalias with no real alias does not make much sense to me.

> I could update the patch so that attribute turns into a null string,
> but that would have a **negative effect** since it would break coldplug
> for all the platform init code which doesn't use platform_add_devices()
> or maybe platform_device_register().

Ok, I'm being thick here, but why do we need a modalias with the same
name as the module?

> > That's not good, it should be an alias, not the "real name".
> 
> Well, adding unjustified complexity _after the fact_ isn't good either,
> and that's what I see going on here.
> 
> How many years has KMOD been around?  It's worked just fine without that
> sort of bizarre (and un-needed) rule.

What rule?  KMOD worked off of char device aliases for the most part.

> Aliases were provided just to give *additional* names to modules ...
> not to make one needlessly "special".  Kernel request_module() calls
> make no distinction between which type of name they use ... and when
> the filesystem name changes, they still work when the old name is
> properly aliased.
> 
> That whole "give a module an alias of itself" model just seems ludicrous
> to me.  We _know_ that "A" means "A", so there's no point in aliasing it
> as itself.

I thought that was my point here :)

So what's the issue?

> ... plus it's a distraction from the real problem, namely that certain
> "legacy" drivers, primarily stuffed onto the "platform" bus, can't ever
> hotplug.  (While normal platform drivers do so just fine, without needing
> strange rules to make some names "more equal than others".)

But does this solve that problem?

ugh, I'm confused...

greg k-h
