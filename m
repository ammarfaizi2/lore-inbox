Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275682AbRJFUNY>; Sat, 6 Oct 2001 16:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275687AbRJFUNO>; Sat, 6 Oct 2001 16:13:14 -0400
Received: from smtp-rt-12.wanadoo.fr ([193.252.19.60]:30915 "EHLO
	tamaris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S275685AbRJFUNG>; Sat, 6 Oct 2001 16:13:06 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>
Subject: Re: %u-order allocation failed
Date: Sat, 6 Oct 2001 22:13:03 +0200
Message-Id: <20011006201303.20370@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.3.96.1011006203014.7808A-100000@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.3.96.1011006203014.7808A-100000@artax.karlin.mff.cuni.cz>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>OK, but my patch uses vmalloc only as a fallback when buddy fails. The
>probability that buddy fails is small. It is slower but with very small
>probability.
>
>It is perfectly OK to have a bit slower access to task_struct with
>probability 1/1000000.
>
>But it is ***BAD*BUG*** if allocation of task_struct fails with
>probability 1/1000000.

I missed the beginning of the thread, sorry if that question was
already answered,

What about all the code that still consider kmalloc'ed memory is
safe for use with virt_to_bus and friends and is contiguous
physically for DMA ? In some cases (non-PCI devices, embedded
platforms, etc...), the pci_consistent API is not an option.
That means that __GFP_VMALLOC can't be part of GFP_KERNEL or
many driver will break in horrible ways (random memory corruption).

Ben.


