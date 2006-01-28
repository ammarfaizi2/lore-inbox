Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWA1Ckl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWA1Ckl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWA1Ckk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:40:40 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:47833 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964799AbWA1Ckk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:40:40 -0500
Date: Fri, 27 Jan 2006 18:40:09 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch, lock validator] fix uidhash_lock <-> RCU deadlock
Message-ID: <20060128024009.GA10588@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060125142307.GA5427@elte.hu> <20060126111352.GF4953@us.ibm.com> <Pine.LNX.4.64.0601271920000.3192@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601271920000.3192@evo.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 07:22:15PM -0500, Linus Torvalds wrote:
> 
> 
> On Thu, 26 Jan 2006, Paul E. McKenney wrote:
> >
> > On Wed, Jan 25, 2006 at 03:23:07PM +0100, Ingo Molnar wrote:
> > > RCU task-struct freeing can call free_uid(), which is taking 
> > > uidhash_lock - while other users of uidhash_lock are softirq-unsafe.
> > 
> > I guess I get to feel doubly stupid today.  Good catch, great tool!!!
> 
> I wonder if the right fix wouldn't be to free the user struct early, 
> instead of freeing it from RCU. Hmm?

Interesting point, might well be the case.  I will check up on the
following:

1.	Any dependencies on the free path?  (Don't believe so, but...)
2.	Any strange uses on the RCUed signal code paths?  (I don't
	remember right offhand...)
	(Again, don't believe so...)
3.	Any interdependencies among tasks?  (No clue...)

Anything else I should check?

							Thanx, Paul
