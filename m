Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbUKVWXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUKVWXC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbUKVWU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:20:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:175 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262412AbUKVWTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:19:11 -0500
Subject: Re: deferred rss update instead of sloppy rss
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       Linus Torvalds <torvalds@osdl.org>, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411221408540.22895@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	 <20041122141148.1e6ef125.akpm@osdl.org>
	 <Pine.LNX.4.58.0411221408540.22895@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Tue, 23 Nov 2004 09:17:24 +1100
Message-Id: <1101161844.13598.133.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 14:13 -0800, Christoph Lameter wrote:
> On Mon, 22 Nov 2004, Andrew Morton wrote:
> 
> > hrm.  I cannot see anywhere in this patch where you update task_struct.rss.
> 
> This is just the piece around it dealing with rss. The updating of rss
> happens in the generic code. The change to that is trivial. I can repost
> the whole shebang if you want.
> 
> > > +	/* only holding mmap_sem here maybe get page_table_lock too? */
> > > +	mm->rss += tsk->rss;
> > > +	tsk->rss = 0;
> > >  	up_read(&mm->mmap_sem);
> >
> > mmap_sem needs to be held for writing, surely?
> 
> If there are no page faults occurring anymore then we would not need to
> get the lock. Q: Is it safe to assume that no faults occur
> anymore at this point?

Why wouldn't the mm take faults on other CPUs ? (other threads)

> > just to prevent transient gross inaccuracies.  For some value of "16".
> 
> The page fault code only increments rss. For larger transactions that
> increase / decrease rss significantly the page_table_lock is taken and
> mm->rss is updated directly. So no
> gross inaccuracies can result.
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

