Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUKICXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUKICXs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 21:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUKICXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 21:23:48 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:60106 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261234AbUKICXd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 21:23:33 -0500
Message-ID: <419029D9.90506@cyberone.com.au>
Date: Tue, 09 Nov 2004 13:22:17 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable
 braindamage
References: <20041105200118.GA20321@logos.cnet> <20041108162731.GE2336@logos.cnet> <20041108185546.GA3468@logos.cnet>
In-Reply-To: <20041108185546.GA3468@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti wrote:

>On Mon, Nov 08, 2004 at 02:27:31PM -0200, Marcelo Tosatti wrote:
>
>>On Fri, Nov 05, 2004 at 06:01:18PM -0200, Marcelo Tosatti wrote:
>>
>>
>>>While doing this, I noticed that kswapd will happily go to sleep 
>>>if all zones have all_unreclaimable set. I bet this is the reason 
>>>for the page allocation failures we are seeing. So the patch 
>>>also makes balance_pgdat() NOT return and go to "loop_again" 
>>>instead in case of page shortage - even if all_unreclaimable is set.
>>>
>>>Basically the "loop_again" logic IS NOT WORKING! 
>>>
>>Wrong, the loop_again logic is working, all_zones_ok will be
>>set when DEF_PRIORITY = 0. 
>>
>
>I meant priority=DEF_PRIORITY. 
>
>

Yep

>>So the page allocation failures are happening for some other 
>>reason(s).
>>

Pre alloc_pages / kswapd shakeup, the watermark stuff had been pretty
broken. For example, allocations would wakeup kswapd at the *same*
watermark as they would start synchronous reclaim (or fail in the case
of !wait allocations).

Why there have been apparently more reports of allocation failures
since those patches is a mystery to me. I've looked but can't find
anything to explain it. Perhaps the initial watermark calculation had
been changed slightly? I'm not sure... it could also be just be a fluke
due to chaotic effects in the mm, I suppose :|

