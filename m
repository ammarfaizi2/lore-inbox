Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318168AbSIOSem>; Sun, 15 Sep 2002 14:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318169AbSIOSem>; Sun, 15 Sep 2002 14:34:42 -0400
Received: from packet.digeo.com ([12.110.80.53]:37009 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318168AbSIOSei>;
	Sun, 15 Sep 2002 14:34:38 -0400
Message-ID: <3D84D799.557653C7@digeo.com>
Date: Sun, 15 Sep 2002 11:55:21 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "M. Edward Borasky" <znmeb@aracnet.com>, Axel Siebenwirth <axel@hh59.org>,
       Con Kolivas <conman@kolivas.net>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: 2.5.34-mm4
References: <HBEHIIBBKKNOBLMPKCBBAEAHFGAA.znmeb@aracnet.com> <Pine.LNX.4.44L.0209151452560.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Sep 2002 18:39:27.0113 (UTC) FILETIME=[38465790:01C25CE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sun, 15 Sep 2002, M. Edward Borasky wrote:
> 
> > Borasky's Corollary 1: If you *can* measure it and it *does* exist, the
> > cheapest solution may still be to buy more memory, more disks or a
> > faster processor.
> 
> Current 2.5 is sluggish on systems with a fast CPU and 768 MB
> of RAM, whereas current -ac runs the same workload smoothly
> with 128 MB of RAM.
> 

I've been running 2.5 on my desktop at work (800MHz/256M UP) since
2.5.26 and on the machine at home (Dual 850MHz/768M) on-and-off
(recent freizures sent that machine back to Marcelo; need to try
again).  I also ran 2.4.19-ac-something for a couple of weeks.

Impressions are:

- 2.5 swaps a lot in response to heavy pagecache activity.

  SEGQ didn't change that, actually.  And this is correct,
  as-designed behaviour.  We'll need some "don't be irritating"
  knob to prevent this.  Or speculative pagein when the load
  has subsided, which would be a fair-sized project.

- In both -ac and 2.5 the scheduler is prone to starving interactive
  applications (netscape 4, gkrellm, command-line gdb, others) when
  there is a compilation happening.

  This is very, very noticeable; and it afects applications which
  do not use sched_yield().  Ingo has put some extra stuff in since
  then and I need to retest.

- In -ac, there are noticeable stalls during heavy writeout.  This
  may be an ext3 thing, but I can't think of any IO scheduling
  differences in -ac ext3.  I'd be guessing that it is due to
  bdflush/kupdate lumpiness.

Overall I find Marcelo kernels to be the most comfortable, followed
by 2.5.  Alan's kernels I find to be the least comfortable in a
"developer's desktop" situation.
