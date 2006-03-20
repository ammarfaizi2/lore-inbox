Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWCTMDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWCTMDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 07:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWCTMDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 07:03:25 -0500
Received: from [194.90.237.34] ([194.90.237.34]:23448 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S932090AbWCTMDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 07:03:24 -0500
Date: Mon, 20 Mar 2006 14:04:07 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "David S. Miller" <davem@davemloft.net>, rick.jones2@hp.com,
       netdev@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
Message-ID: <20060320120407.GY29929@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060320090629.GA11352@mellanox.co.il> <20060320.015500.72136710.davem@davemloft.net> <20060320102234.GV29929@mellanox.co.il> <20060320.023704.70907203.davem@davemloft.net> <20060320112753.GX29929@mellanox.co.il> <1142855223.3114.30.camel@laptopd505.fenrus.org> <20060320114933.GA3058@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320114933.GA3058@xi.wantstofly.org>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 20 Mar 2006 12:06:03.0421 (UTC) FILETIME=[A8F444D0:01C64C16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Lennert Buytenhek <buytenh@wantstofly.org>:
> > > > I disagree with Linux changing it's behavior.  It would be great to
> > > > turn off congestion control completely over local gigabit networks,
> > > > but that isn't determinable in any way, so we don't do that.
> > > 
> > > Interesting. Would it make sense to make it another tunable knob in
> > > /proc, sysfs or sysctl then?
> > 
> > that's not the right level; since that is per interface. And you only
> > know the actual interface waay too late (as per earlier posts).
> > Per socket.. maybe
> > But then again it's not impossible to have packets for one socket go out
> > to multiple interfaces
> > (think load balancing bonding over 2 interfaces, one IB another
> > ethernet)
> 
> I read it as if he was proposing to have a sysctl knob to turn off
> TCP congestion control completely (which has so many issues it's not
> even funny.)

Not really, that was David :)

What started this thread was the fact that since 2.6.11 Linux
does not stretch ACKs anymore. RFC 2581 does mention that it might be OK to
stretch ACKs "after careful consideration", and we are seeing that it helps
IP over InfiniBand, so recent Linux kernels perform worse in that respect.

And since there does not seem to be a way to figure it out automagically when
doing this is a good idea, I proposed adding some kind of knob that will let the
user apply the consideration for us.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
