Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVGDD6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVGDD6o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 23:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVGDD6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 23:58:43 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:18569 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261385AbVGDD6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 23:58:39 -0400
Date: Sun, 3 Jul 2005 20:58:34 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ISA DMA API documentation
Message-Id: <20050703205834.51b43435.rdunlap@xenotime.net>
In-Reply-To: <42C712C9.7080603@drzeus.cx>
References: <42C712C9.7080603@drzeus.cx>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jul 2005 00:18:49 +0200 Pierre Ossman wrote:

| Documentation for how the ISA DMA controller is handled in the kernel.
| 
| Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
| 
| I found the documentation about the ISA DMA controller a bit lacking so
| I figured I could save the next guy some work by documentation the
| lessons learned.
| 
| (English is not my native language so please feel free to point out any
| problems with spelling or grammar.)

+The first is the generic DMA API used to convert virtual addresses to
+physical addresses (see DMA-API.txt for details).
                    (see Documentation/DMA-API.txt for details).

We generally try to use file/path names rooted at the top-level
linux directory.


+The DMA:able address space is the lowest 16 MB of _physical_ memory.
 The DMA-able
+Also the transfer block may not cross page boundaries (which are 64k).
 I would write:                                        (which are 64 KB).

if I knew that was correct, but I don't.
Does Linux limit all ISA-DMA to not crossing 64 KB boundaries?
I haven't looked at the code yet, just PC-AT Technical Reference,
which says that DMA controller 1 is limited to 8-bit transfers and
64 KB blocks and DMA controller 2 is limited to 16-bit data transfers
and 128 KB boundaries.
Does i386-compatible and later chipsets or LPC change/affect this?
(I see that you cover 8/16-bit transfers later in the doc.)

+To translate the virtual address to a physical use the normal DMA
+API. Do _not_ use isa_virt_to_phys() even though it does the same
+thing. The reason for this is that you will get a requirement to ISA
+(instead of only ISA_DMA_API).

I don't understand what you are trying to say in:
... is that you will get a requirement to ISA....
Oh, it's Kconfig-related, right?  So maybe:
"... is that you will get a config requirement for ISA..." ?


+Set the address from where the transfer should start (this needs to
+be word-aligned for 16-bit transfers) and how many bytes to transfer.

"word-aligned" is probably ambiguous to some people and in some
x86 CPU modes.  Better to say "16-bit aligned" IMO.

+flags = claim_dma_flags();

Should be claim_dma_lock();

+if (dma_get_residue(channel) != 0)
+	printk(KERN_ERR "Incomplete DMA transfer!\n");

A printk should identify where it comes from (like a module ID or
source file name) and possibly what DMA channel and how much
residue there was (but at least the module/source ID).

+It is the drivers' responsibility to make sure that the machine isn't

           driver's

HTH.
---
~Randy
