Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271376AbRHOTXg>; Wed, 15 Aug 2001 15:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271375AbRHOTX0>; Wed, 15 Aug 2001 15:23:26 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:51206 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S271372AbRHOTXI> convert rfc822-to-8bit; Wed, 15 Aug 2001 15:23:08 -0400
Date: Wed, 15 Aug 2001 21:20:17 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
Cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>, <andrea@suse.de>
Subject: Re: [patch] zero-bounce highmem I/O
In-Reply-To: <20010815.032218.55508716.davem@redhat.com>
Message-ID: <20010815205954.A1159-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Aug 2001, David S. Miller wrote:

>    From: Jens Axboe <axboe@suse.de>
>    Date: Wed, 15 Aug 2001 11:26:21 +0200
>
>    Ok, here's an updated version. Maybe modulo the struct scatterlist
>    changes, I'd like to see this included in 2.4.x soonish. Or at least the
>    interface we agree on -- it'll make my life easier at least. And finally
>    provide driver authors with something not quite as stupid as struct
>    scatterlist.
>
> Jens, have a look at the patch I have below.  What do you
> think about it?  Specifically the set of interfaces.
>
> Andrea, I am very much interested in your input as well.

Here is some input you donnot seem interested in. Too bad for you! :-)

Some drivers may want to allocate internal DMAable data structures in a 32
bit DMAable address range but also may want to support 64 bit DMA
addressing for user data. This applies to the sym53c8xx driver (which is
not quite ready for 64 bit DMA adressing for now) and to the aic7xxx
driver which seems to be ready. The reason is for simplicity and may-be
feasibility and given that driver internal data structures donnot require
that much memory, this should not make memory pressure at all on the 32
bit DMAable range.

The current solution consists in tampering the dma_mask in the pci_dev
structure prior to allocating DMAable memory. Not really clean...
Some interface that would allow to provide some masks as argument would be
cleaner, in my opinion. Btw, the pci_set_* interface does not seem cleaner
to me than hacking the corresponding field in the pcidev structure directly.


> I would like to kill two birds with one stone here if
> we can.   The x86 versions of the asm/pci.h and
> asm/scatterlist.h bits are pretty mindless and left as
> an exercise to the reader :-)

[... b****ed patch removed since reader should already have it :) ...]

Later,
  Gérard.

