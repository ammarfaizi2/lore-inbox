Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVLEPRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVLEPRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 10:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVLEPRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 10:17:55 -0500
Received: from unthought.net ([212.97.129.88]:58634 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S932441AbVLEPRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 10:17:54 -0500
Date: Mon, 5 Dec 2005 16:17:53 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Greg KH <greg@kroah.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051205151753.GB4179@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Greg KH <greg@kroah.com>, Jesper Juhl <jesper.juhl@gmail.com>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <20051204170049.GA4179@unthought.net> <20051204223931.GA8914@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051204223931.GA8914@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 02:39:31PM -0800, Greg KH wrote:
> On Sun, Dec 04, 2005 at 06:00:49PM +0100, Jakob Oestergaard wrote:
> > 
> > If the kernel was stable (reliability wise - as in "not crashing") then
> > you'd be perfectly right.
> 
> But isn't it? :)

I like your sense of humor :)

> > In the real world, however, admins currently need to pick out specific
> > versions of the kernel for specific workloads (try running a large
> > fileserver on anything but 2.6.11.11 for example - any earlier or later
> > kernel will barf reliably.
> 
> Have you filed a but at bugzilla.kernel.org about this?  If not, how do
> you expect it to get fixed?

I don't expect to get it fixed. It's futile. It can get fixed in one
version and broken two days later, and it seems the attitude is that
that is just fine.

After a long long back-and-forth, 2.6.11 was fixed to the point where it
could reliably serve files (at least on uniprocessor configurations -
and in my setup I don't see problems on NUMA either, but as far as I
know that's just me being lucky).

Right after that, someone thought it was a great idea to pry out the PCI
subsystem and shovel in something else.  Find, that's great for a
development kernel, but for a kernel that's supposed to be stable it's
just not something you can realistically do and expect things to work
afterwards.  And things broke - try mounting 10-20 XFS filesystems
simultaneously on 2.6.14.  Boom - PCI errors.

Now what? Do I as a user upgrade my production environment to the latest
and greatest kernel experiment, hope that the problems can be fixed
quickly, and hope that I don't lose too much data in the process?
(remember I will have people unable to do their jobs whenever the file
server is down).   Or do I stay on 2.6.11.11 which works on this
particular server?

I think I stay.

> 
> > For web serving it's another kernel that's golden, I forgot which).
> 
> That sounds very strange, the same kernel version should work just as
> well for all workloads.  If not, it's a bug and should be fixed.

Well...  You have bugs in different places in different kernels. It's
perfectly understandable that kernel A works for workload p and fails on
workload q, where kernel B works for workload q and fails on p.

> 
> > There are very very good reasons for offering a 'stable series' in plain
> > source-tree form - lots of admins of real-world systems need this.
> 
> But it sounds like you will want different stable series depending on
> what kind of server you are running.  And that will be even more work...

The idea would be to fix the actual bugs. After a while, one could have
a kernel of higher quality with fewer bugs, making it a lot more likely
that the *same* kernel tree could be used for both workloads A and B.

It's really very simple :)

Now, I'm just giving my oppinion as a user, and my advise as a developer
- I know how much it sucks to postpone new great cleanups or features,
just because some policy says the current branch has to be 'stable'. But
I also know how much it sucks to have users complain that a new feature
broke their existing setup. That's not a problem for a kernel developer
of course, because users don't pay for the service and the "if it breaks
you get to keep the pieces" attitude can be defended. But as a user, it
really really sucks, even if you get to keep the pieces.

I don't mean to be entirely negative - sure there are great things about
the new development model. But there is a very significant downside for
at least a group of users too.

My 0.02 Euro, for what it's worth.

-- 

 / jakob

