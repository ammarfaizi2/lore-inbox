Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268617AbRHKS0W>; Sat, 11 Aug 2001 14:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268675AbRHKS0L>; Sat, 11 Aug 2001 14:26:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:28432 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268617AbRHKS0F>; Sat, 11 Aug 2001 14:26:05 -0400
Date: Sat, 11 Aug 2001 13:57:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>,
        Zach Brown <zab@osdlab.org>, linux-mm@kvack.org
Subject: Re: vmstats patch against 2.4.8pre7 and new userlevel hack
In-Reply-To: <01081022333100.00293@starship>
Message-ID: <Pine.LNX.4.21.0108111349500.17282-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Aug 2001, Daniel Phillips wrote:

> On Thursday 09 August 2001 08:45, Marcelo Tosatti wrote:
> > I've updated the vmstats patch to use Andrew Morton's statcount facilities
> > (which is in initial development state). I've also removed/added some
> > statistics due to VM changes.
> 
> I applied it and added some of my own statistics.  Very nice, much nicer than 
> the traditional compile-reboot-measure-the-time cycle.
> 
> For one thing, it means you can watch the system in operation under a test 
> load and see what it's really doing.  Chances are, you know right then 
> whether it's running well or not and don't have to wait till the end of a 
> long test run.
> 
> Problem: none of the statistics show up in proc until the first time the 
> kernel hits them.  The /proc/stats entry isn't even there until the kernel 
> hits the first statistic.  This isn't user-friendly.

Right. This has to be fixed.
 
> I can see that this patch is going to break a lot between kernel updates, 
> because it touches precisely the places we work on all the time - that's why 
> the stats are there, right? 

Exactly. Thats why I've thought about doing the thing in an easy way to
remove/add new statistics.

Kudos goes to Andrew for the statcount code. Thanks a lot! 

> I'd suggest breaking it into two patchs, one with all the support and
> a few basic statistics in stable places, and another that adds in the
> rest of your current favorite vm stats.  It would also be nice if the
> stats were broken up into sets that can be catted out of proc onto the
> screen, in other words, sets of 23 or less.  This would mean that that
> something like watch cat /proc/stats/vm is already an effective
> interface.
> 
> I already learned a lot more about the what's actually happening inside the 
> vm using this.  One thing that surprised me is how few locked pages there 
> actually are on the inactive_dirty list.  I suppose I'd need a heavy mmap 
> load to see more activity there.  Maybe a heavy write load would show up more 
> there, but for now it looks like there are so few of those locked pages it 
> won't interfere with scanning performance at all.
> 
> > On the userlevel side, I got zab's cpustat nice tool and transformed it
> > into an ugly hack which allows me to easily add/remove statistic
> > counters.
> 
> I didn't get that to work.  It seemed to be looking at the wrong /proc
> file. I didn't look into it further.

The default /proc file it tries to open is "/proc/vm_stat", while the
stats are at "/proc/stats/vm". Use the -p option to select the file to
read the stats from. (nvmstat  -p /proc/stats/vm)

The userlevel tool will average the stats, so you can actually see whats
happening over time, and not just see "what already happened". Its really
really useful. 

