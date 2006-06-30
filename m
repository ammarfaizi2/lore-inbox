Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWF3Gb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWF3Gb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 02:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWF3Gb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 02:31:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4557 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751155AbWF3Gb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 02:31:58 -0400
Date: Thu, 29 Jun 2006 23:31:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: ZVC: Increase threshold for larger processor configurationss
Message-Id: <20060629233151.31a12d81.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606292314580.31091@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606281038530.22262@schroedinger.engr.sgi.com>
	<20060628154911.6e035153.akpm@osdl.org>
	<Pine.LNX.4.64.0606291116500.27926@schroedinger.engr.sgi.com>
	<Pine.LNX.4.64.0606292314580.31091@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 23:15:55 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Thu, 29 Jun 2006, Christoph Lameter wrote:
> 
> > > Did you consider my earlier suggestion about these counters?  That, over the
> > > short-term, they tend to count in only one direction?  So we can do
> > Uhh... We are overcompensating right? Pretty funky idea that is new to me 
> > and that would require some thought.
> > 
> > This would basically increase the stepping by 50% if we are only going in 
> > one direction.
> 
> A patch that does this:
> 
> 
> ZVC: overcompensate while incrementing ZVC counters
> 
> Overcompensate by a balance factor when incrementing or decrementing
> ZVC counters anticipating continual increase in the same direction.

Looks sensible.

Please check that none of this is racy wrt memory hotplug
(process_zones->vm_stat_setup).

> Note that I have not been able to see any effect off this approach on
> an 8p system where I tested this.
> I probably will have a chance to test it on larger systems (160p) tomorrow.

OK.  But let's not rush - it's only fine-tuning.  I'm thinking we should
get what we have in -mm4 into -rc1 - I think it's stable enough, and we
don't want to be carrying all those changes splatered across the VM for the
next two months.  Let's aim to get the well-measured fine-tuning in place
for -rc2, OK?

Are you aware of any to-do items remaining in the -mm4 patches?  The NFS
changes need a review from Trond - hopefully he'll be able to find 5-10
minutes to do that sometime?
