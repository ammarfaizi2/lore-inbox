Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132473AbQKDGWY>; Sat, 4 Nov 2000 01:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132484AbQKDGWO>; Sat, 4 Nov 2000 01:22:14 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:59402 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132473AbQKDGWE>;
	Sat, 4 Nov 2000 01:22:04 -0500
Message-ID: <3A03AB05.5BD95C8B@mandrakesoft.com>
Date: Sat, 04 Nov 2000 01:21:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard A Nelson <cowboy@vnet.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Sample device driver - 2.2 and 2.4 support?
In-Reply-To: <Pine.LNX.4.30.0011021711120.1544-100000@badlands.lexington.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard A Nelson wrote:
> I've been assigned a device driver that uses the old (2.0) PCI
> support APIs - and is still working on 2.2.
> 
> I need to get this driver working on 2.2 and 2.4, I'm assuming I'll
> need to go switch to the newer PCI stuff - but am curious about the
> toleration support in later 2.2 kernels; is it complete enough that
> I can migrate to 2.4, and still compile on 2.2?

You can still use the 2.0.x PCI functions on 2.4.x.  They are slower
than the 'struct pci_dev' versions of the functions, because each
pcibios_xxx call incurs a call to pci_find_slot().
> 
> The device:
>   1-2 DMA
>   1   IRQ
> 
> The driver:
>   mkalloc
>   __get_free_pages
>   virt_to_bus
>   request_irc
>   wake_up
> 
> The driver has similiar functionality to a sound card:
>   Send/Receive (possibly large) data to device via DMA (page fixing, etc)
> 
> Is there a cononical example (esp. wrt 2.2 <-> 2.4 changes) I should look
> at ?

That depends on both the changes and your driver...  Every driver is
different, so nothing is really canonical WRT driver API changes.  If
your driver is similar to a sound card, then look at drivers/sound/*.c
...

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
