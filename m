Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265569AbTGHJEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 05:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbTGHJEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 05:04:42 -0400
Received: from dyn-ctb-210-9-241-186.webone.com.au ([210.9.241.186]:62218 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S265569AbTGHJEf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 05:04:35 -0400
Message-ID: <3F0A8C5C.1070602@cyberone.com.au>
Date: Tue, 08 Jul 2003 19:18:20 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
References: <20030703023714.55d13934.akpm@osdl.org> <200307080213.53203.phillips@arcor.de> <Pine.LNX.4.55.0307071724540.3524@bigblue.dev.mcafeelabs.com> <200307080307.18018.phillips@arcor.de> <Pine.LNX.4.55.0307072314490.3597@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0307072314490.3597@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Davide Libenzi wrote:

>On Tue, 8 Jul 2003, Daniel Phillips wrote:
>
>
>>1. 400ms buffers are hated by users, as was noted previously.  They are
>>passable for some applications, but way too laggy for others.
>>
>>2. Even if you are will to have a 400-500 ms buffer, if you can prove that you
>>will always meet that deadline, then it's a realtime system.
>>
>>3. If you can show logically that you will nearly always meet the deadline,
>>it's a soft realtime system.  That's what we're after here.  From a design
>>standpoint, there are elegant soft realtime systems, and there are sucky
>>ones.
>>
>>4. So how do you propose to "program timings" so that it's really hard to miss
>>those deadlines?
>>
>
>Having a backup of 400-500ms gives you an average hang-over of 200-250ms
>that are hardly noticeable by a human in this topic. The issue is not if
>you always meet the deadline, the issue is what amount of load will make
>you miss it. If I have to hire five ppl clicking and dragging on my desktop
>to make my player to skip, and it skips, I don't care if it missed the
>deadline. This because my desktop will hardly see that load. But if you
>have a 50-100ms backup, things turns out to be a little bit different.
>If you pretend to run a `make -jUNREAL` and still have the audio not
>skipping it is simply wrong. Running a `make -j20` in my machine shows an
>average of 24 TASK_RUNNING tasks, that even if they're granted with a mere
>40ms timeslice, it'll take a full second before an expired task will see
>the light again. BTW, under such load RealPlayer skips badly, but I don't
>really care since it never did while I was doing all the normal (and many
>extra) stuff I'm doing on my desktop.
>
>

I agree some people have some inflated ideas about a desktop workload,
but I'd just point out that if your mp3 player was using say 2% CPU,
it should be able to preempt the make soon after it becomes runnable,
and not have to wait at the end of the queue. It would become a CPU
hog itself if you had 48 other processes running though.


