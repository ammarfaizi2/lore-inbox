Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSEABAD>; Tue, 30 Apr 2002 21:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315280AbSEABAC>; Tue, 30 Apr 2002 21:00:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20201 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315279AbSEABAA>; Tue, 30 Apr 2002 21:00:00 -0400
Message-Id: <200205010056.g410ujG03375@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] discontigmem support for ia32 NUMA box against 2.4.19pre7 
In-Reply-To: Message from Christoph Hellwig <hch@infradead.org> 
   of "Tue, 30 Apr 2002 07:26:54 BST." <20020430072654.B2262@infradead.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Apr 2002 17:56:45 -0700
From: Patricia Gaughen <gone@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  > On Mon, Apr 29, 2002 at 06:15:26PM -0700, Patricia Gaughen wrote:
  > > +	if [ "$CONFIG_MULTIQUAD" = "y" ]; then
  > > +   	bool 'Discontiguous Memory Support' CONFIG_DISCONTIGMEM
  > > +		if [ "$CONFIG_DISCONTIGMEM" = "y" ]; then
  > > +		define_bool CONFIG_DISCONTIGMEM_X86 y
  > > +		define_bool CONFIG_IBMNUMAQ y
  > > +		define_bool CONFIG_NUMA y
  > > +		fi
  > > +	fi
  > 
  > CML code uses three tab indentes. Also the way you do the config looks
  > rather strange. I'd rather ask for IBM NUMAQ support and imply NUMA &
  > DISCONTIGMEM support if set.  Also CONFIG_DISCONTIGMEM_X86 looks like
  > an ugly workaround to me, all places where it is used should rather check
  > for one of CONFIG_DISCONTIGMEM/CONFIG_NUMA/CONFIG_IBMNUMAQ.
  > (and CONFIG_IBMNUMAQ would better be named CONFIG_X86_NUMAQ, IMHO).

the CONFIG_DISCONTIGMEM_X86 option was added for using in ifndef'ing some 
stuff (see include/linux/bootmem.h and mm/bootmem.c) in the common code.  I 
didn't want to use CONFIG_DISCONTIGMEM because it would break things for other 
archs.

I admit that my config options could use some work.... I'll change it so that 
you're asked for IBM NUMAQ support and it turns on 
CONFIG_DISCONTIGMEM/CONFIG_DISCONTIGMEM_X86/CONFIG_NUMA/CONFIG_IBMNUMAQ.  I'll 
also fix the spacing :-)

  > 
  > > +
  > > +#ifdef CONFIG_SMP
  > > +	/*
  > > +	 * But first pinch a few for the stack/trampoline stuff
  > > +	 * FIXME: Don't need the extra page at 4K, but need to fix
  > > +	 * trampoline before removing it. (see the GDT stuff)
  > > +	 */
  > > +	reserve_bootmem_node(NODE_DATA(0), PAGE_SIZE, PAGE_SIZE);
  > > +#endif
  > 
  > Umm, NUMA without SMP looks rather strange to me..

true.  I'll fix that.  Sort of on this topic, I had considered removing the 
CONFIG_HIGHMEM ifdef's because you need to have highmem turned on to use this 
code (I should do some magic in the config file to make sure that happens), 
but I hadn't done that as of yet... any opinions on this?

Thanks,
Pat

