Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVAWPtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVAWPtJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 10:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVAWPtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 10:49:09 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:10382 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261320AbVAWPtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 10:49:04 -0500
Message-ID: <41F3C76E.7000904@acm.org>
Date: Sun, 23 Jan 2005 09:49:02 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch to fix race between the NMI code and the CMOS clock
References: <41F18A52.9040703@acm.org> <20050123001806.53140e54.akpm@osdl.org>
In-Reply-To: <20050123001806.53140e54.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Corey Minyard <minyard@acm.org> wrote:
>  
>
>>This patch fixes a race between the CMOS clock setting and the NMI
>> code.  The NMI code indiscriminatly sets index registers and values
>> in the same place the CMOS clock is set.  If you are setting the
>> CMOS clock and an NMI occurs, Bad values could be written to or
>> read from the CMOS RAM, or the NMI operation might not occur
>> correctly.
>>
>> Fixing this requires creating a special lock so the NMI code can
>> know its CPU owns the lock an "do the right thing" in that case.
>>    
>>
>
>hm, tricky patch.  I can't see any holes in it.  The volatile variable is
>awkward but should be OK on x86 and I can see the need for it.
>  
>
It took some thought and I couldn't think of anything simpler.  I posted 
in on lkml a little while ago, and some people tried but nobody else 
found a simpler solution that worked with SMP.

>There's a preposterous amount of inlining happening in this code.  Hence
>your patch took the size of drivers/char/rtc.o from
>
>   text    data     bss     dec     hex filename
>   3657     540       8    4205    106d drivers/char/rtc.o
>to
>   5419     540       8    5967    174f drivers/char/rtc.o
>
>Do you think you could take a look at uninlining everything sometime?
>  
>
Certainly.  I'll try to have it sometime today.

Thanks,

-Corey
