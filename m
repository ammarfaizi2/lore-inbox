Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317360AbSGDESq>; Thu, 4 Jul 2002 00:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317362AbSGDESq>; Thu, 4 Jul 2002 00:18:46 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:25472
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317360AbSGDESp>; Thu, 4 Jul 2002 00:18:45 -0400
Date: Wed, 3 Jul 2002 21:17:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
Message-ID: <20020704041739.GE697@opus.bloom.county>
References: <20020702151206.GK20920@opus.bloom.county> <Pine.LNX.3.96.1020703234516.2248E-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020703234516.2248E-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 12:02:20AM -0400, Bill Davidsen wrote:

> On Tue, 2 Jul 2002, Tom Rini wrote:
> 
> > Sure there is.  It's called stopping feature creep.  O(1) is a nice
> > feature, but so is the bio stuff, the initcall levels, and other things
> > in 2.5 as well.  But should we back port all of these to 2.4 as well?
> 
> None of the other stuff is (a) a solution for any current problem I've
> seen (it NEW capability), or (b) has a functional and widely exposed port
> to 2.4 already.

I believe (b), but bio is attempting to solve some of the underlying
block device issues.  And all of the IDE stuff is trying to make a good
IDE subsystem.  And so on and so forth.

> The only other feature which which I'm familiar which even remotely fits
> those two characteristics is rmap, and with the VM changes Andrea has made
> I certainly don't hit really bad VM behaviour on my machines. On some rmap
> is a tad better, but compared to 2.4.16 or so 19-preX-aa is acceptable.

And rmap isn't in 2.4.  And I don't think it will be, nor IMHO some
parts of -aa.

> > It's no more of a reduction in stability than not back porting
> > everything else.  And making things stable is why eventually Linus says
> > 'enough' and kicks out 2.stable.0-test1.  Anyhow, since this isn't a
> > subsystem backport, but part of the core kernel, I would think that you
> > could only get limited use out of the testing (I remember reading some
> > of the O(1) announcments for 2.4.then-current and reading about small
> > bugs that weren't in the 2.5 version).
> 
> The current scheduler has one big bug; it gives the processor to the wrong
> process under some load conditions to the point where the system appears
> hung for seconds (or longer).

So, in some corner cases it sucks.  The VM has issues for corner cases
as well, which is why distros include lots of other patches in their
kernels.

> And as I mentioned to Ingo, I don't feel that way about low-latency or
> preempt, even though they help a little they don't really fix anything
> broken, and I don't argue for inclusion. The current scheduler does behave
> very badly in some cases, and should be fixed now, not in 18 months.

I don't think the low-latency, preempt or O(1) should make it into 2.4.
And since Ingo, who wrote this, doesn't think it should go into 2.4
right now, it hopefully won't.

Just because some corner cases can be fixed by massive rewrites doesn't
mean the fix should be backported.  It seems I can't stress this enough,
2.4 is supposed to be _stable_.  And by stable I mean doesn't crash,
lock up, or panic.  Less than ideal VM usage or CPU usage generally
isn't solvable in small easily verifiable patches like fixing crashes,
lock ups and panics are.

I'm not saying people shouldn't use O(1) (or preempt or low-latency or a
half dozen other things not in 2.4 proper), just that they shouldn't go
into 2.4.<current>.  Vendors should decide if they want to add them on
top of a stable base.  Users should decide if they want to add them on
top of a stable base.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
