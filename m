Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWDJOkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWDJOkh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 10:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWDJOkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 10:40:37 -0400
Received: from rtr.ca ([64.26.128.89]:35751 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751179AbWDJOkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 10:40:36 -0400
Message-ID: <443A6E3A.9080002@rtr.ca>
Date: Mon, 10 Apr 2006 10:39:54 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Jens Axboe <axboe@suse.de>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
References: <20060110125852.GA3389@suse.de>	<20060110132957.GA28666@elte.hu>	<20060110133728.GB3389@suse.de>	<Pine.LNX.4.63.0601100840400.9511@winds.org>	<20060110143931.GM3389@suse.de> <20060110200755.55ee8215.vsu@altlinux.ru> <443A6789.9090809@sw.ru>
In-Reply-To: <443A6789.9090809@sw.ru>
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>>> +#if defined(CONFIG_DEFAULT_3G)
>>> +#define __PAGE_OFFSET_RAW    (0xC0000000)
>>> +#elif defined(CONFIG_DEFAULT_3G_OPT)
>>> +#define    __PAGE_OFFSET_RAW    (0xB0000000)
>>> +#elif defined(CONFIG_DEFAULT_2G)
>>> +#define __PAGE_OFFSET_RAW    (0x78000000)
>>> +#elif defined(CONFIG_DEFAULT_1G)
>>> +#define __PAGE_OFFSET_RAW    (0x40000000)
>>> +#else
>>> +#error "Bad user/kernel offset"
>>> +#endif
>>> +
>>>  #ifdef __ASSEMBLY__
>>> -#define __PAGE_OFFSET        (0xC0000000)
>>> +#define __PAGE_OFFSET        __PAGE_OFFSET_RAW
>>>  #define __PHYSICAL_START    CONFIG_PHYSICAL_START
>>>  #else
>>> -#define __PAGE_OFFSET        (0xC0000000UL)
>>> +#define __PAGE_OFFSET        ((unsigned long)__PAGE_OFFSET_RAW)
>>>  #define __PHYSICAL_START    ((unsigned long)CONFIG_PHYSICAL_START)
>>>  #endif
>>>  #define __KERNEL_START        (__PAGE_OFFSET + __PHYSICAL_START)
>>
>> Changing PAGE_OFFSET this way would break at least Valgrind (the latest
>> release 3.1.0 by default is statically linked at address 0xb0000000, and
>> PIE support does not seem to be present in that release).  I remember
>> that similar changes were also breaking Lisp implementations (cmucl,
>> sbcl), however, I am not really sure about this.
> it also breaks some java versions, so we use 3:4 Gb split in OpenVZ, but 
> redhat still uses 4:4 in enterprise version, so number of such 
> applications should decrease :)

Mmm.. that's an old thread.  The reply above was to
a posting from Sergey Vlasov (the same) on Tue Jan 10 2006,
12:06:50 EST.
