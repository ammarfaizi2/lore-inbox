Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTLTXPs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 18:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbTLTXPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 18:15:48 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:34439 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261796AbTLTXPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 18:15:46 -0500
Message-ID: <3FE4D81E.2050708@cyberone.com.au>
Date: Sun, 21 Dec 2003 10:15:42 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] 2.6.0 fix preempt ctx switch accounting
References: <3FE46885.2030905@cyberone.com.au> <20031220192238.GA30970@elte.hu> <Pine.LNX.4.58.0312201140320.29271@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312201140320.29271@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

>On Sat, 20 Dec 2003, Ingo Molnar wrote:
>  
>
>>i'd prefer the much simpler patch below. This also keeps the kernel
>>preemption logic isolated instead of mixing it into the normal path.
>>    
>>
>
>That patch still gets several cases wrong: we don't update any counters at
>all for the case where we were TASK_INTERRUPTIBLE and we got made
>TASK_RUNNING because of having a signal pending.
>
>Also, we shouldn't update the context switch counter just because we 
>entered the scheduler. If we don't actually end up switching to anything 
>else, it shouldn't count as a context switch.
>
>So how about something like this?
>
>Totally untested. Comments?
>  
>

Thats about as good as you'll get it, I think.


