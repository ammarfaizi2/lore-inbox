Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbULFCB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbULFCB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 21:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbULFCB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 21:01:26 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:39884 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261452AbULFCBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 21:01:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pTf6ujLZDV/96n5Q2mqjfsvc5WcOZ1m+EmLeRpBitNhO1edhwVPYwERlRDVx2z9Hf9bQVGmvqt+3ryVl0JMTEvagHY0IdTLhnIfVDEcGH8KL0xK3vvQcs5O76wFuO5Ie14G2SnuC3fCV8qY4SAhd1S8bs6L3PVeTWp2keE0tA/8=
Message-ID: <3b2b32004120517563bf408f@mail.gmail.com>
Date: Sun, 5 Dec 2004 20:56:45 -0500
From: Linh Dang <dang.linh@gmail.com>
Reply-To: Linh Dang <dang.linh@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH][PPC32[NEWBIE] enhancement to virt_to_bus/bus_to_virt (try 2)
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <16819.31194.561882.514591@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3b2b32004120206497a471367@mail.gmail.com>
	 <3b2b320041202082812ee4709@mail.gmail.com>
	 <16815.31634.698591.747661@cargo.ozlabs.ibm.com>
	 <3b2b32004120306463b016029@mail.gmail.com>
	 <16819.31194.561882.514591@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004 08:12:58 +1100, Paul Mackerras <paulus@samba.org> wrote:
> Linh Dang writes:
> 
> > I wrote a DMA engine (to used by other drivers) that (would like to) accept
> > all kind of buffers as input (vmalloced, dual-access shared RAM mapped
> > by BATs, etc). The DMA engine has to decode the virtual address of the
> > input buffer to (possibly multiple) physical  address(es). virt_to_phys()
> > has the right name for the job except it only works for the kernel virtual
> > addresses initially mapped at KERNELBASE
> 
> Have you read Documentation/DMA-API.txt?  It explains the official
> kernel API for DMA, and drivers should use it in order to be portable
> to more than just one architecture.

>From further reading of that text, I don't think it's what I'm looking for.
The DMA-API.txt file describes the official API for mapping an kernel
virtual address to something usable by the DMA of the bus-master
capable device.

On a many embedded ppc32 platforms, the bridge is capable of
performing DMA  (usually called IDMA) between RAM ram and
NON-busmaster-devices. Examples of such platforms are the
PowerQuiccII, PowerQuiccIII, the Marvell Discovery I,II,II, etc.

Such DMA operations are very useful because CPU cycles are
precious on many embedded platforms.

What I'm looking for is the Linux way or the Linux equivalent of:

  http://fxr.watson.org/fxr/source/dev/marvell/gtidma.c?v=NETBSD


Oh, a side question, in Linux/Unix world, is it acceptable to DMA
data directly from/to the userspace buffer? Something like:

         int fd = open("/dev/my_asic0", O_RDWR);
         int buffer = calloc(40, 4096);
         int n = pread64(fd, buffer, 40 * 4096, SOME_ADDR);

and the IDMA engine would transfer 40 pages from my_asic0's
shared-ram directly into `buffer'.

Thanx
-- 
Linh Dang
