Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbUAFCwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 21:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUAFCwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 21:52:19 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:17117 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265493AbUAFCwQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 21:52:16 -0500
Message-ID: <3FFA2289.6060803@cyberone.com.au>
Date: Tue, 06 Jan 2004 13:50:49 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: Con Kolivas <kernel@kolivas.org>,
       Tim Connors <tconnors+linuxkernel1073186591@astro.swin.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>	<200401041242.47410.kernel@kolivas.org>	<slrn-0.9.7.4-25573-3125-200401041423-tc@hexane.ssi.swin.edu.au>	<200401041658.57796.kernel@kolivas.org> <m2ptdxq3vf.fsf@telia.com>	<3FFA1149.5030009@cyberone.com.au> <m2ekudq080.fsf@telia.com>
In-Reply-To: <m2ekudq080.fsf@telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Osterlund wrote:

>Nick Piggin <piggin@cyberone.com.au> writes:
>
>
>>Peter Osterlund wrote:
>>
>>
>>>But the scheduler is also far from fair in this situation. If I run
>>>
>>snip a good analysis...
>>
>>... but fairness is not about a set of numbers the scheduler gives to
>>each process, its about the amount of CPU time processes are given.
>>
>>In this case I don't know if I find it objectionable that X and xterm
>>are considered interactive and perl considered a CPU hog. What is the
>>actual problem?
>>
>
>The problem is that if perl would get only slightly more cpu time, it
>would get ahead of xterm, which would make this test case run
>something like 10 times faster than it currently does. (Because xterm
>switches to jump scrolling when it can't keep up.)
>
>I guess it would be possible to fix this by introducing a
>usleep(10000) at some strategic place in the xterm source code, but I
>still find it strange that two tasks eating 40% cpu time each are
>considered interactive, while a task eating 4% is considered a cpu
>hog, especially since the 4% task never got a chance to prove that it
>didn't want to steal all cpu time. All that was proven was that it
>wanted more than 4% of the cpu.
>
>Also, while my test case runs, other tasks (such as running "ps" from
>a network login) are very slow, at least until the extra load makes
>the scheduler realize that the two tasks eating most of the cpu time
>should not have maximum priority bonus.
>

OK yeah you are right. I perl should get more CPU time if it wants it.


