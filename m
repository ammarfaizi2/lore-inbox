Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTDNNQ6 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 09:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbTDNNQ6 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 09:16:58 -0400
Received: from dialup-12.156.221.203.acc50-nort-cbr.comindico.com.au ([203.221.156.12]:63748
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263012AbTDNNQ4 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 09:16:56 -0400
Message-ID: <3E9AB77F.5000506@cyberone.com.au>
Date: Mon, 14 Apr 2003 23:28:31 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Benefits from computing physical IDE disk geometry?
References: <Pine.LNX.4.44.0304140244020.7922-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0304140244020.7922-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mark Hahn wrote:

>>>>The benefit I see is knowing the seek time itself (not geometry), which
>>>>can be used to tune the IO scheduler. This is something that I'll
>>>>
>
>but seek time is some combination of headswitch time, rotational 
>latency, and actual head motion.  the first three are basically
>not accessible in any practical way.  the latter is easy, and the 
>
Yep which is one reason why I don't think being fancy will pay
off (the other reason being that even if you did know the parameters
I don't think they would help a lot).

I just want to know the average seek time.

>
>current approximation (seek time is a linear function of block distance)
>is very reasonable.
>
Well, strictly, not linear. But yes it does provide a good ordering.
That is besides the point though: I can decide if one request will
have a shorter seek time than another just fine. I would still like
to know the aproximate seek _time_ for higher level tuning stuff
eg. will anticipation be worth it, and how soon should requests
expire.

>
>
>adjusting the cost function would be interesting: I'm guessing that 
>handling short seeks (which are quite fast) would be more important
>than adjusting for zones.  given that the current queueing code 
>handles starvation, I wonder if we could actually permit backward
>seeks of, say, 0-2 cylinders.
>
There is (in AS) no cost function further than comparing distance
from the head. Closest forward seek wins.

If by the queueing code you mean the actual IO schedulers? Then
yes, they do handle starvation, however they (AS, deadline)
handle _fairness_ by not seeking backward. Well actually
AS does allow a process to seek upto IIRC 256MB backward
which is a couple of ext2 blockgroups while maintaining quite
good fairness.

>
>
>>Well using the assumption that |head sector - target sector| gives
>>an ordering correstponding to seek time, we do sort the queue optimally.
>>I personally feel that being trickier than that is too much complexity.
>>
>
>exactly.
>  
>

