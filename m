Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262843AbSIPSu7>; Mon, 16 Sep 2002 14:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262856AbSIPSu6>; Mon, 16 Sep 2002 14:50:58 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11789 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262843AbSIPSu5>; Mon, 16 Sep 2002 14:50:57 -0400
Date: Mon, 16 Sep 2002 14:48:35 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@digeo.com>
cc: Rik van Riel <riel@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: 2.5.34-mm4
In-Reply-To: <3D84D799.557653C7@digeo.com>
Message-ID: <Pine.LNX.3.96.1020916143506.6180E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, Andrew Morton wrote:

> Impressions are:
> 
> - 2.5 swaps a lot in response to heavy pagecache activity.
> 
>   SEGQ didn't change that, actually.  And this is correct,
>   as-designed behaviour.  We'll need some "don't be irritating"
>   knob to prevent this.  Or speculative pagein when the load
>   has subsided, which would be a fair-sized project.

It would be nice to have a knob in /proc/sys which could be tuned for
response or throughput, Preferably not a boolean;-) I suspect that we
would have lack of agreement on what that would do, but it sure would be
nice!
 
> - In both -ac and 2.5 the scheduler is prone to starving interactive
>   applications (netscape 4, gkrellm, command-line gdb, others) when
>   there is a compilation happening.
> 
>   This is very, very noticeable; and it afects applications which
>   do not use sched_yield().  Ingo has put some extra stuff in since
>   then and I need to retest.
> 
> - In -ac, there are noticeable stalls during heavy writeout.  This
>   may be an ext3 thing, but I can't think of any IO scheduling
>   differences in -ac ext3.  I'd be guessing that it is due to
>   bdflush/kupdate lumpiness.

I have the feeling that 2.5 is less good about noting that a file is open
for write only and no seeks have been done. I haven't measured it, but it
would seem that writes to such a file would be better on the disk and not
taking buffers, since they're probably not going to be read.

This is just based on running mkisofs on 2.4.19 and 2.5.34, a watching "no
disk activity" followed by a heavy burst. I haven't made any careful
measurement, so take this as you will, but I agree that heavy write bogs
the system. Clearly with big memory I can/do get the whole ~700MB in
memory if writes don't start quickly.

Yes, that could be tuning, I know that.
 
> Overall I find Marcelo kernels to be the most comfortable, followed
> by 2.5.  Alan's kernels I find to be the least comfortable in a
> "developer's desktop" situation.

On small memory machines I don't see as much to choose, and the -ck series
has been very nice to me. I don't run 2.5 on any but test machines, and
both are big memory (1+GB) machines.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

