Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUEQPsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUEQPsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUEQPsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:48:35 -0400
Received: from web50005.mail.yahoo.com ([206.190.38.20]:15540 "HELO
	web50005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261693AbUEQPsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:48:32 -0400
Message-ID: <20040517154831.81383.qmail@web50005.mail.yahoo.com>
Date: Mon, 17 May 2004 08:48:31 -0700 (PDT)
From: fc scsi <scsi_fc_group@yahoo.com>
Subject: Re: _PAGE_PCD bit in DMAable memory
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <52r7tjx09t.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the reply and the information. Actually,
the code will have to run on Intel Xscale
processor(ARM based). Since I don't have Linux running
on the board as of now, I was trying out things on my
i386 machine to get non-cacheable memory. That was
when I thought that GFP_DMA should give me
non-cacheable memory(_PAGE_PCD on i386 should be set
for such a memory, and L_PTE_CACHEABLE should be clear
on Xscale by this analogy). But, as you have explained
_PAGE_PCD need not be set for non-cacheable memory for
i386. I am new to Xscale architecture and don't know
if pci_alloc_consistent() will give me non-cacheable
memory or not. Can anyone who has worked on Xscale
confirm this.

Another curiousity for me is, if
pci_alloc_consistent() gives non-cacheable memory for
Xscale(arm) then will the L_PTE_CACHEABLE bit set in
it or not?

Anyway, thanks Roland for the previous answer. It was
a great help.

Regards.


--- Roland Dreier <roland@topspin.com> wrote:
>     fc> Hi, I am trying to get DMAable memory on
> i386
>     fc> (kmalloc(GFP_DMA,)) but seems _PAGE_PCD is
> not set on the
>     fc> pages that i get back the memory from. Am I
> getting the
>     fc> correct results? If yes, then is it not that
> GFP_DMA should
>     fc> give me non-cacheable memory (equivalent to
> setting _PAGE_PCD
>     fc> along with _PAGE_PWT on i386). Can anyone
> confirm for me that
>     fc> GFP_DMA will *always* give me non-cacheable
> and contiguous
>     fc> memory.
> 
> On i386, the GFP_DMA flag controls _where_ the
> memory will be
> allocated, namely in the low 16 MB.  This is really
> a relic of the
> days of 24-bit ISA DMA.
> 
> On i386, the memory does not have to be
> non-cacheable, since in the PC
> architecture the bus controller will maintain
> consistency by snooping
> the CPU.  However, to be portable, your code should
> use
> pci_alloc_consistent() to get memory for DMAing. 
> This will do the
> right thing on all platforms, including making sure
> that the memory is
> non-cacheable on architectures where the bus
> controller does not snoop.
> 
> (By the way, kmalloc() will always return contiguous
> memory, but you
> should still use pci_alloc_consistent for DMA
> memory)
> 
>  - Roland



	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/
