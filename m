Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264852AbUEJQ17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264852AbUEJQ17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUEJQ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:27:59 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:4386 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S264852AbUEJQ15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:27:57 -0400
Date: Mon, 10 May 2004 09:26:45 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, arjanv@redhat.com, helgehaf@aitel.hist.no,
       linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-ID: <20040510162645.GA1646@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040508211920.GD4007@in.ibm.com> <20040508171027.6e469f70.akpm@osdl.org> <Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org> <20040508201215.24f0d239.davem@redhat.com> <Pine.LNX.4.58.0405082039510.1592@ppc970.osdl.org> <20040509210312.GL5414@waste.org> <409F3CEE.8060102@aitel.hist.no> <1084177928.4925.13.camel@laptop.fenrus.com> <20040510024658.53cb0b80.akpm@osdl.org> <20040510145403.GL28459@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510145403.GL28459@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 09:54:04AM -0500, Matt Mackall wrote:
> On Mon, May 10, 2004 at 02:46:58AM -0700, Andrew Morton wrote:
> > Arjan van de Ven <arjanv@redhat.com> wrote:
> > >
> > > On Mon, 2004-05-10 at 10:27, Helge Hafting wrote:
> > >  > Matt Mackall wrote:
> > >  > 
> > >  > >One also wonders about whether all the RCU stuff is needed on UP. I'm
> > >  > >not sure if I grok all the finepoints here, but it looks like the
> > >  > >answer is no and that we can make struct_rcu head empty and have
> > >  > >call_rcu fall directly through to the callback. This would save
> > >  > >something like 16-32 bytes (32/64bit), not to mention a bunch of
> > >  > >dinking around with lists and whatnot.
> > >  > >
> > >  > >So what am I missing?
> > >  > >  
> > >  > >
> > >  > Preempt can happen anytime, I believe.
> > > 
> > >  ok so for UP-non-preempt we can still get those 16 bytes back from the
> > >  dentry....
> > 
> > I suppose so.  And on small SMP, really.  We chose not to play those games
> > early on so the code got the best testing coverage.
> 
> Ok, I can spin something up. I'll start with a generic no-RCU-on-UP
> and then we can think about the small SMP case a bit later.

Hello, Matt,

You may wish to start with the dcache portion of Dipankar's earlier patch:

http://sourceforge.net/mailarchive/forum.php?thread_id=3644163&forum_id=730

It does not remove the extra rcu_head from the dentry, but does the
rest of the work.

						Thanx, Paul
