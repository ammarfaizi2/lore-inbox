Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUGMX3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUGMX3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267233AbUGMX3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:29:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:38123 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267232AbUGMX3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:29:44 -0400
Date: Tue, 13 Jul 2004 16:32:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040713163236.0dbf3872.akpm@osdl.org>
In-Reply-To: <20040713231803.GP974@dualathlon.random>
References: <20040713162539.GD974@dualathlon.random>
	<20040713114829.705b9607.akpm@osdl.org>
	<20040713213847.GH974@dualathlon.random>
	<20040713145424.1217b67f.akpm@osdl.org>
	<20040713220103.GJ974@dualathlon.random>
	<20040713152532.6df4a163.akpm@osdl.org>
	<20040713223701.GM974@dualathlon.random>
	<20040713154448.4d29e004.akpm@osdl.org>
	<20040713225305.GO974@dualathlon.random>
	<20040713160628.596b96a3.akpm@osdl.org>
	<20040713231803.GP974@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > And it's currently OK to add a might_sleep() to (say) an inline path which
> > is expended a zillion times because we know it'll go away for production
> > builds.  If those things become cond_resched() calls instead, the code
> > increase will be permanent.
> 
> this is exactly why I'm making this change: so you can still add
> might_sleep in a inline path expected to run a zillion times. With
> Ingo's change you would be doing cond_sched internally to might_sleep, I
> do the other way around so might_sleep remains a debugging statement.

OK.


cond_resched() is usually a waste of space with CONFIG_PREEMPT.  It might
make sense to define a cond_resched_if_not_preempt thingy, which only does
things if !CONFIG_PREEMPT.  We'd still need to use cond_resched() inside
lock_kernel().

> 
> > I've yet to go through Arjan's patch - I suspect a lot of it is not needed.
> 
> Arjan's or Ingo's? I've seen Ingo's patch but maybe I missed Arjan's one.

I think Ingo's patch includes Arjan's one.  Ingo's patch apparently breaks
ext3.  I have a bunch of ext3 and other fixes here, but there's still an occasional
problem on SMP.

