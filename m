Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbUAZQer (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 11:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUAZQer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 11:34:47 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:59841 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264472AbUAZQeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 11:34:46 -0500
Date: Mon, 26 Jan 2004 08:34:36 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: New NUMA scheduler and hotplug CPU
Message-ID: <315060000.1075134874@[10.10.2.4]>
In-Reply-To: <4014CF39.50209@cyberone.com.au>
References: <20040125235431.7BC192C0FF@lists.samba.org> <4014CF39.50209@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>	Looking at your new scheduler in -mm, it uses cpu_online_map
>> alot in arch_init_sched_domains.  This means with hotplug CPU that it
>> would need to be modified: certainly possible to do, but messy.
>> 
>>	The other option is to use cpu_possible_map to create the full
>> topology up front, and then it need never change.  AFAICT, no other
>> changes are neccessary: you already check against moving tasks to
>> offline cpus.
>> 
>> Anyway, I was just porting the hotplug CPU patches over to -mm, and
>> came across this, so I thought I'd ask.
>> 
> 
> Hi Rusty,
> Yes I'd like to use the cpu_possible_map to create the full
> topology straight up. Martin?

Well isn't it a bad idea to have cpus in the data that are offline?
It'll throw off all your balancing calculations, won't it? You seemed
to be careful to do things like divide the total load on the node by
the number of CPUs on the node, and that'll get totally borked if you
have fake CPUs in there.

To me, it'd make more sense to add the CPUs to the scheduler structures
as they get brought online. I can also imagine machines where you have
a massive (infinite?) variety of possible CPUs that could appear - 
like an NUMA box where you could just plug arbitrary numbers of new
nodes in as you wanted.

Moreover, as the CPUs aren't fixed numbers in advance, how are you going 
to know which node to put them in, etc? Setting up every possible thing 
in advance seems like an infeasible way to do hotplug to me. 

M.
