Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315356AbSDWXD0>; Tue, 23 Apr 2002 19:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315359AbSDWXDZ>; Tue, 23 Apr 2002 19:03:25 -0400
Received: from zero.tech9.net ([209.61.188.187]:1287 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S315356AbSDWXDY>;
	Tue, 23 Apr 2002 19:03:24 -0400
Subject: Re: [PATCH] 2.5: MAX_PRIO cleanup
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204232241520.8215-100000@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 23 Apr 2002 19:03:26 -0400
Message-Id: <1019603008.2045.273.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-23 at 16:44, Ingo Molnar wrote:

> i'm not so sure whether we want to make the last step to make the maximum
> RT priority value to be a .config option. Sure we can keep things flexible
> so that it's just a matter of a single redefine, but do we really want
> users to be able to change the API of Linux in such a way?
>
> the applications which need 1000 RT threads are i suspect specialized, and
> since it needs a kernel recompile anyway, it's not a big problem to change
> a single constant in the source code - we do that for many other things.  
> I'd very much suggest we keep the 0-99 range for RT tasks, it's been well
> established and not making it a .config doesnt make it any harder for 1000
> RT priority levels to be defined for specific applications.

I understand your points - I am doing the patch for those that could
benefit, I felt it is useful enough to be in the kernel.  It is in fact
the only real-time item missing from your scheduler - otherwise it is an
ideal RT scheduler.

It is common for real-time schedules to either have very large RT
priority ranges or allow customizing of these ranges.

I should note that while this changes the API, it should not break any
existing applications (as long as the number only goes up).  Existing
scheduler calls will succeed.  In fact, the only difference to existing
programs would be sched_getparam returning a different maximum RT
priority value.

Finally, it is not so simple as "just setting the define" because of
sched_find_first_bit.  I have a working patch that I will post soon - I
did pretty much what I mentioned in an earlier email where if MAX_PRIO
is outside of a certain range we fall back on using find_first_bit.

Would you be open to a patch to do the rest of the invariant work and
the sched_find_first_bit switch, but not export a configure option?  Or
have I convinced you the configure option is not bad? :-)

The whole patch is not large either way.

	Robert Love

