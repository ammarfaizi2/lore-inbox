Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbUCLTH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUCLTH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:07:58 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:20365 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262412AbUCLTG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:06:57 -0500
Message-ID: <40520B86.50803@tmr.com>
Date: Fri, 12 Mar 2004 14:12:06 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
References: <404FACF4.3030601@cyberone.com.au> <200403111825.22674@WOLK> <40517E47.3010909@cyberone.com.au> <20040312012703.69f2bb9b.akpm@osdl.org> <pan.2004.03.12.11.08.02.700169@smurf.noris.de> <4051B0C6.2070302@cyberone.com.au>
In-Reply-To: <4051B0C6.2070302@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Matthias Urlichs wrote:
> 
>> Hi, Andrew Morton wrote:
>>
>>
>>> That effect is to cause the whole world to be swapped out when people
>>> return to their machines in the morning.
>>>
>>
>> The correct solution to this problem is "suspend-to-disk" --
>> if the machine isn't doing anything anyway, TURN IT OFF.
>>
>>
> 
> Without arguing that point, the VM also should have a solution
> to the problem where people don't turn it off.
> 
>> One slightly more practical solution from the "you-now-who gets angry
>> mails" POV anyway, would be to tie the reduced-rate scanning to the load
>> average -- if nothing at all happens, swap-out doesn't need to happen
>> either.
>>
>>
> 
> Well if nothing at all happens we don't swap out, but when something
> is happening, desktop users don't want any of their programs to be
> swapped out no matter how long they have been sitting idle. They don't
> want to wait 10 seconds to page something in even if it means they're
> waiting an extra 10 minutes throughout the day for their kernel greps
> and diffs to finish.

I have noticed that 2.6 seems to clear memory (any version I've run for 
a while) and a lunch break results in a burst of disk activity before 
the screen saver even gets in to unlock the screen. I know this box has 
no cron activity during the day, so the pages were not forced out.

It's a good thing IMHO to write dirty pages to swap so the space can be 
reclaimed if needed, but shouldn't the page be marked as clean and left 
in memory for use without swap-in nif it's needed? I see this on backup 
servers, and a machine with 3GB of free memory, no mail, no cron and no 
app running isn't getting much memory pressure ;-)

I am not saying the behaviour is wrong, I just fail to see why the last 
application run isn't still in memory an hour later, absent memory pressure.

-- 
		-bill
