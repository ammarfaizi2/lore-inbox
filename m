Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267831AbUHNAGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267831AbUHNAGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 20:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUHNAGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 20:06:42 -0400
Received: from imf19aec.mail.bellsouth.net ([205.152.59.67]:1155 "EHLO
	imf19aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S267831AbUHNAGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 20:06:36 -0400
Message-ID: <411D578C.5010805@redhat.com>
Date: Fri, 13 Aug 2004 20:06:36 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Pete Zaitcev <zaitcev@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mike_phillips@urscorp.com
Subject: Re: [Patch} to fix oops in olympic token ring driver on media disconnect
References: <411D126B.6090303@redhat.com>	<1092434830.25002.25.camel@localhost.localdomain> <20040813163527.17aec0b5@lembas.zaitcev.lan> <411D536A.7050206@pobox.com>
In-Reply-To: <411D536A.7050206@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Pete Zaitcev wrote:
>
>> On Fri, 13 Aug 2004 23:07:16 +0100
>> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>
>>
>>> On Gwe, 2004-08-13 at 20:11, Neil Horman wrote:
>>>
>>>> the olympic_close routine was waiting on.  This patch cleans that up.
>>>>
>>>> Tested by me, on 2.4 and 2.6 with good, working results, and no 
>>>> more oopses.
>>>
>>>
>>> Should it not be blocking the IRQs on the chip as well ?
>>
>>
>>
>> I assumed that old olympic_close() did, but perhaps it didn't after all.
>> There is nothing like the following in it:
>>
>> +#define DISABLE_IRQS(base_addr) do { \
>> +   writel(LISR_LIE,(base_addr)+LISR_RWM);\
>> +   writel(SISR_MI,(base_addr)+SISR_RWM);\
>> +} while(0)
>>
>> This is curious. If something was never used, how do we know if it 
>> works?
>> Maybe it's safer just to leave things as Neil did.
>
>
>
> Well, regardless, Neil's patch is IMO a good first step.
>
> There is plenty of work in olympic for any motivated person :)
>
>     Jeff
>
>
Thanks :) I figure if someone reports system hangs or lock-ups with this 
card in place, I just re-add teh irq disable stuff.
Neil
