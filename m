Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266684AbRGYIY4>; Wed, 25 Jul 2001 04:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266673AbRGYIYr>; Wed, 25 Jul 2001 04:24:47 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:16708 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S266696AbRGYIYe>; Wed, 25 Jul 2001 04:24:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Patrick Dreker <patrick@dreker.de>
Organization: Chaos Inc.
To: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] Optimization for use-once pages
Date: Wed, 25 Jul 2001 10:20:49 +0200
X-Mailer: KMail [version 1.2.9]
Cc: <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107241726130.29909-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0107241726130.29909-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15PJuY-0000A3-00@wintermute>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Am Mittwoch, 25. Juli 2001 02:27 schrieb Linus Torvalds:
> On Tue, 24 Jul 2001, Rik van Riel wrote:
> > (using smaller chunks, or chunks which aren't a
> > multiple of 4kB should break the current code)
>
> Maybe Patrick is using stdio? In that case, the small chunks will be
> coalesced in the library layer anyway, which might explain the lack of
> breakage.
I am using normal read() calls to read the file after open()ing it on program 
start and each call reads only 4 bytes. So if I am reading this right I am 
seeing an improvement where I should not see one, or at least not such a big 
one, right?

I did a few more test runs on each of the kernels to check if the results are 
reproducible:
2.4.7-plain:
17.320u 115.100s 2:17.36 96.4%	0+0k 0+0io 110pf+0w
17.200u 94.170s 1:53.14 98.4%	0+0k 0+0io 110pf+0w
17.490u 113.730s 2:13.48 98.3%	0+0k 0+0io 110pf+0w

2.4.5-use_once:
14.730u 108.310s 2:09.57 94.9%	0+0k 0+0io 203pf+0w
13.880u 79.410s 1:38.64 94.5%	0+0k 0+0io 226pf+0w
14.840u 78.680s 1:37.86 95.5%	0+0k 0+0io 238pf+0w

The time under 2.4.5-use_once stays constant from the second run on (I tried 
3 more times), while 2.4.7 shows pretty varying performance but I have never 
seen it getting better than the 1:53.14 from the second run above. I had 
stopped all services which I knew to cause periodic activity (exim, 
cron/anacron) which could disturb the tests.

I also noticed, that under 2.4.5 after the 3 test runs the KDE Taskbasr got 
swapped out, while under 2.4.7 this was not the case.

> Of course, if it improved performance even when "broken", that would be
> even better. I like those kind sof algorithms.
Who doesn't? :)

>
> 		Linus

-- 
Patrick Dreker
---------------------------------------------------------------------
> Is there anything else I can contribute?
The latitude and longtitude of the bios writers current position, and
a ballistic missile.        
                         Alan Cox on linux-kernel@vger.kernel.org
