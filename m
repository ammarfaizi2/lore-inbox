Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbSKRWFg>; Mon, 18 Nov 2002 17:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbSKRWEl>; Mon, 18 Nov 2002 17:04:41 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:26506 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265114AbSKRWEY> convert rfc822-to-8bit; Mon, 18 Nov 2002 17:04:24 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Ragnar =?iso-8859-1?q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       Rashmi Agrawal <rashmi.agrawal@wipro.com>
Subject: Re: Failover in NFS
Date: Mon, 18 Nov 2002 16:11:06 -0600
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <3DD90197.4DDEEE61@wipro.com> <20021118164408.B30589@vestdata.no>
In-Reply-To: <20021118164408.B30589@vestdata.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211181611.06241.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 November 2002 09:44 am, Ragnar Kjørstad wrote:
> On Mon, Nov 18, 2002 at 08:34:55PM +0530, Rashmi Agrawal wrote:
> > 1. I have a 4 node cluster and nfsv3 in all the nodes of cluster with
> > server running in one
> > of the 2 nodesconnected to shared storage and 2 other nodes are acting
> > as clients.
> > 2. If nfs server node crashes, I need to failover to another node
> > wherein I need to have access
> > to the lock state of the previous server and I need to tell the clients
> > that the IP address of the
> > nfs server node has changed. IS IT POSSIBLE or what can be done to
> > implement it?
>
> No, you need to move the IP-address from the old nfs-server to the new
> one. Then to the clients it will look like a regular reboot. (Check out
> heartbeat, at http://www.linux-ha.org/)
>
> You need to make sure that NFS is using the shared ip (the one you move
> around) rather than the fixed ip. (I assume you will have a fixed ip on
> each host in addition to the one you move around). Also, you need to put
> /var/lib/nfs on shared stoarage. See the archive for more details.

It would actually be better to use two floating IP numbers. That way during
normal operation, both servers would be functioning simultaneously
(based on the shared storage on two nodes).

Then during failover, the floating IP of the failed node is activated on the
remaining node (total of 3 IP numbers now, one real, two floating). The NFS
recovery cycle should then cause the clients to remount the filesystem from
the backup server.

When the failed node is recovered, the active server should then disable the
floating IP associated with the recovered server, causing only the mounts
using that IP number to fall back to the proper node, balancing the load
again.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
