Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbTDIUrf (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTDIUrf (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:47:35 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:29418 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263789AbTDIUrd (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 16:47:33 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Randy.Dunlap" <rddunlap@osdl.org>
Date: Wed, 9 Apr 2003 22:58:45 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.67-mm1 cause framebuffer crash at bootup
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <1A6006592C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[As this one is matroxfb only, I removed others...]

> I can reproduce the problem with the earlier-keyboard-init.patch, but if
> I reverse it, I get this [using Petr's 2.5.66-bk12 mga patch].  Is that the
> right one to use?  do I need to use any kernel command line options with it?
> Matrox G400 dual-head capable, but only using one of them.
> 
> 
> matroxfb: Matrox G450 detected
> matroxfb: MTRR's turned on
> matroxfb: 640x480x8bpp (virtual: 640x26208)
> matroxfb: framebuffer at 0xEC000000, mapped to 0xf8805000, size 16777216
> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> 00000000
> *pde = 00000000

It should not happen. Did not you get some rejects while patching?

> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<00000000>]    Not tainted
> EFLAGS: 00010246
> EIP is at 0x0
> eax: c04b77c8   ebx: f7f9fccc   ecx: c1ada17f   edx: c04b6f40
> esi: ffffffff   edi: 00000030   ebp: 00000030   esp: f7f9fc78
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=f7f9e000 task=f7f9c080)
> Stack: c0292c1e c04b6f40 f7f9fccc ffffffff ffffffff 00000000 00000000 00000400 
>        00000008 00000001 000000ff 0000000c c04b6f40 00000030 c1a41480 c0292e65 
>        c1a41480 c04b6f40 f7f9fccc 00000030 c00bb1c0 00000000 00000108 00000180 
> Call Trace:
>  [<c0292c1e>] putcs_aligned+0x16e/0x1b0
>  [<c0292e65>] accel_putcs+0xc5/0xf0
>  [<c02939ce>] fbcon_putcs+0x7e/0x90

If your kernel binary is simillar to mine, it looks like that 
fbops->fb_imageblit was NULL. It should not happen, as matroxfb's 
fb_imageblit should point either to no_imageblit (which currenlty does 
nothing, but it should complain loudly) or to cfb_imageblit (which 
paints character) or matroxfb_imageblit (which should paint character too).

But from call trace it looks like that some printk() error got
triggered on your config. Can you try booting with serial console? 
Do you see penguins on the screen, or not? 

Or remove body from drivers/video/console/fbcon.c:check_vc() - it should
is not triggered on Linus kernels, but maybe -mm1 moved something around.
It looks like that it is time to download -mm1 :-(
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

