Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbTLWBg4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 20:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbTLWBg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 20:36:56 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:10706 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264918AbTLWBgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 20:36:55 -0500
Message-ID: <3FE79C32.6050104@cyberone.com.au>
Date: Tue, 23 Dec 2003 12:36:50 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
References: <200312231138.21734.kernel@kolivas.org> <3FE79626.1060105@cyberone.com.au> <200312231224.49069.kernel@kolivas.org>
In-Reply-To: <200312231224.49069.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Tue, 23 Dec 2003 12:11, Nick Piggin wrote:
>
>>I think this patch is much too ugly to get into such an elegant scheduler.
>>No fault to you Con because its an ugly problem.
>>
>
>You're too kind. No it's ugly because of my code but it works for now.
>

Well its all the special cases for batch scheduling that I don't like,
the idea to not run batch tasks on a package running non batch processes
is sound. I thought the batch scheduling code is Ingo's, but I could
be mistaken. Anyway...

>
>>How about this: if a task is "delta" priority points below a task running
>>on another sibling, move it to that sibling (so priorities via timeslice
>>start working). I call it active unbalancing! I might be able to make it
>>fit if there is interest. Other suggestions?
>>
>
>I discussed this with Ingo and that's the sort of thing we thought of. Perhaps 
>a relative crossover of 10 dynamic priorities and an absolute crossover of 5 
>static priorities before things got queued together. This is really only 
>required for the UP HT case.
>

Well I guess it would still be nice for "SMP HT" as well. Hopefully the code
can be generic enough that it would just carry over nicely. It does have
complications though because the load balancer would have to be taught about
it, and those architectures that do hardware priorities probably don't even
want it.


