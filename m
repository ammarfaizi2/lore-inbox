Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWF1Pbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWF1Pbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423320AbWF1Pbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:31:52 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:2252 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422687AbWF1Pbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:31:51 -0400
Date: Wed, 28 Jun 2006 08:32:25 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] srcu: RCU variant permitting read-side blocking
Message-ID: <20060628153225.GB1293@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060627211358.GA484@oleg> <20060627185945.GD1286@us.ibm.com> <20060628194121.GA247@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628194121.GA247@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 11:41:21PM +0400, Oleg Nesterov wrote:
> On 06/27, Paul E. McKenney wrote:
> >
> > On Wed, Jun 28, 2006 at 01:13:58AM +0400, Oleg Nesterov wrote:
> > > 
> > > Also, I can't understand the purpose of 2-nd synchronize_sched() in
> > > synchronize_srcu().
> > 
> > This one handles the srcu_read_unlock() analog of the situation you
> > are worried about above.  The reader does not have memory barriers in
> > srcu_read_unlock(), so an access to the data structure might get
> > reordered to follow the decrement of .c[0] -- which would get messed
> > up by the following kfree().
> 
> Aha, I see.

Fortunately, we understood opposite sides of the problem, so, taken
together, we have it covered.  ;-)

Now we just need to figure out how to find the problems that both of
us missed!

> The last question. The 'srcu-2' you posted today does synchronize_srcu_flip()
> twice. You did it this way because srcu is optimized for readers, otherwise we
> could just add smp_rmb() into srcu_read_lock() - this should solve the problem
> as well.
> 
> Is my understanding correct?

Exactly correct!!!

							Thanx, Paul
