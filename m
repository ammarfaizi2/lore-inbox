Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbULNQEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbULNQEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbULNQEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:04:53 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:60290 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261534AbULNQEb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:04:31 -0500
Message-ID: <41BF0F0D.4000408@ribosome.natur.cuni.cz>
Date: Tue, 14 Dec 2004 17:04:29 +0100
From: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20041209
X-Accept-Language: cs, en, en-us
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au, chris@tebibyte.org,
       marcelo.tosatti@cyclades.com, andrea@novell.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet>	 <20041114094417.GC29267@logos.cnet>	 <20041114170339.GB13733@dualathlon.random>	 <20041114202155.GB2764@logos.cnet>	<419A2B3A.80702@tebibyte.org>	 <419B14F9.7080204@tebibyte.org>	<20041117012346.5bfdf7bc.akpm@osdl.org>	 <419CD8C1.4030506@ribosome.natur.cuni.cz>	 <20041118131655.6782108e.akpm@osdl.org>	 <419D25B5.1060504@ribosome.natur.cuni.cz>	 <419D2987.8010305@cyberone.com.au>	 <419D383D.4000901@ribosome.natur.cuni.cz>	 <20041118160824.3bfc961c.akpm@osdl.org>	 <419E821F.7010601@ribosome.natur.cuni.cz>	 <1100946207.2635.202.camel@thomas> <419F2AB4.30401@ribosome.natur.cuni.cz>	 <1100957349.2635.213.camel@thomas>	 <419FB4CD.7090601@ribosome.natur.cuni.cz> <1101037999.23692.5.camel@thomas>	 <41A08765.7030402@ribosome.natur.cuni.cz>	 <1101045469.23692.16.camel@thomas>	 <1101120922.19380.17.camel@tglx.tec.linutronix.de>	 <41A2E98E.7090109@ribosome.natur.cuni.cz> <1101205649.3888.6.camel@tglx.tec.linutronix.de>
In-Reply-To: <1101205649.3888.6.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:

Hi,
  I went to check what's the status of this. I tested 2.6.10-rc3-bk8
on the same machine, and the parent process still get's killed.
The last patch Thomas has posted to the list in this thread for 2.6.10-rc2-mm3
killed only the application. Maybe it's still in -mm tree?
Anyway, here are results for 2.6.10-rc3-bk8 as I've said:

Free pages:        3924kB (112kB HighMem)
Active:128410 inactive:125323 dirty:0 writeback:0 unstable:0 free:981 slab:1985 mapped:253497 pagetables:739
DMA free:68kB min:68kB low:84kB high:100kB active:5436kB inactive:5512kB present:16384kB pages_scanned:11608 all_unreclaimable
? yes
protections[]: 0 0 0
Normal free:3744kB min:3756kB low:4692kB high:5632kB active:443312kB inactive:430804kB present:901120kB pages_scanned:887679 all_unreclaimable? yes
protections[]: 0 0 0
HighMem free:112kB min:128kB low:160kB high:192kB active:64892kB inactive:64976kB present:131044kB pages_scanned:132923 all_unreclaimable? yes
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 68kB
Normal: 0*4kB 0*8kB 0*16kB 1*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3744kB
HighMem: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 112kB
Swap cache: add 294889, delete 294883, find 530/704, race 0+0
Out of Memory: Killed process 6944 (RNAsubopt).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 14, high 42, batch 7
cpu 0 cold: low 0, high 14, batch 7

Free pages:        3924kB (112kB HighMem)
Active:135050 inactive:118681 dirty:0 writeback:0 unstable:0 free:981 slab:1977 mapped:253498 pagetables:739
DMA free:68kB min:68kB low:84kB high:100kB active:5572kB inactive:5368kB present:16384kB pages_scanned:13496 all_unreclaimable ? yes
protections[]: 0 0 0
Normal free:3744kB min:3756kB low:4692kB high:5632kB active:469736kB inactive:404380kB present:901120kB pages_scanned:941233 all_unreclaimable? yes
protections[]: 0 0 0
HighMem free:112kB min:128kB low:160kB high:192kB active:64892kB inactive:64976kB present:131044kB pages_scanned:137915 all_unreclaimable? yes
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 68kB
Normal: 0*4kB 0*8kB 0*16kB 1*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3744kB
HighMem: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 112kB
Swap cache: add 294889, delete 294883, find 530/704, race 0+0
Out of Memory: Killed process 6863 (xterm).


I see the machine a lot less responsive when it starts swapping
compared to 2.6.10-rc2-mm3. For example, just moving mouse between
windows takes some 10-12 seconds to fvwm2 to re-focus to another xterm
window.

Martin


> On Tue, 2004-11-23 at 08:41 +0100, Martin MOKREJŠ wrote: 
> 
>>>One big problem when killing the requesting process or just sending
>>>ENOMEM to the requesting process is, that exactly this process might be
>>>a ssh login, when you try to log into to machine after some application
>>>went crazy and ate up most of the memory. The result is that you
>>>_cannot_ log into the machine, because the login is either killed or
>>>cannot start because it receives ENOMEM.
>>
>>I believe the application is _first_ who will get ENOMEM. It must be
>>terrible luck that it would ask exactly for the size of remaining free
>>memory. Most probably, it will ask for less or more. "Less" in not
>>a problem in this case, so consider it asks for more. Then, OOM killer
>>might well expect the application asking for memory is most probably
>>exactly the application which caused the trouble.
> 
> 
> For one application, which eats up all memory the 2.4 ENOMEM bahviour
> works.
> 
> The scenario which made one of my boxes unusable under 2.4 is a forking
> server, which gets out of control. The last fork gets ENOMEM and does
> not happen, but the other forked processes are still there and consuming
> memory. The server application does the correct thing. It receives
> ENOMEM on fork() and cancels the connection request. On the next request
> the game starts again. Somebody notices that the box is not repsonding
> anymore and tries to login via ssh. Guess what happens. ssh login cannot
> fork due to ENOMEM. The same will happen on 2.6 if we make it behave
> like 2.4. 
> 
> We have TWO problems in oom handling:
> 
> 1. When do we trigger the out of memory killer
> 
> As far as my test cases go, 2.6.10-rc2-mm3 does not longer trigger the
> oom without reason.
> 
> 2. Which process do we select to kill
> 
> The decision is screwed since the oom killer was introduced. Also the
> reentrancy problem and some of the mechanisms in the out_of_memory
> function have to be modified to make it work.
> That's what my patch is addressing.
> 
> 
>>>Putting hard coded decisions like "prefer sshd, xyz,...", " don't kill
>>>a, b, c" are out of discussion.
>>
>>I'd go for it at least nowadays.
> 
> 
> Sure, you can do so on your box, but can you accept, that we _CANNOT_
> hard code a list of do not kill apps, except init, into the kernel. I
> don't want to see the mail thread on LKML, where the list of precious
> application is discussed.
> 
> 
>>> 
>>>The ideas which were proposed to have a possibility to set a "don't kill
>>>me" or "yes, I'm a candidate" flag are likely to be a future way to go.
>>>But at the moment we have no way to make this work in current userlands.
>>
>>Do you think login or sshd will ever use flag "yes, I'm a candidate"?
>>I think exactly same bahaviour we get right now with those hard coded decisions
>>you mention above. Otherwise the hard coded decision is programmed into
>>every sshd, init instance anyway. I think it's not necessary to put
>>login and shells on thsi ban list, user will re-login again. ;)
> 
> 
> Having a generic interface to make this configurable is the only way to
> go. So users can decide what is important in their environment. There is
> more than a desktop PC environment and a lot of embedded boxes need to
> protect special applications.
> 
> 
>>>I refined the decision, so it does not longer kill the parent, if there
>>>were forked child processes available to kill. So it now should keep
>>>your bash alive.
>>
>>Yes, it doesn't kill parent bash. I don't understand the _doubled_ output
>>in syslog, but maybe you do. Is that related to hyperthreading? ;)
>>Tested on 2.6.10-rc2-mm2.
> 
> 
>>oom-killer: gfp_mask=0xd2
>>Free pages:        3924kB (112kB HighMem)
> 
> 
>>oom-killer: gfp_mask=0x1d2
>>Free pages:        3924kB (112kB HighMem)
> 
> 
> No, it's not related to hyperthreading. It's on the way out. 
> 
> I put an additional check into the page allocator. Does this help ?
> 
> tglx
> 

