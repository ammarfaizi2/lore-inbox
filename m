Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSFDRfP>; Tue, 4 Jun 2002 13:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSFDRfO>; Tue, 4 Jun 2002 13:35:14 -0400
Received: from mail.univie.ac.at ([131.130.1.27]:40607 "EHLO
	mailbox.univie.ac.at") by vger.kernel.org with ESMTP
	id <S315277AbSFDRfM>; Tue, 4 Jun 2002 13:35:12 -0400
Message-ID: <3CFCFA33.7020106@univie.ac.at>
Date: Tue, 04 Jun 2002 19:34:43 +0200
From: Gerald Teschl <gerald.teschl@univie.ac.at>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org
Subject: Re: [PATCH] opl3sa2 isapnp activation fix
In-Reply-To: <Pine.LNX.4.44.0206041754050.26634-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Tue, 4 Jun 2002, Zwane Mwaikambo wrote:
>
>  
>
>>>         if(dev->activate(dev) < 0) {
>>>-            printk(KERN_WARNING PFX "ISA PnP activate failed\n");
>>>-            opl3sa2_state[card].activated = 0;
>>>-            return -ENODEV;
>>>+            /*
>>>+             * isapnp.c disallows dma=0 but some opl3sa2 cards need it.
>>>+             * So we set dma by hand and try again
>>>+             */
>>>+            if (dma < 0 || dma > 7)
>>>+                dma= 0;
>>>+            if (dma2 < 0 || dma2 >7)
>>>+                dma2= 1;
>>>      
>>>
>>Oops, that won't work on isapnp since dma = dma2 = -1 at this stage, how 
>>about;
>>
>>if ((dma != -1) && (dma2 != -1)) frob();
>>
I don't get what you mean? I tested this, if I do "modprobe opl3sa2 
dma=1 dma2=3" it will activate
the card with dma 1,3 (according to /proc/isapnp). However, my card will 
not work with these values.

>>
>>you shouldn't hard set 0,1
>>
The idea is that I first try to activate the card without assigning 
fixed values to dma. If this works, then fine. If not,
use whatever the user wants for dma respectively take 0,1 as default 
value. If I do not choose default values, then it
will not work automatically unless the user specifies dma. But if the 
user has to specify values, this is not PnP
IMHO.

 From your previous message I figured that my patch is fine with you?

Gerald


