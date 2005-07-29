Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVG2Egv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVG2Egv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 00:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVG2Egu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 00:36:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62867 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262330AbVG2Egu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 00:36:50 -0400
Date: Thu, 28 Jul 2005 21:35:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cal Peake <cp@absolutedigital.net>
Cc: torvalds@osdl.org, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.13-rc4 (snd-cs46xx)
Message-Id: <20050728213543.6264ca60.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0507282328520.966@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.58.0507281625270.3307@g5.osdl.org>
	<Pine.LNX.4.61.0507282328520.966@lancer.cnet.absolutedigital.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal Peake <cp@absolutedigital.net> wrote:
>
> Hi,
> 
> Getting this nastiness when probing snd-cs46xx:
> 
> Unable to handle kernel paging request at virtual address 000a75a8
> ...
> EIP is at sub_alloc+0x42/0x170
> ...
>  [<c01afff8>] idr_get_new_above_int+0x78/0x120
>  [<c01b010f>] idr_get_new+0x1f/0x50
>  [<c017d409>] get_inode_number+0x39/0x60
>  [<c017d6c7>] proc_register+0x17/0xb0
>  [<c017db05>] create_proc_entry+0x85/0xd0
>  [<f8b18f80>] snd_create_proc_entry+0x20/0x30 [snd]
>  [<f8b194f4>] snd_info_register+0x44/0xb0 [snd]
>  [<f8bbc0d2>] snd_pcm_lib_preallocate_pages1+0x92/0xd0 [snd_pcm]
>  [<f8bbc184>] snd_pcm_lib_preallocate_pages_for_all+0x44/0x70 [snd_pcm]
>  [<f8be5030>] snd_cs46xx_pcm_rear+0xe0/0x100 [snd_cs46xx]
>  [<f8be30f9>] snd_card_cs46xx_probe+0xf9/0x250 [snd_cs46xx]
>  [<c01b9cbd>] pci_match_device+0x1d/0xb0
>  [<c01b9da8>] __pci_device_probe+0x58/0x70
>  [<c01b9def>] pci_device_probe+0x2f/0x50
>  [<c01fb168>] driver_probe_device+0x38/0xb0
>  [<c01fb270>] __driver_attach+0x0/0x50
>  [<c01fb2bc>] __driver_attach+0x4c/0x50
>  [<c01fa799>] bus_for_each_dev+0x69/0x80
>  [<c01fb2e6>] driver_attach+0x26/0x30
>  [<c01fb270>] __driver_attach+0x0/0x50
>  [<c01fac73>] bus_add_driver+0x83/0xe0
>  [<c01ba08d>] pci_register_driver+0x6d/0x90
>  [<f897e00f>] alsa_card_cs46xx_init+0xf/0x13 [snd_cs46xx]
>  [<c012efb1>] sys_init_module+0x141/0x1d0
>  [<c0102c95>] syscall_call+0x7/0xb
>  
> 
> 2.6.13-rc3-git9 is OK. I'll try poking around at the ALSA changes, see if 
> I can figure out which one is the culprit.

The procfs inode IDR tree is scrogged.  I'd be suspecting a random memory
scribble.  I'd suggest that you enable CONFIG_DEBUG_SLAB,
CONFIG_DEBUG_PAGEALLOC, CONFIG_DEBUG_everything_else and retest.

If that doesn't show anything, try eliminating stuff from your kernel
config.

If it _is_ a scribble then there's a good chance that changing the config
will simply make it disappear, or will make it manifest in different ways.
