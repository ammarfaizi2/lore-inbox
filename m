Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161479AbWASW5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161479AbWASW5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161478AbWASW5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:57:20 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:29642
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161473AbWASW5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:57:19 -0500
Date: Thu, 19 Jan 2006 14:57:16 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: RFC: ipath ioctls and their replacements
Message-ID: <20060119225716.GB27689@kroah.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com> <20060119025741.GC15706@kroah.com> <1137646957.25584.17.camel@localhost.localdomain> <20060119053940.GB21467@kroah.com> <1137649988.25584.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137649988.25584.67.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 09:53:08PM -0800, Bryan O'Sullivan wrote:
> On Wed, 2006-01-18 at 21:39 -0800, Greg KH wrote:
> 
> > Ok, that's fair enough.  But if you want to do something like ptys, then
> > why not just have your own filesystem for this driver?
> 
> If you think it's appropriate to implement a new filesystem to replace a
> single ioctl that returns two integers, we can probably do that, but
> more realistically, the GETPORT ioctl can probably live a long and
> untroubled life as another netlink message.

Well it only takes about 250 lines to make a new fs these days, but a
single netlink message would probably be smaller :)

> > You are just making your own type of special interface up as you
> > go, so the complexity is also there (this complexity would normally be
> > in some core code, which I am hoping that your code will turn into for
> > other devices of the same type, right?)
> 
> The most important chunk of likely common code I can see at the moment
> is the stuff for bodging user page mappings that we got hammered over
> already.  The drivers/infiniband/ tree already has code that does
> something like this, and a few other not-yet-in-tree network drivers
> that support RDMA have similar needs, too.

The RDMA-loving people need to get together and hammer out a proposal
that the network people can laugh at and shoot down all at once :)

Ok, maybe not shoot down, but they do need to get together and come up
with some kind of solution, add-hok implementations in a bunch of
different drivers, in a bunch of different ways is not the proper thing
to do, no matter _how_ different the hardware works at the lower levels.

thanks,

greg k-h
