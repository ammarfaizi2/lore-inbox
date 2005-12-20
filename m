Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVLTIDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVLTIDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVLTIDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:03:12 -0500
Received: from smtp103.plus.mail.mud.yahoo.com ([68.142.206.236]:62884 "HELO
	smtp103.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750832AbVLTIDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:03:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kbmuyYA8J8G2NOpCcMG9In+w5I1lcdb2e6vXhFInfFiJt48ETgUP29BfyjbAwMsS5Q/ye5Mi6R/ZlnKaVgCszIkTTEa9vWNXXhOAyv6SdcLSW2/fuWqISi7eYhDb8oSeXh3O9ekWZtfhB16g7HYrJ1Yt7lncXkhkr71aZIgCjhY=  ;
Message-ID: <43A7BAB5.7020201@yahoo.com.au>
Date: Tue, 20 Dec 2005 19:03:01 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu> <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org> <20051219195553.GA14155@elte.hu> <Pine.LNX.4.64.0512191203120.4827@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512191203120.4827@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> And don't get me wrong: if it's easier to just ignore the performance bug, 
> and introduce a new "struct mutex" that just doesn't have it, I'm all for 
> it. However, if so, I do NOT want to do the unnecessary renaming. "struct 
> semaphore" should stay as "struct semaphore", and we should not affect old 
> code in the _least_.
> 

It would still be good to look at a fair mutex implementation first
IMO before making a choice to use unfair mutexes.

They'll often be held for longer than spinlocks so fairness may be
more important.

> Then code can switch to "struct mutex" if people want to. And if one 
> reason for it ends up being that the code avoids a performance bug in the 
> process, all the better ;)
> 

Is this a good idea? Then we will have for a long time different
bits of code with exactly the same synchronisation requirements
using two different constructs that are slightly different. Not to
mention code specifically requiring semaphores would get confusing.

If we agree mutex is a good idea at all (and I think it is), then
wouldn't it be better to aim for a wholesale conversion rather than
"if people want to"?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
