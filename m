Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265009AbSJPOgn>; Wed, 16 Oct 2002 10:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264998AbSJPOgm>; Wed, 16 Oct 2002 10:36:42 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:29199 "EHLO
	doughboy.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S265009AbSJPOgh>; Wed, 16 Oct 2002 10:36:37 -0400
Message-ID: <3DAD7AA9.1060207@snapgear.com>
Date: Thu, 17 Oct 2002 00:41:45 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.42uc1 (MMU-less support)
References: <3DAC337D.7010804@snapgear.com> <20021015181609.A31647@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Christoph,

Christoph Hellwig wrote:

> There are a bunch of CVS .#* files left from this one.


Cleaned out now.


> v850_defs.h wants updating to the generic generate-asm-offsets.h
> mechanism (check the toplevel Makefile)


Miles cleaned this up.


> Please stop the ugly symlink hell with the linker scripts -
> we have vmlinux.lds.S for that.


Hmph. Hardly seems any better...


> Could you please explain the rootfs hacks in v850?
> I don't think we want those in mainline but rather generic
> initrd/initramfs.
> 
> Also please remove arch/v850/sim/* - that stuff doesn't
> belong into the kernel tree.


Done.



>>2. cleaned up mm/page_alloc.c
> 
> Why do you put set_page_refs into a header?


It looked might it might be usefull elsewhere.
(but currently isn't used for anything else).


> Separating it out
> looks good to me, but IMHO it should stay in page_alloc.c.
> BTW, are you sure that you don't need to set the refs in the
> other caller of prep_new_page?  To me it looks like you should
> and then you could merge it into prep_new_page.


No, you don't want that.


> Also, what is CONFIG_CONTIGUOUS_PAGE_ALLOC doing?  It seems not
> fully implemented but adds lots of uglieness :)


It was a second allocator that more cleverly allocated large
memory chunks - not using the power of 2 allocator. I have
not carried this into the 2.5 patches. Very nice to have,
since you suffer much more from memory fragmentation without
VM. But not strictly neccessary, and to minimize and simplify
the current patch sets I left it out.

Cleanup out all references to it now.


> CONFIG_NO_MMU_LARGE_ALLOCS might want a saner name, btw
> (CONFIG_LARGE_ALLOCS?).


Yes, no doubt the NO_MMU name is universally disliked :-)
Changed to COFNIG_LARGE_ALLOCS now.


> 
> General commets:
> - Config.in files have three-space, not two-space indentation



Fixed.


> - I don't think you want to keep around the old binfmt_flat


This isn't old. It is the primary format used on uClinux. ELF
and a.out are not practical, since you would need to do the final
link/locate on them at exec load time (you won't know what address
in memory they will get loaded to until them). You don have the
VM luxary of just locating it at a fixed address at compile time.

FLAT format is a light weight, mostly architecture independant
way to carry around relocs, and to keep the program binaries
small.


>   format when merghin into mainline
> - MAX_SHARED_LIBS is never used

Another "feature" I have not carried into 2.5. Removed.


Thanks
Greg





-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

