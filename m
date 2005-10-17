Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVJQTjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVJQTjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVJQTjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:39:17 -0400
Received: from dsl-62-3-75-185.zen.co.uk ([62.3.75.185]:35242 "EHLO
	natsu.giantx.co.uk") by vger.kernel.org with ESMTP id S1751250AbVJQTjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:39:16 -0400
Date: Mon, 17 Oct 2005 20:39:15 +0100
From: nyk <nyk@giantx.co.uk>
To: Tim Schmielau <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Re: 2.6.14-rc4-mm1 ntfs/namei.c missing compat.h?
Message-ID: <20051017193915.GA3872@giantx.co.uk>
References: <20051017144900.GA2942@giantx.co.uk> <Pine.LNX.4.61.0510171828440.5555@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510171828440.5555@gans.physik3.uni-rostock.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 06:33:58PM +0200, Tim Schmielau wrote:
> On Mon, 17 Oct 2005, nyk wrote:
> 
> > Looks like fs/ntfs/namei.c is missing linux/compat.h
> > 
> >   CHK     include/linux/version.h
> >   CHK     include/linux/compile.h
> >   CHK     usr/initramfs_list
> >   CC [M]  fs/ntfs/namei.o
> > In file included from include/linux/dcache.h:6,
> >                  from fs/ntfs/namei.c:23:
> > include/asm/atomic.h:383: error: syntax error before '*' token
> > include/asm/atomic.h:384: warning: function declaration isn't a prototype
> > include/asm/atomic.h: In function 'atomic_scrub':
> > include/asm/atomic.h:385: error: 'u32' undeclared (first use in this function)
> > include/asm/atomic.h:385: error: (Each undeclared identifier is reported only once
> [...]
> > 
> > Compiles fine with #include <linux/compat.h> added to the top of
> > fs/ntfs/namei.c
> > 
> > If that's the right place for it, of course.
> 
> [Looks like you are on x86_64, as i386 compiles fine]
> 
> Actually, <asm-x86_64/atomic.h> seems to need <asm/types.h> for the 
> declaration of u32.
> The patch below makes NTFS compile on x86_64 for me. Andi?
> 
> Tim
> 
> 
> --- linux-2.6.14-rc4-mm1/include/asm-x86_64/atomic.h	2005-10-17 17:48:12.000000000 +0200
> +++ linux-2.6.14-rc4-mm1-build/include/asm-x86_64/atomic.h	2005-10-17 18:20:19.000000000 +0200
> @@ -2,6 +2,7 @@
>  #define __ARCH_X86_64_ATOMIC__
>  
>  #include <linux/config.h>
> +#include <asm/types.h>
>  
>  /* atomic_t should be 32 bit signed type */
>  

Yup x86_64. And trying out bluesmoke, but I got a lot of unknown symbols
in ehci_hcd, so I've got problems elsewhere as well. Will try a compile
from a clean tree...

Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_hcd_pci_suspend
Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_free_urb
Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_hub_tt_clear_buffer
Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_hcd_pci_probe
Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_suspend_device
Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_disabled
Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_put_dev
Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_get_dev
Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_calc_bus_time
Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_hcd_pci_resume
Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_get_urb
Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_hcd_giveback_urb
Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_set_device_state
Oct 17 20:24:42 natsu kernel: ehci_hcd: Unknown symbol usb_hcd_pci_remove

Nyk
-- 
/__
\_|\/
   /\
