Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVEXPWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVEXPWT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVEXPWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:22:09 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:30610 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262092AbVEXPVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:21:24 -0400
Message-ID: <4293466B.5070200@yahoo.com.au>
Date: Wed, 25 May 2005 01:21:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Voluntary Kernel Preemption, 2.6.12-rc4-mm2
References: <20050524121541.GA17049@elte.hu> <20050524132105.GA29477@elte.hu> <20050524145636.GA15943@infradead.org> <20050524150950.GA10736@elte.hu>
In-Reply-To: <20050524150950.GA10736@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Christoph Hellwig <hch@infradead.org> wrote:
> 
> 
>>I still disagree with this one violently. [...]
> 
> 
> (then you must be disagreeing with CONFIG_PREEMPT too to a certain 
> degree i guess?)
> 

CONFIG_PREEMPT is different in that it explicitly defines and
delimits preempt critical sections, and allows maximum possible
preemption (whether or not the critical sections themselves are
too big is not really a CONFIG_PREEMPT issue).

Jamming in cond_resched in as many places as possible seems to
work quite well pragmatically, but is just pretty ugly for the
reasons Christoph mentioned (IMO).

The other thing is - if the users don't care about some extra
overhead, why don't they just use CONFIG_PREEMPT? Surely the case
is not that they can tolerate .5% overhead but not 1.5% (pulling
numbers out my bum).

IIRC, the reason (when you wrote the code) was that you didn't
want to enable preempt either because of binary compatibility, or
because of bugs? Well I think the bug issue is no more since your
debug patches went in, and the compatibility reason may be a fine
one for a distro kernel, but not a kernel.org one.

> 
>>[...] If you want a cond_resched() add it where nessecary, but don't 
>>hide it behind might_sleep - there could be quite a lot might_sleeps 
>>in common codepathes and they should stay purely a debug aid.
> 
> 

[...]

> or if you think we can get away with using just a couple of 
> cond_resched()s then you are my guest to prove me wrong: take the -RT 
[...]

How about using CONFIG_PREEMPT instead?

-- 
SUSE Labs, Novell Inc.

