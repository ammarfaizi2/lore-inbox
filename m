Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSEZDbn>; Sat, 25 May 2002 23:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315614AbSEZDbm>; Sat, 25 May 2002 23:31:42 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:53514 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S315611AbSEZDbl>;
	Sat, 25 May 2002 23:31:41 -0400
Date: Sat, 25 May 2002 21:28:32 -0600
From: yodaiken@fsmlabs.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP - Warning actual technical content.
Message-ID: <20020525212832.A6479@hq.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.44.0205251651460.4120-100000@home.transmeta.com> <Pine.LNX.4.44.0205251729490.4355-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 05:39:00PM -0700, Linus Torvalds wrote:
> Side note: we could, of course, mark some spinlocks (and thus some
> code-paths) as being RT-safe, and then make sure that those spinlocks -
> when they disable interrupts - actually disable the _hw_ interrupts even
> with the RT patches.
> 
> That would make those sequences usable even from within a RT subset, but
> would obviously mean that those spinlocks have to be checked for latency
> issues - because any user (also non-RT ones) would obviously be truly
> uninterruptible within these spinlocks.

How about something more useful: interval progress assurances? Such as
"during any 5  second  period this process will be able to read X meg of
data from a file and write Y meg"

So if I have an RT task that dumps data to a DVD at millisecond intervals,
I can be sure that the non-RT task that reads the FS and puts data 
into a buffer will never let me run out of frames on a given shared memory
size.

This is useful in itself for nonRT Linux too. It seems quite hard, but it
could be relatively robust, once it was in place - making a 1 millisecond
worst case turn into a 10 millisecond worst case would not break it.


---
BTW:
I'm ignoring the 10 billionth rehash of the RTLinux/RTAI debate since 
there seems very little purpose in not doing so.  People who have actual 
questions should feel free to ask me directly - publically or privately, I
don't mind. Those on tape loops can keep repeating themselves without
my assistance. 


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

