Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVEXOry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVEXOry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 10:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEXOry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 10:47:54 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:16294 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261470AbVEXOrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 10:47:48 -0400
Date: Tue, 24 May 2005 10:47:43 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: RT patch acceptance
In-reply-to: <Pine.OSF.4.05.10505241532040.29908-100000@da410.phys.au.dk>
To: linux-kernel@vger.kernel.org
Message-id: <200505241047.43473.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.OSF.4.05.10505241532040.29908-100000@da410.phys.au.dk>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 May 2005 09:58, Esben Nielsen wrote:

As a user working on makeing a small mill into a CNC machine, using 
emc, I'll comment as needed here.

>On Tue, 24 May 2005, Karim Yaghmour wrote:
>> Esben Nielsen wrote:
>> > I find that a bad approach:
>> > 1) You don't have RT in userspace.
>> > 2) You can't use Linux drivers for standeard hardware when you
>> > want it to be part of your deterministic RT application.
>>
>> Please have a look at RTAI/fusion. For the record, RTAI has been
>> providing hard-rt in standard Linux user-space for over 5 years
>> now. With RTAI/Fusion this gets even better as there isn't even a
>> special API ...
>
>The tests I have read (I can't remember the links, but it was on
> lwn.net) states that the worst case latency is even worse than for
> a standeard 2.6 kernel!

It is worse, by a quite noticeable amount.  Keyboard events often take 
noticeable fractions of a second to show, or to take effect if its 
the apps own interface that you are entering control data to.

>If you gonna make usefull deterministic real-time in userspace you
> got to change stuff in kernel space and implement stuff like
> priority inheritance, priority ceiling or similar.  It can only
> turn up to be an ugly hack which will end up being as intruesive
> into the kernel as Ingo's approach. If you don't do anything like
> that you can not use _any_ Linux kernel resources from your RT
> processes even though you have reimplemented the pthread library to
> know about the "super RT" priorities.
>
>But I give you: You will gain better interrupt latencies because
>interrupts are executed below the Linux proper. I.e. when the Linux
>kernel runs with interrupt disabled, they are really enabled in the
> RTAI subsystem.
>
>My estimate is that RTAI is good when you have a very small
> subsystem you need to run RT with very low latencies. Forinstance,
> controlling a fast device with limiting hardware resources to
> buffer events.

This is true, and in order to be able to run emc with anything like a 
decent motor speed at the motors, I had to buy a new board and video 
card to replace the one I was going to use, which was a 266mhz p2.  
The p2 could do it, but there was no time left to run linux, so 
controlling the application wasn't possible.  Without changing the 
RTAI cycle time, a 1400mhz athlon runs linux at fairly normal speed 
while emc is running.

>For large control systems I don't think it is the proper way to do
> it. There it is much better to run the control tasks as normal
> Linux user-space processes with RT-priority. I can see Ingo's
> kernel doing that, I can't see RTAI doing it except for very
> special situations where you don't make _any_ Linux system calls at
> all! You can't even use a normal Linux network device or character
> device from your RT application!

I agree.  Use RTAI if you are building a specialized box that will 
never be asked to do anything else, mostly because thats all it will 
be capable of doing unless it has horsepower to burn, lots of it.

Ingo's RT patches allow me to do some play time and driver development 
on this box for that application with a reasonable expectation that 
it will work on that box when I haul the code down there and 
recompile it there.

I've also noted that Jack users need this as its not very usable 
without it, or wasn't half a year ago.  I'm not a die hard Jack user, 
but I'd really like to import my movie camera without any dropped 
frames, so I expect what fixes one will fix the other.

If, at the same time, it will give me back a keyboard when SA is 
filtering the incoming mail on this machine, thats a huge plus.  I'm 
about to find that out as I just built the -07 version.

>> Here are a few links if you're interested:
>> http://www.rtai.org/modules.php?name=Content&pa=showpage&pid=1
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=111634653913840&w=2
>>
>> Karim
>
>Esben

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
