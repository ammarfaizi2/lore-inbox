Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318219AbSGWWhY>; Tue, 23 Jul 2002 18:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSGWWhY>; Tue, 23 Jul 2002 18:37:24 -0400
Received: from [195.223.140.120] ([195.223.140.120]:26432 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318219AbSGWWhW>; Tue, 23 Jul 2002 18:37:22 -0400
Date: Wed, 24 Jul 2002 00:41:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Johannes Erdfelt <johannes@erdfelt.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 VM too aggressive?
Message-ID: <20020723224117.GP1117@dualathlon.random>
References: <20020719170359.E28941@sventech.com> <Pine.LNX.4.33.0207191722260.6698-100000@coffee.psychology.mcmaster.ca> <20020719174521.F28941@sventech.com> <20020723194826.GH1117@dualathlon.random> <1027455756.11109.7.camel@dell_ss3.pdx.osdl.net> <20020723203326.GJ1117@dualathlon.random> <1027460087.14636.102.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027460087.14636.102.camel@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 02:34:46PM -0700, Stephen Hemminger wrote:
> On Tue, 2002-07-23 at 13:33, Andrea Arcangeli wrote:
> 
> > some seldom swapout is ok, the strange thing are those small
> > swapins/swapouts. I also assume it's writing using write(2), not with
> > map_shared+msync.
> 
> I am using ben's lahaise new AIO which effectively maps the pages in
> before the i/o. Using normal I/O I don't see swapping, the cached peaks
> at about .827028

sorry I thought you were using 2.4.19rc3aa1, -ac reintroduces a number
of vm bugs with the rmap vm that I fixed some age ago, plus it
underperformns in many areas, and about async-io I'm not shipping it.
You should report this to Alan and Ben. I'm interested only about
problems that can be reproduced with mainline and -aa, thanks.

> > can you try:
> > 
> > 	echo 1000 >/proc/sys/vm/vm_mapped_ratio
> 
> That file does not exist in 2.4.19rc3ac3

yes I misunderstood the kernel version.

> bash-2.05$ ls /proc/sys/vm 
> bdflush  max_map_count  min-readahead      page-cluster
> kswapd   max-readahead  overcommit_memory  pagetable_cache
> > 
> > I also wonder if you've quite some amount of mapped address space durign
> > the benchmark. In such case there's no trivial way around it, the vm
> > will constantly found tons of mapped address space, and it will trigger
> > some swapouts, however the swapins shouldn't happen so fast in such
> > case.
> The AIO will pin some space, but the upper bound should be 
> 	NIO(16) * Record Size(64k) = 1 Meg
> 
> 
> > In any case the sysctl will allow you to tune for your workload.
> > 
> > Andrea
> 


Andrea
