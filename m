Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269517AbRHLWjO>; Sun, 12 Aug 2001 18:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269512AbRHLWjD>; Sun, 12 Aug 2001 18:39:03 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:29708 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269491AbRHLWiu>; Sun, 12 Aug 2001 18:38:50 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Performance 2.4.8 is worse than 2.4.x<8
Date: Sun, 12 Aug 2001 22:38:36 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9l70hc$1sd$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108120754020.593-100000@mikeg.weiden.de> <E15VtnT-0005bM-00@the-village.bc.nu>
X-Trace: palladium.transmeta.com 997655938 12255 127.0.0.1 (12 Aug 2001 22:38:58 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 12 Aug 2001 22:38:58 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15VtnT-0005bM-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> Here, disk write throughput seems to want some tweaking, and Bonnie
>> doing it's rewrite test triggers a very large and persistant inactive
>> shortage which shouldn't be there (imho).
>
>This is one of the reasons I kept the 2.4.7 vm. The 2.4.8 vm is better
>than 2.4.8pre but not actually better than the older VM by feel or
>measurement on my test boxes

Word of warning: there are some loads on which 2.4.7 will simply lock
up.  If you don't want to take all the new code, at least take the
changes to fs/buffer.c and refill_buffer() or whatever.  With just those
parts it will still end up being pitifully slow in the cases it used to
lock up, but it will end up making progress and eventually recovering. 

(In all fairness, the load to make it go into the bad behaviour is
rather unusual, and as such probably not a huge problem for most people. 
That's obviously also the reason why it wasn't really noticed until now
- but this is, for example, apparently the cause for the "processes
getting stuck in __wait_on_buffer()" bug that I know RedHat also saw
under load). 

That said, me and Marcelo are still working on making sure it's good
under _all_ loads..

			Linus
