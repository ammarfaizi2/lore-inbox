Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270206AbTHFRBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270652AbTHFRBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:01:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46328 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S270206AbTHFRBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:01:18 -0400
Subject: Re: [patch] real-time enhanced page allocator and throttling
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu,
       piggin@cyberone.com.au, kernel@kolivas.org, linux-mm@kvack.org
In-Reply-To: <20030806014148.5408cfbd.akpm@osdl.org>
References: <1060121638.4494.111.camel@localhost>
	 <20030805170954.59385c78.akpm@osdl.org>
	 <1060130368.4494.166.camel@localhost>
	 <20030805174536.6cb5fbf0.akpm@osdl.org>
	 <1060142290.4494.197.camel@localhost>
	 <20030806014148.5408cfbd.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1060189274.4494.212.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 06 Aug 2003 10:01:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-06 at 01:41, Andrew Morton wrote:

> It's pretty easy to demonstrate the benefit of the balance_dirty_pages()
> change.  Just do:
> 
> while true
> do
> 	dd if=/dev/zero of=foo bs=1M count=512 conv=notrunc
> done
> 
> and also:
> 
> rm 1 ; sleep 3; time dd if=/dev/zero of=1 bs=16M count=1
> 
> The 16M dd normally takes 1.5 seconds (I'm pretty please with that btw. 
> Very repeatable and fair).  If you run the 16M dd with SCHED_FIFO it takes
> a repeatable 0.12 seconds.

This is what I did. Same results, basically.

What I did not do was prove that the xmms stalls went away for those who
were seeing that.

> So running a program off disk isn't a very good test.

No, its not. And in general, real-time tasks should not do disk I/O (at
least not via their core RT thread). And they should mlock() their
memory.

But circumstances do differ, and these changes are in the right
direction, I think. It also means e.g. someone can make xmms or whatever
real-time, and hopefully avoid the memory-related stalls that spawned
the discussion and this patch.

	Robert Love


