Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTITOeW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 10:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbTITOeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 10:34:22 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4738
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261895AbTITOeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 10:34:21 -0400
Date: Sat, 20 Sep 2003 16:34:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Roland Bless <bless@tm.uka.de>
Cc: miquels@cistron.nl, linux-kernel@vger.kernel.org, walter@tm.uka.de,
       winter@tm.uka.de, doll@tm.uka.de
Subject: Re: Fix for wrong OOM killer trigger?
Message-ID: <20030920143410.GB1338@velociraptor.random>
References: <20030919191613.36750de3.bless@tm.uka.de> <20030919192544.GC1312@velociraptor.random> <20030920110928.GA24934@vorta.ipv6.tm.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030920110928.GA24934@vorta.ipv6.tm.uka.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 20, 2003 at 01:09:28PM +0200, Roland Bless wrote:
> On Fri, Sep 19, 2003 at 09:25:44PM +0200, Andrea Arcangeli wrote:
> > 
> > can you try with 2.4.22aa1? the oom killer there will only work on tasks
> > that are allocating memory, not on idle daemons, so the probability of
> > killing rsync first should be higher. stock SuSE 8.1 kernel should do
> > the same too.
> 
> This will only help to avoid not shooting important daemons.
> The real cause, however, seems to be that the filesystem cache
> memory is not properly re-used when it should, or, that it tries to
> allocate a huge amount memory. The programs themselves do not
> allocate much memory! It must be the system, because I also
> ran programs with memory restrictions by ulimit. The programs
> are definitely not allocating the memory, and, 4GB RAM are really
> enough for a simple file server like ours.

that might be an accounting error in the oom killing then (even that
should be corrected in my tree or in the stock 8.1 SuSE kernel).

the reason normally oom accounting errors never showup, is that when the
amount of free-swap is >0, the oom-killer is never invoked (that's a
magic that probably avoids those situations to normally arise in the
stock kernel).

so maybe you had no swap, if you had no swap that would explain it.

and of course if you have 4G of ram and you know you've more than enough
ram then you'd be right using 0 swap (just the stock kernel oom killer
may malfunction, but that's not going to happen with the kernels I
suggested you to try, they'll be fine with 0 swap)

hope this helps ;)

Andrea - If you refuse to depend on closed software for a critical
	 part of your business, these links may be useful:
	  rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	  http://www.cobite.com/cvsps/
	  svn://svn.kernel.org/linux-2.[46]/trunk
