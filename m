Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288799AbSAEMsI>; Sat, 5 Jan 2002 07:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288802AbSAEMr6>; Sat, 5 Jan 2002 07:47:58 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:33243 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S288799AbSAEMrn>; Sat, 5 Jan 2002 07:47:43 -0500
Date: Sat, 5 Jan 2002 07:46:20 -0500 (EST)
From: Vladimir Dergachev <volodya@mindspring.com>
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Rui Sousa <rui.p.m.sousa@clix.pt>
cc: linux-kernel@vger.kernel.org, emu10k1-devel@opensource.creative.com
Subject: Re: HIGHMEM and DMA (emu10k1 related)
In-Reply-To: <Pine.LNX.4.33.0201050313200.2199-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.20.0201050730180.17212-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This might not be immediately relevant but I saw a similar issue with
Radeon DMA engine. What was happenning is that the card has an internal
memory controller which was misconfigured. So it was not "seeing" certain
physical pages. The problem manifested in pages of data filled with 0's.
Also it was often that it worked fine right after boot but became slowly
screwed up as memory was getting more fragmented.

So I think what happens is that your cards idea of pci addressable memory
goes awry with the pages you get from kernel. Try printing out the
addresses and checking whether there is any pattern. Also (probably you
did that already) check linux/Documentation/  for new PCI functions..

                             Vladimir Dergachev

On Sat, 5 Jan 2002, Rui Sousa wrote:

> 
> Hi,
> 
> Lately, there have been reports of problems when using
> the emu10k1 driver and a kernel compiled with HIGHMEM support.
> I finally managed to observe the problem myself and basically this 
> e-mail is a request for help to try and solve this.
> 
> 1. The problem is only observed when using a kernel compiled with 
> HIGHMEM support, even if actual RAM available is less than 1GiB 
> (192MiB in my case).
> 
> 2. The emu10k1 uses DMA to get sound data from host memory.
> 
> 3. DMA memory is allocated with pci_alloc_consistent (in 
> PAGE_SIZE blocks).
> 
> 4. The emu10k1 reads some bytes from host memory and caches them 
> locally (up to 128 bytes). These can then be read back through PCI IO 
> registers (using inl()).
> 
> 5. When I compare the values in host memory to the ones read by the card
> _some times_ they are different (all of the 128 bytes read). The values
> read by the card are usually zero when this happens.
> 
> 6. Once the problem starts if I start/stop the same sound application
> (freeing and then allocating the same DMA memory pages) the problem
> persists. If I stop the application, start another one (with a 
> different buffer usually allocating more memory), stop it, go
> back to the initial one, the problem is gone.
> 
> 
> At the hardware level what is the difference between a kernel with 
> HIGHMEM support and one without? I see that the physical/virtual 
> addresses of the pages obtained with pci_alloc_consistent are within
> the same range... 
> 
> If it's a bug in the driver why would it only show up some times and
> only if HIGHMEM support is enabled?
> 
> Thanks for any help,
> Rui Sousa
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

