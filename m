Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266343AbRGFJss>; Fri, 6 Jul 2001 05:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266346AbRGFJsi>; Fri, 6 Jul 2001 05:48:38 -0400
Received: from elin.scali.no ([195.139.250.10]:34833 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S266343AbRGFJsT>;
	Fri, 6 Jul 2001 05:48:19 -0400
Message-ID: <3B458888.75C50552@scali.no>
Date: Fri, 06 Jul 2001 11:44:40 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@idb.hist.no>
CC: Vasu Varma P V <pvvvarma@techmas.hcltech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: DMA memory limitation?
In-Reply-To: <3B4453E6.F4342781@techmas.hcltech.com> <3B457DE6.AFEE6696@idb.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> Vasu Varma P V wrote:
> >
> > Hi,
> >
> > Is there any limitation on DMA memory we can allocate using
> > kmalloc(size, GFP_DMA)? I am not able to acquire more than
> > 14MB of the mem using this on my PCI SMP box with 256MB ram.
> > I think there is restriction on ISA boards of 16MB.
> > Can we increase it ?
> 
> You can allocate a lot more memory for your pci activities.
> No problem there.  Just drop the "GFP_DMA" and you'll get
> up to 1G or so.
> 
> You shouldn't use GFP_DMA because PCI cards don't need that.
> Only ISA cards needs GFP_DMA because they can't use more
> than 16M.  So obviously GFP_DMA is limited to
> 16M because it is really ISA_DMA.
> 
> PCI don't need such special tricks, so don't use GFP_DMA!
> Your PCI cards is able to DMA into any memory, including
> the non-GFP_DMA memory.
> 
> > but we have a macro in include/asm-i386/dma.h,
> > MAX_DMA_ADDRESS  (PAGE_OFFSET+0x1000000).
> >
> > if i change it to a higher value, i am able to get more dma
> > memory. Is there any way i can change this without compiling
> > the kernel?
> >
> No matter what you do, DON'T change that.  Yeah, you'll get
> a bigger GFP_DMA pool, but that'll break each and every
> ISA card that tries to allocate GFP_DMA memory.  You
> achieve exactly the same effect for your PCI card by ditching
> the GFP_DMA parameter, but then you achieve it without breaking
> ISA cards.
> 
A problem arises on 64 bit platforms (such as IA64) if your PCI card is only 32bit (can
address the first 4G) and you don't wan't to use bounce buffers. If you use GFP_DMA on
IA64 you are ensured that the memory you get is below 4G and not 16M as on i386, hence no
bounce buffers are needed. On Alpha GFP_DMA is not limited at all (I think). Correct me if
I'm wrong, but I really think there should be a general way of allocating memory that is
32bit addressable (something like GFP_32BIT?) so you don't need a lot of #ifdef's in your
code.

Regards,
-- 
  Steffen Persvold               Systems Engineer
  Email : mailto:sp@scali.no     Scali AS (http://www.scali.com)
  Tlf   : (+47) 22 62 89 50      Olaf Helsets vei 6
  Fax   : (+47) 22 62 89 51      N-0621 Oslo, Norway
