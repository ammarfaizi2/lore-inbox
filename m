Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268890AbUJUQmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268890AbUJUQmj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUJUQm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:42:27 -0400
Received: from mx2.elte.hu ([157.181.151.9]:12737 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266263AbUJUQjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:39:01 -0400
Date: Thu, 21 Oct 2004 18:40:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gunther Persoons <gunther_persoons@spymac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
Message-ID: <20041021164018.GA11560@elte.hu>
References: <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <4177FAB0.6090406@spymac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4177FAB0.6090406@spymac.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gunther Persoons <gunther_persoons@spymac.com> wrote:

> The kernel booted now with my firewire card plugged in. However when i
> try to mount my reiser4 partition i get following error
> 
> BUG: semaphore recursion deadlock detected!
> .. current task mount/10514 is already holding ccb5bb4c.

> [<c0344760>] down_write+0x103/0x1a6 (48)
> [<d0b26a08>] kcond_wait+0xaa/0xac [reiser4] (36)
> [<d0b280b0>] start_ktxnmgrd+0x98/0x9a [reiser4] (36)
> [<d0b33716>] reiser4_fill_super+0x3b/0x71 [reiser4] (28)
> [<d0b2d569>] reiser4_get_sb+0x2f/0x33 [reiser4] (68)
> [<c016061a>] do_kern_mount+0x4f/0xc0 (4)
> [<c0175945>] do_new_mount+0x9c/0xe1 (36)
> [<c0175feb>] do_mount+0x145/0x194 (44)
> [<c0176459>] sys_mount+0x9f/0xe0 (32)
> [<c01060b1>] sysenter_past_esp+0x52/0x71 (44)

reiser4 has some pretty ugly locking abstraction called kcond, i took a
look but it doesnt seem simple to convert it. Reiserfs should really use
a normal Linux waitqueue and nothing more...

	Ingo
