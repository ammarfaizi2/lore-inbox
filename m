Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTIFPrU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 11:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTIFPrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 11:47:20 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:57539 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261334AbTIFPrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 11:47:18 -0400
Message-ID: <3F59C956.5050200@wmich.edu>
Date: Sat, 06 Sep 2003 07:47:34 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Nick Piggin <piggin@cyberone.com.au>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay> <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay> <3F5935EB.4000005@cyberone.com.au> <6470000.1062819391@[10.10.2.4]> <3F5980CD.2040600@cyberone.com.au> <139550000.1062861227@[10.10.2.4]>
In-Reply-To: <139550000.1062861227@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>I think the two will always related. One means giving a higher
>>dynamic priority, the other a bigger timeslice. So you want
>>say gcc to have a 100ms timeslice with lowest scheduling prio,
>>but X to have a 20ms slice and a very high scheduling priority.
> 
> 
> Right.
>  
> 
>>Unfortunately, the way the scheduler currently works, X might
>>use all its timeslice, then have to wait 100ms for gcc to finish
>>its. The way I do it is give a small timeslice to high prio tasks,
>>and lower priority tasks get progressively less.
> 
> 
> If the interactive task uses all it's timeslice, then it's not really
> very interactive, it's chewing quite a bit of CPU ... presumably in
> the common case, these things don't finish their timeslices. I thought
> we preempted the running task when a higher prio one woke up, so this
> should still work, right?
> 
> So it would seem to make sense to boost the prio of a interactive task 
> *without* increasing the size of it's timeslice.
> 
> 
>>When _only_ low priority tasks are running, they'll all get long
>>timeslices.
> 
> 
> That at least makes sense. AFIAK at least the early versions of Con's
> stuff make cpu bound jobs' timeslices short even if there were no
> interactive jobs. I don't like that (or more relevantly, the benchmarks
> don't either ;-)).
> 
> 
>>OK well just as a rough idea of how mine works: worst case for
>>xmms is that X is at its highest dynamic priority (and reniced).
>>xmms will be at its highest dynamic prio, or maybe one or two
>>below that.
>>
>>X will get to run for maybe 30ms first, then xmms is allowed 6ms.
>>That is still 15% CPU. And X soon comes down in priority if it
>>continues to use a lot of CPU.
> 
> 
> If it works in practice, it works, I guess. I just don't see why X
> is super special ... are we going to have to renice *all* interactive 
> tasks in order to get things to work properly?
> 
> M.


If you dont see why X is super special then why is xmms even a part of 
the discussion?   All of this basing scheduling performance on a bloated 
wannabe winamp makes as much sense as gauging car performance using a 
van.   If this was a purely scheduling problem, then why do other 
players like alsaplayer and such not suck as bad as xmms when under the 
exact same priority and all?  At least use something without a frontend 
so that you can limit the possibility that the programmers did something 
stupid like make decoding dependent on some update to the gui.  xmms was 
coded first and foremost to look and work like winamp. Streamlined - 
even low latency performance was not a base goal.  And outside of these 
two programs X and some audio player, how are things going to be 
effected?   Forget having to renice certain processes, if i have a video 
player that say, outputs using X will the video thread get lowered below 
certain other processes because the audio thread is getting a higher 
dynamic priority and the video thread uses a lot of cpu (maybe i dont 
have hw accel).  What about video players that dont use theads, they 
require both a lot of cpu and audio playing performance to stay in sync, 
will it be dropped below the priority of other apps?

It's early for me so maybe i'm overreacting.  I just dont see the logic 
in using a program like xmms to guage audio playback performance since 
it's main goal is to be like winamp, not efficiently playback audio and 
so can be introducing all kinds of performance hits not found in other 
players.


