Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTDJVk5 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264207AbTDJVk5 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:40:57 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:56581 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264197AbTDJVky (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 17:40:54 -0400
Date: Thu, 10 Apr 2003 22:52:33 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Siim Vahtre <siim@pld.ttu.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: i810fb problems with 2.5.66-bk10
In-Reply-To: <Pine.GSO.4.53.0304061743050.17774@pitsa.pld.ttu.ee>
Message-ID: <Pine.LNX.4.44.0304102252100.23050-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try my latest patch at 
http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz


On Sun, 6 Apr 2003, Siim Vahtre wrote:

> 
> First of all, the cursor is playing fool. Sometimes it disappears when I
> am writing and sometimes it looks normal. Pretty annoying.
> 
> And when I did:
> 
> modprobe i810fb mtrr=1 accel=1 xres=640 yres=480 hsync1=30 hsync2=60 vsync1=50 vsync2=100 bpp=16 dcolor=1
> modprobe fbcon
> 
> I got:
> 
> PCI: Found IRQ 11 for device 00:02.0
> I810FB: fb0         : Intel(R) 815 (Internal Graphics with AGP)
> Framebuffer Device v0.9.0
> I810FB: Video RAM   : 4096K
> I810FB: Monitor     : H: 30-60 KHz V: 50-100 Hz
> I810FB: Mode        : 640x480-16bpp@99Hz
> Unable to handle kernel paging request at virtual address c895d008
>  printing eip:
> c01d5a60
> *pde = 011cd067
> *pte = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c01d5a60>]    Not tainted
> EFLAGS: 00010292
> EIP is at pci_bus_match+0x30/0xb0
> eax: 00008086   ebx: c7e5b000   ecx: c895d008   edx: 20202020
> esi: c7e5b04c   edi: ffffffed   ebp: c8985488   esp: c78a9f28
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 148, threadinfo=c78a8000 task=c13c4680)
> Stack: c8985488 c021343f c7e5b04c c8985488 c7e5b054 c7e5b04c c02feb30
> c021357c
>        c7e5b04c c8985488 c89854a4 c02feae0 00000000 c02feaa0 c0213870
> c8985488
>        c02f8c50 c02f8c38 c8985b40 c02f8c38 c0213ce8 c8985488 00000019
> c7a72860
> Call Trace:
>  [<c8985488>] +0x28/0x94 [i810fb]
>  [<c021343f>] bus_match+0x2f/0x80
>  [<c8985488>] +0x28/0x94 [i810fb]
>  [<c021357c>] driver_attach+0x5c/0x70
>  [<c8985488>] +0x28/0x94 [i810fb]
>  [<c89854a4>] +0x44/0x94 [i810fb]
>  [<c0213870>] bus_add_driver+0xd0/0xe0
>  [<c8985488>] +0x28/0x94 [i810fb]
>  [<c8985b40>] +0x0/0xe0 [i810fb]
>  [<c0213ce8>] driver_register+0x38/0x40
>  [<c8985488>] +0x28/0x94 [i810fb]
>  [<c01d59db>] pci_register_driver+0x4b/0x60
>  [<c8985488>] +0x28/0x94 [i810fb]
>  [<c895c02a>] init_module+0x3a/0x57 [i810fb]
>  [<c8985460>] +0x0/0x94 [i810fb]
>  [<c0131cad>] sys_init_module+0x11d/0x1d0
>  [<c8985b40>] +0x0/0xe0 [i810fb]
>  [<c01092bb>] syscall_call+0x7/0xb
> 
> Code: 8b 01 85 c0 89 c2 75 e8 8b 41 08 85 c0 75 e1 8b 41 14 85 c0
>  Console: switching to colour frame buffer device 80x30
> agp_allocate_memory: c6e36c60
> agp_allocate_memory: 00000000
> agp_allocate_memory: c6e36c20
> 
> It didn't stop working, though... and everything else (like switching to X
> and back) looks nice. (except the cursor..)
> ---
> CONFIG_FB=y
> CONFIG_FB_I810=m
> CONFIG_FB_I810_GTF=y
> CONFIG_FRAMEBUFFER_CONSOLE=m
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

