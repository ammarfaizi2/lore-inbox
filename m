Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWAMBcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWAMBcU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 20:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWAMBcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 20:32:20 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:7385 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964800AbWAMBcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 20:32:20 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Date: Fri, 13 Jan 2006 12:32:01 +1100
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <20051227190918.65c2abac@localhost> <20051230145221.301faa40@localhost> <200601131213.14832.kernel@kolivas.org>
In-Reply-To: <200601131213.14832.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601131232.01846.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 January 2006 12:13, Con Kolivas wrote:
> On Saturday 31 December 2005 00:52, Paolo Ornati wrote:
> > WAS: [SCHED] Totally WRONG prority calculation with specific test-case
> > (since 2.6.10-bk12)
> > http://lkml.org/lkml/2005/12/27/114/index.html
> >
> > On Wed, 28 Dec 2005 10:26:58 +1100
> >
> > Con Kolivas <kernel@kolivas.org> wrote:
> > > The issue is that the scheduler interactivity estimator is a state
> > > machine and can be fooled to some degree, and a cpu intensive task that
> > > just happens to sleep a little bit gets significantly better priority
> > > than one that is fully cpu bound all the time. Reverting that change is
> > > not a solution because it can still be fooled by the same process
> > > sleeping lots for a few seconds or so at startup and then changing to
> > > the cpu mostly-sleeping slightly behaviour. This "fluctuating"
> > > behaviour is in my opinion worse which is why I removed it.
> >
> > Trying to find a "as simple as possible" test case for this problem
> > (that I consider a BUG in priority calculation) I've come up with this
> > very simple program:
>
> Hi Paolo.
>
> Can you try the following patch on 2.6.15 please? I'm interested in how
> adversely this affects interactive performance as well as whether it helps
> your test case.

I should make it clear. This patch _will_ adversely affect interactivity 
because your test case desires that I/O bound tasks get higher priority, and 
this patch will do that. This means that I/O bound tasks will be more 
noticeable now. The question is how much do we trade off one for the other. 
We almost certainly are biased a little too much on the interactive side on 
the mainline kernel at the moment.

Cheers,
Con
