Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbUBTSq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUBTSq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:46:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:2196 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261245AbUBTSqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:46:25 -0500
Date: Fri, 20 Feb 2004 10:38:51 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jonathan Brown <jbrown@emergence.uk.net>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
Subject: Re: Double fb_console_init call during do_initcalls
Message-Id: <20040220103851.3d27f5ab.rddunlap@osdl.org>
In-Reply-To: <4035F9AE.6060001@emergence.uk.net>
References: <4035F9AE.6060001@emergence.uk.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004 12:12:30 +0000 Jonathan Brown <jbrown@emergence.uk.net> wrote:

| fb_console_init gets called twice during do_initcalls. Should it be 
| called from vty_init or as its own initcall? If it should be its own 
| initcall then can it be moved up the list to occur sooner? I think it 
| looks better if the fb kicks in as early as possible.
| 
| 
|   [<c01d09cc>] take_over_console+0x14a/0x1c9
|   [<c031e4c5>] fb_console_init+0x2b/0x59
|   [<c031cde4>] vty_init+0xc9/0xd3
|   [<c031c5b1>] tty_init+0x234/0x23c
|   [<c0310610>] do_initcalls+0x32/0x80
|   [<c01050a6>] init+0x2f/0x109
|   [<c0105077>] init+0x0/0x109
|   [<c0106a81>] kernel_thread_helper+0x5/0xb
| Console: switching to colour frame buffer device 128x48
| 
| 
|   [<c01d09cc>] take_over_console+0x14a/0x1c9
|   [<c031e4c5>] fb_console_init+0x2b/0x59
|   [<c0310610>] do_initcalls+0x32/0x80
|   [<c01050a6>] init+0x2f/0x109
|   [<c0105077>] init+0x0/0x109
|   [<c0106a81>] kernel_thread_helper+0x5/0xb
| Console: switching to colour frame buffer device 128x48
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ugh.  fb_console_init() can be called by
drivers/char/vt.c (one initcall) or drivers/video/fbmem.c or
drivers/video/console/fbcon.c (<-- module_init/initcall).

It definitely wants to be cleaned up, but changing initcall
order can be "fragile".  Have you tried/tested it?

Or maybe James Simmons has some updates for this.

--
~Randy
