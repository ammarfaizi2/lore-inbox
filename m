Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264568AbUASLcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264565AbUASLbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:31:50 -0500
Received: from dp.samba.org ([66.70.73.150]:36826 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264566AbUASLbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:31:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>
Cc: tmolina@cablespeed.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4 
In-reply-to: Your message of "Sat, 17 Jan 2004 10:52:39 -0800."
             <20040117105239.0b94f2b3.akpm@osdl.org> 
Date: Mon, 19 Jan 2004 18:16:50 +1100
Message-Id: <20040119113132.D25A52C2AA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040117105239.0b94f2b3.akpm@osdl.org> you write:
> Hugh Dickins <hugh@veritas.com> wrote:
> >  I was getting something like that on reboot a few days ago, I think it
> >  was with 2.6.1-mm2.  I had to move on before debugging it fully, but
> >  the impression I got (maybe vile calumny, sue me Rusty) was that the
> >  new kthread_create for 2.6.1-mm's ksoftirqd was leaving it vulnerable
> >  to shutdown kill, whereas other things (RCU in my traces) still needed
> >  it around and assumed its task address still valid.
> 
> Yes.  ksoftirqd and the migration threads can now be killed off
> with `kill -9'.

"That shouldn't happen".

We block and flush all signals in workqueue.c.  How is that kill -9
getting through?

It also implies that previously ksoftirqd and migration threads would
tight spin after kill -9, since they slept with TASK_INTERRUPTIBLE.

Will dig...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
