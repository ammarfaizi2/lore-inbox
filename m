Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWD1FD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWD1FD2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 01:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWD1FD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 01:03:28 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:2416 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750985AbWD1FD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 01:03:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fYWunThjA7Fz7Fm8SJI+zpPtqbCt+OzMVdQOsELCHlNvmi3jjQsNbGDI206Ygs5MaRjQejElmbadhVBnCZUWBb21/tESWs2PQ/Pt6eqN0zJjMzHyDnoL0ip2bn5SOlfZS6h99caYMuSSrSByOPVkESUx6yqnAYg1erY4ryltC40=  ;
Message-ID: <4451A163.5020304@yahoo.com.au>
Date: Fri, 28 Apr 2006 15:00:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Peterson <dsp@llnl.gov>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, riel@surriel.com,
       akpm@osdl.org
Subject: Re: [PATCH 1/2] mm: serialize OOM kill operations
References: <200604251701.31899.dsp@llnl.gov> <200604261014.15008.dsp@llnl.gov> <44503BA2.7000405@yahoo.com.au> <200604270956.15658.dsp@llnl.gov>
In-Reply-To: <200604270956.15658.dsp@llnl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson wrote:
> On Wednesday 26 April 2006 20:33, Nick Piggin wrote:
> 
>>Dave Peterson wrote:
>>
>>>If you prefer the above implementation, I can rework the patch as
>>>above.
>>
>>I think you need a semaphore?
> 
> 
> In this particular case, I think a semaphore is unnecessary because
> we just want out_of_memory() to return to its caller if an OOM kill
> is already in progress (as opposed to waiting in out_of_memory() and
> then starting a new OOM kill operation).  What I want to avoid is the

When you are holding the spinlock, you can't schedule and the lock
really should be released by the same process that took it. Are you
OK with that?

>>
>>Mainly the cost of increasing cacheline footprint. I think someone
>>suggested using a flag bit somewhere... that'd be preferable.
> 
> 
> Ok, I'll add a ->flags member to mm_struct and just use one bit for
> the oom_notify value.  Then if other users of mm_struct need flag
> bits for other things in the future they can all share ->flags.  I'll
> rework my patches and repost shortly...

mm_struct already has what you want -- dumpable:2 -- if you just put
your bit in an adjacent bitfield, you'll be right.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
