Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265635AbSJSR3T>; Sat, 19 Oct 2002 13:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbSJSR3T>; Sat, 19 Oct 2002 13:29:19 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:12517 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S265635AbSJSR3R>; Sat, 19 Oct 2002 13:29:17 -0400
Message-ID: <3DB19AE6.6020703@kegel.com>
Date: Sat, 19 Oct 2002 10:48:22 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: John Myers <jgmyers@netscape.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <Pine.LNX.4.44.0210181241300.1537-100000@blue1.dev.mcafeelabs.com> <3DB0AD79.30401@netscape.com> <20021019065916.GB17553@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> On Fri, Oct 18, 2002 at 05:55:21PM -0700, John Myers wrote:
> 
>>So whether or not a proposed set of epoll semantics is consistent with 
>>your Platonic ideal of "use the fd until EAGAIN" is simply not an issue. 
>>What matters is what works best in practice.
> 
> 
>>From this side of the fence: One vote for "use the fd until EAGAIN" being
> flawed. If I wanted a method of monopolizing the event loop with real time
> priorities, I would implement real time priorities within the event loop.

The choice I see is between:
1. re-arming the one-shot notification when the user gets EAGAIN
2. re-arming the one-shot notification when the user reads all the data
    that was waiting (such that the very next read would return EGAIN).

#1 is what Davide wants; I think John and Mark are arguing for #2.

I suspect that Davide would be happy with #2, but advises
programmers to read until EGAIN anyway just to make things clear.

If the programmer is smart enough to figure out how to do that without
hitting EAGAIN, that's fine.  Essentially, if he tries to get away
without getting an EAGAIN, and his program stalls because he didn't
read all the data that's available and thereby doesn't reset the
one-shot readiness event, it's his own damn fault, and he should
go back to using level-triggered techniques like classical poll()
or blocking i/o.

- Dan


