Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVKGE6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVKGE6N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 23:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVKGE6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 23:58:13 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:18882 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751287AbVKGE6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 23:58:12 -0500
Date: Sun, 6 Nov 2005 20:58:09 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, oleg@tv-sign.ru, dipankar@in.ibm.com,
       suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
Message-ID: <20051107045809.GA24195@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051031020535.GA46@us.ibm.com> <20051031140459.GA5664@elte.hu> <20051106134945.0e10cb60.akpm@osdl.org> <436EA9F9.4020809@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436EA9F9.4020809@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 12:12:25PM +1100, Nick Piggin wrote:
> Andrew Morton wrote:
> 
> >>+static inline int get_task_struct_rcu(struct task_struct *t)
> >>+{
> >>+	int oldusage;
> >>+
> >>+	do {
> >>+		oldusage = atomic_read(&t->usage);
> >>+		if (oldusage == 0) {
> >>+			return 0;
> >>+		}
> >>+	} while (cmpxchg(&t->usage.counter,
> >>+		 oldusage, oldusage + 1) != oldusage);
> >>+	return 1;
> >>+}
> >
> >
> >arm (at least) does not implement cmpxchg.
> >
> 
> Yes, and using atomic_t.counter in generic code is ugly, albeit
> compatible with all current implementations.
> 
> >I think Nick is working on patches which implement cmpxchg on all
> >architectures?
> 
> Yes, it is basically ready to go.

Would it simplify the rcuref.h code?  Or lib/dec_and_lock.c?

						Thanx, Paul
