Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268389AbUHTR3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268389AbUHTR3R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUHTR3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:29:17 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:60110 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S268389AbUHTR3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:29:07 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Fri, 20 Aug 2004 13:29:05 -0400
User-Agent: KMail/1.6.82
Cc: V13 <v13@priest.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       mingo@elte.hu, Nick Piggin <nickpiggin@yahoo.com.au>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408201106.15117.gene.heskett@verizon.net> <200408201843.23222.v13@priest.com>
In-Reply-To: <200408201843.23222.v13@priest.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408201329.05176.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.62.54] at Fri, 20 Aug 2004 12:29:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 August 2004 11:43, V13 wrote:
>On Friday 20 August 2004 18:06, Gene Heskett wrote:
>> On Friday 20 August 2004 03:33, Marcelo Tosatti wrote:
>> [...]
>>
>> >> >I can't see how that could be caused by flaky hardware.
>> >>
>> >> There is still that possibility Marcelo.  Someone recommended I
>> >> get cpuburn and memburn, and before fixing the scanf statement
>> >> (it was broken) in memburn, I had compiled it for a 512 meg
>> >> test the first time, and a 768 meg test the next couple of
>> >> runs.
>> >>
>> >> All exited with errors like this:
>> >> Passed round 133, elapsed 4827.19.
>> >> FAILED at round 134/14208927: got ff00, expected 0!!!
>> >>
>> >> REREAD: ff00, ff00, ff00!!!
>> >>
>> >> [root@coyote memburn]# vim memburn.c
>> >> [root@coyote memburn]# gcc -o memburn memburn.c
>> >> [root@coyote memburn]# ./memburn
>> >> Starting test with size 768 megs..
>> >>
>> >> Passed round 0, elapsed 44.36.
>> >> Passed round 1, elapsed 74.13.
>> >> Passed round 2, elapsed 105.12.
>> >> FAILED at round 3/25777183: got 2b00, expected 0!!!
>> >>
>> >> REREAD: 2b00, 2b00, 2b00!!!
>>
>> The latest output of memburn after a bit of format hacking:
>>
>> FAILED at round 78/165714207: got 0000ff00, expected 00000000!!!
>> REREAD: 0000ff00, 0000ff00, 0000ff00!!!
>>
>> and
>>
>> FAILED at round 160/200780831: got 02025302, expected 02020202!!!
>> REREAD: 02025302, 02025302, 02025302!!!
>>
>> So it appears that its the third byte of 4 each time thats
>> fubar'd. I'l run it a few more times to confirm.  Is memory byte
>> wide per chip on these things today?
>
>I had a simillar problem some years ago. I had core dumps and gcc
> errors all the time but memtest could not find a thing. 99% it was
> a CPU problem and not a memory problem. It seemed that there were
> errors at random times even when there was no cpu load.
>
>I believe it was a cache problem. I made a simple prog (like
> memburn) that allocated memory blocks and then did some read/write
> on them (alloc+write 5 blocks, check 1, free 1, alloc+write 6,
> check 2, free 2 alloc+write 7....). After that whenever the program
> encountered an error it looped on this block forever.
>
>The errors occured after a random period of time (from 1 block
> allocation to more than an hour) and were never reproduced after a
> stop/start. When this test program was running and looping on the
> bad block, gcc never displayed errors. The problem was fixed when I
> replaced the CPU and I'm still using the same DIMMs without
> problems. I also did a lot of checks before replacing the CPU, like
> changing the position of the DIMMs, removing one of them, change
> their timing, and much more without success. Even removed all the
> PCI cards.
>
>Disabling the CPU cache or replacing it can be a good test.
>
><<V13>>

I tried disabling it in the bios and the machine became unusable for 
all practical purposes.  But it did run about half a day that way.  
I'd estimate its speed was similar to a 33 mhz 386sx with only 8 megs 
of ram though.  I could type a full sentence ahead of the screen 
display in kmail for instance.  Had it been usable, I might have been 
tempted to let it run a couple of days just for grins.  On the next 
reboot, I'm going to switch the stick around, and see if the errors 
move to an even address.  If they do, then I'd be convinced its 
memory and not cache.  The question then becomes which stick in a 
dual channel setup is even addresses, and which is odd addresses.

Probably best to just go buy another half gigger and swap it in for 
one of these one at a time.  And hope its better!

Yup, memburn stopped again, at an odd address, showing the same 
failure pattern in byte 3 of 4.

FAILED at round 63/20669951: got 0000ff00, expected 00000000!!!
REREAD: 0000ff00, 0000ff00, 0000ff00!!!

I guess i'm going to town.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
