Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265325AbSKRW0u>; Mon, 18 Nov 2002 17:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSKRWRG>; Mon, 18 Nov 2002 17:17:06 -0500
Received: from stine.vestdata.no ([195.204.68.10]:23962 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S265098AbSKRWPl>; Mon, 18 Nov 2002 17:15:41 -0500
Date: Mon, 18 Nov 2002 23:22:30 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Cc: Rashmi Agrawal <rashmi.agrawal@wipro.com>, linux-kernel@vger.kernel.org
Subject: Re: Failover in NFS
Message-ID: <20021118232230.F30589@vestdata.no>
References: <3DD90197.4DDEEE61@wipro.com> <20021118164408.B30589@vestdata.no> <200211181611.06241.pollard@admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211181611.06241.pollard@admin.navo.hpc.mil>; from pollard@admin.navo.hpc.mil on Mon, Nov 18, 2002 at 04:11:06PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 04:11:06PM -0600, Jesse Pollard wrote:
> > No, you need to move the IP-address from the old nfs-server to the new
> > one. Then to the clients it will look like a regular reboot. (Check out
> > heartbeat, at http://www.linux-ha.org/)
> >
> > You need to make sure that NFS is using the shared ip (the one you move
> > around) rather than the fixed ip. (I assume you will have a fixed ip on
> > each host in addition to the one you move around). Also, you need to put
> > /var/lib/nfs on shared stoarage. See the archive for more details.
> 
> It would actually be better to use two floating IP numbers. That way during
> normal operation, both servers would be functioning simultaneously
> (based on the shared storage on two nodes).
> 
> Then during failover, the floating IP of the failed node is activated on the
> remaining node (total of 3 IP numbers now, one real, two floating). The NFS
> recovery cycle should then cause the clients to remount the filesystem from
> the backup server.

Yes, that would be better.

But it would not work as described above. There are some important
limitations here:

- I assumed that /var/lib/nfs is shared. If you want two servers to
  be active at once you need a different way to share lock-data.

- AFAIK there is no way for statd to service 2 IP's at once.
  It will (AFAIK) bind to both adresses, but the problem is the
  message that is sent out at startup and includes the ip of
  the local host.


Neither limitation is a law of nature. They can be fixed. I think there
is work going on to change the way locks are stored, and I'm sure the
second problem can be solved as well.

There may be solutions out there already. E.g. maybe Lifekeeper or
Convolo include better support for this?



-- 
Ragnar Kjørstad
Big Storage
