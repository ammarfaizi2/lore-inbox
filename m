Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264802AbSJaKJe>; Thu, 31 Oct 2002 05:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264803AbSJaKJe>; Thu, 31 Oct 2002 05:09:34 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:48914 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S264802AbSJaKJc>; Thu, 31 Oct 2002 05:09:32 -0500
Date: Thu, 31 Oct 2002 10:15:58 +0000
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Peter Chubb <peter@chubb.wattle.id.au>, tridge@samba.org, tytso@mit.edu
Subject: Re: What's left over.
Message-ID: <20021031101558.GB7487@fib011235813.fsnet.co.uk>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <20021031030143.401DA2C150@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031030143.401DA2C150@lists.samba.org>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 02:00:31PM +1100, Rusty Russell wrote:
> > > EVMS
> > 
> > Not for the feature freeze, there are some noises that imply that SuSE may 
> > push it in their kernels. 
> 
> They have, IIRC.  Interestingly, it was less invasive (existing source
> touched) than the LVM2/DM patch you merged.

FUD.  I added to three areas of existing code:

i) Every man and his dog uses mempools in conjuction with slabs, so
   rather than having everyone redefining their own alloc/free
   functions I added the following huge functions to mempool.c.  In no
   way were they mandatory.

    /*
     * A commonly used alloc and free fn.
     */
    void *mempool_alloc_slab(int gfp_mask, void *pool_data)
    {
            kmem_cache_t *mem = (kmem_cache_t *) pool_data;
            return kmem_cache_alloc(mem, gfp_mask);
    }

    void mempool_free_slab(void *element, void *pool_data)
    {
            kmem_cache_t *mem = (kmem_cache_t *) pool_data;
            kmem_cache_free(mem, element);
    }

ii) vcalloc, this *didn't* get merged, and will probably end up getting
    moved into dm.h.

iii) ioctl32 support: people have argued against an ioctl interface,
     and I'm inclined to agree with them, which is why I'm going to
     publish an fs interface shortly.  However, given that we are
     currently using an ioctl interface how do we avoid adding support for
     32bit userland/64 kernel space ?  If EVMS isn't touching these
     files does that mean they're not supporting these architectures ?

        arch/mips64/kernel/ioctl32.c
        arch/ppc64/kernel/ioctl32.c
        arch/s390x/kernel/ioctl32.c
        arch/sparc64/kernel/ioctl32.c


So given that (ii) didn't get merged, which of (i) and (iii) were you
objecting to ?

- Joe
