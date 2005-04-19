Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVDSTqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVDSTqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVDSTqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:46:14 -0400
Received: from unthought.net ([212.97.129.88]:23463 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261631AbVDSTpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:45:21 -0400
Date: Tue, 19 Apr 2005 21:45:15 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Greg Banks <gnb@melbourne.sgi.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050419194515.GP17359@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Greg Banks <gnb@melbourne.sgi.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1113083552.11982.17.camel@lade.trondhjem.org> <20050411074806.GX347@unthought.net> <1113222939.14281.17.camel@lade.trondhjem.org> <20050411134703.GC13369@unthought.net> <1113230125.9962.7.camel@lade.trondhjem.org> <20050411144127.GE13369@unthought.net> <1113232905.9962.15.camel@lade.trondhjem.org> <20050411154211.GG13369@unthought.net> <1113267809.1956.242.camel@hole.melbourne.sgi.com> <20050412092843.GB17359@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412092843.GB17359@unthought.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 11:28:43AM +0200, Jakob Oestergaard wrote:
...
> 
> But still, guys, it is the *same* server with tg3 that runs well with a
> 2.4 client but poorly with a 2.6 client.
> 
> Maybe I'm just staring myself blind at this, but I can't see how a
> general problem on the server (such as packet loss, latency or whatever)
> would cause no problems with a 2.4 client but major problems with a 2.6
> client.

Another data point;

I upgraded my mom's machine from an earlier 2.6 (don't remember which,
but I can find out) to 2.6.11.6.

It mounts a home directory from a 2.6.6 NFS server - the client and
server are on a hub'ed 100Mbit network.

On the earlier 2.6 client I/O performance was as one would expect on
hub'ed 100Mbit - meaning, not exactly stellar, but you'd get around 4-5
MB/sec and decent interactivity.

The typical workload here is storing or retrieving large TIFF files on
the client, while working with other things in KDE. So, if the
large-file NFS I/O causes NFS client stalls, it will be noticable on the
desktop (probably as Konqueror or whatever is accessing configuration or
cache files).

With 2.6.11.6 the client is virtually unusable when large files are
transferred.  A "df -h" will hang on the mounted filesystem for several
seconds, and I have my mom on the phone complaining that various windows
won't close and that her machine is too slow (*again* it's no more than
half a year ago she got the new P4)  ;)

Now there's plenty of things to start optimizing; RPC over TCP, using a
switch or crossover cable instead of the hub, etc. etc.

However, what changed here was the client kernel going from en earlier
2.6 to 2.6.11.6.

A lot happened to the NFS client in 2.6.11 - I wonder if there's any of
these patches that are worth trying to revert?  I have several setups
that suck currently, so I'm willing to try a thing or two :)

I would try 
---
<trond.myklebust@fys.uio.no>
        RPC: Convert rpciod into a work queue for greater flexibility.
        Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>
---
if noone has a better idea...  But that's just a hunch based solely on
my observation of rpciod being a CPU hog on one of the earlier client
systems.  I didn't observe large 'sy' times in vmstat on this client
while it hung on NFS though...

Any suggestions would be greatly appreciated,

-- 

 / jakob

