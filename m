Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUIJIwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUIJIwa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUIJIw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:52:29 -0400
Received: from ozlabs.org ([203.10.76.45]:62417 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267313AbUIJIwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:52:01 -0400
Date: Fri, 10 Sep 2004 18:48:46 +1000
From: Anton Blanchard <anton@samba.org>
To: adaplas@pol.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Message-ID: <20040910084846.GA24408@krispykreme>
References: <1094783022.2667.106.camel@gaston> <200409101328.57431.adaplas@hotpop.com> <1094796002.14398.118.camel@gaston> <200409101635.16803.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409101635.16803.adaplas@hotpop.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, that should solve the ofonly problem, with the offb in the very last of 
> the Makefile, though as you said, it's a little hackish, but very simple to 
> implement.  This will work for ofonly though, since 
> info->fix.name is not necessarily equal to "xxxfb".  For instance, offb set 
> "OFfb" in info->fix.name, but the boot option is "offb".

FYI Im seeing this on my POWER5 box:

Using unsupported 640x480 MTRX,G450 at e0000000, depth=8, pitch=640
cpu 0x1: Vector: 300 (Data Access) at [c000000074f37230]
    pc: c0000000001e20a4: .cfb_imageblit+0x5c0/0x610
    lr: c0000000001d358c: .accel_putcs+0x1f0/0x720
    sp: c000000074f374b0
   msr: 8000000000009032
   dar: e000000080000000
 dsisr: 42000000
  current = 0xc000000074f310e0
  paca    = 0xc00000000052fa80
    pid   = 1, comm = swapper
enter ? for help
1:mon> t
[c000000074f375a0] c0000000001d358c .accel_putcs+0x1f0/0x720
[c000000074f37740] c000000000218600 .do_update_region+0x238/0x2ac
[c000000074f37810] c0000000002197c8 .redraw_screen+0x138/0x2b8
[c000000074f378b0] c0000000001d4724 .fbcon_init+0x5a0/0x73c
[c000000074f379a0] c000000000219b74 .visual_init+0x22c/0x2dc
[c000000074f37a50] c00000000021c0c4 .take_over_console+0x43c/0x6dc
[c000000074f37b20] c0000000001d31b4 .fbcon_takeover+0x88/0xf0
[c000000074f37bb0] c0000000001d968c .fbcon_event_notify+0x514/0xc00
[c000000074f37c70] c00000000006284c .notifier_call_chain+0x64/0x98
[c000000074f37d00] c0000000001dc87c .register_framebuffer+0x144/0x20c
[c000000074f37df0] c00000000049dcd0 .offb_init+0x528/0x838
[c000000074f37f00] c00000000000c698 .init+0x23c/0x44c
[c000000074f37f90] c000000000017f14 .kernel_thread+0x4c/0x68

We took a data miss trying to access an ioremapped area (e000000080000000).
Offb might have always been buggy but was hidden by the fact that matroxfb 
used to init first.

Anton
