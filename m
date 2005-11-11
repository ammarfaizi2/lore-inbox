Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVKKNMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVKKNMH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 08:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVKKNMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 08:12:07 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:36237 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750728AbVKKNMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 08:12:06 -0500
Message-ID: <4374989C.20903@m1k.net>
Date: Fri, 11 Nov 2005 08:11:56 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Junichi Uekawa <dancer@netfort.gr.jp>, debian-amd64@lists.debian.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [x86_64] 2.6.14-git13 mplayer fails with "v4l2: ioctl queue	buffer
 failed: Bad address" (2 Nov 2005, 11 Nov 2005)
References: <87fyqeicge.dancerj%dancer@netfort.gr.jp>	<87wtjg5gh2.dancerj%dancer@netfort.gr.jp>	<4373D087.5050908@linuxtv.org>	<87psp859sd.dancerj%dancer@netfort.gr.jp>	<43740F06.6030504@m1k.net> <87y83vl780.dancerj%dancer@netfort.gr.jp>
In-Reply-To: <87y83vl780.dancerj%dancer@netfort.gr.jp>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junichi Uekawa wrote:

>>>>> mplayer  tv://1 -tv driver=v4l2
>>>>>MPlayer dev-CVS--4.0.2 (C) 2000-2005 MPlayer Team
>>>>>CPU: Advanced Micro Devices Athlon 64 Newcastle,Winchester,San Diego,Venice; Sempron Palermo (Family: 15, Stepping: 0)
>>>>>Detected cache-line size is 64 bytes
>>>>>CPUflags:  MMX: 1 MMX2: 1 3DNow: 1 3DNow2: 1 SSE: 1 SSE2: 1
>>>>>Compiled for x86 CPU with extensions: MMX MMX2 3DNow 3DNowEx SSE SSE2
>>>>>
>>>>bttv currently only supports v4l1.  We are still in the process of 
>>>>porting the bttv driver from v4l1 to v4l2. Nickolay is working on it.
>>>>
>>>Thanks for the info. It's strange since this is a regression
>>>(pre 2.6.14 used to work. New code made it fail).
>>>Do you mean there was a change that broke v4l2 support in bttv ?
>>>Ever since Linux Kernel 2.6.3, I used v4l2 for recording (more
>>>than one and a half years...)
>>>
>>v4l2 support could not have been broken, since it was never present.  
>>You were going through a compat layer.... Maybe that's where the 
>>regression is.
>>    
>>
>>One question -- At exactly what point does this break for you?  The git 
>>commit key above was from today, but at what point did this LAST work 
>>for you?  It would be really helpful if you can do a git bisection test, 
>>so that we can isolate the trouble patch if in fact it is a regression.
>>    
>>
>df70b17f88a4d1d8545d3569a1f6d28c6004f9e4 2 Nov 2005 Nonfunctional bttv
>d83c671fb7023f69a9582e622d01525054f23b66 1 Nov 2005 (fails to boot due to USB issues)
>6e9d6b8ee4e0c37d3952256e6472c57490d6780d 27 Oct 2005 Functional bttv
>  
>
This info was quite helpful... Looking through gitweb, it looks like the 
trouble began for you BEFORE Mauro started to send our new patchsets 
over to akpm. If I am correct, this indicates that the problem patch is 
from elsewhere in the kernel.

I saw a thread about some i2c related bttv problem... I don't know if 
that's a red herring or not, but it was also around the time that you 
say your kernel breaks.

At this point, the best thing that you can do is run a git bisection 
regression test, like I had previously suggested. Linus has written a 
HOWTO thread about it a few months ago on LKML. Does anybody know if 
there is a howto online for git bisection testing? Maybe there's a copy 
of the thread on kerneltrap.org? just a guess...

If we can narrow this down to the exact patch that is causing the 
problem for you, it would be a lot easier to deal with.

>>You might also like to join us in #v4l on irc.freenode.net ... Sometimes 
>>it's much quicker to troubleshoot this stuff over irc instead of email.
>>    
>>
>joined, but currently rebooting sporadically to test 
>different kernels.
>  
>
Okay, well here are a few other things that I would have you try:

#1) Try using v4l-kernel cvs, and tell us if you still have the problem. 
Since I think that the problem is occurring for you elsewhere in the 
kernel, using our code in cvs should yeild no change in behavior. Even 
though this doesn't sound promising, it can help us to prove whether v4l 
is responsible for this problem or not:

http://linuxtv.org/v4lwiki/index.php/How_to_build_from_CVS

First, try out latest cvs. Yes, there is still some new code in cvs that 
we have not yet sent upstream, including some compat_ioctl32.c fixes 
from Nickolay from this morning.

#2) After testing the latest cvs, then I would ask for you to wipe out 
the cvs tree and try again, but using older code..... Say, from October 
first or so, maybe even September first. To do this, follow the same 
procedure in the wiki-howto above, but add the -D parameter to the cvs 
checkout command. ( cvs co -D 2005-09-01 -- see man cvs)

I would assume that there will be no difference in behavior between the 
different cvs versions, but maybe you will find otherwise.

#3) Another thing you can try is to build the current cvs modules 
against the last known working kernel. If the new cvs modules in the 
older kernel break it again, then it tells us that some new v4l code IS 
to blame.

#4) Once again, the -git bisection regression testing is the best thing 
to do here.

Regards,

Michael Krufky
