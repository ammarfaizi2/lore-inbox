Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUHVFFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUHVFFj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 01:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUHVFFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 01:05:39 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:52200 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S266181AbUHVFF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 01:05:28 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 22 Aug 2004 01:05:25 -0400
User-Agent: KMail/1.6.82
Cc: "R. J. Wysocki" <rjwysocki@sisk.pl>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408202211.46854.rjwysocki@sisk.pl> <200408201617.09245.gene.heskett@verizon.net>
In-Reply-To: <200408201617.09245.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408220105.25734.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.62.54] at Sun, 22 Aug 2004 00:05:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 August 2004 16:17, Gene Heskett wrote:
>On Friday 20 August 2004 16:11, R. J. Wysocki wrote:[...]
>
>>There's a simple test you can do unless your DIMMs must go in pairs
>> (I don't remember if it's required by nforce2): remove one of them
>> and see what happens.
>
>To get dual channel DDR, they have to be in a pair.  Since this
> post, they've been swapped one for the other, and I'll be curious
> to see if the address goes to an even address when it errors, which
> it hasn't yet.
>
It has, one time in 35 hours now.  The problem is considerably 
reduced.

Whereas the error was always at an odd address, and in the 2nd LSbyte, 
now its still an odd address but the error has moved to the MSB of a 
32 bit fetch:

[root@coyote memburn]# ./memburn 512
Starting test with size 512 megs..
Passed round 2308, elapsed 41225.98.
FAILED at round 2309/40220063: got ff000000, expected 00000000!!!
REREAD: ff000000, ff000000, ff000000!!!
[root@coyote memburn]# ./memburn 512
Starting test with size 512 megs..
Passed round 2636, elapsed 60944.15.

As can be seen, I restarted it, and its ran quite even more loops now 
without error.  There has been no more Oops, but with memburn eating 
512 megs, half my ram, and kde-3.3 under construction by konstruct, 
I've peaked at nearly a gig of swap, and 754 megs in swap right now.  
Sure, its a bit laggy, but not unusable.

So now the question is since the error address is always odd, which 
stick is it?

Or do I need to sanitize the dimm sockets somehow?

They sure seem to slip in and out easy enough for a socket with that 
many contacts. Not over 3 pounds on each end will seat them, and if 
the clips are re-opened they virtually fall out into your hand.  I'm 
rather more used to having to press 5 to 10 pounds on each end to 
seat them.

Next time I have to reboot, I'm going to 'exercise' them in and out a 
few times just to polish the oxide from the contacts.

>> If you can reproduce the same symptoms on
>> each of them separately, I'd bet on a cache problem.
>
>That makes sense, so I can try that too.  I hadn't thought of that,
>duh!
>
>>Greetings,
>
>Someone else asked if ECC was on, but this board doesn't have it,
> and the memory has a blank pattern where the parity chip would be. 
> So I think its safe to say no :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
