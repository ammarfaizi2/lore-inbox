Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVAJXLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVAJXLf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVAJXHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:07:07 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:59374 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262725AbVAJXBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:01:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jatKw5M2TVPjNVVzUa1UrNNwNUzZjW30bZFULAv2Zoaas9KzBnNFxhoQKoy/S96KZFnHVoHUhZsYjF6yFKEBRYwDQsnk1MBVl854IwGjDix5ZfJ+3LeChg4/r9y2LYTADFEvO3aQlWmidcdHVHsk7VPR7lpvTf2cmwsZEKiQ4pM=
Message-ID: <3f250c7105011015015940eedd@mail.gmail.com>
Date: Mon, 10 Jan 2005 19:01:37 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: User space out of memory approach
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050110193953.GA18601@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <20050110193953.GA18601@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005 17:39:53 -0200, Marcelo Tosatti
<marcelo.tosatti@cyclades.com> wrote:
> On Mon, Jan 10, 2005 at 05:20:13PM -0200, Marcelo Tosatti wrote:
> > On Mon, Jan 10, 2005 at 05:43:23PM -0400, Mauricio Lin wrote:
> > > Hi all,
> > >
> > > We have done a comparison between the kernel version and user space
> > > version and apparently the behavior is similar. You can also get this
> > > patch and module to test it and compare with kernel OOM Killer. Here
> > > goes a patch and a module that moves the kernel space OOM Killer
> > > algorithm to user space. Let us know about your ideas.
> >
> > No comments on the code itself - It is interesting to have certain pids "not selectable" by
> > the OOM killer. Patches which have similar funcionality have been floating around.
> >
> > The userspace OOM killer is dangerous though. You have to guarantee that allocations
> > will NOT happen until the OOM killer is executed and the killed process is dead and
> > has its pages freed - allocations under OOM can cause deadlocks.
> >
> > "OOM-killer-in-userspace" is unreliable, not sure if its worth the effort making
> > it reliable (mlock it, flagged as PF_MEMALLOC, etc).
> 
> Actually its only unreliable if its called from OOM time.
> 
> The case here is you have a daemon which periodically writes
> to /proc/oom ?
Yes, let me explain the idea.
When the memory consumption reaches a percentage of usage, as 98% or
something like that, we call this as red zone. So when red zone is
reached, the ranking algorithm is started to select which processes
could be killed whe out of memory happens. If the memory comsumption
is less than this percentage (not in red zone), the ranking algorithm
is not executed. So we have a loop the check the memory comsumption
all the time and if the red zone is reached, the ranking algorithm is
started before the system get the out of memory state.

BR,

Mauricio Lin.
