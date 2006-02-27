Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751716AbWB0WRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbWB0WRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWB0WRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:17:34 -0500
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.201]:15837 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751694AbWB0WRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:17:34 -0500
Date: Mon, 27 Feb 2006 17:16:47 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch 6/7] Swapin page fault delays
In-reply-to: <1141029030.2992.63.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Message-id: <44037A4F.5000107@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <1141026996.5785.38.camel@elinux04.optonline.net>
 <1141028549.5785.67.camel@elinux04.optonline.net>
 <1141029030.2992.63.camel@laptopd505.fenrus.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Mon, 2006-02-27 at 03:22 -0500, Shailabh Nagar wrote:
>  
>
>>delayacct-swapin.patch
>>
>>Record time spent by a task waiting for its pages to be swapped in.
>>This statistic can help in adjusting the rss limits of 
>>tasks (process), especially relative to each other, when the system is 
>>under memory pressure.
>>    
>>
>
>
>ok this poses a question: how do you deal with nested timings? 
>
I don't :-(
An earlier version used local variables instead of one within the 
task_delay_info
struct but we moved to using a var within to save on stack space in 
critical paths.

>Say an
>O_SYC write which internally causes a pagefault?
>  
>
And here we hit the problem of nesting being needed....so....

>delayacct_timestamp_start() at minimum has to get event-type specific,
>or even implement a stack of some sorts.
>  
>
Would keeping the timespec vars on the stacks of the functions being 
accounted be too
expensive vs. keeping bunches of vars within task_delay_info to deal 
with the nesting ?

Unfortunately, the need for accuracy also means the variables needed are 
timespecs and
not something smaller.

--Shailabh

