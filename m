Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbVINTqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVINTqv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVINTqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:46:51 -0400
Received: from smtpout.mac.com ([17.250.248.72]:40391 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932552AbVINTqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:46:50 -0400
In-Reply-To: <Pine.LNX.4.61.0509141458380.19578@chaos.analogic.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <4328299C.9020904@tmr.com> <BB99A175-9BC7-4004-896D-7A5A22349861@mac.com> <Pine.LNX.4.61.0509141458380.19578@chaos.analogic.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C6194C86-1879-4C18-9C3C-2EF86C8E6046@mac.com>
Cc: Bill Davidsen <davidsen@tmr.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Wed, 14 Sep 2005 15:46:28 -0400
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 14, 2005, at 15:09:09, linux-os (Dick Johnson) wrote:
> No No. The solution is to do it right. If the standard says that
> the header file can't include a header file defining the types used
> within that header file (and I don't think the "standard" says that
> at all), then the correct solution is to include the correct header  
> file
> in the user program. It is truly just that simple.
>

I don't even have to say anything substantial in my response to this  
flame, because I've already said everything substantial that needs to  
be said, but just for clarity, let me repeat myself.

First, let me be repetitious and say this again:
> On Wed, 14 Sep 2005, Kyle Moffett wrote:
>> Argh, it seems I'm going to be giving this example forever!

Then:
>> If it [sys/types.h] used stdint.h types, such as uint32_t, then it  
>> would need to #include <stdint.h> or provide the stdint.h types  
>> itself.

Finally (with extra emphasis added):
>> In order to remain POSIX compliant, sys/stat.h _*MUST*_*NOT*_ not  
>> include stdint.h or
>> assume that stdint.h is included.

This means that the stat structure *CANNOT* use stdint.h types. Those  
are absolutely forbidden by the standard, because they have been used  
and reused, defined and redefined by userspace programs since the  
dawn of time.  There are standard definitions provided by libc if a  
program wants them, but libc _*MUST*_*NOT*_ force those definitions  
on anybody.  If you don't believe me, quit flaming and go read the  
standards yourself, that's exactly what they say, and for good reason  
too.

PS: This crap apology doesn't cut it, please use a different email  
service that does not append such garbage to your emails when sending  
stuff to the LKML:

> .
> I apologize for the following. I tried to kill it with the above dot :
>
> ****************************************************************
> The information transmitted in this message is confidential and may  
> be privileged.  Any review, retransmission, dissemination, or other  
> use of this information by persons or entities other than the  
> intended recipient is prohibited.  If you are not the intended  
> recipient, please notify Analogic Corporation immediately - by  
> replying to this message or by sending an email to  
> DeliveryErrors@analogic.com - and destroy all copies of this  
> information, including any attachments, without reading or  
> disclosing them.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


