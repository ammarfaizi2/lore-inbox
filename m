Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVHLPmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVHLPmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 11:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVHLPmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 11:42:24 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:36793 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751200AbVHLPmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 11:42:23 -0400
Date: Fri, 12 Aug 2005 08:42:52 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050812154252.GB1297@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com> <42FC6305.E7A00C0A@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FC6305.E7A00C0A@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 12:51:17PM +0400, Oleg Nesterov wrote:
> Paul E. McKenney wrote:
> >
> > --- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/fs/exec.c	2005-08-11 11:44:55.000000000 -0700
> > +++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/fs/exec.c	2005-08-11 12:26:45.000000000 -0700
> > [ ... snip ... ]
> > @@ -785,11 +787,13 @@ no_thread_group:
> >  		recalc_sigpending();
> > 
> > +		oldsighand->deleted = 1;
> > +		oldsighand->successor = newsighand;
> 
> I don't think this is correct.
> 
> This ->oldsighand can be shared with another CLONE_SIGHAND
> process and will not be deleted, just unshared.
> 
> When the signal is sent to that process we must use ->oldsighand
> for locking, not the oldsighand->successor == newsighand.

Hmmm...  Sounds like I mostly managed to dig myself in deeper here.

Back to the drawing board...

						Thanx, Paul
