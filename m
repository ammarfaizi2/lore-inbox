Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTJEDNc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 23:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTJEDNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 23:13:32 -0400
Received: from dyn-ctb-210-9-241-202.webone.com.au ([210.9.241.202]:22278 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262955AbTJEDN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 23:13:29 -0400
Message-ID: <3F7F8C46.4030404@cyberone.com.au>
Date: Sun, 05 Oct 2003 13:13:10 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: David B Harris <david@eelf.ddts.net>
CC: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.0-test6 scheduler goodness
References: <20031004151738.789d8ad9.david@eelf.ddts.net>
In-Reply-To: <20031004151738.789d8ad9.david@eelf.ddts.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David B Harris wrote:

>Hey guys. Using Linux 2.6.0-test6, and have a few scheduler comments
>(first though, good work! :) see below):
>
>1) I'm a fairly heavy user/developer. 2.4.x's stock scheduler has always
>been excellent for me. Just in case I was missing out, I tried preempt
>patches, lowlatency patches, different VMs/schedulers and such. All of
>them reduced throughput and responsiveness noticeably.
>
>2) I've been tracking 2.5.x/2.6.0-test* for a while, and up to and
>including 2.6.0-test4, I had the same problems as I did with non-stock
>2.4.x schedulers; in other words, both throughput and responsiveness
>were worse than I needed (in other words, they weren't as good as what I
>was used to).
>
>3) I'm aware of how easy it is to create a world-class workstation
>scheduler, and how hard it is to make a scheduler that's excellent in
>all workload cases ;)
>
>4) In either 2.6.0-test5, or 2.6.0-test6 (I'm using 2.6.0-test6, I
>skipped test5), responsiveness was magically fixed for my workload case.
>I still have lower throughput, apparently (big compiles and whatnot take
>about 20% longer), but I recently got a CPU upgrade so I don't
>particularily notice it - the CPU upgrade was a pretty major one.
>
>Allright, so, in that context, here are some excerpts form a
>conversation I had on IRC:
>
>[14:42:14] <ElectricElf> Heh, impressive:                                     
>[14:42:14] <ElectricElf>  14:41:55 up 14:58,  6 users,  load average: 171.82, 319.28, 475.21
>[14:44:51] <ElectricElf> Oh, heh, that explains why:
>[14:44:59] <ElectricElf> [ david@willow: ~/ ]$ ps auwwx | wc -l
>[14:44:59] <ElectricElf> 3381
>[14:45:22] <steve> mothers of christ
>[14:45:31] <ElectricElf> They're all procmail instances.
>[14:45:34] <ElectricElf> formail/procmail sucks.
>[14:45:40] <ElectricElf> Highest loadavg I've ever seen though.
>[14:45:47] <steve> same.
>[14:46:40] <ElectricElf> In 2.6.x's defence, though, I didn't even notice it
>                         was that bad.
>[14:46:51] <ElectricElf> Still web browsing fairly normally.
>[14:47:04] <ElectricElf> Disk was thrashing, but I just assumed it was
>                         slugging through all the mails sequentially.
>[14:47:50] <ElectricElf> I think I have about 3200 procmail processes polling
>                         for a lockfile every second.
>[14:48:02] <ElectricElf> ... and one of 'em died, not releasing lockfile :)
>[14:48:33] <steve> hahaha
>[14:48:46] <ElectricElf> [ david@willow: ~/ ]$ ps auwwx | wc -l
>[14:48:46] <ElectricElf> 3379
>[14:48:51] <ElectricElf> Yah. They're all just kind of sitting there.
>[14:48:59] *  ElectricElf removes the lock and waits for the shitstorm
>[14:49:15] <ElectricElf> Heh. Didn't do much at all.
>[14:49:18] <ElectricElf> *sigh*
>[14:49:24] *  ElectricElf killalls procmail
># Annotation:
># I had suspended the formail process which had all the procmails traced.
>#
># A few processes were very, very unhappy at this point: notably, my Screens 
># and X were unable to process keyboard/mouse input. There was quite the 
># swapstorm as procmail processes which had been swapped out were brought back
># in and killed. However, it passed in about 30 seconds, and I was able to
># watch the progress as my pretty much everything appeared to at least be able
># to continue with output; gkrellm and X didn't appear to be struggling in 
># that manner.
>

Hi David,
You said your box was swapping heavily - this is probably the cause of your
problems. Can you reproduce bad behaviour when the box is not swapping?

Try my scheduler patches if you like.
http://www.kerneltrap.org/~npiggin/v15a/

