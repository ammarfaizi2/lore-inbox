Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVKEPZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVKEPZf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 10:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVKEPZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 10:25:35 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:47088 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932076AbVKEPZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 10:25:34 -0500
Message-ID: <436CCFEC.50709@student.ltu.se>
Date: Sat, 05 Nov 2005 16:29:48 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Knutsson <ricknu-0@student.ltu.se>
CC: Andrew Morton <akpm@osdl.org>, ashutosh.lkml@gmail.com,
       netdev@vger.kernel.org, davej@suse.de, acme@conectiva.com.br,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [PATCH]dgrs - Fixes Warnings when CONFIG_ISA and CONFIG_PCI are
 not enabled
References: <81083a450511012314q4ec69927gfa60cb19ba8f437a@mail.gmail.com>	<4368878D.4040406@student.ltu.se>	<c216304e0511020516o5cfcd0b9u96a3220bf2694928@mail.gmail.com>	<436927CA.3090105@student.ltu.se>	<20051104182537.741be3d9.akpm@osdl.org>	<20051104183043.27a2229c.akpm@osdl.org>	<436C6F02.90904@student.ltu.se> <20051105004609.0f04481c.akpm@osdl.org> <436C9D73.5030506@student.ltu.se>
In-Reply-To: <436C9D73.5030506@student.ltu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson wrote:

> Andrew Morton wrote:
>
>> Richard Knutsson <ricknu-0@student.ltu.se> wrote:
>>  
>>
>>>>      */
>>>>     
>>>
>>> > #ifdef CONFIG_EISA
>>> >-    eisacount = eisa_driver_register(&dgrs_eisa_driver);
>>> >-    if (eisacount < 0)
>>> >-        return eisacount;
>>> >-#endif
>>> >-#ifdef CONFIG_PCI
>>> >-    pcicount = pci_register_driver(&dgrs_pci_driver);
>>> >-    if (pcicount)
>>> >-        return pcicount;
>>> >+    cardcount = eisa_driver_register(&dgrs_eisa_driver);
>>> >+    if (cardcount < 0)
>>> >+        return cardcount;
>>> > #endif
>>> >+    cardcount = pci_register_driver(&dgrs_pci_driver);
>>> >+    if (cardcount)
>>> >+        return cardcount;
>>> >     return 0;
>>> > }
>>> >  >
>>> I do not know what to think about this one:
>>> * reduce one #ifdef: good
>>> * check for something clearly stated not to: not so good
>>>   
>>
>>
>> Well a nicer fix would be to provide a stub implementation of
>> eisa_driver_register() if !CONFIG_EISA, just like 
>> pci_register_driver(). Then all the ifdefs go away and the compiler 
>> removes all the code for us,
>> after checking that we typed it correctly.
>>  
>>
> Oh, sorry. Missed the stub implementation of the pci-driver. I "ack" 
> your patch.
>
> BTW, can anyone ack or is that up to the maintainers?
> BTW #2, why not remove #ifdef CONFIG_PCI on dgrs_cleanup_module() at 
> the same time? Or maybe that should be in a "remove config_pci"-patch...
>
> /Richard

Just realized; what happens if CONFIG_EISA && !CONFIG_PCI and 
eisa_driver_register() returns value > 0, then the if-statement for the 
pci-driver is going to return the value, instead of 0.

/Richard

