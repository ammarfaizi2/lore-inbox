Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUCSJ6y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 04:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUCSJ6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 04:58:54 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:22982 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262332AbUCSJ6v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 04:58:51 -0500
Message-ID: <405AC456.1070806@cyberone.com.au>
Date: Fri, 19 Mar 2004 20:58:46 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [BENCHMARKS] 2.6.4 vs 2.6.4-mm1
References: <40525C1F.5030705@cyberone.com.au> <20040319095047.GA6301@elte.hu>
In-Reply-To: <20040319095047.GA6301@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>* Nick Piggin <piggin@cyberone.com.au> wrote:
>
>
>>volanomark (MPS):
>>This one starts getting huge mmap_sem contention at 150+ coming
>>from futexes. Don't know what is taking the mmap_sem for writing.
>>Maybe just brk or mmap.
>>
>
>are you sure it's down_write() contention? down_read() can create
>contention just as much, simply due to the fact that hundreds of threads
>and a dozen CPUs are pounding in on the same poor lock.
>
>

No I'm not sure actually, it could be just read lock
contention. IIRC it was all coming from the semaphore's
spinlock, in up_read...

>i do think there should be a rw-semaphore variant that is per-cpu for
>the read path. (This would also fix the 4:4 threading overhead.)
>
>

That would be interesting, yes. I have (somewhere) a patch
that wakes up the semaphore's waiters outside its spinlock.
I think that only gave about 5% or so improvement though.

