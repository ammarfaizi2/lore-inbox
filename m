Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbTJBAkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 20:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbTJBAkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 20:40:52 -0400
Received: from 176.Red-81-38-200.pooles.rima-tde.net ([81.38.200.176]:17198
	"EHLO falafell") by vger.kernel.org with ESMTP id S262672AbTJBAku
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 20:40:50 -0400
Date: Thu, 2 Oct 2003 02:41:02 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test6
Message-ID: <20031002004102.GB2013@81.38.200.176>
Reply-To: piotr@member.fsf.org
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <200309281703.53067.kernel@kolivas.org> <200309280502.36177.rob@landley.net> <3F77BB2C.7030402@cyberone.com.au> <3F7863F0.6070401@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7863F0.6070401@wmich.edu>
User-Agent: Mutt/1.5.4i
From: Pedro Larroy <piotr@member.fsf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 12:55:12PM -0400, Ed Sweetman wrote:
> Nick Piggin wrote:
> >
> >
> >Rob Landley wrote:
> >
> >>On Sunday 28 September 2003 02:03, Con Kolivas wrote:
> >>
> >>>On Sun, 28 Sep 2003 11:27, Linus Torvalds wrote:
> >>>
> >>>>from Andrew Morton. Most notably perhaps Con's scheduler changes that
> >>>>have been discussed extensively and made it into the -mm tree for
> >>>>testing.
> >>>>
> >>>For those who are trying this for the first time, please note that the
> >>>scheduler has been tuned to tell the difference between tasks of the 
> >>>_same_
> >>>nice level. This means do NOT renice X or it will make audio skip unless
> >>>you also renice your audio application by the same amount. Lots of
> >>>distributions have done this for the old 2.4 scheduler which could not
> >>>treat equal "nice" levels as differently as the new scheduler does 
> >>>and 2.6
> >>>shouldn't need special treatment.
> >>>
> >>>So for testing note the following points:
> >>>
> >>>Make sure X is NOT reniced to -10 as many distributions are doing.
> >>>Some shells spawn processes at nice +5 by default and this will make 
> >>>audio
> >>>apps suffer.
> >>>Make sure your hard disk, graphics card and audio card are performing at
> >>>equal standard to your 2.4 kernel (ie dma is working, graphics is fully
> >>>accelerated etc).
> >>>
> >>
> >>I.E. with your new scheduler, priority levels actually have enough of 
> >>an effect now that things that aren't reniced can be noticeably 
> >>starved by things that are.
> >>
> >
> >AFAIK, Con's scheduler doesn't change the nice implementation at all.
> >Possibly some of his changes amplify its problems, or, more likely they
> >remove most other scheduler problems leaving this one noticable.
> >
> >If X is running at -20, and xmms at +19, xmms is supposed to still get
> >5% of the CPU. Should be enough to run fine. Unfortunately this is
> >achieved by giving X very large timeslices, so xmms's scheduling latency
> >becomes large. The interactivity bonuses don't help, either.
> >
> 
> there are 40 positions between -20 and 19, that doesn't equal 5% steps. 
> They don't even refer to % of cpu.  If i nice a process to -20 it 
> doesn't get a given percentage of cpu just because it's -20. I may have 
> other processes at -20 as well.  If you nice something to -20 and it is 
> actually using that cpu then things that are +19 shouldn't run and wont 
> run.  If I nice -20 vmstat 1, it's not going to starve xmms (or any 
> better audio player).  -20 means starve all and it should do that when 
> it actually makes use of the resources.
> 

Why not run xmms with SCHED_RR or SCHED_FIFO?


Regards.

        Pedro.

