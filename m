Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUBDIoy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 03:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266226AbUBDIox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 03:44:53 -0500
Received: from m244.net81-65-141.noos.fr ([81.65.141.244]:43190 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S264391AbUBDIow
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 03:44:52 -0500
Date: Wed, 4 Feb 2004 09:44:37 +0100
From: Stelian Pop <stelian@popies.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] meye: correct printk of dma_addr_t
Message-ID: <20040204084437.GA13455@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040203153606.76442b9c.rddunlap@osdl.org> <20040203155752.17a8e274.akpm@osdl.org> <20040203162822.64ee18e1.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203162822.64ee18e1.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 04:28:22PM -0800, Randy.Dunlap wrote:

> | mchip_ptable[] just contains pointers to kernel memory.  It doesn't seem
> | appropriate to be casting these to dma_addr_t's
> 
> 
> Ugh... if I am reading this correcly, what I see is that
> mchip_table[] is mostly used for kernel pointers, like you say.

Yep. The meye driver uses 256 PAGE_SIZE buffers. The kernel virtual
pointers to these buffers are stored in mchip_ptable[]. The
"toc" containing the dma pointers to these buffers must be given
to the device as a table having 256 entries, each being 32 bits in length.

In the code I used the last entry of mchip_ptable to store the toc,
but I could as well construct a different data structure.

Anyway, the device expects a dma_addr to be 32 bits in length, so this
will not work anyway with HIGHMEM32 (moreover, this is a driver for the
motion eye camera which is found only in C1 Vaio Sony laptops, which
motherboard is limited to 384 MB...).

I can see only two solutions:
	*) put the toc in a different, dma_addr_t[] structure, so the
	   driver will compile even with HIGHMEM32 (but won't work...)

	*) exclude meye from kernel config when HIGHMEM32 is set.
	
Which one do you prefer ?

Stelian.
-- 
Stelian Pop <stelian@popies.net>
