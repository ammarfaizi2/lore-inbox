Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278081AbRKSLbb>; Mon, 19 Nov 2001 06:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278085AbRKSLbV>; Mon, 19 Nov 2001 06:31:21 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:10250 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S278081AbRKSLbO>;
	Mon, 19 Nov 2001 06:31:14 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111191131.fAJBVC058828@saturn.cs.uml.edu>
Subject: Re: Bug or feature? Priority in /proc/<pid>/stat for RT processes
To: mlev@despammed.com (Lev Makhlis)
Date: Mon, 19 Nov 2001 06:31:12 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <200111190731.fAJ7VUs21238@portent.dyndns.org> from "Lev Makhlis" at Nov 19, 2001 02:31:30 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov writes:
> On Monday 19 November 2001 01:01 am, Albert D. Cahalan wrote:

>> Do not do this. Just supply the raw value for ps(1) and top(1) to use.
>> Also supply the scheduling policy type. You can tack this on the end
>> of /proc/<pid>/stat and tell me when Linus accepts it so that I can
>> make ps(1) and top(1) support the new info.
>
> I agree scaling from 1.99 to 20..-20 wasn't a good idea, but I don't think
> supplying the raw (1..99) value without any transformation at all would be
> right either -- I think we need to reverse its sign, for the following
> reason: 
> 
> If you look at what happens on other Unix platforms, the "direction"
> of priority values can vary: usually, higher values mean lower priority,
> but, for example, on Solaris, higher values mean higher priority.
> But on any specific platform, the "direction" is consistent across
> the different scheduling policies.  On Linux, it's "higher value = lower
> priority" for the default timesharing policy, and therefore I think it should
> be the same for the RT priorities.
> 
> I think the Right Thing would be to use a f(x) = c - x transormation,
> where c could be 100, or 0, or -20, or -100, or something else.
> -20 or -100 have the advantage of preserving the order relationship
> between priorities across the scheduling policies.
> 
> The patch below uses c=-100 -- as an example.

I can tell you what procps will do. The very first thing is
to undo your transformation. Don't bother having the kernel
muck with the numbers. The procps code will transform the
numbers as needed to match UNIX convention and/or the tools
which users run to set these values.
