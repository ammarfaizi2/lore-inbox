Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261762AbTCaSoz>; Mon, 31 Mar 2003 13:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbTCaSoy>; Mon, 31 Mar 2003 13:44:54 -0500
Received: from holomorphy.com ([66.224.33.161]:32452 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261762AbTCaSox>;
	Mon, 31 Mar 2003 13:44:53 -0500
Date: Mon, 31 Mar 2003 10:55:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
Message-ID: <20030331185553.GR30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20030328040038.GO1350@holomorphy.com> <20030330231945.GH2318@x30.local> <20030331042729.GQ30140@holomorphy.com> <20030331183506.GC11026@x30.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030331183506.GC11026@x30.random>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 30, 2003 at 08:27:29PM -0800, William Lee Irwin III wrote:
>> No, that's why it's nontrivial. Otherwise it'd be something like

On Mon, Mar 31, 2003 at 01:19:45AM +0200, Andrea Arcangeli wrote:
> I didn't expect that, I'm quite impressed now, I will check your
> explanation thanks.

On Mon, Mar 31, 2003 at 08:35:06PM +0200, Andrea Arcangeli wrote:
> could you try 2.4.21pre5aa2 too if you have some time, I'd love to have
> a confirm that it boots strightforward on such a machine (sure the
> normal zone will be pretty small, not enough for AIM7 probably but still
> ok for doing a large shmfs allocation and have smp_num_cpus tasks
> attaching in large chunks to work on it) I really expect it to boot, if
> not it must be a silly bug and I'll fix it, because it should definitely
> boot on such x86 64G hardware (despite the normal zone will be so
> small).

I'll see what those I have to answer to think. I'll have to warn you,
the NUMA-Q code in 2.4.x hasn't been very heavily focused on recently
so it may depend on someone testing/debugging the 2.4.x-based tree on
another machine (we haven't quite lost all the NUMA-Q's in our lab to
this) before the RAM goes away. I myself don't have guarantees I'll have
sufficient time for "must do" things -- if I run out of time it's gone
regardless. Extras are definitely a question of chance.


On Mon, Mar 31, 2003 at 08:35:06PM +0200, Andrea Arcangeli wrote:
> About you not caring anymore about the mem_map array size, that still
> matters on the embedded usage, infact rmap on the embedded usage is the
> biggest waste there, normally they don't even have swap so if something
> you should use the rmap provided for truncate, rather than wasting
> memory in the mem_map array.

They should be able to utilize the same technique for cutting down
mem_map, and there are pending bits around that allow the pte_chain
allocations to be eliminated entirely for file-backed memory, and so
embedded systems's needs can be accommodated with a bit of extra
adjustment for !CONFIG_SWAP and they'll never see pte_chains again.


-- wli
