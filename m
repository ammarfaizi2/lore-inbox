Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284681AbRLEUfG>; Wed, 5 Dec 2001 15:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284676AbRLEUe5>; Wed, 5 Dec 2001 15:34:57 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:30660 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S284681AbRLEUeq> convert rfc822-to-8bit; Wed, 5 Dec 2001 15:34:46 -0500
Date: Wed, 5 Dec 2001 18:38:33 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Heinz-Ado Arnolds <Ado.Arnolds@dhm-systems.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16: running *really* short on DMA buffers
In-Reply-To: <3C0E6E77.A5365331@web-systems.net>
Message-ID: <20011205182528.D1831-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Dec 2001, Heinz-Ado Arnolds wrote:

> Hi all,
>
> I get the message "kernel: Warning - running *really* short on DMA
> buffers" frequently with medium to heavy disk i/o (running several
> tar and/or moving huge directories).
>
> Can anybody give me some hints what the reason for this might be
> and how to avoid this condition.

The reason is certainly not driver allocations (either sym53c8xx version 1
or 2), since it performs all allocations of its internal data structures
directly from the page pool. OTOH, the Symbios PCI devices are quite able
to DMA the whole 32 bit physical address range.

So, they are the allocations internal to the scsi layer that may well
exhaust the ISA DMA pool. This pool is divided into 512 bytes chunks.
Under heavy reordering of IOs, it can get very fragmented and much memory
being wasted as a result.

An immediate solution might be to hack the scsi code for it to allocate
more memory.

> Do you need more information (I'm using only SCSI disks attached
> to a Symbios controller: <875> rev 0x26 on pci bus 0 device 11 func
> tion 0 irq 15)? I even can't find this error string in the kernel
> sources.

The error string in well known since years, so you shouldn't have missed
it from sources. :-)

  Gérard.

