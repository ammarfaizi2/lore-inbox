Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274669AbRIYWl1>; Tue, 25 Sep 2001 18:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274567AbRIYWlR>; Tue, 25 Sep 2001 18:41:17 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:39690 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S274670AbRIYWlI>; Tue, 25 Sep 2001 18:41:08 -0400
Date: Tue, 25 Sep 2001 18:41:32 -0400
Message-Id: <200109252241.f8PMfWY07018@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
X-Newsgroups: linux.dev.kernel
In-Reply-To: <Pine.LNX.4.20.0109250820001.28393-100000@otter.mbay.net>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.20.0109250820001.28393-100000@otter.mbay.net> jalvo@mbay.net wrote:

| There used to be stupid hard disk formatting tricks where the sector
| numbers were interleaved
| 
| 1001 1008 1002 1009 1003 1010 1004 1011 1005 1012 1006 1013 1007 1014
| 
| just to gain that enhancement. I also remember an ancient IBM Dasd trick
| where the sectors were offset just slightly so that a track to track
| switch could pick up the next sector in time.
| 
| Ancient history...

  The spacing between consecutively numbered sectors is called
interleave, and the offset between cylinders is called skew.

  Take a look at superformat, it's still done. The object is to take any
media without hardware cache and match the timing of the media under the
head with the need for data. This could easily double the transfer rate
on any media which runs in an unbuffered reader.

  And I would be surprised if modern hard drives don't allow using an
offset between tracks so that when a track is read the next track
"starts" under the read heads after the delay to step one track. This
can save you the rotational latency of the drive, which on a 7200rpm
drive is ~8.5ms, or as great as the step time. If actual track to track
is matched to the step time you save that one rotation on big block
reads, like swaps.

  Guess it's not quite so ancient history after all, just done by the
vendor typically. If I were writing a low level formatting routine, and
I haven't in over a decade, I would run some tests on how much skew is
needed to have the first sector under the head. The penelty for making
that number a little too large is a sector or two, the penalty for
making it too small is one rotation less a sector or two.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
