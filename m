Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271586AbRHQUjJ>; Fri, 17 Aug 2001 16:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271559AbRHQUi7>; Fri, 17 Aug 2001 16:38:59 -0400
Received: from mail.erisksecurity.com ([208.179.59.234]:58194 "EHLO
	Tidal.eRiskSecurity.com") by vger.kernel.org with ESMTP
	id <S271584AbRHQUil>; Fri, 17 Aug 2001 16:38:41 -0400
Message-ID: <3B7D80CE.1070303@blue-labs.org>
Date: Fri, 17 Aug 2001 16:38:38 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010815
X-Accept-Language: en-us
MIME-Version: 1.0
To: klink@clouddancer.com
CC: linux-kernel@vger.kernel.org
Subject: Re: "VM watchdog"? [was Re: VM nuisance]
In-Reply-To: <3B748AA8.4010105@blue-labs.org>    <20010814140011.B38@toy.ucw.cz> <20010817002420.C30521@unthought.net> <3B7C72CE.60601@blue-labs.org> <9li6sf$h5$1@ns1.clouddancer.com> <20010817090440.4A63B783F6@mail.clouddancer.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>>The kernel allocates memory within itself.  We will still reach OOM 
>>conditions.  It can't be avoided.
>>
>
>That doesn't sound good.
>
>What bugs me about this statement was that until 2.4, I never had
>lockups.  I sometimes had a LOT of swapping and slow response, but I
>also knew that running a complex numeric simulation when RAM <
>'program needs' does that.  I accepted it and tended to arrange such
>runs in my absence.  Now I find that I get some process nuked (or
>worse - partially nuked) even after increasing to 4x swap and
>eliminating lazy habits that would leave some idle process up for a
>few days in case I needed it again (worked fine in 2.0.36).  There are
>_alot_ of good things in 2.4, but sometimes....
>
>
>Does your statement imply that a machine left "alone" must eventually
>OOM given enough runtime??  It seems that it must.
>

Nope, not at all.  The kernel acquires and releases memory as it goes. 
 My statement is to the fact that we can reach a point where we have 
exhausted all the memory resources by the time we start a particular 
code path but in order to complete that code path we need more memory. 
 I.e. journaled filesystems.  We have reached 0 memory but we need to 
start down a code path to update data on the disk.  That means we may 
have to allocate memory to read and update the journal as we start 
writing regular file data to disk.

This only occurs when we ride right on the very edge of OOM.  This will 
also be fixed when we implement all the desired bean counting.

David


