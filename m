Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWAIOQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWAIOQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWAIOQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:16:47 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:41647 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751043AbWAIOQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:16:46 -0500
Message-ID: <43C2822F.F26F855E@tv-sign.ru>
Date: Mon, 09 Jan 2006 18:33:03 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/5] rcu: don't check ->donelist in __rcu_pending()
References: <43C165BC.F7C6DCF5@tv-sign.ru> <20060109093141.GA10811@in.ibm.com> <43C2785C.4E937748@tv-sign.ru> <20060109134238.GA26700@in.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> 
> On Mon, Jan 09, 2006 at 05:51:08PM +0300, Oleg Nesterov wrote:
> > Srivatsa Vaddagiri wrote:
> > >             If we have to do a rcu_move_batch of ->donelist also,
> > > then perhaps the ->donelist != NULL check is required in
> > > rcu_pending?
> >
> > rcu_move_batch() always adds entries to the ->nxttail, so I think
> > this patch is correct.
> 
> Hmm ..adding entries on dead cpu's ->donelist to ->nxtlist of some other CPU
> doesnt make sense (it re-triggers graceperiods for all those callbacks which is
> not needed).

Yes, but this is rare event, so ...

>              Maybe rcu_move_batch should take that into account and instead add
> to ->donelist of current CPU which is processing the CPU_DEAD callback.

May be you are right,

> In which case, ->donelist != NULL check is still reqd in rcu_pending ?

Yes, in that case it is required. Do you think it is worth to optimize
CPU_DEAD case?

Oleg.
