Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbULTX5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbULTX5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbULTXy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:54:56 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:25430 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261678AbULTXvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:51:54 -0500
Message-ID: <41C76591.2060903@yahoo.com.au>
Date: Tue, 21 Dec 2004 10:51:45 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Hideo AOKI <aoki@sdl.hitachi.co.jp>
CC: Andrew Morton <akpm@osdl.org>, lista4@comhem.se,
       linux-kernel@vger.kernel.org, mr@ramendik.ru, kernel@kolivas.org,
       riel@redhat.com
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
References: <1329986.1103525472726.JavaMail.tomcat@pne-ps1-sn1> <20041219231250.457deb12.akpm@osdl.org> <41C682F1.20200@yahoo.com.au> <41C710BB.9000705@sdl.hitachi.co.jp>
In-Reply-To: <41C710BB.9000705@sdl.hitachi.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hideo AOKI wrote:
> Nick Piggin wrote:
> 
> 
>>Andrew Morton wrote:
> 
> [snip]
> 
>>>Did anyone come up with a simple step-by-step procedure for 
>>>reproducing the
>>>problem?  It would be good if someone could do this, because I don't 
>>>think
>>>we understand the root cause yet?
>>
>>I admit to generally being in the same boat as you with respect to
>>running complex userspace apps.
>>
>>However, based on this and other scattered reports, I'd say it seems
>>quite likely that token based thrashing control is the culprit. Based
>>on the cost/benefit, I wonder if we should disable TBTC by default for
>>2.6.10, rather than trying to fix it, and try again for 2.6.11?
> 
> 
> Hello,
> 
> I imagine that the issue might occur when only one process holds 
> almost all memory and has swap token too long time.
> 
> However, TBTC has a good effect in my workload.  
> So, I think that it is better to keep VM tunable using TBTC.
>  
> It may be a good idea to set 0 to default swap_token_timeout 
> until we find the root cause.
> 

Yes, with Con's patch to have TBTC turned off when swap_token_timeout
is set to zero. It causes unacceptable regressions, so that is the
best way to go.

It would be great to get it fixed, but I would be worried about putting
in new patches for it now, right before 2.6.10.
