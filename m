Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292117AbSBAWpf>; Fri, 1 Feb 2002 17:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292119AbSBAWpZ>; Fri, 1 Feb 2002 17:45:25 -0500
Received: from air-1.osdl.org ([65.201.151.5]:1408 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292117AbSBAWpP>;
	Fri, 1 Feb 2002 17:45:15 -0500
Date: Fri, 1 Feb 2002 14:45:07 -0800
From: Bob Miller <rem@osdl.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.3 remove global semaphore_lock spin lock.
Message-ID: <20020201144507.A1419@doc.pdx.osdl.net>
In-Reply-To: <20020131150139.A1345@doc.pdx.osdl.net> <3C59D956.4F2B85DB@zip.com.au>, <3C59D956.4F2B85DB@zip.com.au> <20020201125234.A1418@doc.pdx.osdl.net> <3C5B0312.40DB82AB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5B0312.40DB82AB@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 01:05:22PM -0800, Andrew Morton wrote:
> Bob Miller wrote:
> > 
> > Also, at your suggestion I set wait.h:USE_RW_WAIT_QUEUE_SPINLOCK on
> > a clean 2.5.3 system to test.  The problem is that it OOPs on startup.
> 
> OK, someone broke it; possibly the scheduler changes.  Not surprising,
> really.
> 
> It'd be nice to have it fixed, but I wouldn't suggest that you
> bust a gut over it.   Certainly your patch shouldn't be held up by
> this.  An oops trace would be useful.
> 
> -
I found the problem... in kernel/sched.c around the 2.4.7 time frame
wait_for_completion() and other code was added.  It uses a new
completion structure that has a wait_queue_haed_t embedded in it.
In wait_for_completion() and other places they use spin_lock_*()
calls that cause the OOPs.

In order to do some of the clean up you suggested I needed to and
some macros to wait.h.  To fix wait_for_completion() and others
those same macros will be needed.  I'm going to fix the wait_for_completion()
stuff first and then get back to the sema stuff.

-- 
Bob Miller					Email: rem@osdl.org
Open Software Development Lab			Phone: 503.626.2455 Ext. 17
