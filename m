Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSIXBtz>; Mon, 23 Sep 2002 21:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbSIXBtz>; Mon, 23 Sep 2002 21:49:55 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:41625 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S261524AbSIXBtx>;
	Mon, 23 Sep 2002 21:49:53 -0400
Message-ID: <1032832499.3d8fc5f3a1444@kolivas.net>
Date: Tue, 24 Sep 2002 11:54:59 +1000
From: Con Kolivas <conman@kolivas.net>
To: jw schultz <jw@pegasys.ws>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: [BENCHMARK] Statistical representation of IO load results with contest
References: <1032830639.3d8fbeafe0368@kolivas.net> <20020924013711.GE15156@pegasys.ws>
In-Reply-To: <20020924013711.GE15156@pegasys.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting jw schultz <jw@pegasys.ws>:

> On Tue, Sep 24, 2002 at 11:23:59AM +1000, Con Kolivas wrote:
> > Since your lkml message implies you missed this follow up message I've
> forwarded
> > it to you.
> > 
> 
> The missed followup is probably due to propigation delays.

no problem

> I still think a relative performance number would be more
> generally useful and applying that to the confidence
> interval would make instantly clear whether something really
> was an improvement or not (crossing 1.0).

That is actually the way I want to represent the numbers! The problem has been
the numbers and format have been changing as the benchmark has progressed,
making parsing the information useless until it reached a stable set (that and
bash is integer only). If you look at the OSDL www.osdl.org you'll see version
0.34 of contest is now included in the benchmarks and reports exactly that
thing: a ratio. I did not want it included on osdl till it was complete, and
thought that v0.34 would keep results static from then on. Unfortunately that's
not yet true.

> Sorry if i seem to be carping on getting relative numbers.
> It is just that your benchmark seems to be actually
> reporting someting of general interest and i'm sick of
> seeing benchmark results that are big blocks of numbers that
> require in-depth analisys to have any meaning.

Agree with you on that I can.

> I can see the contest benchmark being usefull for those of
> us who aren't statisticians or tweaking some tiny pocket of
> code.  I suspect it would be good for such uses as
> evaluating what effects might occur from adding memory or
> whether to add more CPUs or replace them with faster ones.
> In other words, not only does contest look usefull for
> kernel tweaking but also for real-world scalability
> anticipation.

I actually have reservations about using contest for this purpose as the
hardware configuration makes the tests run differently. Comparing numbers in
this setting is likely to lead to wrong conclusions. For example if you go from
256Mb to 512Mb ram, noload and process load results will be fine, but the
mem_load and IO_load modules will then try to access more memory during memory
loading and write larger files during IO loading. There are other problems with
other hardware changes that I wont go into. Each load has to be tailored to be a
true load for that hardware to maximise the sensitivity of kernel comparisons.
Hence comparisons between hardware will not work. 

If you think there is a workaround for this I'd love to hear it, but I don't
want it to interfere with the usefulness of the test as it currently stands. It
can't be both a hardware and kernel comparison benchmark in it's current guise.

I appreciate your feedback

Regards,
Con.

> > ----- Forwarded message from Con Kolivas <conman@kolivas.net> -----
> >     Date: Tue, 24 Sep 2002 09:26:38 +1000
> >     From: Con Kolivas <conman@kolivas.net>
> > Reply-To: Con Kolivas <conman@kolivas.net>
> >  Subject: [BENCHMARK] Statistical representation of IO load results with
> contest
> >       To: linux-kernel@vger.kernel.org
> > 
> > Thank you all who responded with suggestions on how to get useful data out
> of
> > the IO load module from contest. These are _new_ results with a
> > sync,swapoff,swapon before conducting just the IO load. I have digested all
> your
> > suggestions and come up with the following:
> > 
> > n=5 for number of samples
> > 
> > Kernel          Mean    CI(95%)
> > 2.5.38          411     344-477
> > 2.5.39-gcc32    371     224-519
> > 2.5.38-mm2      95      84-105
> > 
> > 
> > The mean is a simple average of the results, and the CI(95%) are the 95%
> > confidence intervals the mean lies between those numbers. These numbers
> seem to
> > be the most useful for comparison.
> > 
> > Comparing 2.5.38(gcc2.95.3) with 2.5.38(gcc3.2) there is NO significant
> > difference (p 0.56)
> > 
> > Comparing 2.5.38 with 2.5.38-mm2 there is a significant diffence
> (p<0.001)
> > 
> > After playing with all these it appears I should do the following to
> contest:
> > 
> > Add sync,swapoff,swapon before each load
> > Perform noload and process_load twice to ensure no abnormal results
> > Perform mem_load 3 times
> > Perform IO_fullmem 5 times (and rename it just IO_load)
> > Drop IO_halfmem (adds no more useful information and just adds time).
> > Do a statistical analysis like the above when posting information.
> > 
> > Comments?
> > 
> > Con


