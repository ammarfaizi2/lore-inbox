Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312600AbSEHJ4k>; Wed, 8 May 2002 05:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312634AbSEHJ4j>; Wed, 8 May 2002 05:56:39 -0400
Received: from [195.63.194.11] ([195.63.194.11]:11015 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312600AbSEHJ4i>; Wed, 8 May 2002 05:56:38 -0400
Message-ID: <3CD8E78E.40302@evision-ventures.com>
Date: Wed, 08 May 2002 10:53:34 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, bjornw@axis.com
Subject: Re: [PATCH] IDE 58
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com>	<3CD7ECB9.9050606@evision-ventures.com> <15576.51389.931803.495093@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Paul Mackerras napisa?:
> Martin Dalecki writes:
> 
> 
>>- Virtualize the udma_enable method as well to help ARM and PPC people.  Please
>>   please if you would like to have some other methods virtualized in a similar
>>   way - just tell me or even better do it yourself at the end of ide-dma.c.
>>   I *don't mind* patches.
>>
>>- Fix the pmac code to adhere to the new API. It's supposed to work again.
>>   However this is blind coding... I give myself 80% chances for it to work ;-).
> 
> 
> OK, now I am truly impressed.  Not only does it compile cleanly, it
> works first go!

Thank you.

BTW> I would really love it if the cris architecture people could
"lend me" some small developement system for they interresting CPU.
In return I could give them what's certainly worth "several weeks of
developers time". (If you hear me: this is a hint if you need an argument for
your management.)

This unfortunately is the somehow most wired ATA interface
around. Which is due to the fact that the interface cell is directly mapped to
some CPU registers. As a CPU design I think it's a fine approach. Don't
take me wrong. You save yourself the whole silicon which is needed
for BM access arbitration and general handling and so on... Very nice tought
out. But on the software side this is a bit wired, since you can't use
the generic I/O primitives of the arch in question.

This makes my  cleanup of the portability layer a bit hard
to finish on the software side.

> I am using the tiny patch below, it sets the unmask flag so interrupts
> will be unmasked by default (which is safe on powermacs).

And on every other fscking PCI based system... (modulo the "problematic"
cmd640 and RZ1000). Should have been done a long time ago this way... I will 
adjust the others as well.

> Thanks,
> Paul.
> 
> diff -urN linux-2.5/drivers/ide/ide-pmac.c pmac-2.5/drivers/ide/ide-pmac.c
> --- linux-2.5/drivers/ide/ide-pmac.c	Wed May  8 16:40:17 2002
> +++ pmac-2.5/drivers/ide/ide-pmac.c	Wed May  8 08:26:48 2002
> @@ -343,6 +343,7 @@
>  			ide_hwifs[ix].autodma = 1;
>  #endif
>  	}
> +	ide_hwifs[ix].unmask = 1;
>  }
>  
>  #if 0
> 

