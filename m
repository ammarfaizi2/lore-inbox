Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267744AbUHPPst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267744AbUHPPst (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267687AbUHPPfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:35:40 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:3997 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S267744AbUHPPZM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:25:12 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Mon, 16 Aug 2004 11:25:10 -0400
User-Agent: KMail/1.6.82
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408161013.38430.gene.heskett@verizon.net> <200408161749.23663.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408161749.23663.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408161125.10269.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.63.91] at Mon, 16 Aug 2004 10:25:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 August 2004 10:49, Denis Vlasenko wrote:
>> >>> Ok, non-preempt is building.  Will reboot to it when the build
>> >>> is done.
>> >>
>> >>Do not load sound modules too please, unless you absolutely need
>> >> sound.
>> >
>> >One thing at a time I think.  Thats major surgery on
>> > modprobe.conf to disable that, plus a chkconfig alsasound off.
>> >
>> >I've noticed that with preempt off, my kde curser motions are
>> > back to using the mouse if I want to move it more than a word or
>> > so to hit a typu and fix it.  Its an effect that comes and goes,
>> > often in the same message reply.  X is running at -1 I think. 
>> > Other than that (knock on wood) its running ok so far, but only
>> > 9h50m uptime.
>>
>> [...]
>> With PREEMPT off, and a 16 hour uptime, I am suddenly nearly out
>> of memory again. As an additional tool, I had started ksysguard
>> for its
>
>That depends of what you call "out of memory". It's normal for Linux
>to have very little free memory. top shows on my 256Mb home box:
>
>224 processes: 223 sleeping, 1 running, 0 zombie, 0 stopped
>CPU states:   2.9% user  13.8% system   0.0% nice   0.1% iowait 
> 82.9% idle Mem:   254936k av,  252736k used,    2200k free,      
> 0k shrd,   38872k buff ^^^^^^^^^^
>       197796k active,              31396k inactive
>Swap:  262136k av,       0k used,  262136k free                  
> 95868k cached ^^^^^^^^^^^^^
>
>Of course, when you're fresh after reboot, you do have
>tons of free memory. How quickly cache will fill your RAM
>depends on RAM amount and your usage pattern.
>With 1Gig of RAM and mild usage it can take e.g. 16 hours or so. ;)
>
>> gfx memory display and set it for a 1 minute update interval. 
>> When I awoke again, the memory panel was 100% blue since some
>> major event, I assume logrotate by cron, ran but hadn't quite
>> scrolled off screen.
>
>Quite possibly. Reboot, run "grep -rF 'something' ." in a kernel
> tree and see your RAM quickly filled with cache.
>
>> However, there is no swapping yet, and nothing unusual in the log.
>> Here are /proc/meminfo:
>> MemTotal:      1035956 kB
>> Buffers:        181044 kB
>
>I'm not sure. Maybe this is a bit high. Other values look ok.
>
>> and /proc/slabinfo:
>> slabinfo - version: 2.0
>> # name            <active_objs> <num_objs> <objsize> <objperslab>
>> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> :
>> slabdata <active_slabs> <num_slabs> <sharedavail>
>>
>> Note the size-64, dentry_cache and ext3_inode_cache lines
>
>Yes, dentry_cache and ext3_inode_cache are filesystem cache.
>So far, nothing looks wrong.
>
>> Now if I can remember that shell line to check /proc/fs/ext3
>> for dups:
>
>Sorry, I am all-reiserfs now. ;]

I believe it was Viro that sent me a patch that instrumented
the inode handling of ext3.  This is the results of that,
otherwise /proc/fs/ext3 doesn't exist.

>> [root@coyote linux-2.6.8-rc4]# grep ' 2 ' /ext3-allocs
>>       2 3:8:8227974:100644
>>       2 3:8:8227973:100644
>>       2 3:8:8227972:100644
>>       2 3:8:8227971:100644
>>       2 3:8:8193936:100644
>>       2 3:8:8193935:100644
>>       2 3:8:8193934:100644
>>       2 3:8:8193738:100644
>>       2 3:8:7834144:100644
>>       2 3:8:7834143:100644
>>       2 3:8:7684604:100644
>>       2 3:8:7521425:100644
>>       2 3:8:7521411:100644
>>       2 3:8:6360398:40755
>>       2 3:8:6013120:40755
>>       2 3:8:6013101:40755
>>       2 3:8:5982111:40755
>>       2 3:8:5982098:40755
>>       2 3:8:5982088:40775
>>       2 3:8:5949697:40777
>>       2 3:8:5949683:40777
>>       2 3:8:5947892:42755
>>       2 3:8:5947890:42755
>>       2 3:8:5915386:42755
>>       2 3:8:5915379:42755
>>       2 3:8:5901299:42755
>>       2 3:8:5901289:42755
>>       2 3:8:5835169:42777
>>       2 3:8:5835162:40755
>>       2 3:8:5835159:40755
>>       2 3:8:1250790:100644
>>       2 3:8:1250789:100644

The first ' 2 ' represents an error in that only one process
should have allocated that block of ram _1_ time only for 
that particular inode.  This could, but hasn't yet that I know of,
lead to disk corruption I'm sure.  These are the most thoroughly
e2fsck'd drives on the planet I'd think.  Somewhat more than
an average of once daily now for several weeks.  I'd also bet
a cold one that if I typed reboot, I would end up having to use
the reset button to finish the job at some point, its a 75% sure
thing.

And, wonder of wonders, this list has self-shortened!:  And still
no Oops either.  The number of leading 2's had gone down the next
time I ran that line.  I'd taken a shower between runs but didn't 
know it would clean this up too :-)

Then reading up on grep, I used this command line the next time:

#>cat /proc/fs/ext3|sort|uniq -c|sort -nr|grep -v ' 1 ' >/ext3-allocs-bad;cat /ext3-allocs-bad

and got this, a much shorter list:
      2 3:8:8405754:40775
      2 3:8:7850178:100644
      2 3:8:7816153:100644
      2 3:8:7816152:100644
      2 3:8:7803727:100644
      2 3:8:7803726:100644
      2 3:8:7803033:100644
      2 3:8:7684502:100644
      2 3:8:7407284:100644

But I still don't know enough about this to point any fingers
at anything.

[... old list]

>> So now we have an odor of a problem, the question is what does
>> it smell like?  What can I do next to shine a light on this?

Questions still valid IMO.

>--
>vda

-- 
Cheers & thanks Denis, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
