Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbVJJRVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbVJJRVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVJJRVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:21:10 -0400
Received: from [66.45.247.194] ([66.45.247.194]:5013 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1750997AbVJJRVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:21:09 -0400
Message-ID: <434AA000.4070403@linuxtv.org>
Date: Mon, 10 Oct 2005 21:08:16 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <lnx4us@gmail.com>
CC: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org,
       Jiri Slaby <jirislaby@gmail.com>
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <43287712.3040503@gmail.com>	 <4328A3C8.6010501@linuxtv.org>	 <200510101403.02578@bilbo.math.uni-mannheim.de>	 <434A6334.4090407@linuxtv.org>	 <3888a5cd0510100719r3fddc368oa01e07e2c42b71e@mail.gmail.com>	 <434A8225.5050808@linuxtv.org> <3888a5cd0510100846p7f2ff70cid69a1136b9256ab6@mail.gmail.com>
In-Reply-To: <3888a5cd0510100846p7f2ff70cid69a1136b9256ab6@mail.gmail.com>
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
>>Jiri Slaby wrote:
>>    
>>
>>>Some points to the new driver:
>>>indentation isn't so good, the code is not readable well (80 chars on
>>>a line mainly).
>>>      
>>>
>>I do agree that indentation is not so good, but how would you suggest
>>the code be wrapped ?
>>    
>>
>Divide strings not "text blabalba \
>         continue"
>but with better "text blablabalasjdl"
>         "continue"
>  
>

The dprintk() macro (in mantis_common.h ) was looking very badly with 
wrap, which Andrew also commented on (about the col's) (the macro being 
the same, eventhough i was using it elsewhere) it being more than 80 
cols, but wrapping the macro made it look like hell.

>wrap line, if it is longer than 80 columns, near last comma, |, & and so on
>You seem to use some editor with tab to be less than 8 columns and
>some headers are indented bad because of it.
>  
>

My editor uses 8 columns only as a tab, Thunderbird does really handle 
things a bit different though.


>>The problem with wrapping is that readability goes down horribly, but
>>while debugging a driver, this is too painful.
>>Considering that it has a long way to go still..
>>
>>    
>>
>>>>      mantis->pdev = pdev;
>>>>
>>>>
>>>>        
>>>>
>>>If you work with this out from pci functions, you should call
>>>pci_get_dev and in exit function pci_dev_put, otherwise you don't need
>>>it at all.
>>>      
>>>
>>Well i am using it in mantis_dma.c, pci_alloc/free
>>    
>>
>And it is called only from places, where pdev is known (i.e. in
>parameter of function, e.g. mantis_pci_probe). So you don't need it to
>store in mantis, but only call mantis_dma_init(mantis, pdev). Read
>below.
>  
>
>>You mean rather than saving off the pointer, i do a pci_get_dev()
>>and later on in the exit routine, i do a pci_dev_put() .. ?
>>    
>>
>But if you really want it, call pci_get_dev() and store it into mantis
>struct. In the _device_ exit routine call the latter. But I think,
>that not to store is better, or the best is to call
>mantis_dma_init(pdev) and do pci_get_drvdata inside.
>  
>

i think will pass (pdev) it as a function argument. Looks a bit more cleaner
But what i fail to understand is , if you can pass it as an argument, 
why can't you save the pointer in the struct ?

>>>mantis_dma_init and others could be __devinit too, or not? Try to use
>>>it as much as possible.
>>>      
>>>
>>Any thoughts as to why ? I am not saying it is not needed, but i would
>>like to know what was the idea.
>>    
>>
>Kernel frees up the sections that won't be needed anymore. You put the
>function in some section by this.
>  
>
Ok,

Thanks.
Manu

