Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264760AbSJORMH>; Tue, 15 Oct 2002 13:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264758AbSJORKo>; Tue, 15 Oct 2002 13:10:44 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:38662 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264748AbSJORKY>; Tue, 15 Oct 2002 13:10:24 -0400
Date: Tue, 15 Oct 2002 18:16:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.42uc1 (MMU-less support)
Message-ID: <20021015181609.A31647@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg Ungerer <gerg@snapgear.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3DAC337D.7010804@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAC337D.7010804@snapgear.com>; from gerg@snapgear.com on Wed, Oct 16, 2002 at 01:25:49AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 01:25:49AM +1000, Greg Ungerer wrote:
> Hi All,
> 
> An updated uClinux patch is available at:
> 
> http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.42uc1.patch.gz
> 
> Changelog:
> 
> 1. v850 update

There are a bunch of CVS .#* files left from this one.
v850_defs.h wants updating to the generic generate-asm-offsets.h
mechanism (check the toplevel Makefile)
Please stop the ugly symlink hell with the linker scripts -
we have vmlinux.lds.S for that.
it should read something like:

#include <linux/config.h>
#ifdef BOARD1
#include "board1.lds"
#else
...
#endif

for v850

Could you please explain the rootfs hacks in v850?
I don't think we want those in mainline but rather generic
initrd/initramfs.

Also please remove arch/v850/sim/* - that stuff doesn't
belong into the kernel tree.

> 2. cleaned up mm/page_alloc.c

Why do you put set_page_refs into a header?  Separating it out
looks good to me, but IMHO it should stay in page_alloc.c.
BTW, are you sure that you don't need to set the refs in the
other caller of prep_new_page?  To me it looks like you should
and then you could merge it into prep_new_page.

Also, what is CONFIG_CONTIGUOUS_PAGE_ALLOC doing?  It seems not
fully implemented but adds lots of uglieness :)
CONFIG_NO_MMU_LARGE_ALLOCS might want a saner name, btw
(CONFIG_LARGE_ALLOCS?).

General commets:
- Config.in files have three-space, not two-space indentation
- I don't think you want to keep around the old binfmt_flat
  format when merghin into mainline
- MAX_SHARED_LIBS is never used
