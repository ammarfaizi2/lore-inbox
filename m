Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWCYAD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWCYAD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWCYAD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:03:57 -0500
Received: from mx.pathscale.com ([64.160.42.68]:37079 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750832AbWCYAD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:03:56 -0500
Subject: Re: [openib-general] Re: [PATCH 0 of 18] ipath driver - for
	inclusion in 2.6.17
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <ada8xqzh1ju.fsf@cisco.com>
References: <patchbomb.1143175292@eng-12.pathscale.com>
	 <ada4q1nr7pu.fsf@cisco.com>
	 <1143227515.30626.43.camel@serpentine.pathscale.com>
	 <adaveu3pml7.fsf@cisco.com>
	 <1143239617.30626.83.camel@serpentine.pathscale.com>
	 <ada8xqzh1ju.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 24 Mar 2006 16:03:56 -0800
Message-Id: <1143245036.30626.112.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 15:21 -0800, Roland Dreier wrote:

> Clearly the simplest solution for your
> situation is just to kill it.

Yes, I'll do that.

> We seem to be going around and around on this.  There definitely is
> duplicated code; you just hide some of it in userspace.  You clearly
> have two copies of the function to generate a reply to a GET of
> NodeInfo, for example.

That's true.  What I'm not so clear on is why you care that we have a
similar facility in userland.  The userland SMA is so simple, we haven't
had to touch it in a long time, except to use the new ioctl-free ABI.
There's negligible duplicated coding effort going on.

> What if you moved the MAD query handling code into your core driver?
> You could use your current method of sending and receiving replies
> directly when ib_ipath isn't loaded, but just process the queries in
> the kernel without proxying to userspace.  Then if/when QP0 is
> created, switch to letting the MAD layer handle sending and receiving
> queries and let it call the same query handling code via your
> process_mad method.
> 
> But it would (I think) solve all the issues of needing ib_mad loaded
> for things to work.  Users could even load ib_ipath without ib_mad and
> have IB verbs work -- anything that actually needed MADs would pull in
> ib_mad as a dependency, and everything else should work fine with the
> SMA stuff handled by your driver.

I'll have to chew over this for a bit with a few other people.  I'm not
actually trying to be difficult; it's just that changing the SMA at this
point is quite disruptive.  we have schedules to muck with, plans to
accelerate, people to reallocate, and the like.

It would be a huge relief to me to be able to simply merge what we have
with the understanding that we'll resolve the SMA issue to your liking
as soon as possible, but you're the gatekeeper.

> I understand that you really, really want your driver in 2.6.17.

Very much.

> Also, in my opinion, we can still merge ipath
> even after 2.6.17-rc1, since it doesn't touch anything (except trivial
> kbuild stuff) outside of drivers/infiniband/hw/ipath.

I hope you're right.

	<b

