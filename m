Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273345AbRJDX2S>; Thu, 4 Oct 2001 19:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277203AbRJDX2I>; Thu, 4 Oct 2001 19:28:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48134 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273345AbRJDX2C>; Thu, 4 Oct 2001 19:28:02 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [POT] Which journalised filesystem ?
Date: Thu, 4 Oct 2001 23:27:45 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9pir9h$ief$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10110031648250.20425-100000@coffee.psychology.mcmaster.ca> <E15pHJT-00041q-00@calista.inka.de>
X-Trace: palladium.transmeta.com 1002238085 32388 127.0.0.1 (4 Oct 2001 23:28:05 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 4 Oct 2001 23:28:05 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15pHJT-00041q-00@calista.inka.de>,
Bernd Eckenfels  <ecki@lina.inka.de> wrote:
>In article <Pine.LNX.4.10.10110031648250.20425-100000@coffee.psychology.mcmaster.ca> you wrote:
>> for a current Maxtor 60G 5400 RPM UDMA100 disk, 2.4.10, ext2,
>> I just measured: 7 MBps with -W0, vs 27 MB/s with -W1.
>
>how much data do you have written to get those numbers? The drive cache is
>is most often so small it only can cache a few blocks.

Actually, that's not the main win of writeback caching.

Themain win is being able to write a whole track in one go, starting at
the _right_ position (where "right" is defined as "where the head
happens to be when it can start writing). Along with making up for the
occasional seek for meta-data, and other "smooth out the writes so that
the platter keeps gettint written to all the time" things.

Which can be a HUGE win, and which is why I personally think that any
disk that doesn't do write-back caching is a waste of good money.

We (as in Linux) should make sure that we explicitly tell the disk when
we need it to flush its disk buffers. We don't do that right, and
because of _our_ problems some people claim that writeback caching is
evil and bad.

		Linus
