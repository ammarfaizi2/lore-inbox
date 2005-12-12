Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVLLLOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVLLLOw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 06:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVLLLOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 06:14:52 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:36483 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751229AbVLLLOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 06:14:51 -0500
Message-ID: <439D5C86.1040304@aitel.hist.no>
Date: Mon, 12 Dec 2005 12:18:30 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc5: multiuser scheduling trouble
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org> <20051210162759.GA15986@aitel.hist.no> <Pine.LNX.4.64.0512111607040.15597@g5.osdl.org> <20051212065150.GA8187@elte.hu>
In-Reply-To: <20051212065150.GA8187@elte.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>Helge,
>
>* Linus Torvalds <torvalds@osdl.org> wrote:
>
>  
>
>>Also, the most common case is that somebody has reniced the X server, 
>>which is just _wrong_.  It used to be done by some distributions to 
>>try to help the scheduler make the right choices, but we've fixed the 
>>scheduler and it doesn't need it or want it.
>>    
>>
>
>  
>
>>>Knowing the root password I renices his Xorg and firefox by 10, and 
>>>then everything is fine.  His games are still ok, and my xterms are 
>>>snappy again.
>>>      
>>>
>
>does this mean X defaults to nice level 0, and then if you renice
>Firefox and X by +10, everything is fine? 
>
Correct. X is at 0, adjusting to 10 helps.  Adjusting only
firefox is not enough.

>Or is Linus' suspicion, and X
>defaults to something like nice -5? (e.g. on Debian type of systems)
>  
>
It is a debian testing system, with some experimental/unstable stuff.
The xservers are not reniced though, that has been configurable
for a while and I turned it off at the time when the scheduler
was changed and renicing no longer was recommended.
top shows NI=o,  ps aux shows no "<" for the xservers.

>but ... i havent seen problems with Firefox and flash myself. My 3 years
>old son's favorite kid's site is fully based on flash, and the 833 MHz
>laptop is still usable remotely while he browses around on it. It's
>Fedora Core 4, and X is not reniced.
>  
>
I guess this depends a bit on how the machine is used remotely.
Light use of an xterm isn't always that bad - although "top" took
a second to appear.  The bringing up icewm and the xterms
themselves took a lot longer though.  I don't use it remotely,
I log in on a second xserver running on a extra graphichs card.
Even the relatively lightweight icewm is much heavier than simply
ssh-ing into a box - there is graphichs work to do.  I wouldn't be surprised
if the usual three-second login took twice as long with a game going on, but
half a minute is a bit excessive.  I have only seen it that bad once,
but the slowness is normally so noticeable that I bother with looking
up the process numbers and renice them.

>but if the X server is not reniced then it would be nice if i could
>reproduce the starvation ... which site is the one triggering it? (and
>  
>
www.teagames.com is popular at the time.  Lots of 2D scrolling flash
games, and all seems to be made with the assumption that the more cpu you
have, the higher framerate you should get.  Never mind that the screen
runs at 60Hz only. . .

>could you check www.egyszervolt.hu, and click around on it, does it
>trigger similar starvation problems too?)
>  
>
No, I clicked around for a while, but was unable to drive the load up to 1.
I never see problems with load<1 - as expected.  Try a game that uses screen
painting as a busy loop - it pegs the load at 1 no matter how powerful the
machine is.  And then the scheduling might get interesting.  Running
two such games at once tends to be slow for both, and also bursty in that
one might get a second of nice speed, some slowness, and sometimes
jerkiness with short stops in the action.  Some of these games would be
ok running at half speed, but not with such uneven speed.

Sticking another cpu in the free slot would probably fix all this. :-/

Helge Hafting
