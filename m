Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbULCWh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbULCWh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbULCWh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:37:28 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:42624
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262442AbULCWhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:37:19 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
In-Reply-To: <20041203022854.GL32635@dualathlon.random>
References: <20041201211638.GB4530@dualathlon.random>
	 <1101938767.13353.62.camel@tglx.tec.linutronix.de>
	 <20041202033619.GA32635@dualathlon.random>
	 <1101985759.13353.102.camel@tglx.tec.linutronix.de>
	 <1101995280.13353.124.camel@tglx.tec.linutronix.de>
	 <20041202164725.GB32635@dualathlon.random>
	 <20041202085518.58e0e8eb.akpm@osdl.org>
	 <20041202180823.GD32635@dualathlon.random>
	 <1102013716.13353.226.camel@tglx.tec.linutronix.de>
	 <20041202233459.GF32635@dualathlon.random>
	 <20041203022854.GL32635@dualathlon.random>
Content-Type: text/plain
Date: Fri, 03 Dec 2004 23:37:17 +0100
Message-Id: <1102113437.13353.290.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-03 at 03:28 +0100, Andrea Arcangeli wrote:
> On Fri, Dec 03, 2004 at 12:34:59AM +0100, Andrea Arcangeli wrote:
> > I'll add to my last patch the removal of the PF_MEMDIE check in oom_kill
> > plus I'll fix the remaining race with PF_EXITING/DEAD, and I'll add a
> > cond_resched. Then you can try again with my simple way (w/ and w/o
> > PREEMPT ;).
> 
> Ok, I expect this patch to fix the problem completely. 
> <SNIP>
> With this thing, I doubt any wrong task will ever be killed again...

You're right. oom-kill() did not do anything wrong. See log below

This is w/o PREEMPT. Is it neccecary to verify w/ PREEMPT too ?

If it would have booted it still would have killed sshd instead of the
application which was forking a lot of childs.

tglx

Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 126476k/131060k available (1690k kernel code, 4044k reserved,
732k data)Checking if this processor honours the WP bit even in
supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Mendocino) stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.

END OF LOG


