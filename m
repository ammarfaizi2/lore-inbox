Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291613AbSBMMfg>; Wed, 13 Feb 2002 07:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291372AbSBMMfX>; Wed, 13 Feb 2002 07:35:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24335 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291611AbSBMMfI>;
	Wed, 13 Feb 2002 07:35:08 -0500
Message-ID: <3C6A5D79.33C31910@mandrakesoft.com>
Date: Wed, 13 Feb 2002 07:35:05 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <200201290137.g0T1bwB24120@karis.localdomain> <a354iv$ai9$1@penguin.transmeta.com> <3C6A57CE.9010107@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
> +                       sg->busaddr=virt_to_phys(dmabuf->rawbuf+dmabuf->fragsize*i);
>                         // the card will always be doing 16bit stereo
>                         sg->control=dmabuf->fragsamples;
>                         if(state->card->pci_id == PCI_DEVICE_ID_SI_7012)
> @@ -954,7 +954,7 @@
>                 }
>                 spin_lock_irqsave(&state->card->lock, flags);
>                 outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
> -               outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
> +               outl(virt_to_phys(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);


These changes are wrong.  The addresses desired need to be obtained from
the pci_alloc_consistent return values.


>                         outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
> -                       outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
> +                       outl(virt_to_phys(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);

likewise

> -       ret = virt_to_bus((void *)kva);
> +       ret = virt_to_phys((void *)kva);

>          va = VMALLOC_VMADDR(adr);
>          kva = uvirt_to_kva(pgd_offset_k(va), va);
> -       ret = virt_to_bus((void *)kva);
> +       ret = virt_to_phys((void *)kva);

> -                      btv->nr,virt_to_bus(po), virt_to_bus(pe));
> +                      btv->nr,virt_to_phys(po), virt_to_phys(pe));

...likewise, etc.

This works on silly x86 but is not portable at all...  definitely not
for application.


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
