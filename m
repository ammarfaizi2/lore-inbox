Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272894AbTHEWhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 18:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272920AbTHEWhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 18:37:46 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:11268 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S272894AbTHEWhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 18:37:23 -0400
Message-ID: <3F303494.3030406@techsource.com>
Date: Tue, 05 Aug 2003 18:49:56 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Charlie Baylis <cb-lkml@fish.zetnet.co.uk>
CC: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [PATCH] O12.2int for interactivity
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Charlie Baylis wrote:
>>I tried them aggressively; irman2 and thud don't hurt here. The idle
>>detection limits both of them from gaining too much sleep_avg while waiting
>>around and they dont get better dynamic priority than 17. 
> 
> 
> Sounds like you've taken the teeth out of the thud program :) The original aim
> was to demonstrate what happens when a maximally interactive task suddenly
> becomes a CPU hog - similar to a web browser starting to render and causing
> intense X activity in the process. Stopping thud getting maximum priority is
> addressing the symptom, not the cause. (That's not to say the idle detection
> is a bad idea - but it's not the complete answer)
> 
> What happens if you change the line
>   struct timespec st={10,50000000}; 
> to
>   struct timespec st={0,250000000}; 
> 
> and the line
>     nanosleep(&st, 0); 
> to
>     for (n=0; n<40; n++) nanosleep(&st, 0); 
> 
> the idea is to do a little bit of work so that the idle detection doesn't kick
> in and thud can reach the max interactive bonus. (I haven't tried your patch
> yet to see if this change achieves this)


MR.BARNARD: (shouting) What do you want?
MAN: Well I was told outside...
MRB: Don't give me that you snotty-faced heap of parrot droppings!
MAN: What!
MRB: Shut your festering gob you tit! Your type makes me puke! You 
vacuous toffee-nosed malodorous pervert!!
MAN: Look! I came here for an argument.
MRB: (calmly) Oh! I'm sorry, this is abuse!


Or closer to the point:

"For each record player, there is a record which it cannot play."
For more detail, please read this dialog:
http://www.geocities.com/g0del_escher_bach/dialogue4.html



The interactivity detection algorithm will always be inherently 
imperfect.  Given that it is not psychic, it cannot tell in advance 
whether or not a given process is supposed to be interactive, so it must 
GUESS based on its behavior.

Furthermore, for any given scheduler algorithm, it is ALWAYS possible to 
write a program which causes it to misbehave.

This "thud" program is Goedel's theorem for the interactivity scheduler 
(well, that's not exactly right, but you get the idea).  It breaks the 
system.  If you redesign the scheduler to make "thud" work, then someone 
will write "thud2" (which is what you have just done!) which breaks the 
scheduler.  Ad infinitum.  It will never end.  And in this case, 
optimizing for "thud" is likely also to make some other much more common 
situations WORSE.


So, while it MAY be of value to write a few "thud" programs, don't let 
it go too far.  The scheduler should optimize for REAL loads -- things 
that people actually DO.  You will always be able to break it by 
reverse-engineering it and writing a program which violates its 
expectations.  Don't worry about it.  You will always be able to break 
it if you try hard enough.


As Linus says, "Perfect" is the enemy of "Good".


