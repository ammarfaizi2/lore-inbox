Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWAINmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWAINmt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWAINmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:42:49 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:22735 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751526AbWAINms
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:42:48 -0500
Date: Mon, 9 Jan 2006 19:12:39 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/5] rcu: don't check ->donelist in __rcu_pending()
Message-ID: <20060109134238.GA26700@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <43C165BC.F7C6DCF5@tv-sign.ru> <20060109093141.GA10811@in.ibm.com> <43C2785C.4E937748@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C2785C.4E937748@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 05:51:08PM +0300, Oleg Nesterov wrote:
> Srivatsa Vaddagiri wrote:
> >             If we have to do a rcu_move_batch of ->donelist also,
> > then perhaps the ->donelist != NULL check is required in
> > rcu_pending?
> 
> rcu_move_batch() always adds entries to the ->nxttail, so I think
> this patch is correct.

Hmm ..adding entries on dead cpu's ->donelist to ->nxtlist of some other CPU 
doesnt make sense (it re-triggers graceperiods for all those callbacks which is 
not needed). Maybe rcu_move_batch should take that into account and instead add
to ->donelist of current CPU which is processing the CPU_DEAD callback.

In which case, ->donelist != NULL check is still reqd in rcu_pending ?


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
