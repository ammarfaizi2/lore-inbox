Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWASFxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWASFxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWASFxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:53:35 -0500
Received: from mx.pathscale.com ([64.160.42.68]:6307 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932543AbWASFxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:53:35 -0500
Subject: Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20060119053940.GB21467@kroah.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <20060119025741.GC15706@kroah.com>
	 <1137646957.25584.17.camel@localhost.localdomain>
	 <20060119053940.GB21467@kroah.com>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 21:53:08 -0800
Message-Id: <1137649988.25584.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 21:39 -0800, Greg KH wrote:

> Ok, that's fair enough.  But if you want to do something like ptys, then
> why not just have your own filesystem for this driver?

If you think it's appropriate to implement a new filesystem to replace a
single ioctl that returns two integers, we can probably do that, but
more realistically, the GETPORT ioctl can probably live a long and
untroubled life as another netlink message.

> You are just making your own type of special interface up as you
> go, so the complexity is also there (this complexity would normally be
> in some core code, which I am hoping that your code will turn into for
> other devices of the same type, right?)

The most important chunk of likely common code I can see at the moment
is the stuff for bodging user page mappings that we got hammered over
already.  The drivers/infiniband/ tree already has code that does
something like this, and a few other not-yet-in-tree network drivers
that support RDMA have similar needs, too.

	<b

