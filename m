Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317339AbSGOFn4>; Mon, 15 Jul 2002 01:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSGOFnz>; Mon, 15 Jul 2002 01:43:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15888 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317339AbSGOFnz>; Mon, 15 Jul 2002 01:43:55 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Periodic clock tick considered harmful (was: Re: HZ, preferably as small 
 as possible)
Date: Mon, 15 Jul 2002 05:43:21 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <agtndp$ijn$1@penguin.transmeta.com>
References: <3D2DB5F3.3C0EF4A2@kegel.com> <agtm4f$iic$1@penguin.transmeta.com>
X-Trace: palladium.transmeta.com 1026711997 26650 127.0.0.1 (15 Jul 2002 05:46:37 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 15 Jul 2002 05:46:37 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <agtm4f$iic$1@penguin.transmeta.com>,
Linus Torvalds <torvalds@transmeta.com> wrote:
>
>In contrast, if you slow things down in integer increments of "n", the
>only thing you need to do is to add in "n" instead of "1" in the timer
>tick handler.  Nobody else needs to really care - there is no such thing
>as a "fractional jiffy". 

An added issue: if you slow the tick down, you can easily do it in _one_
place: the idle loop. When you exit the idle loop you speed it up again,
and nobody is ever any wiser (sure, you need to know enough about timers
in idle to know when you can do it, but that's still fairly localized).

In constrast, if you speed the timer up, you have to make this quite
fundamental in timer handling, and have architecture-specific issues on
how to speed the timer up and down etc. Big ugh, compared to just havin
git in one place inside code that is already architecture-specific for
other reasons.

		Linus
