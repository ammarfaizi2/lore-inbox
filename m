Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTJWXiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTJWXiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:38:54 -0400
Received: from gprs147-238.eurotel.cz ([160.218.147.238]:12160 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261891AbTJWXiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:38:52 -0400
Date: Fri, 24 Oct 2003 01:38:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: George Anzinger <george@mvista.com>
Cc: john stultz <johnstul@us.ibm.com>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
Message-ID: <20031023233839.GA714@elf.ucw.cz>
References: <20031022233306.GA6461@elf.ucw.cz> <1066866741.1114.71.camel@cog.beaverton.ibm.com> <20031023081750.GB854@openzaurus.ucw.cz> <3F9838B4.5010401@mvista.com> <1066942532.1119.98.camel@cog.beaverton.ibm.com> <3F985FB0.1070901@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F985FB0.1070901@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I lost (never saw) the first of this thread, BUT, if this is 2.6, I 
> >>strongly recommend that settimeofday() NOT be called.  It will try to 
> >>adjust wall_to_motonoic, but, as this appears to be a correction for time 
> >>lost while sleeping, wall_to_monotonic should not change.
> >
> >
> >While suspended should the notion monotonic time be incrementing? If
> >we're not incrementing jiffies, then uptime isn't being incremented, so
> >to me it doesn't follow that the monotonic time should be incrementing
> >as well. 
> 
> Uh, not moving jiffies?  What does this say about any timers that may be 
> pending?  Say for cron or some such?  Like I said, I picked up this thread 
> a bit late, but, seems to me that if time is passing, it should pass on 
> both the jiffies AND the wall clocks.
> >
> >It may very well be a POSIX timers spec issue, but it just strikes me as
> >odd.
> 
> The spec thing would relate to any sleeps or timers that are pending.  The 
> spec would seem to say they should complete somewhere near the requested 
> wall time, but NEVER before.  By not moving jiffies, I think they will be a 
> bit late.  Now, if they were to complete during the sleep, well those 
> should fire at completion of the sleep.  If the are to complete after the 
> sleep, then, it seems to me, they should fire at the requested time.

We are currently not incrementing jiffies during sleep, so sleep seems
to be 

cli
wait a *long* time
sti

. Adjusting wall time is a must, but I hope to get away without
updating jiffies etc. At least that's how apm worked up to now (?).

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
