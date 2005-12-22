Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbVLVIKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbVLVIKn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 03:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVLVIKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 03:10:43 -0500
Received: from smtp105.plus.mail.mud.yahoo.com ([68.142.206.238]:40034 "HELO
	smtp105.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965119AbVLVIKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 03:10:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1WTpFN5/YMK6BoqaSPRvfhBf7GWqMSRXwshYK4yW964JFL0gtU8UaBNbvGSjLWcIX18tF8kTEWBQQmUvhsF3glmGGGSO7X1gfvQWATRqkloNupe/eSlsPFOLlaumKFB/QlmSD8VD1q8artGShiw0CenPEmbt6nyFK6YAmNm6fj8=  ;
Message-ID: <43AA5F7B.7010407@yahoo.com.au>
Date: Thu, 22 Dec 2005 19:10:35 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Jes Sorensen <jes@trained-monkey.org>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/8] mutex subsystem, ANNOUNCE
References: <20051221155411.GA7243@elte.hu> <yq0irtiuxvv.fsf@jaguar.mkp.net>	 <43AA1134.7090704@yahoo.com.au> <20051222071940.GA16804@elte.hu>	 <43AA5C15.8060907@yahoo.com.au> <1135238423.2940.1.camel@laptopd505.fenrus.org>
In-Reply-To: <1135238423.2940.1.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2005-12-22 at 18:56 +1100, Nick Piggin wrote:
> 
>>Ingo Molnar wrote:
>>
>>>* Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>>
>>>
>>>
>>>>It would be nice to first do a run with a fair implementation of 
>>>>mutexes.
>>>
>>>
>>>which fairness implementation do you mean - the one where all tasks will 
>>>get the lock in fair FIFO order, and a 'lucky bastard' cannot steal the 
>>>lock from waiters and thus put them at an indefinite disadvantage?
>>>
>>
>>I guess so. I'm not so worried about the rare 'lucky bastard' ie. a
>>lock request coming in concurrently, but rather the naturally favoured
>>'this CPU' taking the lock again after waking up the head waiter but
>>before it gets a chance to run / transfer the cacheline.
> 
> 
> that's just the most evil lucky bastard....
> 

I'd probably just call "bastard": it is probably _unlucky_ when _doesn't_
get to retake the lock, judging by the factor-of-4 speedup that Jes
demonstrated.

Which might be the right thing to do, but having the front waiter go to
the back of the queue I think is not.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
