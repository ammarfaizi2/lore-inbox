Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSFTQhl>; Thu, 20 Jun 2002 12:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSFTQhk>; Thu, 20 Jun 2002 12:37:40 -0400
Received: from mail.storm.ca ([209.87.239.66]:30870 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S315257AbSFTQhh>;
	Thu, 20 Jun 2002 12:37:37 -0400
Message-ID: <3D11F7B9.27C74922@storm.ca>
Date: Thu, 20 Jun 2002 11:41:45 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: McVoy's Clusters (was Re: latest linus-2.5 BK broken)
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com> <m1d6umtxe8.fsf@frodo.biederman.org> <20020619222444.A26194@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I removed half a dozen cc's on this, and am just sending to the
  list. Do people actually want the cc's?]

Larry McVoy wrote:

> > Checkpointing buys three things.  The ability to preempt jobs, the
> > ability to migrate processes,

For large multi-processor systems, it isn't clear that those matter
much. On single user systems I've tried , ps -ax | wc -l usually
gives some number 50 < n < 100. For a multi-user general purpose
system, my guess would be something under 50 system processes plus
50 per user. So for a dozen to 20 users on a departmental server,
under 1000. A server for a big application, like database or web,
would have fewer users and more threads, but still only a few 100
or at most, say 2000.

So at something like 8 CPUs in a personal workstation and 128 or
256 for a server, things average out to 8 processes per CPU, and
it is not clear that process migration or any form of pre-emption
beyond the usual kernel scheduling is needed.

What combination of resources and loads do you think preemption
and migration are need for?

> > and the ability to recover from failed nodes, (assuming the 
> > failed hardware didn't corrupt your jobs checkpoint).

That matters, but it isn't entirely clear that it needs to be done
in the kernel. Things like databases and journalling filesystems
already have their own mechanisms and it is not remarkably onerous
to put them into applications where required.

[big snip]

> Larry McVoy's SMP Clusters
> 
> Discussion on November 8, 2001
> 
> Larry McVoy, Ted T'so, and Paul McKenney
> 
> What is SMP Clusters?
> 
>      SMP Clusters is a method of partioning an SMP (symmetric
>      multiprocessing) machine's CPUs, memory, and I/O devices
>      so that multiple "OSlets" run on this machine.  Each OSlet
>      owns and controls its partition.  A given partition is
>      expected to contain from 4-8 CPUs, its share of memory,
>      and its share of I/O devices.  A machine large enough to
>      have SMP Clusters profitably applied is expected to have
>      enough of the standard I/O adapters (e.g., ethernet,
>      SCSI, FC, etc.) so that each OSlet would have at least
>      one of each.

I'm not sure whose definition this is:
   supercomputer: a device for converting compute-bound problems
      into I/O-bound problems
but I suspect it is at least partially correct, and Beowulfs are
sometimes just devices to convert them to network-bound problems.

For a network-bound task like web serving, I can see a large
payoff in having each OSlet doing its own I/O.

However, in general I fail to see why each OSlet should have
independent resources rather than something like using one to
run a shared file system and another to handle the networking
for everybody.
