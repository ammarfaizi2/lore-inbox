Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266312AbRGFJAR>; Fri, 6 Jul 2001 05:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266317AbRGFJAI>; Fri, 6 Jul 2001 05:00:08 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:58635 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S266312AbRGFI74>; Fri, 6 Jul 2001 04:59:56 -0400
Message-ID: <3B457DE6.AFEE6696@idb.hist.no>
Date: Fri, 06 Jul 2001 10:59:18 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Vasu Varma P V <pvvvarma@techmas.hcltech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA memory limitation?
In-Reply-To: <3B4453E6.F4342781@techmas.hcltech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasu Varma P V wrote:
> 
> Hi,
> 
> Is there any limitation on DMA memory we can allocate using
> kmalloc(size, GFP_DMA)? I am not able to acquire more than
> 14MB of the mem using this on my PCI SMP box with 256MB ram.
> I think there is restriction on ISA boards of 16MB.
> Can we increase it ?

You can allocate a lot more memory for your pci activities.
No problem there.  Just drop the "GFP_DMA" and you'll get 
up to 1G or so.

You shouldn't use GFP_DMA because PCI cards don't need that.
Only ISA cards needs GFP_DMA because they can't use more
than 16M.  So obviously GFP_DMA is limited to
16M because it is really ISA_DMA.

PCI don't need such special tricks, so don't use GFP_DMA!
Your PCI cards is able to DMA into any memory, including
the non-GFP_DMA memory.

> but we have a macro in include/asm-i386/dma.h,
> MAX_DMA_ADDRESS  (PAGE_OFFSET+0x1000000).
> 
> if i change it to a higher value, i am able to get more dma
> memory. Is there any way i can change this without compiling
> the kernel?
> 
No matter what you do, DON'T change that.  Yeah, you'll get
a bigger GFP_DMA pool, but that'll break each and every 
ISA card that tries to allocate GFP_DMA memory.  You
achieve exactly the same effect for your PCI card by ditching
the GFP_DMA parameter, but then you achieve it without breaking
ISA cards.

Helge Hafting
