Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbTLKPbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265116AbTLKPbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:31:51 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:22251 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265089AbTLKPbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:31:49 -0500
Message-ID: <3FD88D93.3000909@cyberone.com.au>
Date: Fri, 12 Dec 2003 02:30:27 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
References: <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD81BA4.8070602@cyberone.com.au> <3FD8317B.4060207@cyberone.com.au> <20031211115222.GC8039@holomorphy.com> <3FD86C70.5000408@cyberone.com.au> <20031211132301.GD8039@holomorphy.com> <3FD8715F.9070304@cyberone.com.au> <20031211133207.GE8039@holomorphy.com>
In-Reply-To: <20031211133207.GE8039@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>William Lee Irwin III wrote:
>
>>>It will get contention anyway if they're all pounding on the same futex.
>>>OTOH, if they're all threads in the same process, they can hit other
>>>problems. I'll try to find out more about hackbench.
>>>
>
>
>On Fri, Dec 12, 2003 at 12:30:07AM +1100, Nick Piggin wrote:
>
>>Oh, sorry I was talking about volanomark. hackbench AFAIK doesn't use
>>futexes at all, just pipes, and is not threaded at all, so it looks like
>>a different problem to the volanomark one.
>>hackbench runs into trouble at large numbers of tasks too though.
>>
>
>Volano is all one process address space so it could be ->page_table_lock;
>any chance you could find which spin_lock() call the pounded chunk of the
>lock section jumps back to?
>
>

OK its in futex_wait, up_read(&current->mm->mmap_sem) right after
out_release_sem (line 517).

So you get half points. Looks like its waiting on the bus rather than
spinning on a lock. Or am I'm wrong?


