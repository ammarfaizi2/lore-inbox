Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbSKRWe7>; Mon, 18 Nov 2002 17:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSKRWe7>; Mon, 18 Nov 2002 17:34:59 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:34698 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265828AbSKRWey> convert rfc822-to-8bit; Mon, 18 Nov 2002 17:34:54 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Ragnar =?iso-8859-1?q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
Subject: Re: Failover in NFS
Date: Mon, 18 Nov 2002 16:41:37 -0600
User-Agent: KMail/1.4.1
Cc: Rashmi Agrawal <rashmi.agrawal@wipro.com>, linux-kernel@vger.kernel.org
References: <3DD90197.4DDEEE61@wipro.com> <200211181611.06241.pollard@admin.navo.hpc.mil> <20021118232230.F30589@vestdata.no>
In-Reply-To: <20021118232230.F30589@vestdata.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211181641.37773.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 November 2002 04:22 pm, Ragnar Kjørstad wrote:
> On Mon, Nov 18, 2002 at 04:11:06PM -0600, Jesse Pollard wrote:
> > > No, you need to move the IP-address from the old nfs-server to the new
> > > one. Then to the clients it will look like a regular reboot. (Check out
> > > heartbeat, at http://www.linux-ha.org/)
> > >
> > > You need to make sure that NFS is using the shared ip (the one you move
> > > around) rather than the fixed ip. (I assume you will have a fixed ip on
> > > each host in addition to the one you move around). Also, you need to
> > > put /var/lib/nfs on shared stoarage. See the archive for more details.
> >
> > It would actually be better to use two floating IP numbers. That way
> > during normal operation, both servers would be functioning simultaneously
> > (based on the shared storage on two nodes).
> >
> > Then during failover, the floating IP of the failed node is activated on
> > the remaining node (total of 3 IP numbers now, one real, two floating).
> > The NFS recovery cycle should then cause the clients to remount the
> > filesystem from the backup server.
>
> Yes, that would be better.
>
> But it would not work as described above. There are some important
> limitations here:
>
> - I assumed that /var/lib/nfs is shared. If you want two servers to
>   be active at once you need a different way to share lock-data.
>
> - AFAIK there is no way for statd to service 2 IP's at once.
>   It will (AFAIK) bind to both adresses, but the problem is the
>   message that is sent out at startup and includes the ip of
>   the local host.
>
> Neither limitation is a law of nature. They can be fixed. I think there
> is work going on to change the way locks are stored, and I'm sure the
> second problem can be solved as well.

Actually, I was thinking that each server served a different mountpoint
instead of both providing the same one.

I'm not sure how the locks currently would be provided unless the
distributed lock from the shared storage interacts with each servers statd
properly. Otherwise you will already have problems.

Second, I thought that statd didn't care about the lock requests coming
from two IP numbers. This should be no different than having two network
interfaces attached to one server (and that works under Solaris). The
client should be using the name from the IP number, not the router used
between the client and server. I view the floating IP as existing behind
a router using the real IP. Since none of the clients are using the real
IP, the naming should remain consistant (I think).

> There may be solutions out there already. E.g. maybe Lifekeeper or
> Convolo include better support for this?

I don't know.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
