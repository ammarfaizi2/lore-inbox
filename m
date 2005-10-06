Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVJFP1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVJFP1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVJFP1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:27:49 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:5646 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1751092AbVJFP1s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:27:48 -0400
Message-ID: <20051006192106.A13978@castle.nmd.msu.ru>
Date: Thu, 6 Oct 2005 19:21:06 +0400
From: Andrey Savochkin <saw@sawoct.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, st@sw.ru, discuss@x86-64.org
Subject: Re: SMP syncronization on AMD processors (broken?)
References: <434520FF.8050100@sw.ru> <p73hdbuzs7l.fsf@verdi.suse.de> <20051006174604.B10342@castle.nmd.msu.ru> <Pine.LNX.4.64.0510060750230.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.4.64.0510060750230.31407@g5.osdl.org>; from "Linus Torvalds" on Thu, Oct 06, 2005 at 07:52:17AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 07:52:17AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 6 Oct 2005, Andrey Savochkin wrote:
> > 
> > Well, it's hard to swallow...
> > It's not about being not fully fair, it's about deadlocks that started
> > to appear after code changes inside retry loops...
> 
> No, it's not about fairness.
> 
> It's about BUGS IN YOUR CODE.
> 
> If you need fairness, you need to implement that yourself. You can do so 
> many ways. Either on top of spinlocks, by using an external side-band 
> channel, or by using semaphores instead of spinlocks (semaphores are much 
> higher cost, but part of the cost is that they _are_ fair).

Ok, let it be a bug.

I just want to repeat that nobody wanted or expected any fairness in this case.
But such extremety that on some CPU models one CPU never, not in billion
cycles, can get the lock if the other CPU repeatedly drops and acquires the
lock, and that in this scenario memory changes seem to never propagate to
other CPUs - well, all of that is a surprise.

I start to wonder about existing mainstream code, presumably bug-free, that
uses spinlocks without any problematic restart.
If one day some piece starts to be called too often by some legitimate
reasons, it might fall into the same pattern and completely block others who
want to take the same spinlock.
I'm not advocating for changing spinlock implementation, it's just a
thought...

	Andrey
