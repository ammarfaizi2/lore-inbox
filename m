Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbUKCKqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbUKCKqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 05:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUKCKp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 05:45:59 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:32263 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261537AbUKCKpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 05:45:10 -0500
Date: Wed, 3 Nov 2004 10:45:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org, akpm@osdl.org,
       davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 14/14] FRV: Better mmap support in uClinux
Message-ID: <20041103104502.GA18531@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <20041102095418.GE5841@infradead.org> <20040401020550.GG3150@beast> <200411011930.iA1JUMQe023259@warthog.cambridge.redhat.com> <26128.1099413805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26128.1099413805@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 04:43:25PM +0000, David Howells wrote:
> 
> > > diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/base.c linux-2.6.10-rc1-bk10-frv/fs/proc/base.c
> > ...
> > 
> > please split this up into a mmu and a no-mmu function, in a mmu and nommu
> > file respectively.
> 
> What would you say to this function being moved into the mm/ directory?
> Perhaps in mm/proc.c.

I think it should stay in procfs.  And we already have an mmu and a no-mmu
function there.

> > > +/* list of shareable VMAs */
> > > +LIST_HEAD(shareable_vma_list);
> > > +DECLARE_RWSEM(shareable_vma_sem);
> > 
> > the should both be static
> 
> I'm intending to do a /proc file to allow this list to be viewed.

So provide a proper iterator once you do that.  Global lists are very
bad coding style.

> > >  	vma->vm_ops = &generic_file_vm_ops;
> > > +#endif
> > 
> > please find a nice way to abstract this out without the ifdefs here.
> 
> Why? The #ifdef tells you exactly what you need to know. This _is_ the right
> way to do it. Doing otherwise just makes the code less obvious. However, if
> you can come up with a better way, I'll review the patch for you.

shmem_zero_setup is already duplicated in shmem.c and tiny-shmem.c just
with different vm_ops.

So yes, please provide a set_devzero_vmops macro that is NULL for no-MMU
ports and allows to merge the existing two copies of the function.

