Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTIVKL4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 06:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTIVKL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 06:11:56 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:28135 "EHLO
	iramx2.ira.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S263055AbTIVKLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 06:11:52 -0400
Date: Mon, 22 Sep 2003 12:11:40 +0200
From: Roland Bless <bless@tm.uka.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: miquels@cistron.nl, linux-kernel@vger.kernel.org, walter@tm.uka.de,
       winter@tm.uka.de, doll@tm.uka.de,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Fix for wrong OOM killer trigger?
Message-Id: <20030922121140.73f81627.bless@tm.uka.de>
In-Reply-To: <20030920143410.GB1338@velociraptor.random>
References: <20030919191613.36750de3.bless@tm.uka.de>
	<20030919192544.GC1312@velociraptor.random>
	<20030920110928.GA24934@vorta.ipv6.tm.uka.de>
	<20030920143410.GB1338@velociraptor.random>
Organization: Institute of Telematics, University of Karlsruhe
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Sat, 20 Sep 2003 16:34:10 +0200 Andrea Arcangeli <andrea@suse.de> wrote:

> > The real cause, however, seems to be that the filesystem cache
> > memory is not properly re-used when it should, or, that it tries to
> > allocate a huge amount memory. The programs themselves do not
> > allocate much memory! It must be the system, because I also
> > ran programs with memory restrictions by ulimit. The programs
> > are definitely not allocating the memory, and, 4GB RAM are really
> > enough for a simple file server like ours.
> 
> that might be an accounting error in the oom killing then (even that
> should be corrected in my tree or in the stock 8.1 SuSE kernel).
> 
> the reason normally oom accounting errors never showup, is that when the
> amount of free-swap is >0, the oom-killer is never invoked (that's a
> magic that probably avoids those situations to normally arise in the
> stock kernel).
> 
> so maybe you had no swap, if you had no swap that would explain it.

That's clear then, however, some kernel process/procedure must have tried 
to allocate a huge block of memory.

> and of course if you have 4G of ram and you know you've more than enough
> ram then you'd be right using 0 swap (just the stock kernel oom killer
> may malfunction, but that's not going to happen with the kernels I
> suggested you to try, they'll be fine with 0 swap)

> hope this helps ;)

The suggestion from Marc-Christian Petersen <m.c.p@wolk-project.de>,
namely using v2.4.23-pre5, worked for me. I was not sure before,
because I was not able to guess from the Changelog whether there 
was a fix for the particular bug. My suggestion is that the log entry
below describes the bug fix for it:

Summary of changes from v2.4.22 to v2.4.23-pre1
============================================
...
Marc-Christian Petersen:
  o Cleanup kmem_cache_reap()
or was it related to this one:
  o Avoid potentially leaking pagetables into the per-cpu queues

I hope that it was also fixed in 2.6, or is there a different mechanism
used?

Best regards,
 Roland
