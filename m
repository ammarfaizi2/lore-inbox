Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287493AbSAEDts>; Fri, 4 Jan 2002 22:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287494AbSAEDtf>; Fri, 4 Jan 2002 22:49:35 -0500
Received: from marta.ip.pt ([195.23.132.14]:53519 "HELO marta2.ip.pt")
	by vger.kernel.org with SMTP id <S287493AbSAEDtZ>;
	Fri, 4 Jan 2002 22:49:25 -0500
Date: Sat, 5 Jan 2002 03:49:22 +0000 (WET)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <emu10k1-devel@opensource.creative.com>
Subject: HIGHMEM and DMA (emu10k1 related)
Message-ID: <Pine.LNX.4.33.0201050313200.2199-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Lately, there have been reports of problems when using
the emu10k1 driver and a kernel compiled with HIGHMEM support.
I finally managed to observe the problem myself and basically this 
e-mail is a request for help to try and solve this.

1. The problem is only observed when using a kernel compiled with 
HIGHMEM support, even if actual RAM available is less than 1GiB 
(192MiB in my case).

2. The emu10k1 uses DMA to get sound data from host memory.

3. DMA memory is allocated with pci_alloc_consistent (in 
PAGE_SIZE blocks).

4. The emu10k1 reads some bytes from host memory and caches them 
locally (up to 128 bytes). These can then be read back through PCI IO 
registers (using inl()).

5. When I compare the values in host memory to the ones read by the card
_some times_ they are different (all of the 128 bytes read). The values
read by the card are usually zero when this happens.

6. Once the problem starts if I start/stop the same sound application
(freeing and then allocating the same DMA memory pages) the problem
persists. If I stop the application, start another one (with a 
different buffer usually allocating more memory), stop it, go
back to the initial one, the problem is gone.


At the hardware level what is the difference between a kernel with 
HIGHMEM support and one without? I see that the physical/virtual 
addresses of the pages obtained with pci_alloc_consistent are within
the same range... 

If it's a bug in the driver why would it only show up some times and
only if HIGHMEM support is enabled?

Thanks for any help,
Rui Sousa

