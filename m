Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbSLQTCK>; Tue, 17 Dec 2002 14:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbSLQTCK>; Tue, 17 Dec 2002 14:02:10 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:41989 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S265414AbSLQTCH>; Tue, 17 Dec 2002 14:02:07 -0500
Message-ID: <3DFF764F.9010702@google.com>
Date: Tue, 17 Dec 2002 11:09:03 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ulrich Drepper <drepper@redhat.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212171046550.1095-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It doesn't make sense to me to use a specially formatted page forced 
into user space to tell libraries how to do system calls.  Perhaps each 
executable personality in the kernel should export a special shared 
library in it's own native format that contains the necessary 
information.  That way we don't have to worry as much about code or 
values changing sizes or locations.

We would have the chicken/egg problem with how the special shared 
library gets loaded in the first place.  For that we either support a 
legacy syscall method (i.e. int 0x80 on x86) which should only be used 
by ld.so or the equivalent or magically force the library into user 
space at a known address.

    Ross


Linus Torvalds wrote:

>On 17 Dec 2002, Alan Cox wrote:
>  
>
>>Is there any reason you can't just keep the linker out of the entire
>>mess by generating
>>
>>	.byte whatever
>>	.dword 0xFFFF0000
>>
>>instead of call ?
>>    
>>
>
>Alan, the problem is that there _is_ no such instruction as a "call
>absolute".
>
>There is only a "call relative" or "call indirect-absolute". So you either
>have to indirect through memory or a register, or you have to fix up the
>call at link-time.
>
>Yeah, I know it sounds strange, but it makes sense. Absolute calls are
>actually very unusual, and using relative calls is _usually_ the right
>thing to do. It's only in cases like this that we really want to call a
>specific address.
>
>			Linus
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>



