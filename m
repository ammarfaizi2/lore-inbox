Return-Path: <linux-kernel-owner+w=401wt.eu-S1754144AbWLXHVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbWLXHVb (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 02:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754156AbWLXHVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 02:21:31 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:53587 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbWLXHVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 02:21:30 -0500
Message-ID: <458E2A41.2030200@comcast.net>
Date: Sun, 24 Dec 2006 02:20:33 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: evading ulimits
References: <458C4CEF.3090505@comcast.net> <Pine.LNX.4.61.0612240111250.20280@yvahk01.tjqt.qr>            <458DCCE2.3060605@comcast.net> <200612240655.kBO6tngs031080@turing-police.cc.vt.edu>
In-Reply-To: <200612240655.kBO6tngs031080@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Valdis.Kletnieks@vt.edu wrote:
> On Sat, 23 Dec 2006 19:42:10 EST, John Richard Moser said:
>>
>> Jan Engelhardt wrote:
>>>> I've set up some stuff on my box where /etc/security/limits.conf
>>>> contains the following:
>>>>
>>>> @users          soft    nproc           3072
>>>> @users          hard    nproc           4096
>>>>
>>>> I'm in group users, and a simple fork bomb is easily quashed by this:
>>>>
>>>> bluefox@icebox:~$ :(){ :|:; };:
>>>> bash: fork: Resource temporarily unavailable
>>>> Terminated
>>>>
>>>> Oddly enough, trying this again and again yields the same results; but,
>>>> I can kill the box (eventually; about 1 minute in I managed to `/exec
>>>> killall -9 bash` from x-chat, since I couldn't get a new shell open)
>>>> with the below:
>>> Note that trying to kill all shells is a race between killing them all firs
> t
>>> and them spawning new ones everytime. To stop fork bombs, use killall -STOP
>>> first, then kill them.
>>>
>> Yes I know; the point, though, is that they should die automatically
>> when the process count hits 4096.  They do with the first fork bomb;
>> they keep growing with the second, well past what they should.
> 
> This may be another timing issue - note that in the first case, you have :|:
> which forks off 2 processes with a pipe in between.  If the head process fails,
> the second probably won't get started by the shell *either*.  In the second
> case, you launch *3*, and it's possible that the head process will start and
> live long enough to re-fork before a later one in the pipe gets killed.
> 
> Does the behavior change if you use 4095 or 4097 rather than 4096?  I'm
> willing to bet that your system exhibits semi-predictable behavior regarding
> the order the processes get created, and *which* process gets killed makes
> a difference regarding how fast the process tree gets pruned.
> 

I will test this later (sleeping now)

> Do you have any good evidence that the second version manages to create much
> more than 4096 processes, rather than just being more exuberant about doing so?
> I'm guessing that in fact, in both cases the number of processes ends up
> pseudorandomly oscillating in the 4090-4906 range, but the exact order of
> operations makes the rate and impact different in the two cases.

I haven't gathered evidence; I rather look for evidence that fork() is
failing, like bash complaints.  I get those in abundance in the first
case; but see none in the second case.

Trying again, I can't reproduce the phenomena.  It crashes out in 3
seconds.  Either just weird that it ran for so long last time before I
had to manually kill it off; or a race.  I don't have sufficient data to
decide.


-- 
    We will enslave their women, eat their children and rape their
    cattle!
             -- Bosc, Evil alien overlord from the fifth dimension
Anti-Spam:  https://bugzilla.mozilla.org/show_bug.cgi?id=229686
