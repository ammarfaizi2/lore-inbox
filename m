Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314404AbSEIVyo>; Thu, 9 May 2002 17:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314411AbSEIVym>; Thu, 9 May 2002 17:54:42 -0400
Received: from [195.63.194.11] ([195.63.194.11]:45573 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314404AbSEIVyh>; Thu, 9 May 2002 17:54:37 -0400
Message-ID: <3CDAE154.9080103@evision-ventures.com>
Date: Thu, 09 May 2002 22:51:32 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
        mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI reorg fix
In-Reply-To: <200205092134.g49LYNo04387@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik James Bottomley napisa?:
> dalecki@evision-ventures.com said:
> 
>>If your are at it: I was always itching my had what
>>pci_alloc_inconsistent and pci_free_inconsistent is supposed to be?
>>Negating semantically the consistent attribute shows nicely that the
>>_consistent is a bad nomenclatures. Perhaps something more related to
>>the purpose of it would help. Like
> 
> 
>>ioalloc() and iofree()
> 
> 
>>Could be even abstracted from the bus implementation.
> 
> 
>>And of course much less typing... 
> 
> 
> I'm all for less typing, but "consistent" memory has a definite meaning to 
> some non-x86 architectures (and inconsistent also has a definite and 
> semantically opposite meaning).
> 
> The x86 is nice because it is fully coherent architecture: the CPUs snoop the 
> I/O busses and do CPU cache invalidations for data transferred from an I/O 
> device directly to memory and CPU cache flushes when a device reads directly 
> from memory.

So what you are requesting is memmory which is suitable to be run
for IO. All you are talking about is io. I think ioalloc() and iofree()
fit it nice as names.

> If the CPU doesn't snoop I/O transfers, you have to manually invalidate or 
> flush the necessary CPU cache lines.  The pci_sync_... functions are for doing 
...
> drivers simply choose not to bother with consistent memory at all because the 
> cache manipulation operations are optimised away on fully consistent platforms.
> 
> I'd like to say that this is totally unrelated to the bus type, but some 
> architectures place MMUs on their busses which means that memory consistency 
> (and even memory addressability) can indeed be bus specific depending on what 
> the MMU actually does.


Thank you finally for explaining that the _consistant is about
well coherency and caches... This should have been put up in to the
documentation in question... becouse beleve me or not -
I know well about the "MESIs of the world", but I still wasn't
able to make any sense out of this _consistent term in first place.

And I still have the feeling that the nomenclature is bad.
What are you going to do if on some silly VLSI new slow CPU
invention at some time the need of doing pciIV_alloc_asynchronous() araises?
or pciXI_alloc_remote() or whatever? Are you going to request
all the driver writers to adjust to it again!?

(Something like this could for example just happen very urgently if Transmeta
decided to reveal native access to the hardware and tools in question I guess ;-).

