Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTKJOnT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 09:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbTKJOnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 09:43:19 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:28570 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263866AbTKJOnR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 09:43:17 -0500
Message-ID: <3FAFA401.5080404@cyberone.com.au>
Date: Tue, 11 Nov 2003 01:43:13 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH] cfq-prio #2
References: <20031110140052.GC32637@suse.de> <3FAF9DAE.3070307@cyberone.com.au> <20031110142302.GF32637@suse.de> <3FAFA1E8.8080800@cyberone.com.au> <20031110143939.GJ32637@suse.de>
In-Reply-To: <20031110143939.GJ32637@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jens Axboe wrote:

>On Tue, Nov 11 2003, Nick Piggin wrote:
>
>>
>>You acked the change actually :P
>>I guess it was done in mainline when AS was merged.
>>
>
>Probably missed the semantic change of may_queue.
>

Anyway I won't bother digging up the email, its been done now.

>
>>>>Maybe my version should be called elv_force_queue?
>>>>
>>>>
>>>I just hate to see more of these, really. The original idea for
>>>may_queue was just that, may this process queue io or not. We can make
>>>it return something else, though, to indicate whether the process must
>>>be able to queue. Is it really needed?
>>>
>>>
>>Its quite important. If the queue is full, and AS is waiting for a process
>>to submit a request, its got a long wait.
>>
>>Maybe a lower limit for per process nr_requests. Ie. you may queue if this
>>queue has less than 128 requests _or_ you have less than 8 requests
>>outstanding. This would solve my problem. It would also give you a much more
>>appropriate scaling for server workloads, I think. Still, thats quite a
>>change in behaviour (simple to code though).
>>
>
>That basically belongs inside your may_queue for the io scheduler, imo.
>

You can force it to disallow the request, but you can't force it to allow
one (depending on a successful memory allocation, of course).


