Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWCaD1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWCaD1G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWCaD1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:27:06 -0500
Received: from mail.tmr.com ([64.65.253.246]:56997 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1751211AbWCaD1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:27:05 -0500
Message-ID: <442CA294.7010902@tmr.com>
Date: Thu, 30 Mar 2006 22:31:32 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peterc@gelato.unsw.edu.au>
CC: Ram Gupta <ram.gupta5@gmail.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: RSS Limit implementation issue
References: <728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com>	<1139526447.6692.7.camel@localhost.localdomain>	<728201270603230855l11faeb6ah33ee88568843068f@mail.gmail.com>	<442AEB3A.9030503@tmr.com> <17452.39743.625417.599298@wombat.chubb.wattle.id.au>
In-Reply-To: <17452.39743.625417.599298@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:

>>>>>>"Bill" == Bill Davidsen <davidsen@tmr.com> writes:
>>>>>>            
>>>>>>
>
>Bill> Ram Gupta wrote:
>
>Bill> If you want to make rss a hard limit the result should be
>Bill> swapping, not failure to run. I'm not sure the limit in that
>Bill> form is a good idea, and before someone reminds me, I do
>Bill> remember liking it better a few years ago.
>
>Bill> If you can come up with a better way to adjust rss to get better
>Bill> overall greater throughput while being fair to all processes, go
>Bill> to it. But in general these things are a tradeoff, like
>Bill> swappiness, you tune until the volume of complaints reaches a
>Bill> minimum.
>
>What I did in one experiment was to:
>     1.  delay swapin requests if the process was over its rsslimit,
>         until it fell below, and
>     2.  Poke the swapper to try to swap out the current process's
>         pages in that case.
>
>The problem with the approach is that it behaved poorly under memory
>pressure.  If a process's optimum working set was larger than its RSS
>limit, then either it was delayed to the point of glaciality, or it
>could saturate the swap device (and so disturb other processes's
>operation). 
>
>  
>
I'm paying close attention, but that's kind of the problem people have, 
memory pressure gets high and the processes don't run. I thought of 
"swap out two to swap in one" as a way to dribble the rss down, but I 
doubt it's a magic solution. Swap kills, so does not swap and no memory. 
Obvious solution is to make the rss limit hard and keep it small, I 
don't think that's the answer.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

