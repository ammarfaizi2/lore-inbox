Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318271AbSGWVbz>; Tue, 23 Jul 2002 17:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318295AbSGWVbz>; Tue, 23 Jul 2002 17:31:55 -0400
Received: from air-2.osdl.org ([65.172.181.6]:36817 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318271AbSGWVby>;
	Tue, 23 Jul 2002 17:31:54 -0400
Subject: Re: 2.4.19rc2aa1 VM too aggressive?
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Johannes Erdfelt <johannes@erdfelt.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <20020723203326.GJ1117@dualathlon.random>
References: <20020719170359.E28941@sventech.com>
	<Pine.LNX.4.33.0207191722260.6698-100000@coffee.psychology.mcmaster.ca>
	<20020719174521.F28941@sventech.com>
	<20020723194826.GH1117@dualathlon.random>
	<1027455756.11109.7.camel@dell_ss3.pdx.osdl.net> 
	<20020723203326.GJ1117@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Jul 2002 14:34:46 -0700
Message-Id: <1027460087.14636.102.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-23 at 13:33, Andrea Arcangeli wrote:

> some seldom swapout is ok, the strange thing are those small
> swapins/swapouts. I also assume it's writing using write(2), not with
> map_shared+msync.

I am using ben's lahaise new AIO which effectively maps the pages in
before the i/o. Using normal I/O I don't see swapping, the cached peaks
at about .827028

> 
> can you try:
> 
> 	echo 1000 >/proc/sys/vm/vm_mapped_ratio

That file does not exist in 2.4.19rc3ac3
bash-2.05$ ls /proc/sys/vm 
bdflush  max_map_count  min-readahead      page-cluster
kswapd   max-readahead  overcommit_memory  pagetable_cache
> 
> I also wonder if you've quite some amount of mapped address space durign
> the benchmark. In such case there's no trivial way around it, the vm
> will constantly found tons of mapped address space, and it will trigger
> some swapouts, however the swapins shouldn't happen so fast in such
> case.
The AIO will pin some space, but the upper bound should be 
	NIO(16) * Record Size(64k) = 1 Meg


> In any case the sysctl will allow you to tune for your workload.
> 
> Andrea


