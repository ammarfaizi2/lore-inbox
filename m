Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbUBPDml (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 22:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbUBPDmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 22:42:40 -0500
Received: from dp.samba.org ([66.70.73.150]:56992 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265337AbUBPDmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 22:42:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christophe Saout <christophe@saout.de>
Cc: LKML <linux-kernel@vger.kernel.org>, pavel@suse.cz
Subject: Re: kthread, signals and PF_FREEZE (suspend) 
In-reply-to: Your message of "Mon, 16 Feb 2004 01:18:52 BST."
             <1076890731.5525.31.camel@leto.cs.pocnet.net> 
Date: Mon, 16 Feb 2004 14:38:22 +1100
Message-Id: <20040216034251.0912E2C0F8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1076890731.5525.31.camel@leto.cs.pocnet.net> you write:
> Hi,
> 
> I was wondering, has kthread been tested with the suspend code?

No, it hasn't.

> When trying to freeze the processes the suspend code sets PF_FREEZE on a
> process and calls signal_wake_up(p, 0);
> 
> That means that signal_pending() will return true for that process which
> will make kthread stop the thread.

Yes, the way they are currently coded.  I had assumed that spurious
signals do not occur.

> The workqueues have PF_IOTHREAD set and I'm only seeing those on my
> machine that's why it doesn't fail.
> 
> But the migration threads for example call signal_pending() directly
> after schedule() before checking PF_FREEZE and calling refrigerator()
> (which BTW flushes all signals).

This will only happen on SMP systems with > 1 cpu though?  I don't
think suspend works there anyway.

However, ksoftirqd will die I think: that will hurt if lots of irqs
come in.

Pavel, what is the answer here?  Should the refrigerator code be in
the kthread infrastructure?  Why does the workqueue code set
PF_IOTHREAD?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
