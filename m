Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUGNU3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUGNU3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUGNU3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:29:42 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:56810 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263475AbUGNU3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:29:20 -0400
Date: Wed, 14 Jul 2004 13:28:39 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, ia64 <linux-ia64@vger.kernel.org>
Subject: Re: gettimeofday nanoseconds patch (makes it possible for the
 posix-timer functions to return higher accuracy)
In-Reply-To: <1089835776.1388.216.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0407141323530.15874@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0407140940260.14704@schroedinger.engr.sgi.com>
 <1089835776.1388.216.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004, john stultz wrote:

> Honestly, I'm not a fan of the patch. It realistically only helps ia64
> and and adds more confusing code to the generic time code. If there
> isn't an real/immediate need for this, I'd wait to 2.7 for a better
> cleanup.

The immediate need is that clock_gettime only returns microseconds scaled
to nanoseconds.

> None the less, I do understand the desire for the change (and am working
> to address it in 2.7), so could you at least use a better name then
> gettimeofday()? Maybe get_ns_time() or something? Its just too similar
> to do_gettimeofday and the syscall gettimeofday().

Right. I had it named getnstimeofday before but the feeling was that the
patch should not introduce a new name. Any approach that would allow
progress on the issue would be fine with me.

> Really, I feel the cleaner method is to fix do_gettimeofday() so it
> returns a timespec and then convert it to a timeval in
> sys_gettimeofday(). However this would add overhead to the syscall, so I
> doubt folks would go for it.

do_gettimeofday is used all over the linux kernel for a variety of
purposes and lots of code depends on the presence of a timeval struct.

> I think the ia64 time interpolation code is a step in the right
> direction (def better then the i386 bits), but it still isn't the
> cleanest and clearest way. My plan is to select a reliable timesource
> for the system, then use a periodic interrupt to accumulate time from
> the timesource (in order to avoid overflows). This avoids lost tick
> issues and cleanly separates the timer subsystem from the time of day
> subsystem.

That is what the changes to the time_interpolator do.

