Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274851AbRJJGHj>; Wed, 10 Oct 2001 02:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274863AbRJJGHa>; Wed, 10 Oct 2001 02:07:30 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:38130
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274851AbRJJGHR>; Wed, 10 Oct 2001 02:07:17 -0400
Date: Tue, 9 Oct 2001 23:07:43 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Context switch times
Message-ID: <20011009230743.C12825@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BC067BB.73AF1EB5@welho.com> <200110081519.f98FJnZ10592@deathstar.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110081519.f98FJnZ10592@deathstar.prodigy.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 11:19:49AM -0400, bill davidsen wrote:
> In article <3BC067BB.73AF1EB5@welho.com> Mika.Liljeberg@welho.com wrote:
> 
> >Yes. However, you still want to balance the queues even if all CPUs are
> >100% utilized. It's a fairness issue. Otherwise you could have 1 task
> >running on one CPU and 49 tasks on another.
> 
>   You say that as if it were a bad thing... I believe that if you have
> one long running task and many small tasks in the system CPU affinity
> will make that happen now. Obviously not if all CPUs are 100% loaded,
> and your 1 vs. 49 is unrealistic, but having a task stay with a CPU
> while trivia run on other CPU(s) is generally a good thing under certain
> load conditions, which I guess are no less likely than your example;-)
>

Lets put an actual load example (which I just happen do be doing now):

On my 2x366 celeron smp box, I have a kernel compile running (-j15), and a
bzip2 compressing several large files...

Right now, (2.4.10-ac4, compiling 2.4.10-ac10+preempt) both of my L2
processor caches are moot (128KB) because of the several gcc processes
running, and the very loose affinity.

In this case, bzip2 should probably get a processor (CPU0) to itself, and my kernel
compile another(CPU1).  

It would be interesting to see how a system that has a kind of hierarchy to
the processors.  All new processes would always start on cpu0, and long
running processes would get slowly moved up the list of processors the
longer they run.  Thus, CPU0 would have abysmal L2 cache locality, and CPU7
would have the best caching possible with its L2.

What do you guys think?
