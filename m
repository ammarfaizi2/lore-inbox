Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVDOAOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVDOAOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 20:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVDOAO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 20:14:26 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:40018 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261674AbVDOANv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 20:13:51 -0400
Message-ID: <425F0735.6010407@yahoo.com.au>
Date: Fri, 15 Apr 2005 10:13:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: fix never executed code due to expression always
 false
References: <Pine.LNX.4.62.0504150140250.3466@dragon.hyggekrogen.localhost> <425F064E.8050003@yahoo.com.au> <Pine.LNX.4.62.0504150213240.3466@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0504150213240.3466@dragon.hyggekrogen.localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On Fri, 15 Apr 2005, Nick Piggin wrote:
> 
> 
>>Jesper Juhl wrote:
>>
>>>There are two expressions in kernel/sched.c that are always false since they
>>>test for <0 but the result of the expression is unsigned so they will never
>>>be less than zero. This patch implement the logic that I believe is intended
>>>without the signedness issue and without the nasty casts.
>>><disclaimer>patch is compile tested only</disclaimer>
>>>
>>This is not *quite* the intended behaviour. It is OK for prev->timestamp
>>to be '0 - a bit' and now to be '0 + a bit' in the case of wrapping.
>>
>>Although considering they're 64-bit values, I'm not sure how much we care.
>>
> 
> How do you propose to fix this then?  As the code is now the expressionsa 
> are always false - should we just remove the them?  Or do you have a 
> sensible definition of "a bit" ?  or ome other suggestion alltogether?
> 

Make it a signed comparison?

-- 
SUSE Labs, Novell Inc.

