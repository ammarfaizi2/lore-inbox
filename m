Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314093AbSEISoy>; Thu, 9 May 2002 14:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314094AbSEISox>; Thu, 9 May 2002 14:44:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48887 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314093AbSEISow>; Thu, 9 May 2002 14:44:52 -0400
Message-Id: <200205091840.g49Ie3C02733@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Christoph Hellwig <hch@infradead.org>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] discontigmem support for ia32 NUMA box against 2.4.19pre8 
In-Reply-To: Message from Christoph Hellwig <hch@infradead.org> 
   of "Thu, 09 May 2002 10:28:01 BST." <20020509102801.A9548@infradead.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 May 2002 11:40:03 -0700
From: Patricia Gaughen <gone@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  > > The discontigmem patch is available at:
  > > 
  > > http://prdownloads.sourceforge.net/lse/x86_discontigmem-2.4.19pre8.patch
  > 
  > Urgg, sourceforge seems to have turned these nice links into some download
  > selector crap.  I think it's really time to stop using it as it gets worse
  > all time..
  > Any chance you could post links directly to one of the mirrors next time?

Do you want something like this:

http://prdownloads.sourceforge.net/lse/x86_discontigmem-2.4.19pre8.patch?use_mi
rror=unc

  > 
  > >  if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
  > > --- linux-2.4.19pre8-cleanup/arch/i386/kernel/Makefile	Fri Nov  9 14:2
  > 1:21 2001
  > > +++ linux-2.4.19pre8-multi/arch/i386/kernel/Makefile	Wed May  8 11:0
  > 9:21 2002
  > > @@ -40,5 +40,7 @@
  > >  obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
  > >  obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o acpitable.o
  > >  obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
  > > +obj-$(CONFIG_X86_NUMAQ)		+= core_ibmnumaq.o
  > 
  > The core_ibmnumaq.* naming looks strange to me.  It seems derived from the
  > alpha naming where we support many different cores.  I think numaq.c
  > would fit much better in the naming of the other files in arch/i386/kernel/
  > .
  > Please also note that the ifdef around the whole file body in core_ibmnumaq
  > .c
  > is superflous as we already have the kbuild conditional.

oh man, and I just added that in to core_ibmnumaq.c :-)

you're right, the naming was based on alpha's naming scheme, will change it.

  > 
  > > +obj-$(CONFIG_DISCONTIGMEM)	+= numa.o
  > 
  > Okay, this comes to the next issue, you seem to use CONFIG_DISCONTIGMEM
  > and CONFIG_X86_DISCONTIGMEM interchangable in arch/i386/* and numa.c in
  > fact has a big #ifdef CONFIG_X86_DISCONTIGMEM around all of the code.
  > AFAICS CONFIG_X86_DISCONTIGMEM is really the selector for the bootmem
  > workarounds and I think it shouldn't be used anywhere else, or even better
  > replaced by and HAVE_ARCH_BOOTMEM_NODE #define in asm/pgtable.h.

yes, I agree and that was my intention with CONFIG_X86_DISCONTIGMEM.  I'll fix 
them.

Let me make sure I understand what you mean, you're thing that 
HAVE_ARCH_BOOTMEM_NODE should be turned on in asm/pgtable.h when 
CONFIG_DISCONTIGMEM is defined?  If that's so, I'll make the change.


  > 
  > Also why is this file named numa.c and depends on CONFIG_DISCONTIGMEM?
  > Either it is NUMA-specific and depends on CONFIG_NUMA or it is dicontig
  > code and should be named discontig.c or something like that.  This file
  > is completly about memory managment, btw so I wonder why it isn't placed
  > in arch/i386/mm/..

will change this.

  > 
  > 
  > > -static inline int page_is_ram (unsigned long pagenr)
  > > +inline int page_is_ram (unsigned long pagenr)
  > 
  > What about makeing this a static inline in one of the asm/ headers?
  > This way the external users also have it inline and I know besides
  > NUMAQ at least the LKCD people also want it.

okay, can do that.  I'm planning on moving it to page.h.  

  > 
  > > --- linux-2.4.19pre8-cleanup/include/asm-i386/mmzone.h	Wed Dec 31 16:0
  > 0:00 1969
  > > +++ linux-2.4.19pre8-multi/include/asm-i386/mmzone.h	Wed May  8 11:0
  > 9:21 2002
  > > @@ -0,0 +1,103 @@
  > > +/*
  > > + * Written by Pat Gaughen (gone@us.ibm.com) Mar 2002
  > > + *
  > > + */
  > > +
  > > +#ifndef _ASM_MMZONE_H_
  > > +#define _ASM_MMZONE_H_
  > > +
  > > +#ifdef CONFIG_DISCONTIGMEM
  > <snip>
  > > +#endif /* CONFIG_X86_DISCONTIGMEM */
  > 
  > hmm?

whoops!

I'll try to have a new patch out later today.

BTW, thanks for the feedback, I really appreciate it.

-Pat


-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/


