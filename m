Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbUKJVgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbUKJVgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbUKJVfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:35:52 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:42217 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262046AbUKJVZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:25:54 -0500
Date: Wed, 10 Nov 2004 22:24:47 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: marcelo.tosatti@cyclades.com, zaphodb@zaphods.net,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041110212447.GB25410@mail.muni.cz>
References: <20041103222447.GD28163@zaphods.net> <20041104121722.GB8537@logos.cnet> <20041104181856.GE28163@zaphods.net> <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109224423.GC18366@mail.muni.cz> <20041109203348.GD8414@logos.cnet> <20041110203547.GA25410@mail.muni.cz> <20041110130943.32918c69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041110130943.32918c69.akpm@osdl.org>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 01:09:43PM -0800, Andrew Morton wrote:
> Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> >
> > 2.6.10-rc1-mm3 with CONFIG_PREEMPT=y and  CONFIG_PREEMPT_BKL=y
> > results with: (and many more xfs related calls)
> > 
> > Nov 10 21:21:05 undomiel1 kernel: BUG: using smp_processor_id() in preemptible [00000001] code: swapper/1
> > Nov 10 21:21:05 undomiel1 kernel: caller is xfs_dir2_lookup+0x26/0x157
> > Nov 10 21:21:05 undomiel1 kernel:  [<c025dbf4>] smp_processor_id+0xa8/0xb8
> > Nov 10 21:21:05 undomiel1 kernel:  [<c020679b>] xfs_dir2_lookup+0x26/0x157
> > Nov 10 21:21:05 undomiel1 kernel:  [<c020679b>] xfs_dir2_lookup+0x26/0x157
> > Nov 10 21:21:05 undomiel1 kernel:  [<c025a4e7>] send_uevent+0x148/0x1a0
> 
> That's XFS_STATS_INC() and friends.
> 
> I don't think there's really a bug here.  It's a tiny bit racy, but that
> will merely cause a small inaccuracy in the stats.
> 
> I think I'll just drop the debug patch.  You can disable
> CONFIG_DEBUG_PREEMPT to shut things up.

It did not help :( I had to disable CONFIG_PREEMPT to shut it up.

I had:
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_DEBUG_PREEMPT=y

It did what I wrote.
Then I had:
CONFIG_PREEMPT=y
#CONFIG_PREEMPT_BKL=y
#CONFIG_DEBUG_PREEMPT=y

and I had the same (or similar messages)

Now I have disabled all the preempt stuff and it is ok. (but not ok with
allocation failure, see next mail)

-- 
Luká¹ Hejtmánek
