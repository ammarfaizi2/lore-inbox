Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVKORx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVKORx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVKORx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:53:56 -0500
Received: from smtp6.clb.oleane.net ([213.56.31.26]:40428 "EHLO
	smtp6.clb.oleane.net") by vger.kernel.org with ESMTP
	id S964929AbVKORxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:53:55 -0500
Message-ID: <437A20AA.8020001@aie-etudes.com>
Date: Tue, 15 Nov 2005 18:53:46 +0100
From: sej <trash@aie-etudes.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA transfer with kiobuf, kernel 2.4.21
References: <437A1D6E.4060302@aie-etudes.com> <1132076986.2822.34.camel@laptopd505.fenrus.org>
In-Reply-To: <1132076986.2822.34.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that sounds the wrong approach.. why don't you make your device driver
> export an mmap function.. and let the userspace app use that ?

I can't because I need to allocate 128MB of memory per PCI card and if I put for example 4 cards, I'll have 512MB in kernel memory, and I think there will be some problem in kernel.



>transfer->Descript[i].size        = PAGE_SIZE;
>transfer->Descript[i].pciaddr    = (ULONG)
>virt_to_phys(page_address(iobuf->maplist[idxIobuf]));
>  
>

> you really need to use the PCI DMA mapping api!

I have a plx bridge PCI9656 with a DMA controler. So I have to make a 
descriptor table with physical address and size.
I work in 32 bits address mode, but I don't know which function to call 
to get a 36bits address for my controler.

Regards.
Sebastien


>On Tue, 2005-11-15 at 18:39 +0100, sej wrote:
>  
>
>>Hi,
>>I allocate a big chunck of memory from user space with :
>>
>>#define MEM_SIZE_DMA (128*1024*1024)
>>// allocate 128MB of memory
>>void *_pVirtualMem = memalign(sysconf(_SC_PAGESIZE), MEM_SIZE_DMA);
>>
>>// Reserve memory
>>memset(_pVirtualMem, 0, MEM_SIZE_DMA);
>>
>>// Lock memory
>>if (!mlock(_pVirtualMem, MEM_SIZE_DMA ))
>>{
>>free(_pVirtualMem);
>>return false;
>>}
>>
>>Then I call an IOCTL from my driver (DmaMapDescrpImg) to create a DMA
>>scatter gather list.
>>    
>>
>
>that sounds the wrong approach.. why don't you make your device driver
>export an mmap function.. and let the userspace app use that ?
>
>
>  
>
>>transfer->Descript[i].size        = PAGE_SIZE;
>>transfer->Descript[i].pciaddr    = (ULONG)
>>virt_to_phys(page_address(iobuf->maplist[idxIobuf]));
>>    
>>
>
>you really need to use the PCI DMA mapping api!
>
>
>
>
>
>  
>

