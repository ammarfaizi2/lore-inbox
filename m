Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbSK2SQq>; Fri, 29 Nov 2002 13:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267119AbSK2SQq>; Fri, 29 Nov 2002 13:16:46 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:33200 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267117AbSK2SQq>;
	Fri, 29 Nov 2002 13:16:46 -0500
Message-ID: <3DE7B0C2.7050301@colorfullife.com>
Date: Fri, 29 Nov 2002 19:24:02 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Georg Nikodym <georgn@somanetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: v2.4.19-rmk4 slab.c: /proc/slabinfo uses broken instead of slab
 labels
References: <3DE699EC.9060600@colorfullife.com> <20021128224028.F27234@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Thu, Nov 28, 2002 at 11:34:20PM +0100, Manfred Spraul wrote:
>  
>
>>On i386, it's possible to skip set_fs() and use __get_user() - but 
>>that's i386 specific. For example the i386 oops code uses that.
>>    
>>
>
>That isn't actually an x86 specific feature - it is a requirement across
>all architectures that get_user() and friends can access kernel areas
>after set_fs(get_ds())
>  
>
It's i386 specific that
    __get_user().
is equivalent to
    set_fs(KERNEL_DS)
    get_user()
arch/i386/kernel/traps.c uses that in the fault code.

Portable code must use set_fs()/get_user(), i386 specific code can 
continue to use __get_user().

--
    Manfred

