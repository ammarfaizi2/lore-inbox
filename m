Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266783AbUGLKWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266783AbUGLKWC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 06:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266782AbUGLKWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 06:22:01 -0400
Received: from gate.in-addr.de ([212.8.193.158]:63668 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S266783AbUGLKVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 06:21:48 -0400
Date: Mon, 12 Jul 2004 12:21:24 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Daniel Phillips <phillips@istop.com>, sdake@mvista.com,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040712102124.GH3933@marowsky-bree.de>
References: <200407050209.29268.phillips@redhat.com> <200407101657.06314.phillips@redhat.com> <1089501890.19787.33.camel@persist.az.mvista.com> <200407111544.25590.phillips@istop.com> <20040711210624.GC3933@marowsky-bree.de> <1089615523.2806.5.camel@laptop.fenrus.com> <20040712100547.GF3933@marowsky-bree.de> <20040712101107.GA31013@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040712101107.GA31013@devserv.devel.redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-07-12T12:11:07,
   Arjan van de Ven <arjanv@redhat.com> said:

> well the problem is that you cannot prevent a syscall from blocking really.
> O_NONBLOCK only impacts the waiting for IO/socket buffer space to not do so
> (in general), it doesn't impact the memory allocation strategies by
> syscalls. And there's a whopping lot of that in the non-boring syscalls...
> So while your heartbeat process won't block during getpid, it'll eventually
> need to do real work too .... and I'm quite certain that will lead down to
> GFP_KERNEL memory allocations.

Sure, but the network IO is isolated from the main process via a _very
careful_ non-blocking IO using sockets library, so that works out well.
The only scenario which could still impact this severely would be that
the kernel did not schedule the soft-rr tasks often enough or all NICs
being so overloaded that we can no longer send out the heartbeat
packets, and some more silly conditions. In either case I'd venture that
said node is so unhealthy that it is quite rightfully evicted from the
cluster. A node which is so overloaded should not be starting any new
resources whatsoever.

However, of course this is more difficult for the case where you are in
the write path needed to free some memory; alas, swapping to a GFS mount
is probably a realllllly silly idea, too.

But again, I'd rather like to see this solved (memory pools for
userland, PF_ etc), because it's relevant for many scenarios requiring
near-hard-realtime properties, and the answer surely can't be to push it
all into the kernel.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

