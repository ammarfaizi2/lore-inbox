Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270011AbRHJU1z>; Fri, 10 Aug 2001 16:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270012AbRHJU1q>; Fri, 10 Aug 2001 16:27:46 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:33287 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S270011AbRHJU1m>; Fri, 10 Aug 2001 16:27:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: vmstats patch against 2.4.8pre7 and new userlevel hack
Date: Fri, 10 Aug 2001 22:33:31 +0200
X-Mailer: KMail [version 1.2]
Cc: Andrew Morton <akpm@zip.com.au>, Zach Brown <zab@osdlab.org>,
        linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.21.0108090326470.14424-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0108090326470.14424-100000@freak.distro.conectiva>
MIME-Version: 1.0
Message-Id: <01081022333100.00293@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 August 2001 08:45, Marcelo Tosatti wrote:
> I've updated the vmstats patch to use Andrew Morton's statcount facilities
> (which is in initial development state). I've also removed/added some
> statistics due to VM changes.

I applied it and added some of my own statistics.  Very nice, much nicer than 
the traditional compile-reboot-measure-the-time cycle.

For one thing, it means you can watch the system in operation under a test 
load and see what it's really doing.  Chances are, you know right then 
whether it's running well or not and don't have to wait till the end of a 
long test run.

Problem: none of the statistics show up in proc until the first time the 
kernel hits them.  The /proc/stats entry isn't even there until the kernel 
hits the first statistic.  This isn't user-friendly.

I can see that this patch is going to break a lot between kernel updates, 
because it touches precisely the places we work on all the time - that's why 
the stats are there, right?  I'd suggest breaking it into two patchs, one 
with all the support and a few basic statistics in stable places, and another 
that adds in the rest of your current favorite vm stats.  It would also be 
nice if the stats were broken up into sets that can be catted out of proc 
onto the screen, in other words, sets of 23 or less.  This would mean that 
that something like watch cat /proc/stats/vm is already an effective 
interface.

I already learned a lot more about the what's actually happening inside the 
vm using this.  One thing that surprised me is how few locked pages there 
actually are on the inactive_dirty list.  I suppose I'd need a heavy mmap 
load to see more activity there.  Maybe a heavy write load would show up more 
there, but for now it looks like there are so few of those locked pages it 
won't interfere with scanning performance at all.

> On the userlevel side, I got zab's cpustat nice tool and transformed it
> into an ugly hack which allows me to easily add/remove statistic
> counters.

I didn't get that to work.  It seemed to be looking at the wrong /proc file.
I didn't look into it further.

--
Daniel
