Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271900AbRHVAFD>; Tue, 21 Aug 2001 20:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271903AbRHVAEx>; Tue, 21 Aug 2001 20:04:53 -0400
Received: from ns.ithnet.com ([217.64.64.10]:35089 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271900AbRHVAEq>;
	Tue, 21 Aug 2001 20:04:46 -0400
Date: Wed, 22 Aug 2001 02:04:45 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.9 ?
Message-Id: <20010822020445.435ec6d5.skraw@ithnet.com>
In-Reply-To: <20010821190414Z16086-32384+294@humbolt.nl.linux.org>
In-Reply-To: <20010821154617.4671f85d.skraw@ithnet.com>
	<20010821174918Z16114-32383+718@humbolt.nl.linux.org>
	<20010821201733.40fae5cf.skraw@ithnet.com>
	<20010821190414Z16086-32384+294@humbolt.nl.linux.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001 21:10:44 +0200
Daniel Phillips <phillips@bonn-fries.net> wrote:

> > Aug 21 20:14:51 admin kernel: __alloc_pages: 3-order allocation failed 
> (gfp=0x20/0).
> > Aug 21 20:14:51 admin last message repeated 146 times
> > 
> > Next idea?
> 
> It's an atomic allocation, the driver is supposed to be able to handle this, 
> and it does since you report that the burn just runs slowly, it does not 
> stop.  There is way too much in cache:
> 
> >         total:    used:    free:  shared: buffers:  cached:
> > Mem:  1053675520 1047502848  6172672        0 20930560 939307008
> > Swap: 271392768 15880192 255512576
> 
> This is causing the high order allocation failures - with only a small 
> fraction of memory free the chances of none of it being in contiguous, 
> aligned 8 page units rises dramatically.

I basically thought the same. In fact I do not understand why. Are there any parameters tunable to balance the whole picture a bit more towards the free pages?

>  It's likely the kprint that is 
> slowing you down, you could check this by commenting it out (page_alloc.c, 
> near the end of __alloc_pages).

I guess you mean the formerly patched debug-output, do you? I commented it out and saw a way better result than before. In fact I did not manage to break the NFS-copy at all, and although I managed to get the cpu load up to about 5 everything worked smoother. Only now and then were some moments where the display freezes "a bit", but mouse movement continues to work.
Anyway I am not sure, if it is intended that my browser gets swapped out only by copying files via NFS which are alltogether smaller than my physical 1 GB of RAM. I do think that there is still a little too much caching going on.

> Do you have the same problem on 2.4.8, but not in 2.4.7?

I am going to check that tomorrow. Downgrading is a bit tricky on this system.

Thanks Daniel, 
I'll be back
:-)

