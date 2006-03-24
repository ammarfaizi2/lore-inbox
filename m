Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWCXC7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWCXC7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 21:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWCXC7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 21:59:46 -0500
Received: from lame.durables.org ([64.81.244.120]:17601 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S1751530AbWCXC7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 21:59:45 -0500
Subject: Re: [openib-general] Re: [PATCH 9 of 18] ipath - char devices for
	diagnostics and lightweight subnet management
From: Robert Walsh <rjwalsh@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, greg@kroah.com
In-Reply-To: <adaodzwvdi1.fsf@cisco.com>
References: <patchbomb.1143072293@eng-12.pathscale.com>
	 <dffa0687112e4fdcf7d0.1143072302@eng-12.pathscale.com>
	 <20060323064113.GC9841@mellanox.co.il>
	 <1143103701.6411.21.camel@camp4.serpentine.com> <adaacbhvujm.fsf@cisco.com>
	 <1143158332.11449.33.camel@serpentine.pathscale.com>
	 <adaodzwvdi1.fsf@cisco.com>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 18:59:34 -0800
Message-Id: <1143169174.29062.16.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm
> talking about all the kernel code like the following (and similar
> stuff for guidinfo, nodedescription, portinfo, pkeytable).
> 
> You must have nearly identical code in your userspace SMA, since it
> also has to respond to the same SM queries, right?
> 
> I'm trying to understand why you can't get down to one implementation
> of these functions.

Why does that make a difference?  The way I see it, we handle MAD
packets by either diverting them somewhere or passing them through the
normal ib_mad channel.  We divert them somewhere because we find it
convenient to do so: it allows us to provide an SMA to our customers
without them having to have the full IB stack running.  The SMA we
provide for these circumstances runs in userspace.  It doesn't make use
of the existing ipath_mad.c code because that's tailored to: 1) run in
the kernel; and 2) deal with the IB stack.  Even if we ripped out the
guts of ipath_mad.c and had it pass the requests to the userspace SMA,
we'd still have to have the diversion path in there for cases where the
IB stack isn't around.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


