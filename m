Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSIJSA1>; Tue, 10 Sep 2002 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSIJSA0>; Tue, 10 Sep 2002 14:00:26 -0400
Received: from mail.gmx.de ([213.165.64.20]:17045 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317619AbSIJSAZ>;
	Tue, 10 Sep 2002 14:00:25 -0400
Message-ID: <3D7E34DA.7010100@gmx.net>
Date: Tue, 10 Sep 2002 20:07:22 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@mwaikambo.name>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] per isr in_progress markers
References: <Pine.LNX.4.44.0209092120310.1096-100000@linux-box.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Mon, 9 Sep 2002, Linus Torvalds wrote:
>
>  
>
>>I agree with you, but that is only true for edge-triggered APIC
>>interrupts, though - for level-triggered ones we will just re-take the
>>interrupt when we unmask it again.
>>
>>Which is kind of sad. Is there some fast way to read the status of a 
>>level-trigger irq off the IO-APIC in case it is still pending, and to do 
>>the mitigation even for level-triggered?
>>    
>>
>
>perhaps Remote IRR might help there?
>
>  
>
>>(Btw, if there is, that would also allow us to notice the "constantly
>>screaming PCI interrupt" without help from the low-level isrs)
>>    
>>
>
>As an aside, i just had an idea for another way to improve interrupt 
>handling latency. Instead of walking through all the isrs in the chain, 
>we can have an isr flag wether it was the source of the irq, and if so we 
>stop right there and not walk through the other isrs. 
>
This method is flawed for edge-triggered interrupts: you will miss any
interrupts which come in before you acked the first.


