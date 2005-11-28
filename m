Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVK1UFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVK1UFK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVK1UFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:05:10 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:48650 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932225AbVK1UFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:05:08 -0500
Message-ID: <438B62F3.4070801@vmware.com>
Date: Mon, 28 Nov 2005 12:05:07 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org> <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org> <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org> <438B600C.1050604@tmr.com>
In-Reply-To: <438B600C.1050604@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Nov 2005 20:05:06.0875 (UTC) FILETIME=[071F48B0:01C5F457]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Linus Torvalds wrote:
>
>>
>> In contrast, the simple silicon support scales wonderfully well. 
>> Suddenly libraries can be thread-safe _and_ efficient on UP too. You 
>> get to eat your cake and have it too.
>
>
> I believe that a hardware solution would also accomodate the case 
> where a program runs unthreaded for most of the processing, and only 
> starts threads to do the final stage "report generation" tasks, where 
> that makes sense. I don't believe that it helps in the case where init 
> uses threads and then reverts to a single thread for the balance of 
> the task. I can't think of anything which does that, so it's probably 
> a non-critical corner case, or something the thread library could 
> correct.


Startup routine of a scientific app calls a multithreaded "fetch work" 
routine, then crunches the data using a single thread.  This could even 
happen somewhere inside a library, so the application itself is unaware 
that threads were ever invoked.  This is not a far-fetched case.

You really need per-address object notions of "threadedness" when 
talking about shared memory, since you may need shared memory to be 
atomic, but operate on the heap in single threaded fashion.

Zach
