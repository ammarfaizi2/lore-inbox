Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314232AbSEITc7>; Thu, 9 May 2002 15:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314238AbSEITc6>; Thu, 9 May 2002 15:32:58 -0400
Received: from imladris.infradead.org ([194.205.184.45]:265 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314232AbSEITc4>; Thu, 9 May 2002 15:32:56 -0400
Date: Thu, 9 May 2002 20:32:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patricia Gaughen <gone@us.ibm.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] discontigmem support for ia32 NUMA box against 2.4.19pre8
Message-ID: <20020509203202.A27148@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patricia Gaughen <gone@us.ibm.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
In-Reply-To: <hch@infradead.org> <200205091840.g49Ie3C02733@w-gaughen.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 11:40:03AM -0700, Patricia Gaughen wrote:
>   > Urgg, sourceforge seems to have turned these nice links into some download
>   > selector crap.  I think it's really time to stop using it as it gets worse
>   > all time..
>   > Any chance you could post links directly to one of the mirrors next time?
> 
> Do you want something like this:
> 
> http://prdownloads.sourceforge.net/lse/x86_discontigmem-2.4.19pre8.patch?use_mi
> rror=unc

Seems to have the same problems. The following seems to work nicely for me:

	http://belnet.dl.sourceforge.net/sourceforge/lse/x86_discontigmem-2.4.19pre8.patch

> 
> oh man, and I just added that in to core_ibmnumaq.c :-)
> 
> you're right, the naming was based on alpha's naming scheme, will change it.

Btw, please also do a s/ibmnumaq/numaq/.  Everyone actually reading
the code should know it's from IBM and given that the design actually
originated at Sequent..

>   > Okay, this comes to the next issue, you seem to use CONFIG_DISCONTIGMEM
>   > and CONFIG_X86_DISCONTIGMEM interchangable in arch/i386/* and numa.c in
>   > fact has a big #ifdef CONFIG_X86_DISCONTIGMEM around all of the code.
>   > AFAICS CONFIG_X86_DISCONTIGMEM is really the selector for the bootmem
>   > workarounds and I think it shouldn't be used anywhere else, or even better
>   > replaced by and HAVE_ARCH_BOOTMEM_NODE #define in asm/pgtable.h.
> 
> yes, I agree and that was my intention with CONFIG_X86_DISCONTIGMEM.  I'll fix 
> them.
> 
> Let me make sure I understand what you mean, you're thing that 
> HAVE_ARCH_BOOTMEM_NODE should be turned on in asm/pgtable.h when 
> CONFIG_DISCONTIGMEM is defined?  If that's so, I'll make the change.

For i386, yes.  It looks to me (please correct me that I'm wrong), that
the ifdefs in bootmem.h are to allow architecture-specific versions
of the *_node functions.  This could also be needed by other architectures
and really isn't a config options.  I think because of this such a
feature-define looks more apropinquate to me then a CONFIG_ option.

