Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUBDQLW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 11:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUBDQLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 11:11:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:188 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263125AbUBDQLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 11:11:20 -0500
Date: Wed, 4 Feb 2004 08:05:15 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Stelian Pop <stelian@popies.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] meye: correct printk of dma_addr_t
Message-Id: <20040204080515.63eb4b96.rddunlap@osdl.org>
In-Reply-To: <20040204084437.GA13455@deep-space-9.dsnet>
References: <20040203153606.76442b9c.rddunlap@osdl.org>
	<20040203155752.17a8e274.akpm@osdl.org>
	<20040203162822.64ee18e1.rddunlap@osdl.org>
	<20040204084437.GA13455@deep-space-9.dsnet>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004 09:44:37 +0100 Stelian Pop <stelian@popies.net> wrote:

| On Tue, Feb 03, 2004 at 04:28:22PM -0800, Randy.Dunlap wrote:
| 
| > | mchip_ptable[] just contains pointers to kernel memory.  It doesn't seem
| > | appropriate to be casting these to dma_addr_t's
| > 
| > 
| > Ugh... if I am reading this correcly, what I see is that
| > mchip_table[] is mostly used for kernel pointers, like you say.
| 
| Yep. The meye driver uses 256 PAGE_SIZE buffers. The kernel virtual
| pointers to these buffers are stored in mchip_ptable[]. The
| "toc" containing the dma pointers to these buffers must be given
| to the device as a table having 256 entries, each being 32 bits in length.
| 
| In the code I used the last entry of mchip_ptable to store the toc,
| but I could as well construct a different data structure.
| 
| Anyway, the device expects a dma_addr to be 32 bits in length, so this
| will not work anyway with HIGHMEM32 (moreover, this is a driver for the
| motion eye camera which is found only in C1 Vaio Sony laptops, which
| motherboard is limited to 384 MB...).
| 
| I can see only two solutions:
| 	*) put the toc in a different, dma_addr_t[] structure, so the
| 	   driver will compile even with HIGHMEM32 (but won't work...)
| 
| 	*) exclude meye from kernel config when HIGHMEM32 is set.

  for (HIGHMEM64G=y)

| Which one do you prefer ?


Well, both.  :)

The toc of dma_addr_t's should be in its own array/structure.

Adding some comments or help text about the highmem limitation
would also be good.

--
~Randy
