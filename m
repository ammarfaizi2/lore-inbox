Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286238AbSAMPZi>; Sun, 13 Jan 2002 10:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285745AbSAMPYL>; Sun, 13 Jan 2002 10:24:11 -0500
Received: from lilly.ping.de ([62.72.90.2]:34054 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S286137AbSAMPXz>;
	Sun, 13 Jan 2002 10:23:55 -0500
Date: 13 Jan 2002 16:15:37 +0100
Message-ID: <20020113161537.A1439@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: "Robert Love" <rml@tech9.net>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, "Rob Landley" <landley@trommello.org>,
        "Andrew Morton" <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112170528.N1482@inspiron.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20020112170528.N1482@inspiron.school.suse.de>; from andrea@suse.de on Sat, Jan 12, 2002 at 05:05:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 05:05:28PM +0100, Andrea Arcangeli wrote:
> On Sat, Jan 12, 2002 at 04:07:14PM +0100, jogi@planetzork.ping.de wrote:

[...]

> > Hello Andrea,
> > 
> > I did my usual compile testings (untar kernel archive, apply patches,
> > make -j<value> ...
> > 
> > Here are some results (Wall time + Percent cpu) for each of the consecutive five runs:
> > 
> >         13-pre5aa1      18-pre2aa2      18-pre3         18-pre3s        18-pre3sp
> > j100:   6:59.79  78%    7:07.62  76%        *           6:39.55  81%    6:24.79  83%
> > j100:   7:03.39  77%    8:10.04  66%        *           8:07.13  66%    6:21.23  83%
> > j100:   6:40.40  81%    7:43.15  70%        *           6:37.46  81%    6:03.68  87%
> > j100:   7:45.12  70%    7:11.59  75%        *           7:14.46  74%    6:06.98  87%
> > j100:   6:56.71  79%    7:36.12  71%        *           6:26.59  83%    6:11.30  86%
> > 
> > j75:    6:22.33  85%    6:42.50  81%    6:48.83  80%    6:01.61  89%    5:42.66  93%
> > j75:    6:41.47  81%    7:19.79  74%    6:49.43  79%    5:59.82  89%    6:00.83  88%
> > j75:    6:10.32  88%    6:44.98  80%    7:01.01  77%    6:02.99  88%    5:48.00  91%
> > j75:    6:28.55  84%    6:44.21  80%    9:33.78  57%    6:19.83  85%    5:49.07  91%
> > j75:    6:17.15  86%    6:46.58  80%    7:24.52  73%    6:23.50  84%    5:58.06  88%
> > 
> > * build incomplete (OOM killer killed several cc1 ... )
> > 
> > So far 2.4.13-pre5aa1 had been the king of the block in compile times.
> > But this has changed. Now the (by far) fastest kernel is 2.4.18-pre
> > + Ingos scheduler patch (s) + preemptive patch (p). I did not test
> > preemptive patch alone so far since I don't know if the one I have
> > applies cleanly against -pre3 without Ingos patch. I used the
> > following patches:
> > 
> > s: sched-O1-2.4.17-H6.patch
> > p: preempt-kernel-rml-2.4.18-pre3-ingo-1.patch
> > 
> > I hope this info is useful to someone.
> 
> the improvement of "sp" compared to "s" is quite visible, not sure how
> can a little different time spent in kernel make such a difference on
> the final numbers, also given compilation is mostly an userspace task, I
> assume you were swapping out or running out of cache at the very least,
> right?

The system is *heavily* swapping. Plain 2.4.18-pre3 can not even finish
the jobs because it runs out of memory. That's why I used j75 or j100
initially. Otherwise there was not even a difference between the 2.4.10+
vm and the 2.4.9-ac+ vm. All I want to test with this "benchmark" is how
well the system reacts when I throw *lots* of compilation jobs at it ...

> btw, I'd be curious if you could repeat the same test with -j1 or -j2?
> (actually real world)

Using just -j1 or -j2 will probably be no difference (I will test it anyway
and post the results). 

> Still the other numbers remains interesting for a trashing machine, but
> a few percent difference with a trashing box isn't a big difference, vm
> changes can infulence those numbers more than any preempt or scheduler
> number (of course if my guess that you're swapping out is really right :).
> I guess "p" helps because we simply miss some schedule point in some vm
> routine. Hints?

But what *I* like most about the preemptive results are that the results
for all runs do not vary that much. Looking at plain 2.4.18-pre3 there
is a huge difference in runtime between the fastest and the longest run.

Regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
