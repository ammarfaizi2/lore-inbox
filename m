Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272437AbTHEFM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 01:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272438AbTHEFM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 01:12:59 -0400
Received: from anumail5.anu.edu.au ([150.203.2.45]:24013 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S272437AbTHEFM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 01:12:57 -0400
Message-ID: <3F2F3CC6.2060307@cyberone.com.au>
Date: Tue, 05 Aug 2003 15:12:38 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.2.1) Gecko/20021217
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <200308051220.04779.kernel@kolivas.org> <3F2F149F.1020201@cyberone.com.au> <200308051318.47464.kernel@kolivas.org> <3F2F2517.7080507@cyberone.com.au> <1060059844.3f2f3ac46e2f2@kolivas.org>
In-Reply-To: <1060059844.3f2f3ac46e2f2@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-2.8)
X-Spam-Tests: DATE_IN_PAST_06_12,EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,SPAM_PHRASE_00_01,USER_AGENT,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>Quoting Nick Piggin <piggin@cyberone.com.au>:
>
>
>>
>>Con Kolivas wrote:
>>
>>
>>>On Tue, 5 Aug 2003 12:21, Nick Piggin wrote:
>>>
>>>
>>>>No, this still special-cases the uninterruptible sleep. Why is this
>>>>needed? What is being worked around? There is probably a way to
>>>>attack the cause of the problem.
>>>>
>>>>
>>>Footnote: I was thinking of using this to also _elevate_ the dynamic
>>>
>>priority 
>>
>>>of tasks waking from interruptible sleep as well which may help throughput.
>>>
>>>
>>Con, an uninterruptible sleep is one which is not be woken by a signal,
>>an interruptible sleep is one which is. There is no other connotation.
>>What happens when read/write syscalls are changed to be interruptible?
>>I'm not saying this will happen... but come to think of it, NFS probably
>>has interruptible read/write.
>>
>>In short: make the same policy for an interruptible and an uninterruptible
>>sleep.
>>
>
>That's the policy that has always existed...
>
>Interesting that I have only seen the desired effect and haven't noticed any 
>side effect from this change so far. I'll keep experimenting as much as 
>possible (as if I wasn't going to) and see what the testers find as well.
>

Oh, I'm not saying that your change is outright wrong, on the contrary I'd
say you have a better feel for what is needed than I do, but if you are 
finding
that the uninterruptible sleep case needs some tweaking then the same tweak
should be applied to all sleep cases. If there really is a difference, 
then its
just a fluke that the sleep paths in question use the type of sleep you are
testing for, and nothing more profound than that.


