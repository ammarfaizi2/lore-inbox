Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVCET2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVCET2L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVCET1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:27:19 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:15754 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261155AbVCES7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:59:17 -0500
Subject: Re: 2.6.11-mm1 (x86-abstract-discontigmem-setup.patch)
From: Dave Hansen <haveblue@us.ibm.com>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200503051535.24372.adobriyan@mail.ru>
References: <200503051535.24372.adobriyan@mail.ru>
Content-Type: text/plain
Date: Sat, 05 Mar 2005 10:58:57 -0800
Message-Id: <1110049138.6446.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-05 at 15:35 +0200, Alexey Dobriyan wrote:
> > +	}
> > +	printk(KERN_DEBUG "\n");
> 	       ^^^^^^^^^^
> > +}
> 
> Too much KERN_DEBUG.

On my system, that ends up printing out 4 or 5 lines of output per node,
but it's quite invaluable if you're debugging early memory setup issues.
It is KERN_DEBUG after all.  What does it do on your system?

I'm not horribly opposed to removing some of this output, let's just
make sure...

> > --- 25/include/linux/mmzone.h~x86-abstract-discontigmem-setup
> > +++ 25-akpm/include/linux/mmzone.h
> 
> > +#ifdef CONFIG_HAVE_MEMORY_PRESENT
> > +void memory_present(int nid, unsigned long start, unsigned long end);
> > +#else
> > +static inline void memory_present(int nid, unsigned long start, unsigned long end) {}
> > +#endif
> 
> > +#ifdef CONFIG_NEED_NODE_MEMMAP_SIZE
> > +unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
> > +#endif
> 
> 	#else
> 	static inline unsigned long node_memmap_size_bytes(...);
> 	#endif
> 
> Is this needed?

It's really only used for the i386 NUMA architectures, but it is
necessary.  We'll be overriding that discontigmem version for sparsemem,
which I'll be submitting soon:

http://www.sr71.net/patches/2.6.11/2.6.11-mhp1/broken-out/B-sparse-150-sparsemem.patch


-- Dave

