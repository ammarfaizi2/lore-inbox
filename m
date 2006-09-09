Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWIIPcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWIIPcS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWIIPcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:32:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44746 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932263AbWIIPcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:32:16 -0400
Date: Sat, 9 Sep 2006 08:31:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: 2.6.18-rc6-mm1
Message-Id: <20060909083140.adfa878e.akpm@osdl.org>
In-Reply-To: <20060909090449.GA16579@amd64.of.nowhere>
References: <20060908011317.6cb0495a.akpm@osdl.org>
	<20060908193041.GA18966@amd64.of.nowhere>
	<20060908124411.aa96fb7b.akpm@osdl.org>
	<20060909090449.GA16579@amd64.of.nowhere>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Sep 2006 11:04:49 +0200
thunder7@xs4all.nl wrote:

> From: Andrew Morton <akpm@osdl.org>
> Date: Fri, Sep 08, 2006 at 12:44:11PM -0700
> > On Fri, 8 Sep 2006 21:30:41 +0200
> > thunder7@xs4all.nl wrote:
> > 
> > > From: Andrew Morton <akpm@osdl.org>
> > > Date: Fri, Sep 08, 2006 at 01:13:17AM -0700
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/
> > > > 
> > > This throws an oops on my IBM Thinkpad T23 notebook. Some parts scroll
> > > off the screen, but the visible stack trace goes like this:
> > > 
> > We'd really need to see that trace, please.  netconsole is worth setting
> > up, if you have another machine on the LAN.
> > 
> Well, I've learned that built-in framebuffers initialize _before_ the
> network stack is up, so that didn't help. Rebuilding savagefb as a
> module gave me:
> 
> hub 3-0:1.0: 2 ports detected
> savagefb: mapped io at f8980000
> savagefb: probed videoram:  16384k
> savagefb: Detected current MCLK value of 71591 kHz
> savagefb: 1024x768 TFT LCD panel detected and active
> savagefb: Limiting video mode to 1024x768
> savagefb: mapped framebuffer at f8a80000, pbase == e8000000
> BUG: unable to handle kernel NULL pointer dereference at virtual address
> 00000000
>  printing eip:
>  f8831013
>  *pde = 00000000
>  Oops: 0000 [#1]
>  4K_STACKS PREEMPT 
>  last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_governor
>  Modules linked in: savagefb fb_ddc cfbimgblt uhci_hcd usbcore
>  CPU:    0
>  EIP:    0060:[<f8831013>]    Not tainted VLI
>  EFLAGS: 00010286   (2.6.18-rc6-mm1 #6) 
>  EIP is at fb_ddc_read+0x13/0x1c4 [fb_ddc]
>  eax: f7faf250   ebx: 00000000   ecx: f7faf244   edx: f7faf244
>  esi: 00000000   edi: f7faf008   ebp: f7fbed98   esp: f7fbed68
>  ds: 007b   es: 007b   ss: 0068
>  Process modprobe (pid: 1776, ti=f7fbe000 task=f7fbdab0
>  task.ti=f7fbe000)
>  Stack: 00000001 f7faf244 00004988 01000000 f7faf000 f9a6d9e0 f7fbede8 00000000 
>         f7faf244 f7faf208 f7faf000 f7faf008 f7fbedb0 f8846af9 f7faf250 f7faf208 
>         f7faf000 f7faf008 f7fbede8 f884667c f7faf000 f7faf6b0 f7fbedd0 c01ebe91 
>  Call Trace:
>  [<c01039eb>] show_trace_log_lvl+0x15/0x28
>  [<c0103a8a>] show_stack_log_lvl+0x8c/0x97
>  [<c0103e48>] show_registers+0x188/0x21c
>  [<c0104085>] die+0x1a9/0x283
>  [<c0113bb5>] do_page_fault+0x3ed/0x4bf
>  [<c03421df>] error_code+0x3f/0x44
>  [<f8846af9>] savagefb_probe_i2c_connector+0x18/0x66 [savagefb]
>  [<f884667c>] savagefb_probe+0x484/0x672 [savagefb]
>  [<c01f6722>] pci_device_probe+0x3a/0x61
>  [<c0269ecb>] really_probe+0x37/0xb0
>  [<c0269fbc>] driver_probe_device+0x78/0x84
>  [<c026a06a>] __driver_attach+0x38/0x60
>  [<c026992a>] bus_for_each_dev+0x42/0x69
>  [<c0269df7>] driver_attach+0x16/0x18
>  [<c0269491>] bus_add_driver+0x66/0x179
>  [<c026a2f7>] driver_register+0x77/0x7c
>  [<c01f68bf>] __pci_register_driver+0x5e/0x7e
>  [<f882d02e>] savagefb_init+0x2e/0x36 [savagefb]
>  [<c0132158>] sys_init_module+0x1274/0x1443
>  [<c0102dd8>] syscall_call+0x7/0xb
>  =======================
>  Code: <ff> 33 ff 53 08 6a 00 ff 33 ff 53 08 c7 45 d4 00 00 00 00 83 c4 10 6a 00 31 ff ff 33 ff 53 04 6a 
>  EIP: [<f8831013>] fb_ddc_read+0x13/0x1c4 [fb_ddc] SS:ESP 0068:f7fbed68
> 
> Hope this helps,

Does, thanks.  I guess adapter->algo_data is NULL.

savagefb-use-generic-ddc-reading.patch, perhaps...


