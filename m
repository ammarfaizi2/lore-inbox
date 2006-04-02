Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWDBSwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWDBSwx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 14:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWDBSwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 14:52:53 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:10200
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750855AbWDBSww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 14:52:52 -0400
Date: Sun, 2 Apr 2006 11:52:29 -0700
From: Greg KH <greg@kroah.com>
To: Chris Boot <bootc@bootc.net>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Occasional APC Smart-UPS CS 500 USB UPS troubles
Message-ID: <20060402185229.GA5985@kroah.com>
References: <442FE22E.9090000@bootc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442FE22E.9090000@bootc.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 03:39:42PM +0100, Chris Boot wrote:
> Hi all,
> 
> I have an APC Smart-UPS CS 500, and most of the time it works really 
> nicely. I was stupefied to find it worked out of the box in Ubuntu 
> Dapper and pops up a nice little icon when the power goes out, etc... 
> The trouble is, that's only most of the time.
> 
> I'm guessing the USB controller in the device is buggy or something, 
> because occasionally, when I reboot my machine with the UPS plugged in, 
> the boot hangs or produces strange errors when detecting USB devices. 
> All it takes to get the machine to boot properly is yank the USB plug on 
> the UPS, plug it in again, and reboot.

What exactly are these "strange errors"?

> Has anyone seen this before?

It hasn't been reported, no.

> Not exactly kernel related I must admit, but this never seems to happen 
> on *shudder* Windows, and I wouldn't expect such severe behaviour in 
> case of trouble...
> 
> I've seen this on all sorts of kernels starting with the early 2.6 
> series up to 2.6.16.1 and 2.6.16-ck3. My latest hang was with the latter 
> kernel, and modprobe got stuck with the following trace:
> 
> modprobe      D ED465280     0   819    815                     (NOTLB)
> f7cfade4 f7d0366c f7d03540 ed465280 000f41fd 005b8d80 00000000 f7794d1c
>        00000292 f7cfa000 f7d03540 c02d0e0e 00000001 f7d03540 c0113f02 
> f7794d24
>        f7794d24 f6e31c58 f9734f40 f97e2f44 c0257dc6 c02cf89f f97e2f44 
> f7794c58
> Call Trace:
>  [__down+202/240] __down+0xca/0xf0
>  [default_wake_function+0/12] default_wake_function+0x0/0xc
>  [__driver_attach+0/89] __driver_attach+0x0/0x59
>  [__sched_text_start+7/12] __down_failed+0x7/0xc
>  [.text.lock.dd+39/188] .text.lock.dd+0x27/0xbc
>  [bus_for_each_dev+55/89] bus_for_each_dev+0x37/0x59
>  [driver_attach+17/19] driver_attach+0x11/0x13
>  [__driver_attach+0/89] __driver_attach+0x0/0x59
>  [bus_add_driver+90/211] bus_add_driver+0x5a/0xd3
>  [pg0+959850838/1069790208] usb_register_driver+0x50/0xae [usbcore]
>  [pg0+949030918/1069790208] hid_init+0x6/0x3d [usbhid]
>  [sys_init_module+4905/5197] sys_init_module+0x1329/0x144d
>  [cp_new_stat64+237/255] cp_new_stat64+0xed/0xff
>  [vma_prio_tree_insert+23/42] vma_prio_tree_insert+0x17/0x2a
>  [vma_link+162/223] vma_link+0xa2/0xdf
>  [do_mmap_pgoff+1202/1535] do_mmap_pgoff+0x4b2/0x5ff
>  [sys_mmap2+97/144] sys_mmap2+0x61/0x90
>  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
> 
> Let me know if you need more info!

That's really odd.  What else is happening in the sysrq-t output at this
moment in time?

Also CCing the linux-usb-devel list, as the people there can help out.

thanks,

greg k-h
