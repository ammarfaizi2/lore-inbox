Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSFQV0U>; Mon, 17 Jun 2002 17:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317031AbSFQV0T>; Mon, 17 Jun 2002 17:26:19 -0400
Received: from freeside.toyota.com ([63.87.74.7]:25098 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S317030AbSFQV0Q>; Mon, 17 Jun 2002 17:26:16 -0400
Message-ID: <3D0E53D8.2020407@lexus.com>
Date: Mon, 17 Jun 2002 14:25:44 -0700
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Emmanuel Michon <emmanuel_michon@realmagic.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: binary compatibity (mixing different gcc versions) in modules
References: <Pine.LNX.3.95.1020617085231.12517B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I always compile the nvidia tarball against
whatever kernel I'm running - it has been
quite stable thus used, and I've used it with
stock RH kernels, -ac kernels, -aa kernels
and 2.5 kernels...

Joe

Richard B. Johnson wrote:

>On 17 Jun 2002, Emmanuel Michon wrote:
>
>  
>
>>Hi,
>>
>>looking at nvidia proprietary driver, the makefile warns
>>the user against insmod'ing a module compiled with a gcc
>>version different from the one that was used to compile
>>the kernel.
>>
>>This sounds strange to me, since I never encountered this
>>problem.
>>
>>As a counterpart, what I'm sure of, is that you easily get system
>>crashes when insmod'ing a module resulting of the linking together 
>>(with ld -r) of object files (.o) that were not produced by the same gcc.
>>
>>Can someone give me a clue on what happens?
>>
>>    
>>
>
>Nothing happens if you don't use -fcaller-saves or some other such
>optimization(s). Even -fomit-frame-pointer is safe across called
>functions so there should not be a problem mixing and matching.
>
>Note that your 'C' runtime library was probably not created by your
>current C Compiler and your user-mode C programs probably run just
>fine.
>
>Very old GNU C compilers followed the "M$" convention of prepending
>an underscore on a global variable. Therefore "main:" became "_main:".
>With such a compiler output, the linker will have trouble.
>
>If you link together certain objects to make a module, you must
>ascertain that the objects were produced using the same kernel
>structures (read identical kernel version). As an example, the
>main module structure, used by the kernel to find out where your
>module's procedures are, is called: "struct file_operations".
>The first structure member used to be a pointer to lseek(), now
>it's an opaque object of type THIS_MODULE.
>
>Imagine the fun if you made a module with this mixup!
>
>Cheers,
>Dick Johnson
>
>Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
>
>                 Windows-2000/Professional isn't.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>



