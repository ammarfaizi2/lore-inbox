Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWDNK7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWDNK7b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 06:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWDNK7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 06:59:31 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:36007 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751203AbWDNK7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 06:59:30 -0400
Date: Fri, 14 Apr 2006 14:56:12 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] net/netlink/: possible cleanups
Message-ID: <20060414105610.GA18149@2ka.mipt.ru>
References: <20060413162710.GE4162@stusta.de> <20060413.132603.94193712.davem@davemloft.net> <20060414103202.GF4162@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060414103202.GF4162@stusta.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 14 Apr 2006 14:56:13 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 12:32:02PM +0200, Adrian Bunk (bunk@stusta.de) wrote:
> On Thu, Apr 13, 2006 at 01:26:03PM -0700, David S. Miller wrote:
> > From: Adrian Bunk <bunk@stusta.de>
> > Date: Thu, 13 Apr 2006 18:27:10 +0200
> > 
> > > This patch contains the following possible cleanups plus changes related 
> > > to them:
> > > - make the following needlessly global functions static:
> > >   - attr.c: __nla_reserve()
> > >   - attr.c: __nla_put()
> > > - #if 0 the following unused global functions:
> > >   - attr.c: nla_validate()
> > >   - attr.c: nla_find()
> > >   - attr.c: nla_memcpy()
> > >   - attr.c: nla_memcmp()
> > >   - attr.c: nla_strcmp()
> > >   - attr.c: nla_reserve()
> > >   - genetlink.c: genl_unregister_ops()
> > > - remove the following unused EXPORT_SYMBOL's:
> > >   - af_netlink.c: netlink_set_nonroot
> > >   - attr.c: nla_parse
> > >   - attr.c: nla_strlcpy
> > >   - attr.c: nla_put
> > > 
> > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
...
> Anything else where a removal might be OK?

__nla_* helpers were created for small performance optimisation
if reservation is heavily used.
nla_* helpers were created to be used, but not to be removed or
commented. Some of them are used in generic netlink family.

Others and genl_register/unregister_ops() might be used in recenly 
announced accounting patches.
genl_unregister_ops() is supposed to be used in, for example, 
generic netlink exit path (which can not be called though).

Although it is always statically built systems, it is still very
convenient way of netlink usage for others (future modular systems).

> cu
> Adrian

-- 
	Evgeniy Polyakov
