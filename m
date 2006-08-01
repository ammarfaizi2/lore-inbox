Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161183AbWHAGhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161183AbWHAGhd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 02:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161184AbWHAGhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 02:37:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:58239 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161183AbWHAGhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 02:37:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=MSGlXxBM9N5FcLJmEMINQzYPLVlIxJ06rS/XrQVjtUHaEsZKLCbRRD2btUcAt0Y34SI4fhNNiZWC6YLV58C3JzDSHd77mXxO+wQ6a1QwEK8inUZgSWCYeH6hdSWafIL7Fs1NTOXPALPNY0IvYYVKMusNX3pZv4ZUqRV2aU9M21k=
Message-ID: <1f1b08da0607312337l34eabc56jdee7b056acd9a71a@mail.gmail.com>
Date: Mon, 31 Jul 2006 23:37:30 -0700
From: "john stultz" <johnstul@us.ibm.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [BUG] no sound on ppc mac mini
Cc: lkml <linux-kernel@vger.kernel.org>,
       "Johannes Berg" <johannes@sipsolutions.net>
In-Reply-To: <1152831309.23037.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1152821370.6845.9.camel@localhost>
	 <1152831309.23037.31.camel@localhost.localdomain>
X-Google-Sender-Auth: 2cde464ec08fc94d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Thu, 2006-07-13 at 13:09 -0700, john stultz wrote:
> > Using the current 2.6.18-rc1-git, I'm finding no sound card being
> > detected on my mac mini.
> >
> > I looked through the config and saw the new AOA option w/ the Toonie
> > chip under it, and I enabled it. However, I still get no sound card
> > detected. I tried enabling the "layout-id fabric" option, but I got a
> > panic on boot (I can try to get a photo later if necessary).
>
> Is this really a current git or an -rc1 snapshot ? The crashes on boot
> should have been fixed ... unless there is another problem on the mac
> mini. Can you try having them as modules instead ?

I know you mentioned there was a fix for this somewhere, but as
motivation to get it flowing to mainline, here's what I get w/ the
current -rc3-git and the sound bits compiled as modules:

snd-aoa-fabric-layout: found bus with layout 58
snd-aoa-fabric-layout: Using direct GPIOs
Unable to handle kernel paging request for data at address 0x00000014
Faulting instruction address: 0xc000f00c
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT
Modules linked in: snd_aoa_fabric_layout snd_aoa_i2sbus snd_aoa_soundbus
NIP: C000F00C LR: C000F09C CTR: C0017C20
REGS: c20f9bf0 TRAP: 0300   Not tainted  (2.6.18-rc3john)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22008488  XER: 00000000
DAR: 00000014, DSISR: 40000000
TASK = c24fecf0[5745] 'modprobe' THREAD: c20f8000
GPR00: C000F09C C20F9CA0 C24FECF0 00000000 C04A6638 C20F9CD8 0000003F 0000003D
GPR08: C0E74800 00000001 8088003D C20F8000 22008488 1001E354 00000000 00000000
GPR16: 00000000 00000000 00000124 00000000 C004C9B8 F2259839 C0610000 C0610000
GPR24: C0610000 C0610000 C0610000 00000000 C20F9CD8 C04A6638 C20F8000 00000000
NIP [C000F00C] of_find_property+0x30/0xb0
LR [C000F09C] get_property+0x10/0x34
Call Trace:
[C20F9CA0] [C0017788] mpic_host_map+0x74/0x7c (unreliable)
[C20F9CC0] [C000F09C] get_property+0x10/0x34
[C20F9CD0] [C000BBC8] of_irq_map_one+0x70/0x150
[C20F9D00] [C00069B8] irq_of_parse_and_map+0x14/0x40
[C20F9D30] [C03976E4] get_irq+0x1c/0x34
[C20F9D50] [C03980D0] ftr_gpio_init+0x15c/0x240
[C20F9D80] [F2268E44] aoa_fabric_layout_probe+0x1dc/0x930 [snd_aoa_fabric_layout
]
[C20F9DB0] [F20E50BC] soundbus_probe+0x44/0x84 [snd_aoa_soundbus]
[C20F9DD0] [C02849A0] driver_probe_device+0x60/0x118
[C20F9DF0] [C0284C04] __driver_attach+0xe8/0x118
[C20F9E10] [C0283B68] bus_for_each_dev+0x54/0x90
[C20F9E40] [C0284808] driver_attach+0x24/0x34
[C20F9E50] [C0283F94] bus_add_driver+0x88/0x164
[C20F9E70] [C028517C] driver_register+0x70/0xb8
[C20F9E80] [F20E5530] soundbus_register_driver+0x28/0x38 [snd_aoa_soundbus]
[C20F9E90] [F20EF018] aoa_fabric_layout_init+0x18/0x48 [snd_aoa_fabric_layout]
[C20F9EA0] [C004D6CC] sys_init_module+0xf4/0x153c
[C20F9F40] [C0011478] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff7325c
    LR = 0x10003b50
Instruction dump:
7c0802a6 9421ffe0 7d800026 bf810010 543e0024 7c9d2378 7cbc2b78 90010024
9181000c 813e000c 39290001 913e000c <83e30014> 2f9f0000 419e0028 2e050000
 <6>note: modprobe[5745] exited with preempt_count 1
BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():1, irqs_disabled():0
Call Trace:
[C20F9AF0] [C00099D8] show_stack+0x50/0x190 (unreliable)
[C20F9B20] [C00257F8] __might_sleep+0xcc/0xe8
[C20F9B30] [C00483BC] down_read+0x24/0x5c
[C20F9B50] [C00507B0] acct_collect+0x44/0x1ac
[C20F9B70] [C002D90C] do_exit+0xfc/0x8cc
[C20F9BB0] [C000FA70] kernel_bad_stack+0x0/0x4c
[C20F9BD0] [C0015094] bad_page_fault+0xbc/0xd4
[C20F9BE0] [C0011914] handle_page_fault+0x7c/0x80
--- Exception: 300 at of_find_property+0x30/0xb0
    LR = get_property+0x10/0x34
[C20F9CA0] [C0017788] mpic_host_map+0x74/0x7c (unreliable)
[C20F9CC0] [C000F09C] get_property+0x10/0x34
[C20F9CD0] [C000BBC8] of_irq_map_one+0x70/0x150
[C20F9D00] [C00069B8] irq_of_parse_and_map+0x14/0x40
[C20F9D30] [C03976E4] get_irq+0x1c/0x34
[C20F9D50] [C03980D0] ftr_gpio_init+0x15c/0x240
[C20F9D80] [F2268E44] aoa_fabric_layout_probe+0x1dc/0x930 [snd_aoa_fabric_layout
]
[C20F9DB0] [F20E50BC] soundbus_probe+0x44/0x84 [snd_aoa_soundbus]
[C20F9DD0] [C02849A0] driver_probe_device+0x60/0x118
[C20F9DF0] [C0284C04] __driver_attach+0xe8/0x118
[C20F9E10] [C0283B68] bus_for_each_dev+0x54/0x90
[C20F9E40] [C0284808] driver_attach+0x24/0x34
[C20F9E50] [C0283F94] bus_add_driver+0x88/0x164
[C20F9E70] [C028517C] driver_register+0x70/0xb8
[C20F9E80] [F20E5530] soundbus_register_driver+0x28/0x38 [snd_aoa_soundbus]
[C20F9E90] [F20EF018] aoa_fabric_layout_init+0x18/0x48 [snd_aoa_fabric_layout]
[C20F9EA0] [C004D6CC] sys_init_module+0xf4/0x153c
[C20F9F40] [C0011478] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff7325c
    LR = 0x10003b50

thanks
-john
