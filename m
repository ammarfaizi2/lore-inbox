Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSILJNn>; Thu, 12 Sep 2002 05:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSILJNn>; Thu, 12 Sep 2002 05:13:43 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:42411 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314529AbSILJNm>;
	Thu, 12 Sep 2002 05:13:42 -0400
Message-Id: <200209120918.g8C9IND03853@eng4.beaverton.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] sard changes for 2.5.34 
In-reply-to: Your message of "Thu, 12 Sep 2002 00:20:22 PDT."
             <3D804036.4C000672@digeo.com> 
Date: Thu, 12 Sep 2002 02:18:23 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    OK, that's a start.  I think there was some work done on making
    kernel_stat percpu as well.

Yes there's work on a couple of different fronts there.  There is work
to specifically make disk stats per cpu (actually, I have some 2.4
patches already I could port), and there is a more general interface
(statctr_t) which Dipankar Sarma (dipankar@in.ibm.com) is working on
for 2.5 for stat counters in general which generalizes the per-cpu
concept.

Regardless of which route we go, can you suggest a good exercise to
demonstrate the advantage of per-cpu counters?  It seems intuitive to
me, but I'm much more comfortable when I have numbers to back me up.

    Cleaning up and speeding up kernel_stat is a separate exercise of
    course, but as we need to change userspace we may as well roll it
    all up together.

That would be great ... but I want to be sure we don't take so long
working on the polish that we miss 10/31 with the main event.  I can
spend a few days incorporating all of these things and repost, if you
don't think it makes it "too many changes at one time."

    >     a) all of it appear in /proc/stat?
    > 
    >     b) all of it appear in /proc/diskstats?
    > 
    >     c) keep the current (limited) info in /proc/stat (for backward
    >        compatibility) and introduce the expanded info in
    >        /proc/diskstats?
    
    b).  Let's get the kernel right and change userspace to follow.  We
    have another accounting patch which breaks top(1), so Rik has fixed
    it (and is feeding the fixes upstream).

Easily done.

    Does it work with the utilities at http://linux.inet.hr/?  What is
    the relationship with the 2.4 sard work?  (I've never used sard, so
    words of one syllable please ;))

The utilities won't without some minor changes.  Those tools assume this
information appears in /proc/partitions, and that's a bad place for it
to appear.  The tools would have to be updated to utilize
/proc/diskstats.  Beyond that, the format is similar and the content is
similar.  My guesstimate with a 3 minute look at iostat is it's less
than a day to modify the tools; possibly less than an hour.

This is a direct derivative of the 2.4 work.  The work of collecting it
appears in the 2.4 tree already; the work of extracting it does not,
because Marcello has asked (smartly) that we do it first in 2.5 and then
backport to 2.4, so that the final interface is the same in each.

My understanding is that these are referred to as the "sard changes"
only because they provide the sort of information "sar -d" provided in
some unixes.  There isn't a sar daemon running somewhere producing or
consuming this information.

The numbers in diskstats only increase.  A tool like iostat can collect
the information from diskstats and do interesting things with it, like
provide just the delta from snapshot 1 and snapshot 2. (and 3, and 4,
and ..) and thus provide info like "# of write io's per 5 seconds".

    If we can get this work playing nicely with those existing sard
    tools, get the kernel_stat stuff cleaned up and get the relevant
    userspace tools working and merged upstream then we have a neat
    bundle to submit.

I think this is very doable.

Rick
