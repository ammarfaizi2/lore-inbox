Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbVLVH4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbVLVH4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 02:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbVLVH4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 02:56:18 -0500
Received: from smtp101.plus.mail.mud.yahoo.com ([68.142.206.234]:39251 "HELO
	smtp101.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965058AbVLVH4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 02:56:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cVYEwRwYT5i07PEqBjD7H/W1h4gx1FcjcQgboeIQwNsbfi3djnB3bv3YC2jCSBh5qGNwhV5hGGpkD2nrSsLVLGe321xm0kXERzQSsVUT1A7geYx0iLGNjzJG8d168MD676xhioPTTHIom6AFqiQRs2ByZP5M8gyvdbyeORrUNKw=  ;
Message-ID: <43AA5C15.8060907@yahoo.com.au>
Date: Thu, 22 Dec 2005 18:56:05 +1100
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
References: <20051221155411.GA7243@elte.hu> <yq0irtiuxvv.fsf@jaguar.mkp.net> <43AA1134.7090704@yahoo.com.au> <20051222071940.GA16804@elte.hu>
In-Reply-To: <20051222071940.GA16804@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>It would be nice to first do a run with a fair implementation of 
>>mutexes.
> 
> 
> which fairness implementation do you mean - the one where all tasks will 
> get the lock in fair FIFO order, and a 'lucky bastard' cannot steal the 
> lock from waiters and thus put them at an indefinite disadvantage?
> 

I guess so. I'm not so worried about the rare 'lucky bastard' ie. a
lock request coming in concurrently, but rather the naturally favoured
'this CPU' taking the lock again after waking up the head waiter but
before it gets a chance to run / transfer the cacheline.

At the very least, the head waiter should not put itself on the end of
the FIFO when it finds the lock contended and waits again.

But yes, also interesting would be performance of the _completely_ FIFO
implementation.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
