Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318846AbSHRE0T>; Sun, 18 Aug 2002 00:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318847AbSHRE0T>; Sun, 18 Aug 2002 00:26:19 -0400
Received: from waste.org ([209.173.204.2]:64992 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318846AbSHRE0S>;
	Sun, 18 Aug 2002 00:26:18 -0400
Date: Sat, 17 Aug 2002 23:30:16 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818043016.GH21643@waste.org>
References: <20020818025913.GF21643@waste.org> <Pine.LNX.4.44.0208172006050.1491-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208172006050.1491-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 08:08:36PM -0700, Linus Torvalds wrote:
> 
> On Sat, 17 Aug 2002, Oliver Xymoron wrote:
> > 
> > Let me clarify that 2-5 orders thing. The kernel trusts about 10 times
> > as many samples as it should, and overestimates each samples' entropy
> > by about a factor of 10 (on x86 with TSC) or 1.3 (using 1kHz jiffies).
> 
> Lookin gat the code, your _new_ code just throws samples away _entirely_ 
> just because some random event hasn't happened (the first thing I noticed 
> was the context switch testing, there may be others there that I just 
> didn't react to).

No, it still mixes them in.
 
> In short, you seem to cut those random events to _zero_. And this happens 
> under what seems to be perfectly realistic loads. That's not trying to fix 
> things, that's just breaking them.
> 
> > The patches will be a nuisance for anyone who's currently using
> > /dev/random to generate session keys on busy SSL servers.
> 
> No, it appears to be a nuisanse even for people who have real issues, ie 
> just generating _occasional_ numbers on machines that just don't happen to 
> run much user space programs.

Read the code again. Better yet, try it.

23:06ash~$ cat /proc/sys/kernel/random/entropy_avail 
4096
23:17ash~$ w
 23:17:22 up 11 min,  2 users,  load average: 0.09, 0.06, 0.05

It was probably full in less than 11 minutes.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
