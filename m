Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310757AbSCHJWD>; Fri, 8 Mar 2002 04:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310758AbSCHJVy>; Fri, 8 Mar 2002 04:21:54 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:14605 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S310757AbSCHJVt>; Fri, 8 Mar 2002 04:21:49 -0500
Message-ID: <3C888284.8030206@loewe-komp.de>
Date: Fri, 08 Mar 2002 10:21:08 +0100
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: frankeh@watson.ibm.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: furwocks: Fast Userspace Read/Write Locks
In-Reply-To: <E16j95K-00047G-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> In message <20020307153228.3A6773FE06@smtp.linux.ibm.com> you write:
> 
>>On Thursday 07 March 2002 07:50 am, Arjan van de Ven wrote:
>>
>>>Rusty Russell wrote:
>>>
>>>>This is a userspace implementation of rwlocks on top of futexes.
>>>>
>>>question: if rwlocks aren't actually slower in the fast path than
>>>futexes,
>>>would it make sense to only do the rw variant and in some userspace
>>>layer
>>>map "traditional" semaphores to write locks ?
>>>Saves half the implementation and testing....
>>>
>>I m not in favor of that. The dominant lock will be mutexes.
>>
> 
> To clarify: I'd love this, but rwlocks in the kernel aren't even
> vaguely fair.  With a steady stream of overlapping readers, a writer
> will never get the lock.
> 
> Hope that clarifies,


But you talk about the current implementation, don't you?
Is there something to prevent an implementation of rwlocks in the
kernel, where a wrlock will lock (postponed) further rdlock requests?

I mean: the wrlocker prevents newly rdlocks to succeed and waits for the
current rdlockers to release the lock an then gets the lock..


