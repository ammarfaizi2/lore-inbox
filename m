Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287276AbSBKGCw>; Mon, 11 Feb 2002 01:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287289AbSBKGCn>; Mon, 11 Feb 2002 01:02:43 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:38835 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S287276AbSBKGCW>; Mon, 11 Feb 2002 01:02:22 -0500
Message-ID: <3C675E6B.4010605@nyc.rr.com>
Date: Mon, 11 Feb 2002 01:02:19 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.4 Compile Error
In-Reply-To: <3C674CFA.2030107@nyc.rr.com> <3C6750CD.46575DAA@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> John Weber wrote:
> 
>>/usr/src/linux-2.5.4/include/asm/processor.h: In function `thread_saved_pc':
>>/usr/src/linux-2.5.4/include/asm/processor.h:444: dereferencing pointer
>>to incomplete type
>>make: *** [init/main.o] Error 1
>>
> 
> since it's just for /usr/bin/ps, ie. not a fast path, I just un-inlined
> it in my alpha hacking.  Same approach might work for here, too.
> 
> The basic problem, I'm guessing, is that asm/processor.h wants to know
> about the internals of task struct, but it can't yet.
> 
> 	Jeff
> 

I don't know what the problem is, but un-inlining this function isn't 
correcting it.

The function thread_saved_pc() is a mystery to me.  It is declared with 
a return type of unsigned long, and yet return this:

((unsigned long *)tsk->thread->esp)[3]

This is confusing to me in many ways:
- the "thread" member of task struct is not a pointer
- esp is of type unsigned long, so I don't understand the cast, and
I certainly don't understand the [3] here.

Can anyone explain this code to me?

I'm a kernelnewbie, so I'm inclined to return:
return (tsk->thread).esp
What is this function trying to do?

