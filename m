Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbTFSUgy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbTFSUgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:36:50 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7179 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265665AbTFSUgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:36:37 -0400
Date: Thu, 19 Jun 2003 16:43:36 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: James Simmons <jsimmons@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71 - random console corruption
In-Reply-To: <Pine.LNX.4.44.0306172149490.21214-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.3.96.1030619164055.12043B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jun 2003, James Simmons wrote:

> 
> > > For userland<->kernel transactions we have the console_semaphore to 
> > > protect us. It is also used for console_callback. The console_semaphore is
> > > not used internally to protect global variables :-( To do this properly 
> > > would take quite a bit of work.  
> > 
> > It looks like all these globals need a lock -- they can race on SMP or
> > with kernel preemption.
> > 
> > Is it really going to be that hard to wrap a lock around their access,
> > because I think this is going to bite SMP users.
> 
> For things like fg_console and currcon it will be. Those variables are 
> used everyway like mad. That is a whole lot of locks. I doubt this issue 
> will be solved until 2.7.X.

Given that it has just become easy to replicate, I suspect that it will
get fixed by someone looking at the recent changes. Agreed, a perfect fix
may wait, but when preempt fails regularly and SMP works, as described in
posts and by some mail, I don't think a rewrite is needed, just one or a
few locks.

My guess only.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

