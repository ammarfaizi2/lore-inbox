Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265486AbRFVS4Y>; Fri, 22 Jun 2001 14:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265487AbRFVS4P>; Fri, 22 Jun 2001 14:56:15 -0400
Received: from sncgw.nai.com ([161.69.248.229]:37563 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265486AbRFVS4H>;
	Fri, 22 Jun 2001 14:56:07 -0400
Message-ID: <XFMail.20010622115917.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3B33918D.1CF642B4@mvista.com>
Date: Fri, 22 Jun 2001 11:59:17 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: george anzinger <george@mvista.com>
Subject: Re: signal dequeue ...
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22-Jun-2001 george anzinger wrote:
> Davide Libenzi wrote:
>> 
>> I'm just trying to figure out the reason why signal must be delivered one at
>> a
>> time instead of building a frame with multiple calls with only the last one
>> chaining back to the kernel.
>> All previous calls instead of calling the stub that jump back to the kernel
>> will call a small stub like ( Ix86 ) :
>> 
>> stkclean_stub:
>>         add $frame_size, %esp
>>         cmp %esp, $end_stubs
>>         jae $sigreturn_stub
>>         ret
>> sigreturn_stub:
>>         mov __NR_sigreturn, %eax
>>         int $0x80
>> end_stubs:
>> 
>> ...
>> | context1
>> * $stkclean_stub
>> * sigh1_eip
>> | context0
>> * $stkclean_stub
>> * sigh0_eip
>> 
>> When sigh0 return, it'll call stkclean_stub that will clean context0 and if
>> we're at the end it'll call the jump-back-to-kernel stub, otherwise the
>> it'll
>> execute the  ret  the will call sigh1 handler ... and so on.
>> 
> And if the user handler does a long_jmp?  

But if the user handler does a long_jump even the old stub will be missed,
isn't it ?




- Davide

