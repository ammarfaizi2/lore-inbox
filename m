Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277411AbRJEPZ1>; Fri, 5 Oct 2001 11:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277413AbRJEPZI>; Fri, 5 Oct 2001 11:25:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60468 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S277414AbRJEPYu>; Fri, 5 Oct 2001 11:24:50 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Kravetz <kravetz@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Context switch times
In-Reply-To: <Pine.LNX.4.33.0110041647130.975-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Oct 2001 09:15:37 -0600
In-Reply-To: <Pine.LNX.4.33.0110041647130.975-100000@penguin.transmeta.com>
Message-ID: <m1adz6yv6u.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Thu, 4 Oct 2001, Mike Kravetz wrote:
> 
> > On Thu, Oct 04, 2001 at 10:42:37PM +0000, Linus Torvalds wrote:
> > > Could we try to hit just two? Probably, but it doesn't really matter,
> > > though: to make the lmbench scheduler benchmark go at full speed, you
> > > want to limit it to _one_ CPU, which is not sensible in real-life
> > > situations.
> >
> > Can you clarify?  I agree that tuning the system for the best LMbench
> > performance is not a good thing to do!  However, in general on an
> > 8 CPU system with only 2 'active' tasks I would think limiting the
> > tasks to 2 CPUs would be desirable for cache effects.
> 
> Yes, limiting to 2 CPU's probably gets better cache behaviour, and it
> might be worth looking into why it doesn't. The CPU affinity _should_
> prioritize it down to two, but I haven't thought through your theory about
> IPI latency.

I don't know what it is but I have seen this excessive cpu switching
in the wild.  In particular on a dual processor machine I ran 2 cpu
intensive jobs, and a handful of daemons.  And the cpu intensive jobs
would switch cpus every couple of seconds.  

I was investigating it because on the Athlon I was running on a
customer was getting a super linear speed up.  With one processes it
would take 8 minutes, and with 2 processes one would take 8 minutes
and the other would take 6 minutes.  Very strange.  

These processes except at their very beginning did no I/O and were
pure cpu hogs until they spit out their results.  Very puzzling.
I can't see why we would ever want to take the cache miss penalty of
switching cpus, in this case.

Eric
