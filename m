Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVJNRks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVJNRks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 13:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVJNRks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 13:40:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12533 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750813AbVJNRks
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 13:40:48 -0400
Message-ID: <434FED9F.6080909@mvista.com>
Date: Fri, 14 Oct 2005 10:40:47 -0700
From: Khem Raj <kraj@mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: David Singleton <dsingleton@mvista.com>, robustmutexes@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Robust Futex update
References: <434DA382.1050100@mvista.com> <20051014054522.GA22749@elte.hu>
In-Reply-To: <20051014054522.GA22749@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo

As we pass same flags from glibc to kernel we thought it will be good to 
have defines in one place to avoid going out of sync in future.
glibc already has dependency on kernel headers. So were looking for ways 
to fix futex.h in kernel so that glibc can use it. But if it is not 
feasible then we can define these flags inside glibc headers. Only 
additional burden will be that these headers will be required to be 
synced whenever there is any change pertaining to them(mostly the defines.)

Thanks

Khem

Ingo Molnar wrote:

>* David Singleton <dsingleton@mvista.com> wrote:
>
>  
>
>>Index: linux-2.6.13/include/linux/futex.h
>>===================================================================
>>--- linux-2.6.13.orig/include/linux/futex.h
>>+++ linux-2.6.13/include/linux/futex.h
>>@@ -1,8 +1,6 @@
>> #ifndef _LINUX_FUTEX_H
>> #define _LINUX_FUTEX_H
>> 
>>-#include <linux/fs.h>
>>-
>> /* Second argument to futex syscall */
>> 
>>    
>>
>
>this chunk broke the build, so i added the #include back. Really, the 
>robust mutex glibc patches should _NOT_ automatically include the 
>kernel's futex.h file. If they do so and rely on an installed 
>kernel-headers package then they are broken. Just copy the file into the 
>glibc tree and remove the #include line.
>
>	Ingo
>  
>
>------------------------------------------------------------------------
>
>_______________________________________________
>robustmutexes mailing list
>robustmutexes@lists.osdl.org
>https://lists.osdl.org/mailman/listinfo/robustmutexes
>  
>

-- 
Khem Raj <kraj@mvista.com>
MontaVista Software, Inc.
www.mvista.com

