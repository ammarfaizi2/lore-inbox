Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261764AbTCaSXq>; Mon, 31 Mar 2003 13:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261765AbTCaSXq>; Mon, 31 Mar 2003 13:23:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59010
	"EHLO x30.random") by vger.kernel.org with ESMTP id <S261764AbTCaSXp>;
	Mon, 31 Mar 2003 13:23:45 -0500
Date: Mon, 31 Mar 2003 20:35:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
Message-ID: <20030331183506.GC11026@x30.random>
References: <20030328040038.GO1350@holomorphy.com> <20030330231945.GH2318@x30.local> <20030331042729.GQ30140@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030331042729.GQ30140@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 30, 2003 at 08:27:29PM -0800, William Lee Irwin III wrote:
> On Mon, Mar 31, 2003 at 01:19:45AM +0200, Andrea Arcangeli wrote:
> > Didn't you break the linux x86 ABI in mmap? the file offset must be a
> > multiple of the softpagesize and binary apps can break with -EINVAL with
> > pgcl. The workaround is to allocate it in anon mem but it's not coherent
> > if somebody does a change to the binary with MAP_SHARED, so still broken
> > semantics. In theory we could also have aliasing in the cache, but it
> > doesn't seem a good idea.
> 
> No, that's why it's nontrivial. Otherwise it'd be something like

I didn't expect that, I'm quite impressed now, I will check your
explanation thanks.

> On Mon, Mar 31, 2003 at 01:19:45AM +0200, Andrea Arcangeli wrote:
> > Since you have access to such a machine, can you please try to boot
> > 2.4.21pre5aa2 on such a machine? That must boot just fine too according

could you try 2.4.21pre5aa2 too if you have some time, I'd love to have
a confirm that it boots strightforward on such a machine (sure the
normal zone will be pretty small, not enough for AIM7 probably but still
ok for doing a large shmfs allocation and have smp_num_cpus tasks
attaching in large chunks to work on it) I really expect it to boot, if
not it must be a silly bug and I'll fix it, because it should definitely
boot on such x86 64G hardware (despite the normal zone will be so
small).

About you not caring anymore about the mem_map array size, that still
matters on the embedded usage, infact rmap on the embedded usage is the
biggest waste there, normally they don't even have swap so if something
you should use the rmap provided for truncate, rather than wasting
memory in the mem_map array.

Andrea
