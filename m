Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271021AbTGVUr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 16:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271027AbTGVUr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 16:47:56 -0400
Received: from ip252-142.choiceonecom.com ([216.47.252.142]:18188 "EHLO
	explorer.reliacomp.net") by vger.kernel.org with ESMTP
	id S271021AbTGVUrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 16:47:52 -0400
Message-ID: <3F1DA679.60807@cendatsys.com>
Date: Tue, 22 Jul 2003 16:02:49 -0500
From: Edward King <edk@cendatsys.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John V. Martinez" <jvm@snarkhunter.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
References: <3F1C54A8.5020404@snarkhunter.com> <3F1D4DBA.4010700@cendatsys.com> <20030722180732.GA24179@bounce.snarkhunter.com>
In-Reply-To: <20030722180732.GA24179@bounce.snarkhunter.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not compile the devfs -- I beleive if you compile it, it will be used 
(it can't be compiled as a module).

I caught the error because partimage didn't find /dev/hda1 but found the 
path devfs uses natively (don't remember, something like bsd, not 
important) which I beleive (and could be really off base here) that the 
/dev/hda1 actually pointed to if devfs code was compiled in (I _think_ 
-- big stress on not being sure -- that devfs makes itself transparent.)

Compile without devfs and try it.  It doesn't matter how many ide 
controllers you use, where you put the drives, DMA settings, etc.  I 
found with devfs the raid would crash in a heartbeat but single drives 
would respond without a hiccup -- even running bonnie on each drive 
simultaneously for hours.

As for more ide ports, no idea.  Maybe the new SATA will help there but 
I haven't played with them.

- Ed

John V. Martinez wrote:

>Hi Ed,
>
>
>Thanks for the quick reply. Sadly, I think I have a different
>(possibly related?) problem, as I am not currently using devfs.
>
>(clarification: my kernel does have devfs support compiled in, but it
>is not mounted on my system -- you don't think just having it compiled
>in makes any difference, do you? I can't see why it would, but
>stranger things have happened -- to me, at least :^) -- I'm currently
>running a Debian 3.0 system with their 'Pentium Classic' 2.4.18 kernel
>(2.4.18-586tsc) flavor, but the problem was still present when I tried
>switching to the 2.4.20 kernel currently in testing. I guess I'll try
>building 2.4.21 when I get a chance - trouble is, it's (supposed to
>be) a 24x7 server, so I can't afford too much downtime for these
>experiments. (Which is why I was searching the web, hoping to find a
>definitive checkin comment somewhere that said "John's problem with
>two promise controllers locking up his system when he rebuild his RAID
>array is fixed now in 2.4.21-cheesewhiz" but no such luck.
>
>:^)
>
>I guess if all else fails, I'll use the setup you have: 4-drive RAID
>on one controller. My concern was not so much the performance hit of
>using both master&slave, but the possibility of a bad drive hosing the
>connection to both drives on that controller, thus taking down 1/2 of my
>RAID5 array at once. 
>
>Do you happen to know if anybody makes a (Linux-friendly) IDE
>controller card with more than two channels? All the cards I have
>found which will connect more than 4 drives are hardware RAID
>controllers, (or faux-hardware raid, like Promise.)
>
>Anyway, thanks again for your time,
>
>-(-- John V. Martinez
>
>
>
>On Tue, Jul 22, 2003 at 09:44:10AM -0500, Edward King wrote:
>  
>
>>John:
>>
>>Quick fix to the problem is remove devfs -- it appears that the devfs 
>>code doesn't like to have the raid layered on top of it, and it loses 
>>interrupts.
>>
>>I've got two systems now running 4 200GB WD's connected to a single 
>>promise card (ATA100/TX2)  with the booting drive (a 5th drive) attached 
>>to the motherboard.  The raid works flawlessly and is fast -- I imagine 
>>there'd be a speedup by keeping all the drives as master (with 2 pdc's) 
>>and it would be more robust, but those aren't issues.
>>
>>Hope this helps -- I'll post this to the mailing list to help anyone 
>>else with this problem.
>>
>>- Ed
>>
>>John V. Martinez wrote:
>>
>>    
>>
>>>Hi Ed,
>>>
>>>I found a linux-kernel post you made back in March about problems 
>>>running two Promise IDE controllers in the same system. I have a 
>>>similar configuration, (and a similar problem,) and I was wondering if 
>>>you ever found a solution, or if one of the more recent 2.4.21-foo 
>>>kernels solved it for you.
>>>
>>>(I have two Promise ATA-100/TX2 (20268 chip) controllers, and I have 
>>>one 200GB WD drive as a single master on each channel. The two 
>>>controllers are sharing interrupts with othwer cards, but not with 
>>>each other. I can access each disk individually, but when I tried to 
>>>make them work hard: mkraid a RAID5 array using these four drives, the 
>>>system freezes HARD until I hit the big red button. [Then it reboots, 
>>>spots the raid superblock, tries to rebuild my RAID5 array, and 
>>>freezes again, until I get a clue and unplug the drives in question 
>>>while powered down :^))
>>>
>>>Anyway, if you have any more insight into this problem than you did in 
>>>March, and care to share, I'd be much obliged.
>>>
>>>Cheers,
>>>
>>>-(-- John
>>>      
>>>
>>    
>>
>
>  
>

