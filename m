Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVLQUuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVLQUuE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVLQUuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:50:04 -0500
Received: from solarneutrino.net ([66.199.224.43]:64006 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S964948AbVLQUuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:50:02 -0500
Date: Sat, 17 Dec 2005 14:45:53 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: lockd: couldn't create RPC handle for (host)
Message-ID: <20051217194553.GE20539@tau.solarneutrino.net>
References: <20051216205536.GA20497@tau.solarneutrino.net> <1134776945.7952.4.camel@lade.trondhjem.org> <20051216235841.GA20539@tau.solarneutrino.net> <1134797577.20929.2.camel@lade.trondhjem.org> <20051217055907.GC20539@tau.solarneutrino.net> <1134801822.7946.4.camel@lade.trondhjem.org> <20051217070222.GD20539@tau.solarneutrino.net> <1134847699.7950.25.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1134847699.7950.25.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 02:28:19PM -0500, Trond Myklebust wrote:
> On Sat, 2005-12-17 at 02:02 -0500, Ryan Richter wrote:
> > > > There's no filtering between the two.  I get this on the machine itself:
> > > > $ rpcinfo -u localhost 100021
> > > > rpcinfo: RPC: Timed out
> > > > program 100021 version 0 is not available
> > > > zsh: exit 1     rpcinfo -u localhost 100021
> > > > 
> > > > There's no lockd process running on this client machine anymore.
> > > 
> > > ...yet the client still has the partition mounted, and isn't using the
> > > -onolock option? That sounds weird.
> > 
> > There are lots of nfs mounts, the root is ro nolock, but the trouble is
> > with the home directories which are rw lock.  Everything is still
> > mounted, I can ssh in fine etc.  The problem is with people using kde -
> > it tries to lock some file in the home directory during the login
> > process and hangs.
> 
> So what do you mean when you say that there is "no lockd process
> running" on the client?
> 
> Is it not appearing in the output of 'ps -ef' either?

Nope.

$ ps -ef|grep lock
root        77     5  0 Nov20 ?        00:00:00 [kblockd/0]
foo       6811  6800  0 14:29 pts/0    00:00:00 grep -E lock

> Is anything at all listening on port 32768 on 'jacquere'? (check using
> 'netstat -ap | grep 32768').

Er... sort of?

# netstat -ap | grep 32768
udp    11144      0 *:32768                 *:*                                -                   
I'm not sure what that means...  lsof|grep 32768 returns nothing.

> Could anything be playing around with the 'pmap_set' utility so as to
> corrupt portmap?

Not that I know of.

> Are you perhaps setting /proc/sys/fs/nfs/nlm_udpport and/or the kernel
> parameter nfs.nlm_udpport? If so, to what?

Nope, that file contains a 0.  I can't think of anything that would be
changing parameters like this.

There are several identical workstations like this, and all the ones
that are used regularly have lost their lockd.  There's one that's
located in an inconvenient place and nobody ever uses it - this one
still has lockd running.

Thanks,
-ryan
