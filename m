Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbVLVIhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbVLVIhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 03:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVLVIhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 03:37:54 -0500
Received: from smtp104.plus.mail.mud.yahoo.com ([68.142.206.237]:53077 "HELO
	smtp104.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965135AbVLVIhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 03:37:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=WAL4/8lCq55t5V4UOeR+sReQ6eyraiqE0rUDMvSXJCYXvTQ7jVBoj8g8SDu7XgL8blwIm9qGN/bwVGvQsQK+WoHDjFv85I6z1AhwnCZgmdIaxYToVf6KvzOrh7LaRhOUWamQI7mCqpJyl9E/S4z0Q6R8oc6s0gbUN6wk+xglU6Y=  ;
Message-ID: <43AA65DA.6060003@yahoo.com.au>
Date: Thu, 22 Dec 2005 19:37:46 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Jes Sorensen <jes@trained-monkey.org>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/8] mutex subsystem, ANNOUNCE
References: <20051221155411.GA7243@elte.hu> <yq0irtiuxvv.fsf@jaguar.mkp.net> <43AA1134.7090704@yahoo.com.au> <20051222071940.GA16804@elte.hu> <43AA5C15.8060907@yahoo.com.au> <20051222082406.GA32052@elte.hu>
In-Reply-To: <20051222082406.GA32052@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>At the very least, the head waiter should not put itself on the end of 
>>the FIFO when it finds the lock contended and waits again.
> 
> 
> It's on my list. I had this implemented a couple of days ago, but then 
> profiled it and it turns out that the scenario isnt actually happening 
> in any significant way, not even on the most extreme 512-task workloads.  
> So i just removed the extra bloat. But i'll look at this again today, 
> together with some 'max delay' statistics.
> 

That would be good.

If it isn't happening in a significant quantity, then something else
must be responsible for the performance increase. Arjan guesses the
double wakeups which could be the case, but I'd still put my money
on this issue (or maybe it is a combination of both).

Either way it would be good to work out where the performance is
coming from, and I do think fixing this is a good idea for fairness
(even though it may not technically improve deterministic max
latencies because there are still race windows)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
