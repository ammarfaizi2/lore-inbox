Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267142AbTAFVOb>; Mon, 6 Jan 2003 16:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267143AbTAFVOa>; Mon, 6 Jan 2003 16:14:30 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:18425 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267142AbTAFVO2>; Mon, 6 Jan 2003 16:14:28 -0500
Date: Mon, 06 Jan 2003 13:14:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ion Badulescu <ionut@badula.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix starfire compiler warning on PAE
Message-ID: <33980000.1041887671@flay>
In-Reply-To: <200301062057.h06KvJA03060@buggy.badula.org>
References: <200301062057.h06KvJA03060@buggy.badula.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fix the compiler warning, yes; fix the driver for 64-bit dma_addr_t, no.
> It may work with PAE, by chance, if all addresses returned by pci_map_single
> and friends are < (1 << 33), but not otherwise.

Odd. It seems to work with PAE now. pci_map_single just casts an address
though ... are the things you're passing it always allocated from ZONE_NORMAL?
I run these all the time on 16Gb machines with 16 processors (ia32 NUMA-Q).

> Jeff already has an updated starfire driver in his queue, complete with
> full 64-bit support.

Cool! Sorry, I've just been seeing that warning for about 1 year, and was
sick of it.
 
> [the cc: to the maintainer is always appreciated...]

Sorry, missed that. But in that case, I have another question for you ;-)
Why do I get wierd errors like this:

Jan  6 10:09:53 larry kernel: eth0: Increasing Tx FIFO threshold to 80 bytes
Jan  6 10:09:56 larry kernel: eth0: Increasing Tx FIFO threshold to 96 bytes
Jan  6 10:09:56 larry kernel: eth0: Increasing Tx FIFO threshold to 112 bytes
Jan  6 10:10:09 larry kernel: eth0: Increasing Tx FIFO threshold to 128 bytes
Jan  6 10:10:09 larry kernel: eth0: Increasing Tx FIFO threshold to 144 bytes
Jan  6 10:10:12 larry kernel: eth0: Increasing Tx FIFO threshold to 160 bytes
Jan  6 10:10:12 larry kernel: eth0: Increasing Tx FIFO threshold to 176 bytes
Jan  6 10:10:14 larry kernel: eth0: Increasing Tx FIFO threshold to 192 bytes
Jan  6 10:10:30 larry kernel: eth0: Increasing Tx FIFO threshold to 208 bytes
Jan  6 10:10:32 larry kernel: eth0: Increasing Tx FIFO threshold to 224 bytes
Jan  6 10:10:39 larry kernel: eth0: Increasing Tx FIFO threshold to 240 bytes
Jan  6 10:10:39 larry kernel: eth0: Increasing Tx FIFO threshold to 256 bytes
Jan  6 10:10:39 larry kernel: eth0: Increasing Tx FIFO threshold to 272 bytes
Jan  6 10:10:46 larry kernel: eth0: Increasing Tx FIFO threshold to 288 bytes
Jan  6 10:10:46 larry kernel: eth0: Increasing Tx FIFO threshold to 304 bytes
Jan  6 10:10:47 larry kernel: eth0: Increasing Tx FIFO threshold to 320 bytes
Jan  6 10:10:47 larry kernel: eth0: Increasing Tx FIFO threshold to 336 bytes
Jan  6 10:10:57 larry kernel: eth0: Increasing Tx FIFO threshold to 352 bytes
Jan  6 10:10:57 larry kernel: eth0: Increasing Tx FIFO threshold to 368 bytes
Jan  6 10:11:22 larry kernel: eth0: Increasing Tx FIFO threshold to 384 bytes
Jan  6 10:11:37 larry kernel: eth0: Increasing Tx FIFO threshold to 400 bytes
Jan  6 10:11:58 larry kernel: eth0: Increasing Tx FIFO threshold to 416 bytes
Jan  6 10:12:29 larry kernel: eth0: Increasing Tx FIFO threshold to 432 bytes
Jan  6 10:12:29 larry kernel: eth0: Increasing Tx FIFO threshold to 448 bytes
Jan  6 10:12:29 larry kernel: eth0: Increasing Tx FIFO threshold to 464 bytes

I also recall getting errors like "Something Wicked happened", but I
don't seem to be able to find them in the log right now.

Thanks,

M.
