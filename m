Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267705AbTACV5w>; Fri, 3 Jan 2003 16:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267706AbTACV5w>; Fri, 3 Jan 2003 16:57:52 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:30593 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267705AbTACV5v>;
	Fri, 3 Jan 2003 16:57:51 -0500
Message-ID: <3E160948.1060008@colorfullife.com>
Date: Fri, 03 Jan 2003 23:06:00 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] extable cleanup
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On Fri, 3 Jan 2003, Rusty Russell wrote:
>>
>> Fairly straightforward consolidation of extable handling.  Sparc64 is
>> trickiest, with its extable range stuff (ideally, the ranges would be
>> in a separate __extable_range section, then the extable walking code
>> could be made common, too).
>> 
>> Only tested on x86: ppc and sparc64 written untested, others broken.
>
>Did you test on a true i386, which needs exception handling very early on 
>to handle the test for broken WP? In other words, are all the exception 
>table data structures properly initialized?
>  
>
It's the other way around: a real 80386 doesn't need the early exception 
handling, all other cpus need it.
The WP test works by writing to a write-protected page while at ring 0. 
A real 80386 ignores the write-protected bit, later x86 cpus honor it 
and cause a page fault.

Rusty, against which kernel is the patch you have posted? I've tried 
both 2.5.54 and the latest bk shapshot from www.kernel.org, I get an 
patch error in kernel/extable.c.

--
    Manfred

