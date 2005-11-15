Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVKOA33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVKOA33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVKOA32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:29:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29407 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932211AbVKOA32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:29:28 -0500
Date: Mon, 14 Nov 2005 16:29:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, yi.zhu@intel.com,
       jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
Message-Id: <20051114162942.5b163558.akpm@osdl.org>
In-Reply-To: <4378980C.7060901@ens-lyon.fr>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<4378980C.7060901@ens-lyon.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Buisse <alexandre.buisse@ens-lyon.fr> wrote:
>
> Hi Linus,
> 
> I experienced a hard crash (no input devices answering at all) yesterday
> while playing a movie from a CD, but with nothing showing up in
> /var/log/messages.
> A few minutes ago, however, I had a nice oops from ipw2200 (I think), a
> few minutes after booting (I had already associated and had a steady
> connection). It then began crashing methodically all of my applications,
> each time producing a oops...
> 
> 
> Nov 14 14:20:09 ubik [  783.604398] ipw2200: Firmware error detected. 
> Restarting.
> Nov 14 14:20:09 ubik [  783.604919] ipw2200: Sysfs 'error' log captured.
> Nov 14 14:20:11 ubik [  785.171844] Unable to handle kernel paging
> request at virtual address 1740f369
> Nov 14 14:20:11 ubik [  785.171852]  printing eip:
> Nov 14 14:20:11 ubik [  785.171853] c014cd02
> Nov 14 14:20:11 ubik [  785.171855] *pde = 00000000
> Nov 14 14:20:11 ubik [  785.171858] Oops: 0002 [#1]
> Nov 14 14:20:11 ubik [  785.171860] PREEMPT
> Nov 14 14:20:11 ubik [  785.171863] Modules linked in: ipw2200 ieee80211
> ieee80211_crypt ac thermal battery acpi_cpufreq processor radeon
> snd_intel8x0 snd_ac97_codec snd_ac97_bus
> Nov 14 14:20:11 ubik [  785.171874] CPU:    0
> Nov 14 14:20:11 ubik [  785.171875] EIP:    0060:[<c014cd02>]    Not
> tainted VLI
> Nov 14 14:20:11 ubik [  785.171876] EFLAGS: 00010003   (2.6.15-rc1-ubik)
> Nov 14 14:20:11 ubik [  785.171886] EIP is at cache_alloc_refill+0xa2/0x2a0
> Nov 14 14:20:11 ubik [  785.171889] eax: c14ddb00   ebx: c14d7ac0   ecx:
> df427000   edx: 1740f365
> Nov 14 14:20:11 ubik [  785.171892] esi: 00000032   edi: c14ddb00   ebp:
> dc9d7d60   esp: dc9d7d38
> Nov 14 14:20:11 ubik [  785.171895] ds: 007b   es: 007b   ss: 0068
> Nov 14 14:20:11 ubik [  785.171898] Process updatedb (pid: 4939,
> threadinfo=dc9d6000 task=df7ad5e0)
> Nov 14 14:20:11 ubik [  785.171900] Stack: c017fe03 dc9d7d78 c017fed1
> c14deb00 c14d9000 cca7201c 0000003b 00000282
> Nov 14 14:20:11 ubik [  785.171907]        c14d7ac0 d9516ee8 dc9d7d78
> c014d15d c14d7ac0 000000d0 fffffff4 ce4f0838
> Nov 14 14:20:11 ubik [  785.171913]        dc9d7d94 c017f71f c14d7ac0
> 000000d0 fffffff4 ce4f0838 d9516ee8 dc9d7db8
> Nov 14 14:20:11 ubik [  785.171920] Call Trace:
> Nov 14 14:20:11 ubik [  785.171922]  [<c010388b>] show_stack+0xab/0xf0
> Nov 14 14:20:11 ubik [  785.171927]  [<c0103a7f>] show_registers+0x18f/0x230
> Nov 14 14:20:11 ubik [  785.171931]  [<c0103cbd>] die+0xed/0x1b0
> Nov 14 14:20:11 ubik [  785.171935]  [<c04e1a9a>] do_page_fault+0x33a/0x670
> Nov 14 14:20:11 ubik [  785.171941]  [<c01034ef>] error_code+0x4f/0x54
> Nov 14 14:20:11 ubik [  785.171944]  [<c014d15d>] kmem_cache_alloc+0x4d/0x50
> Nov 14 14:20:11 ubik [  785.171948]  [<c017f71f>] d_alloc+0x1f/0x1b0
> Nov 14 14:20:11 ubik [  785.171952]  [<c017427c>] real_lookup+0xac/0xf0
> Nov 14 14:20:11 ubik [  785.171957]  [<c01745d5>] do_lookup+0xa5/0xb0
> Nov 14 14:20:11 ubik [  785.171961]  [<c0174e45>]
> __link_path_walk+0x865/0xfb0
> Nov 14 14:20:11 ubik [  785.171965]  [<c01755e5>] link_path_walk+0x55/0x100
> Nov 14 14:20:11 ubik [  785.171968]  [<c017595c>] path_lookup+0x9c/0x1e0
> Nov 14 14:20:11 ubik [  785.171972]  [<c0175dd1>] __user_walk+0x31/0x50
> Nov 14 14:20:11 ubik [  785.171976]  [<c016f6eb>] vfs_lstat+0x1b/0x50
> Nov 14 14:20:11 ubik [  785.171979]  [<c016fd69>] sys_lstat64+0x19/0x40
> Nov 14 14:20:11 ubik [  785.171983]  [<c01032c5>] syscall_call+0x7/0xb
> Nov 14 14:20:11 ubik [  785.171986] Code: 00 00 8d bc 27 00 00 00 00 85
> f6 7e 4a 8b 0f 39 f9 0f 84 48 01 00 00 8b 5d 08 8b 43 1c 3b 41 10 0f 87
> 85 00 00 00 8b 11 8b 41 04 <89> 42 04 89 10 83 79 14 ff c7 01 00 01 10
> 00 c7 41 04 00 02 20

This looks like some sort of slab scribble, possibly caused by faulty
error-path handling in the ipw2200 code.

Please enable CONFIG_DEBUG_SLAB and see if that picks anything up.

Also enable CONFIG_DEBUG_PAGEALLOC.

You may also get more info by setting CONFIG_IPW_DEBUG and loading the
module with `debug=65535' (guess).

Whatever you do, don't fix the firmware loading failure (sorry).  Doing
that will cause you to not be able to reproduce this bug ;)

