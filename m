Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbTIVNBz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 09:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbTIVNBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 09:01:55 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45962
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263136AbTIVNBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 09:01:49 -0400
Date: Mon, 22 Sep 2003 15:02:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Roland Bless <bless@tm.uka.de>
Cc: miquels@cistron.nl, linux-kernel@vger.kernel.org, walter@tm.uka.de,
       winter@tm.uka.de, doll@tm.uka.de,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Fix for wrong OOM killer trigger?
Message-ID: <20030922130202.GB9936@velociraptor.random>
References: <20030919191613.36750de3.bless@tm.uka.de> <20030919192544.GC1312@velociraptor.random> <20030920110928.GA24934@vorta.ipv6.tm.uka.de> <20030920143410.GB1338@velociraptor.random> <20030922121140.73f81627.bless@tm.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922121140.73f81627.bless@tm.uka.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 12:11:40PM +0200, Roland Bless wrote:
> was a fix for the particular bug. My suggestion is that the log entry
> below describes the bug fix for it:

the kmem cleanup wasn't a bug. So in theory it could be even the leaking
of pagetables that went from -aa to mainline in 23pre1, but I think it
really was the removal of the oom killer with the -aa VM merges that
went into 2.4.23pre[2-5] that really fixed your problem (if it's true
that you had no swap, which I understood it's the case, and no swap puts
at the light the brokeness of the oom killer), that leak is a minor one,
many other places shrinks the per-cpu queues, so it's unlikely to be
able to leak lots of ram in a misc workload.

It's good to hear that pre5 is fixed. thanks.


> 
> Summary of changes from v2.4.22 to v2.4.23-pre1
> ============================================
> ...
> Marc-Christian Petersen:
>   o Cleanup kmem_cache_reap()
> or was it related to this one:
>   o Avoid potentially leaking pagetables into the per-cpu queues
> 
> I hope that it was also fixed in 2.6, or is there a different mechanism
> used?

dunno, but the oom killer certainly has not enough information in 2.6
either to be able to do a reliable decision.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
