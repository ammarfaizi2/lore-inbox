Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289164AbSANXIO>; Mon, 14 Jan 2002 18:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289281AbSANXID>; Mon, 14 Jan 2002 18:08:03 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:47356 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S289277AbSANXHO>; Mon, 14 Jan 2002 18:07:14 -0500
Message-ID: <3C436446.65F03FD6@mvista.com>
Date: Mon, 14 Jan 2002 15:05:42 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jogi@planetzork.ping.de
CC: Ed Sweetman <ed.sweetman@wmich.edu>, Andrea Arcangeli <andrea@suse.de>,
        yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com> <20020112180016.T1482@inspiron.school.suse.de> <005301c19b9b$6acc61e0$0501a8c0@psuedogod> <20020113162258.C1439@planetzork.spacenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jogi@planetzork.ping.de wrote:
> 
> On Sat, Jan 12, 2002 at 02:00:17PM -0500, Ed Sweetman wrote:
> >
> >
> > > On Sat, Jan 12, 2002 at 09:52:09AM -0700, yodaiken@fsmlabs.com wrote:
> > > > On Sat, Jan 12, 2002 at 04:07:14PM +0100, jogi@planetzork.ping.de wrote:
> > > > > I did my usual compile testings (untar kernel archive, apply patches,
> > > > > make -j<value> ...
> > > >
> > > > If I understand your test,
> > > > you are testing different loads - you are compiling kernels that may
> > differ
> > > > in size and makefile organization, not to mention different layout on
> > the
> > > > file system and disk.
> >
> > Can someone tell me why we're "testing" the preempt kernel by running
> > make -j on a build?  What exactly is this going to show us?  The only thing
> > i can think of is showing us that throughput is not damaged when you want to
> > run single apps by using preempt.  You dont get to see the effects of the
> > kernel preemption because all the damn thing is doing is preempting itself.
> >
> > If you want to test the preempt kernel you're going to need something that
> > can find the mean latancy or "time to action" for a particular program or
> > all programs being run at the time and then run multiple programs that you
> > would find on various peoples' systems.   That is the "feel" people talk
> > about when they praise the preempt patch.  make -j'ing something and not
> > testing anything else but that will show you nothing important except "does
> > throughput get screwed by the preempt patch."   Perhaps checking the
> > latencies on a common program on people's systems like mozilla or konqueror
> > while doing a 'make -j N bzImage'  would be a better idea.
> 
> That's the second test I am normally running. Just running xmms while
> doing the kernel compile. I just wanted to check if the system slows
> down because of preemption but instead it compiled the kernel even
> faster :-) 

This sort of thing is nice to hear, but, it does show up a problem in
the non-preempt kernel.  That preemption improves compile performance
implies that the kernel is not doing the right thing during a normal
compile and that preemption, to some extent, corrects the problem.  But
preemption adds the overhead of additional context switches.  It would
be nice to know where the time is coming from.  I.e. lets assume that
the actual compile takes about the same amount of execution time with or
without preemption.  Then for the preemptable kernel to do the job
faster something else must go up, idle time perhaps.  If this is the
case, then there is some place in the kernel that is wasting cpu time
and that is preemptable and the preemptable patch is moving this idle
time to the idle process.  

What ever the reason, while I do want to promote preemption, I think we
should look at this issue and, at the very least, explain it.

>           But so far I was not able to test the latency and furthermore
> it is very difficult to "measure" skipping of xmms ...
> 
> > > Ouch, I assumed this wasn't the case indeed.
> 
> Sorry for not answering immedeatly but I am compiling the same kernel
> source with the same .config and everything I could think of being the
> same! I even do a 'rm -rf linux' after every run and untar the same
> sources *every* time.
> 
> Regards,
> 
>    Jogi
> 
> --
> 
> Well, yeah ... I suppose there's no point in getting greedy, is there?
> 
>     << Calvin & Hobbes >>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
