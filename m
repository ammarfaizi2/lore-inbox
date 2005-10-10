Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVJJPNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVJJPNz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 11:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVJJPNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 11:13:55 -0400
Received: from [66.45.247.194] ([66.45.247.194]:23722 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1750845AbVJJPNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 11:13:54 -0400
Message-ID: <434A8225.5050808@linuxtv.org>
Date: Mon, 10 Oct 2005 19:00:53 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <lnx4us@gmail.com>
CC: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <43287712.3040503@gmail.com>	 <4328A3C8.6010501@linuxtv.org>	 <200510101403.02578@bilbo.math.uni-mannheim.de>	 <434A6334.4090407@linuxtv.org> <3888a5cd0510100719r3fddc368oa01e07e2c42b71e@mail.gmail.com>
In-Reply-To: <3888a5cd0510100719r3fddc368oa01e07e2c42b71e@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:

>On 10/10/05, Manu Abraham <manu@linuxtv.org> wrote:
>  
>
>>I have fixed most of the stuff, it is partly working, not ready yet as
>>there are some more things to be added to  ..
>>I have attached what i was working on.
>>    
>>
>I'm not so bad, I help people (but not 10 times with the same point),
>fuck it and forget.
>
>  
>
presumption is not always good, and it is very clear. Most of the 
flamewars blaze up because of that. Anyway let's not hover on that ..

>Some points to the new driver:
>indentation isn't so good, the code is not readable well (80 chars on
>a line mainly).
>
>  
>

I do agree that indentation is not so good, but how would you suggest 
the code be wrapped ?

The problem with wrapping is that readability goes down horribly, but 
while debugging a driver, this is too painful.
Considering that it has a long way to go still..

>>static irqreturn_t mantis_pci_irq(int irq, void *dev_id, struct pt_regs *regs)
>>{
>>       int count = 0, interrupts = 0;
>>       u32 stat = 0, mask = 0, temp;
>>
>>       struct mantis_pci *mantis;
>>
>>       mantis = (struct mantis_pci *) dev_id;
>>    
>>
>you don't need to cast from void *
>struct mantis_pci *mantis = dev_id; is enough
>
>  
>

Thanks, Ack'd.

>>       mantis->pdev = pdev;
>>    
>>
>If you work with this out from pci functions, you should call
>pci_get_dev and in exit function pci_dev_put, otherwise you don't need
>it at all.
>
>  
>
Well i am using it in mantis_dma.c, pci_alloc/free

You mean rather than saving off the pointer, i do a pci_get_dev()
and later on in the exit routine, i do a pci_dev_put() .. ?

>mantis_dma_init and others could be __devinit too, or not? Try to use
>it as much as possible.
>
>  
>

Any thoughts as to why ? I am not saying it is not needed, but i would 
like to know what was the idea.

>>static struct pci_driver mantis_pci_driver = {
>>       .name = DRIVER_NAME,
>>       .id_table = mantis_pci_table,
>>       .probe = mantis_pci_probe,
>>       .remove = mantis_pci_remove,
>>    
>>
>here should be = __devexit_p(...),
>  
>

Ack'd, Thanks ..

>>};
>>    
>>
>
>  
>
>>err0:
>>    
>>
>you should change naming of labels such as errfree, where do you do kfree etc.
>
>  
>
Ah , okay.


Thanks,
Manu

