Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131437AbRAXPJ4>; Wed, 24 Jan 2001 10:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131128AbRAXPJq>; Wed, 24 Jan 2001 10:09:46 -0500
Received: from tux.rsn.hk-r.se ([194.47.143.135]:44180 "EHLO tux.rsn.hk-r.se")
	by vger.kernel.org with ESMTP id <S132594AbRAXPJg>;
	Wed, 24 Jan 2001 10:09:36 -0500
Date: Wed, 24 Jan 2001 16:07:57 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Mark Longair <list-reader@ideaworks3d.com>
cc: linux-kernel@vger.kernel.org,
        "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: [2.2.18] outgoing connections getting stuck in SYN_SENT
In-Reply-To: <871ytt1239.fsf@starfruit.iwks.multi.local>
Message-ID: <Pine.LNX.4.21.0101241604540.30193-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jan 2001, Mark Longair wrote:

> Mark Longair <list-reader@ideaworks3d.com> writes:
> [..]
> > I'm having a problem where twice a day or so, any new tcp connection
> > it gets stuck in SYN_SENT.  Eventually this situation rights itself,
> > but obviously in the meantime many services (e.g. squid, X) are
> > broken.  The machine does IP masquerdading with ipchains, and
> > masqueraded connections through it seem to be unaffected.  The
> > kernel version is 2.2.18, although the same happened with 2.2.17.
> [..]
> 
> It turned out that this was caused by using autofw to forward a range
> of ports (2300-2400 in this case.)  It seems that these ports aren't
> reserved in any way, so eventually the server tries to use one as a
> local port on an outgoing connection.
> 
> There was a previous reference to this on the list: 
> 
>   http://kernelnotes.org/lnxlists/linux-kernel/lk_9908_01/msg00573.html
> 
> I'm looking at finding fix for that.  Would this be an issue with the
> new networking code in 2.4?
> 
> Thanks for the suggestions...

This is not an issue for 2.4 and the place where you portforward is in
the PREROUTING-chain which only get passed packets marked as NEW by the
connection-tracking.

So if you make a new connection from the machine in question and from one
of the ports that's being forwarded it will still work as the packets you
get in response isn't marked as NEW and thereby they aren't passed to
the PREROUTING-chain = not forwarded.

/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
