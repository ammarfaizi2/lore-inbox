Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316632AbSGYWwP>; Thu, 25 Jul 2002 18:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316629AbSGYWwP>; Thu, 25 Jul 2002 18:52:15 -0400
Received: from [195.223.140.120] ([195.223.140.120]:6468 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316632AbSGYWwO>; Thu, 25 Jul 2002 18:52:14 -0400
Date: Fri, 26 Jul 2002 00:56:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725225613.GW1180@dualathlon.random>
References: <20020725110033.G2276@host110.fsmlabs.com> <20020725181126.A17859@infradead.org> <20020725112142.I2276@host110.fsmlabs.com> <20020725190445.GO1180@dualathlon.random> <20020725142716.N2276@host110.fsmlabs.com> <20020725205910.GR1180@dualathlon.random> <20020725150525.Q2276@host110.fsmlabs.com> <20020725220643.GT1180@dualathlon.random> <20020725160559.X2276@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725160559.X2276@host110.fsmlabs.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 04:05:59PM -0600, Cort Dougan wrote:
> The patch works, though.  I'm seeing lots of function names in ksyms -a
> and haven't done a single export_symbol in any module.  Perhaps you mean

It's really weird that the patch works in a generic manner for you, maybe our
userspace side is different than, or maybe it's a difference on ppc where
you're not trimming the symbol list to the exported functions?

See:

andrea@dualathlon:~> ksyms -a | grep bttv
cc8e8400  bttv_get_cardinfo_Rsmp_48320158   [bttv]
cc8e8440  bttv_get_id_Rsmp_294b5550         [bttv]
cc8e8480  bttv_gpio_enable_Rsmp_11dc4b6d    [bttv]
cc8e8500  bttv_read_gpio_Rsmp_bcf2d2fb      [bttv]
cc8e8550  bttv_write_gpio_Rsmp_8ecf4acc     [bttv]
cc8e85d0  bttv_get_gpio_queue_Rsmp_a6788968  [bttv]
cc8e0000 __insmod_bttv_O/lib/modules/2.4.19-rc3aa2/kernel/drivers/media/video/bttv.o_M3D3ED28E_V132115 [bttv]
cc8e0080  __insmod_bttv_S.text_L35810       [bttv]
cc8e8d0c  __insmod_bttv_S.rodata_L340       [bttv]
cc8eb5a0  __insmod_bttv_S.data_L14172       [bttv]
cc8eed00  __insmod_bttv_S.bss_L5920         [bttv]
andrea@dualathlon:~/devel/kernel/2.4.19rc3aa2> egrep 'bttv_get_cardinfo|bttv_get_id|bttv_gpio_enable|bttv_read_gpio|bttv_write_gpio|bttv_get_gpio_queue' drivers/media/video/*
drivers/media/video/bttv-if.c:EXPORT_SYMBOL(bttv_get_cardinfo);
drivers/media/video/bttv-if.c:EXPORT_SYMBOL(bttv_get_id);
drivers/media/video/bttv-if.c:EXPORT_SYMBOL(bttv_gpio_enable);
drivers/media/video/bttv-if.c:EXPORT_SYMBOL(bttv_read_gpio);
drivers/media/video/bttv-if.c:EXPORT_SYMBOL(bttv_write_gpio);
drivers/media/video/bttv-if.c:EXPORT_SYMBOL(bttv_get_gpio_queue);
drivers/media/video/bttv-if.c:int bttv_get_cardinfo(unsigned int card, int *type, int *cardid)
drivers/media/video/bttv-if.c:int bttv_get_id(unsigned int card)
drivers/media/video/bttv-if.c:  printk("bttv_get_id is obsolete, use bttv_get_cardinfo instead\n");
drivers/media/video/bttv-if.c:int bttv_gpio_enable(unsigned int card, unsigned long mask, unsigned long data)
drivers/media/video/bttv-if.c:int bttv_read_gpio(unsigned int card, unsigned long *data)
drivers/media/video/bttv-if.c:int bttv_write_gpio(unsigned int card, unsigned long mask, unsigned long data)
drivers/media/video/bttv-if.c:wait_queue_head_t* bttv_get_gpio_queue(unsigned int card)
drivers/media/video/bttv.h:extern int bttv_get_cardinfo(unsigned int card, int *type, int *cardid);
drivers/media/video/bttv.h:/* obsolete, use bttv_get_cardinfo instead */
drivers/media/video/bttv.h:extern int bttv_get_id(unsigned int card);
drivers/media/video/bttv.h:extern int bttv_gpio_enable(unsigned int card,
drivers/media/video/bttv.h:extern int bttv_read_gpio(unsigned int card, unsigned long *data);
drivers/media/video/bttv.h:extern int bttv_write_gpio(unsigned int card,
drivers/media/video/bttv.h:   (wake_up_interruptible) and following call to the function bttv_read_gpio
drivers/media/video/bttv.h:extern wait_queue_head_t* bttv_get_gpio_queue(unsigned int card);
andrea@dualathlon:~/devel/kernel/2.4.19rc3aa2> egrep 'EXPORT_SYMBOL.*bttv' drivers/media/video/*
drivers/media/video/bttv-if.c:EXPORT_SYMBOL(bttv_get_cardinfo);
drivers/media/video/bttv-if.c:EXPORT_SYMBOL(bttv_get_id);
drivers/media/video/bttv-if.c:EXPORT_SYMBOL(bttv_gpio_enable);
drivers/media/video/bttv-if.c:EXPORT_SYMBOL(bttv_read_gpio);
drivers/media/video/bttv-if.c:EXPORT_SYMBOL(bttv_write_gpio);
drivers/media/video/bttv-if.c:EXPORT_SYMBOL(bttv_get_gpio_queue);
andrea@dualathlon:~/devel/kernel/2.4.19rc3aa2> egrep 'bttv_bit_setsda' drivers/media/video/*
drivers/media/video/bttv-if.c:void bttv_bit_setsda(void *data, int state)
drivers/media/video/bttv-if.c:  setsda:  bttv_bit_setsda,
drivers/media/video/bttv-if.c:  bttv_bit_setsda(btv,1);
drivers/media/video/bttv.h:extern void bttv_bit_setsda(void *data, int state);
andrea@dualathlon:~/devel/kernel/2.4.19rc3aa2> egrep 'bttv_bit_setsda' /proc/ksyms
andrea@dualathlon:~/devel/kernel/2.4.19rc3aa2>

I guess it worked for you because you've single file .c modules, that interface
with each other, so there every extern function is going to be exported.

modutils could build the whole symbol table if asked to, so with a change of
insmod you could make your patch to work in a generic manner for all
module symbols too, but it would be a waste of ram like kksymoops.

> only in the kernel.  Do I misunderstand?
> 
> } Hmm no, only functions that are explicitly exported through
> } EXPORT_SYMBOL are given, they're the only one needed, if you were right
> } the modules would be wasting an overkill of kernel not swappable ram for
> } no good reason. This is true for both kernel and modules, no difference.
> } 
> } And even if only the non static ones would not be given still it would
> } be an high probability to need the system.map to resolve it.
> 
> That it certainly is!
> 
> } I appreciated it as a good start to get more reliable module reports,
> } but I think it's not the best way to do it (but still it's way better
> } than nothing! :).
> 
> Explaining to people what a System.map is, how to send it to me and trying
> to get them to be methodical enough to be sure they're sending the right
> one is a sure road to insanity.  I took a daytrip down that road once.

:) In that case kksymoops is probably the best. OTOH for shipped binary
images this problem doesn't exist assuming we can regognize the image
from the oops (hence the idea to show uname -a into the oops).

> } I'm not trying to make it easier, I'm trying to make it possible at all.
> } 
> } Right now if I get an oops into a module from an user I cannot debug it
> } period. I'm missing information that I cannot generate on my side. Every
> } time he loads the module it will be at a different address (in
> } particular with my tree where I try to allocate modules in multipages to
> } get faster performance of the binary image at runtime even if they will
> } use more ram), so unless he managed running ksymoops on the "after-oops"
> } semi broken kernel, the oops will be totally useless.
> 
> It's hard in a cross-build environment to get ksymoops to be useful,
> though.  If you have suggestions, I have the will.

That's more a ksymoops problem then, the symbol resolution is really
trivial to implement in a generic manner.

Andrea
