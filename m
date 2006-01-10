Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWAJJ6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWAJJ6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 04:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWAJJ6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 04:58:13 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:13451 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932080AbWAJJ6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 04:58:13 -0500
Date: Tue, 10 Jan 2006 15:28:11 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/5] rcu: don't check ->donelist in __rcu_pending()
Message-ID: <20060110095811.GA30159@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <43C165BC.F7C6DCF5@tv-sign.ru> <20060109185944.GB15083@us.ibm.com> <43C2C818.65238C30@tv-sign.ru> <20060109195933.GE14738@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109195933.GE14738@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 11:59:33AM -0800, Paul E. McKenney wrote:
> Hmmm...  So your thought is that __rcu_offline_cpu() moves nxtlist and
> curlist, but not donelist, but then returns to rcu_offline_cpu(), which
> might well do the tasklet_kill_immediate() before the tasklet completed
> processing all of donelist.
> 
> Seems plausible to me.  If true, your patch adding the following statement
> to the ed of __rcu_offline_cpu seems like a reasonable fix:
> 
> 	rcu_move_batch(this_rdp, rdp->donelist, rdp->donetail);
>
> Vatsa, is there something that Oleg and I are missing?

I think this should take care of the CPU Hotplug bug, with the caveat
that the callbacks on ->donelist will wait for additional grace period before 
being invoked (which seems ok).

Oleg, do you want to resend the patch after some testing? 

- vatsa
