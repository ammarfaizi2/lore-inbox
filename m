Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313759AbSDPQ3N>; Tue, 16 Apr 2002 12:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313760AbSDPQ3M>; Tue, 16 Apr 2002 12:29:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62481 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313759AbSDPQ3L>; Tue, 16 Apr 2002 12:29:11 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Why HZ on i386 is 100 ?
Date: Tue, 16 Apr 2002 16:27:12 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a9hjd0$16s$1@penguin.transmeta.com>
In-Reply-To: <AAEGIMDAKGCBHLBAACGBEEONCEAA.balbir.singh@wipro.com> <1018952961.31914.446.camel@swordfish> <20020416100148.GA17560@venus.local.navi.pl>
X-Trace: palladium.transmeta.com 1018974521 27521 127.0.0.1 (16 Apr 2002 16:28:41 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 16 Apr 2002 16:28:41 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020416100148.GA17560@venus.local.navi.pl>,
Olaf Fraczyk  <olaf@navi.pl> wrote:
>On 2002.04.16 12:29 Liam Girdwood wrote:
>> 
>> I remember reading that a higher HZ value will make your machine more
>> responsive, but will also mean that each running process will have a
>> smaller CPU time slice and that the kernel will spend more CPU time
>> scheduling at the expense of processes.
>> 
>Has anyone measured this?
>This shouldn't be a big problem, because some architectures use value 
>1024, eg. Alpha, ia-64.

On the ia-64, they do indeed use a HZ value of 1000 by default.

And I've had some Intel people grumble about it, because it apparently
means that the timer tick takes anything from 2% to an extreme of 10%
(!!) of the CPU time under certain loads.

Apparently the 10% is due to cache/tlb intensive loads, and as a result
the interrupt handler just missing in the caches a lot, but still:
that's exactly the kind of load that you want to buy an ia64 for. 

There's no point in saying that "the timer interrupt takes only 0.5% of
an idle CPU", if it takes a much larger chunk out of a busy one. 

So the argument that a kHz timer takes a noticeable amount of CPU power
seems to be still true today - even with the "architecture of tomorrow". 

Yeah, I wouldn't have believed it myself, but there it is..  You only
get the gigaHz speeds if you hit in the cache - when you miss, you start
crawling (everything is relative, of course: the crawl of today is a
rather rapid one by 6502 standards ;)

		Linus
