Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291614AbSBMMln>; Wed, 13 Feb 2002 07:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291611AbSBMMlh>; Wed, 13 Feb 2002 07:41:37 -0500
Received: from [195.63.194.11] ([195.63.194.11]:39687 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291614AbSBMMlR>; Wed, 13 Feb 2002 07:41:17 -0500
Message-ID: <3C6A5EDB.40908@evision-ventures.com>
Date: Wed, 13 Feb 2002 13:40:59 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <200201290137.g0T1bwB24120@karis.localdomain> <a354iv$ai9$1@penguin.transmeta.com> <3C6A57CE.9010107@evision-ventures.com> <3C6A5D79.33C31910@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>Martin Dalecki wrote:
>sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
>
>>+                       sg->busaddr=virt_to_phys(dmabuf->rawbuf+dmabuf->fragsize*i);
>>                        // the card will always be doing 16bit stereo
>>                        sg->control=dmabuf->fragsamples;
>>                        if(state->card->pci_id == PCI_DEVICE_ID_SI_7012)
>>@@ -954,7 +954,7 @@
>>                }
>>                spin_lock_irqsave(&state->card->lock, flags);
>>                outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
>>-               outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
>>+               outl(virt_to_phys(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
>>
>
>
>These changes are wrong.  The addresses desired need to be obtained from
>the pci_alloc_consistent return values.
>
>>                        outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
>>-                       outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
>>+                       outl(virt_to_phys(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
>>
>
>likewise
>
>>-       ret = virt_to_bus((void *)kva);
>>+       ret = virt_to_phys((void *)kva);
>>
>>         va = VMALLOC_VMADDR(adr);
>>         kva = uvirt_to_kva(pgd_offset_k(va), va);
>>-       ret = virt_to_bus((void *)kva);
>>+       ret = virt_to_phys((void *)kva);
>>
>>-                      btv->nr,virt_to_bus(po), virt_to_bus(pe));
>>+                      btv->nr,virt_to_phys(po), virt_to_phys(pe));
>>
>
>...likewise, etc.
>
>This works on silly x86 but is not portable at all...  definitely not
>for application.
>

The bttv we can argue about, I was just tagging it as beeing a quick fix...

Of course I admit that I have taken the easy shoot here. But it wasn't 
possible
to me to deduce the proper thing to do by looking at the patches.
This is the usual way I deal with API changes: Have a look at what has 
been done
to the other candidates and do the analogous thing where you need it.

But please just show me a non x86 architecture which is using the 
i810_audio driver!


