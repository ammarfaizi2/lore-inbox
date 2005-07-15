Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVGOSj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVGOSj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 14:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVGOSj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 14:39:29 -0400
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:41627 "EHLO
	mail8.fw-sd.sony.com") by vger.kernel.org with ESMTP
	id S261152AbVGOSj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 14:39:27 -0400
Message-ID: <42D802C6.2010401@am.sony.com>
Date: Fri, 15 Jul 2005 11:39:02 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux@kesh.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RealTimeSync Patch
References: <20050714171052.362f93dd.akpm@osdl.org>
In-Reply-To: <20050714171052.362f93dd.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Elias Kesh <linux@kesh.com> wrote:
>> Looking at the archives I see that a an intel patch
>> was submitted back in October but I am unable to
>> determine what the resolution was.
> 
> What patch was that?

http://lkml.org/lkml/2004/10/29/332

> OK.  But adding fiddle new config options and ifdefs is really, really a
> last resort.  Much better to fix the code by making it smarter, or
> runtime-selectable, or by avoiding the delays if we see that they're not
> really needed (like: certain hardware isn't present) or whatever.

...
> Better would be to work out whether the underlying platform really, realy
> needs the delay and if so only enable it on those platforms, preferable via
> a runtime decision.
> 
> But then, I don't know what that synchronisation code is actually trying to
> do.

The short of it: it's trying to make the system
time as accurate as possible, by delaying
setting the system time until the actual RTC
seconds rollover.  Without this synch. operation,
the system time is within a second of the
RTC value anyways.

With regard to the actual feature request,
I agree that a config option should be a
last resort.  I'd rather just eliminate
the synchronization altogether, and let
post-boot code fix the system time
(sub-second) accuracy, if it's needed.
IMHO it won't be needed in embedded
scenarios and will very seldom be needed
in other use areas (server and desktop).
Many desktop users already get their
system time accuracy from an external
source (ntp) now anyways.

We can submit a patch to *remove* code
for multiple architectures very quickly!
;-)

> In general, it's taking waaaay to long to get all
> these CELinux patches into the outside world.  Thanks
> for getting this one on the wires. Let's
> get them all done and finish this thing.

The forum, of late, has been taking a different approach.
While the forum has a few patches we want to push
ourselves directly, we now focus more effort on
getting individual member companies (and individual
engineers) to participate directly in projects
of interest.

As one example, a Sony engineer has participated
quite heavily in the high resolution timers project
over the last year or so.

Only occasionally, when there does not appear
to be another suitable project in an area
(such as fast booting), do we manage a patch
inside the forum and submit it from there.

But I agree that in some areas the forum has
been quite slow to push these patches. This RTC
synch. issue was first discussed on LKML in
May of 2004.

See: http://lkml.org/lkml/2004/5/7/180

In a perfect world, a patch would have shown
up within a week of that discussion.  For
reasons too long to discuss here, it took
5 months instead, and then another 9 months
to submit this.  So, yes, CELF and some
of it's members clearly have some areas
to improve on in working with the open
source model.

I'm sincerely grateful for the help and
encouragement!
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
