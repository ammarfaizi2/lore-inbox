Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317327AbSGOFVw>; Mon, 15 Jul 2002 01:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSGOFVv>; Mon, 15 Jul 2002 01:21:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9231 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317327AbSGOFVu>; Mon, 15 Jul 2002 01:21:50 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Periodic clock tick considered harmful (was: Re: HZ, preferably as small 
 as possible)
Date: Mon, 15 Jul 2002 05:21:19 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <agtm4f$iic$1@penguin.transmeta.com>
References: <3D2DB5F3.3C0EF4A2@kegel.com>
X-Trace: palladium.transmeta.com 1026710675 26124 127.0.0.1 (15 Jul 2002 05:24:35 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 15 Jul 2002 05:24:35 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3D2DB5F3.3C0EF4A2@kegel.com>,  <dank@kegel.com> wrote:
>
>How about this: let's apply the high-resolution timer patch,
>which adds explicit timer events inbetween the normal 100 Hz
>events when needed to satisfy precise sleep requests.

The thing is, I think that's the wrong way around.

What we should have is a notion of a reasonably high frequency timer,
and then _slow_it_down_ to something else if not needed.

Speeding the timer up is bad, because:
 - you do need to limit the speedup to _something_ anyway (and it might
   as well be HZ)
 - you get "partial jiffies", which means that only stuff that knows
   about the finer granularity gets it.

In contrast, if you slow things down in integer increments of "n", the
only thing you need to do is to add in "n" instead of "1" in the timer
tick handler.  Nobody else needs to really care - there is no such thing
as a "fractional jiffy". 

		Linus
