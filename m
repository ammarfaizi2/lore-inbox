Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbUKEClK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbUKEClK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 21:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbUKEClK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 21:41:10 -0500
Received: from ultra7.eskimo.com ([204.122.16.70]:8465 "EHLO ultra7.eskimo.com")
	by vger.kernel.org with ESMTP id S262568AbUKEClD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 21:41:03 -0500
Date: Thu, 4 Nov 2004 18:38:50 -0800
From: Elladan <elladan@eskimo.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Russell Miller <rmiller@duskglow.com>, Doug McNaught <doug@mcnaught.org>,
       Jim Nelson <james4765@verizon.net>, DervishD <lkml@dervishd.net>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       M?ns Rullg?rd <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041105023850.GC17010@eskimo.com>
References: <200411030751.39578.gene.heskett@verizon.net> <87k6t24jsr.fsf@asmodeus.mcnaught.org> <200411031733.30469.rmiller@duskglow.com> <200411040839.34350.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411040839.34350.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 08:39:34AM +0200, Denis Vlasenko wrote:
> On Thursday 04 November 2004 01:33, Russell Miller wrote:
> > On Wednesday 03 November 2004 17:03, Doug McNaught wrote:
> > 
> > > It was already mentioned in this thread that the bookkeeping required
> > > to clean up properly from such an abort would add a lot of overhead
> > > and slow down the normal, non-buggy case.
> > >
> > I am going to continue pursuing this at the risk of making a bigger fool of 
> > myself than I already am, but I want to make sure that I understand the 
> > issues - and I did read the message you are referring to.
> > 
> > I think what you are saying is that there is kind of a race condition here.  
> > When something is on the wait queue, it has to be followed through to 
> > completion.  An interrupt could be received at any time, and if it's taken 
> > off of the wait queue prematurely, it'll crash the kernel, because the 
> > interrupt has no way of telling that.
> 
> The problem is in locking. You must not kill process while it is
> in uninterruptible state because it is uninterruptible
> for a reason - has taken semaphore, or get_cpu(), etc.
> You do want it to do put_cpu(), right?
> 
> Processes must never get stuck in D, it's a kernel bug.
> 
> Find out how did process ended up in D state forever,
> and fix it - that's what I'm trying to do
> in these cases.

Perhaps it would be useful to add some debugging to the kernel for these
cases, somewhat akin to Ingo's preempt trace stuff?

If a process is in D state and receives a SIGKILL, assume it must exit
within a few seconds or it's a bug, and dump as much information about
it as is practical...?

-J

