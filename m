Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264164AbUFCOOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUFCOOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUFCOOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:14:49 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:27777 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S264164AbUFCOO3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:14:29 -0400
Message-ID: <40BF3250.9040901@tmr.com>
Date: Thu, 03 Jun 2004 10:14:40 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: FabF <fabian.frederick@skynet.be>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <E1BVIVG-0003wL-00@calista.eckenfels.6bone.ka-ip.net> <1086154721.2275.2.camel@localhost.localdomain> <200406022142.52854.kernel@kolivas.org>
In-Reply-To: <200406022142.52854.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wed, 2 Jun 2004 15:38, FabF wrote:
> 
>>On Wed, 2004-06-02 at 01:17, Bernd Eckenfels wrote:
>>
>>>In article <200406012000.i51K0vor019011@turing-police.cc.vt.edu> you 
> 
> wrote:
> 
>>>>out (unlike some, I don't mind if Mozilla or OpenOffice end up out on
>>>>disk after extended inactivity - but if my window manager gets swapped
>>>>out, I get peeved when focus-follows-mouse doesn't and my typing goes
>>>>into the wrong window or some such... ;)
>>>
>>>Yes but: your wm is so  often used/activated it will not get swaped  out.
>>>But if your mouse passes over mozilla and tries to focus it, then you
>>>will feel the pain of a swapped-out x program.
>>
>>Exactly !
>>Does autoregulated VM swap. patch could help here ?
> 
> 
> Unless you are pushing the limits of your available ram by your usage pattern 
> then yes the autoregulated swappiness patch should help.
> 
> available here:
> http://ck.kolivas.org/patches/2.6/2.6.7-rc2/patch-2.6.7-rc2-am11
> 
> Just a brief word that might clarify things for people. It seems this huge 
> swap discussion centres around 2 different arguments. Akpm has said that the 
> correct way for the vm to behave is that of swappiness=100. Desktop users 
> note they have less swap out of the programs they use with swappiness 0 or 
> their swap turned off. When your swappiness is set high, the current vm 
> decisions are the fastest they can be, but when you go back to your 
> applications they will take longer to restart. When your swappiness is set 
> low your applications will restart rapidly, but the current vm will be doing 
> more work and be slower. Most benchmarks will show the latter, but most 
> desktop users will feel the former and not really notice the latter.
> 
> Try the little experiment to see: Boot with mem=128M and try to compile a 2.6 
> kernel with all the debugging symbols option enabled - do this with 
> swappiness set to 0 and then at 100. You'll see it compile much faster at 
> 100. Yet you know that if you set your swappiness to 0 mozilla will load 
> faster next time you use it on your desktop during your normal usage pattern 
> (of course you'd probably be using mozilla on a system with a bit more than 
> 128M ram but this helps demonstrate the point). 
> 
> Does this explain in coarse examples to the desktop users why ideal systems 
> shouldn't be swap disabled or swappiness=0 ?
> 
> The autoregulated swappiness patch tries to get some sort of common ground, 
> where it sacrifices performance slightly currently to improve what happens 
> the next time you use your machine substantially. Because it changes with the 
> amount of application pages in ram, it will not increasingly sacrifice 
> performance when your memory is full with application pages. What it will not 
> do is improve the swap thrash situation when you have grossly overloaded your 
> ram.

But swap behaviour kills performance even when memory is more than 
adequate. Consider building a DVD image in a 4GB system. The i/o forces 
all of the unused programs out, in spite of the fact that an extra 100MB 
doesn't make a measurable difference in performance. But when I click 
Mozilla paging most of it in from disk make a big difference in 
performance to the user.

My perception is that the system is really bad at recognizing 
diminishing returns to be had by paging programs for the benefit of i/o. 
Not to mention what happens if you get 2-3GB of dirty buffers and then 
do a sync(). In practice my little RAID array will take at most 40MB/s, 
so the creation of a DVD runs fast, but the system bogs right after.

The problems with small memory are different in kind, when not even the 
programs will fit in memory at the same time, or will leave next to 
nothing for i/o, swap is required for performance. But on a large memory 
system I believe the gain to pain ratio is way too low with the current 
VM. The solution at the moment is to turn off swap, which as you note 
has other problems (can't move between zones without swap?) which in 
theory could really hang a system.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
