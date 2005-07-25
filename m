Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVGYTB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVGYTB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVGYTB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:01:59 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:24591 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261431AbVGYTBV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:01:21 -0400
Message-ID: <42E537D1.6000100@tmr.com>
Date: Mon, 25 Jul 2005 15:04:49 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: itimer oddness in 2.6.12
References: <20050722171657.GG4311@real.com> <42E14735.1090205@grupopie.com> <20050722205825.GB6476@real.com> <42E1A208.8060408@mvista.com>
In-Reply-To: <42E1A208.8060408@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> Tom Marshall wrote:
> 
>> On Fri, Jul 22, 2005 at 08:21:25PM +0100, Paulo Marques wrote:
>>
>>> Tom Marshall wrote:
>>>
>>>> The patch to fix "setitimer timer expires too early" is causing 
>>>> issues for
>>>> the Helix server.  We have a timer processs that updates the server's
>>>> timestamp on an itimer and it expects the signal to be delivered at 
>>>> roughly
>>>> the interval retrieved from getitimer.  This is very consistent on 
>>>> every
>>>> platform, including Linux up to 2.6.11, but breaks on 2.6.12.  On 
>>>> 2.6.12,
>>>> setting the itimer to 10ms and retrieving the actual interval from 
>>>> getitimer
>>>> reports 10.998ms, but the timer interrupts are consistently 
>>>> delivered at
>>>> roughly 11.998ms.  
>>>
>>>
>>> Unfortunately, this is not so clear cut as it seems :(
> 
> 
> Oops!  That patch is wrong.  The +1 should be applied to the initial 
> interval _only_.  We KNOW when the repeating intervals start (i.e. at 
> the jiffie edge) and don't need to adjust them.  The patch, however, 
> incorrectly, rolls them all into one.  The attach patch should fix the 
> problem.  Warnning, it compiles and boots, but I have not tested it.

Can this get into 2.6.13? Or stable if it's too late? This would appear 
to be a fix to a visible problem.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

