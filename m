Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbUKVXQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbUKVXQP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUKVXNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:13:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:30385 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261224AbUKVXMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:12:22 -0500
Date: Mon, 22 Nov 2004 15:16:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: hugh@veritas.com, torvalds@osdl.org, benh@kernel.crashing.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: deferred rss update instead of sloppy rss
Message-Id: <20041122151628.77ab87ca.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411221444410.22895@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	<20041122141148.1e6ef125.akpm@osdl.org>
	<Pine.LNX.4.58.0411221408540.22895@schroedinger.engr.sgi.com>
	<20041122144507.484a7627.akpm@osdl.org>
	<Pine.LNX.4.58.0411221444410.22895@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Mon, 22 Nov 2004, Andrew Morton wrote:
> 
> > > The page fault code only increments rss. For larger transactions that
> > > increase / decrease rss significantly the page_table_lock is taken and
> > > mm->rss is updated directly. So no
> > > gross inaccuracies can result.
> >
> > Sure.  Take a million successive pagefaults and mm->rss is grossly
> > inaccurate.  Hence my suggestion that it be spilled into mm->rss
> > periodically.
> 
> It is spilled into mm->rss periodically. That is the whole point of the
> patch.
> 
> The timer tick occurs every 1 ms.

That only works if the task happens to have the CPU when the timer tick
occurs.  There remains no theoretical upper bound to the error in mm->rss,
and that's very easy to fix.
