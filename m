Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319047AbSIDEkv>; Wed, 4 Sep 2002 00:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319048AbSIDEkv>; Wed, 4 Sep 2002 00:40:51 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:9989 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319047AbSIDEku>; Wed, 4 Sep 2002 00:40:50 -0400
Date: Tue, 3 Sep 2002 21:45:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: pwaechtler@mac.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD]replace save_flags();cli(); with spin_lock_irqsave
In-Reply-To: <C8181396-B145-11D6-8C8C-00039387C942@mac.com>
Message-ID: <Pine.LNX.4.10.10209032142560.3440-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


well I have a few places where

save_flags();sti() is called.

# define save_and_sti(x)        local_irq_save_on(x)

This is totally funky but until it can we cleared out the annoying
ide__sti() thing is painful.

On Fri, 16 Aug 2002 pwaechtler@mac.com wrote:

> I have a large patch (>130KB) against 2.5.31 converting most of oss 
> sound drivers to
> use spinlocks instead of cli() - so that they compile on SMP systems.
> 
> Most changes are trivial but I think some drivers are simply not SMP 
> safe. I hope I haven't
> break any drivers. Since one can argue that OSS in the kernel gets 
> obsolete and there are
> no maintainers for individual drivers I would  prefer NOT to split the 
> patches for each
> individual driver.
> 
> Some like the GUS driver and the dmabuf.c were more complicated - I had 
> to change the
> locking a lot. Now if I grep through the kernel source with
> 
> /usr/src/linux-2.5.31:>find . -name "*.c"| xargs egrep 'cli[ \t]*\(\)' | 
> wc -l
>     1838
> 
> Is the usage of cli() really obsolete? Will all occurences will be fixed 
> as stated in
> 
> /usr/src/linux-2.5.31/include/linux/interrupt.h
> /*
>   * Temporary defines for UP kernels, until all code gets fixed.
>   */
> #if !CONFIG_SMP
> # define cli()                  local_irq_disable()
> # define sti()                  local_irq_enable()
> # define save_flags(x)          local_irq_save(x)
> # define restore_flags(x)       local_irq_restore(x)
> # define save_and_cli(x)        local_irq_save_off(x)
> #endif
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

