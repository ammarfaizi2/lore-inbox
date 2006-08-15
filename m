Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752103AbWHOP0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbWHOP0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbWHOP0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:26:36 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:3253 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752103AbWHOP0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:26:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A5CdhodelUkK2F+8ddQBRhWVL0i2gtoZS9JXDaJKxCoBttixzbIXQQZ6WbNKLRDGGUM82txR0t0mEjQBe3yvBWpuYN4y8RvyyAyWYdOiEJu1DepRsiiOHaqnTTYKq2jz8ERgtpPcLuh5EMaZnEtOyvJ0L8M0jAuZiBigTPs9g3o=
Message-ID: <b0943d9e0608150826y29d00818n557ac5363533ecda@mail.gmail.com>
Date: Tue, 15 Aug 2006 16:26:34 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0608150825s5b15c838t4cc1eaa9c0d73a63@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <6bffcb0e0608130459k1c7e142esbfc2439badf323bd@mail.gmail.com>
	 <b0943d9e0608140834w7c338203lfdaf108c0b89fe39@mail.gmail.com>
	 <b0943d9e0608150825s5b15c838t4cc1eaa9c0d73a63@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 14/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > The kmemleak+slab locking is a bit complicated because memleak itself
> > needs to allocate memory and avoid recursive calls to it (the
> > pointer_cache and the radix_tree allocations). The kmemleak-related
> > allocations are not tracked by kmemleak.
> >
> > I see the following solutions:
> >
> > 1. acquire the memleak_lock at the beginning of an alloc/free function
> > and release it when finished while allowing recursive/nested calls
> > (and only call the memleak_* functions during the outermost lock).
> > This would mean ignoring the off-slab management allocations as these
> > would lead to deadlock because of the recursive call into kmemleak.
> > This locking should be placed around cache_reap() as well (actually,
> > around all the entry points in the mm/slab.c file).
>
> This would actually work because the slab allocation functions may sleep.

I meant "would *not*" above.

-- 
Catalin
