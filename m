Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbUKJBL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUKJBL1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUKJBL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:11:27 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:42904 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261815AbUKJBLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:11:24 -0500
Message-ID: <41916AB4.20308@cyberone.com.au>
Date: Wed, 10 Nov 2004 12:11:16 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable
 braindamage
References: <20041105200118.GA20321@logos.cnet> <20041108162731.GE2336@logos.cnet> <20041108185546.GA3468@logos.cnet> <419029D9.90506@cyberone.com.au> <20041108183552.7caccad1.akpm@osdl.org> <20041109071545.GA5473@logos.cnet>
In-Reply-To: <20041109071545.GA5473@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti wrote:

>On Mon, Nov 08, 2004 at 06:35:52PM -0800, Andrew Morton wrote:
>
>>Nick Piggin <piggin@cyberone.com.au> wrote:
>>
>>>I'm not sure... it could also be just be a fluke
>>> due to chaotic effects in the mm, I suppose :|
>>>
>>2.6 scans less than 2.4 before declaring oom.  I looked at the 2.4
>>implementation and thought "whoa, that's crazy - let's reduce it and see
>>who complains".  My three-year-old memory tells me it was reduced by 2x to
>>3x.
>>
>>We need to find testcases (dammit) and do the analysis.  It could be that
>>we're simply not scanning far enough.
>>
>
>Andrew,
>
>When reading the code I was really suspicious of the all_unreclaimable code. 
>It basically stops scanning when reaching OOM conditions - that might be it.
>
>

Yeah, I saw a pretty good correlation between OOM killing and 
all_unreclaimable.

We've got some code to spit that out during an OOM kill now, so that 
might be
helpful.

>I tried to disable it (ignore it if priority==0) - result: very slow progress 
>on extreme load. 
>
>

I had a patch that caused try_to_free_pages to ignore all_unreclaimable and
go 'round the loop again if we reached oom-kill conditions. Basically that
guarantees you'll scan ~ pages_present*2 before going OOM. I think it may
be a good thing to do, but I wasn't really able to reproduce these early
OOM killings.

