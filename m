Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUCMABW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 19:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUCMABW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 19:01:22 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:29853 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262347AbUCMABU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 19:01:20 -0500
Message-ID: <40524CDC.8020101@cyberone.com.au>
Date: Sat, 13 Mar 2004 10:50:52 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
References: <404FACF4.3030601@cyberone.com.au> <200403111825.22674@WOLK> <40517E47.3010909@cyberone.com.au> <20040312012703.69f2bb9b.akpm@osdl.org> <pan.2004.03.12.11.08.02.700169@smurf.noris.de> <4051B0C6.2070302@cyberone.com.au> <40520B86.50803@tmr.com>
In-Reply-To: <40520B86.50803@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bill Davidsen wrote:

>
> I have noticed that 2.6 seems to clear memory (any version I've run 
> for a while) and a lunch break results in a burst of disk activity 
> before the screen saver even gets in to unlock the screen. I know this 
> box has no cron activity during the day, so the pages were not forced 
> out.
>


It shouldn't. Perhaps something else is using memory in the background?


> It's a good thing IMHO to write dirty pages to swap so the space can 
> be reclaimed if needed, but shouldn't the page be marked as clean and 
> left in memory for use without swap-in nif it's needed? I see this on 
> backup servers, and a machine with 3GB of free memory, no mail, no 
> cron and no app running isn't getting much memory pressure ;-)
>

Well it is basically just written out and reclaimed when it is needed,
it won't just be swapped out without memory pressure.

Although, there were some highmem balancing problems in 2.6 including
2.6.4 (now fixed in -bk). This causes too much pressure to be put on
ZONE_NORMAL mapped and file cache memory in favour of slab cache. This
could easily be causing the misbehaviour.

> I am not saying the behaviour is wrong, I just fail to see why the 
> last application run isn't still in memory an hour later, absent 
> memory pressure.
>

There would have to be *some* memory pressure... honestly, try 2.6-bk,
or if they are production machines and you can't, then wait for 2.6.5.


