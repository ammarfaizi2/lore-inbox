Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbTBDAjA>; Mon, 3 Feb 2003 19:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbTBDAjA>; Mon, 3 Feb 2003 19:39:00 -0500
Received: from ns.suse.de ([213.95.15.193]:60428 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267059AbTBDAi7>;
	Mon, 3 Feb 2003 19:38:59 -0500
To: "Haoqiang Zheng" <hzheng@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux hangs with printk on schedule()
References: <05db01c2cbe5$4b4c34f0$9c2a3b80@zhengthinkpad.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Feb 2003 01:48:32 +0100
In-Reply-To: "Haoqiang Zheng"'s message of "4 Feb 2003 01:38:59 +0100"
Message-ID: <p733cn4rhun.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Haoqiang Zheng" <hzheng@cs.columbia.edu> writes:

> I found Linux hangs when printk is inserted to the function schedule().
> Sure, it doesn't make much sense to add such a line to schedule(). But Linux
> shouldn't hang anyway, right? It's assumed that printk can be inserted
> safely to anywhere. So, is it a bug of Linux?
> 
> The linux I am running is 2.4.18-14, the same version used by Redhat 8.0.
> The scheduler is Ingo's O(1) scheduler.

printk can call wake_up to wake up the klogd daemon. This will deadlock
on aquiring the scheduler lock of the local run queue.

One way to avoid it is to wrap it like this:

	oops_in_progress++;
	printk(...);
	oops_in_progress--;

And no, it's not a bug in Linux.

-Andi
