Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWBAIvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWBAIvc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 03:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWBAIvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 03:51:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50627 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751253AbWBAIvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 03:51:32 -0500
Date: Wed, 1 Feb 2006 00:51:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3
Message-Id: <20060201005106.35ca4b8c.akpm@osdl.org>
In-Reply-To: <43E0718F.1020604@yahoo.com.au>
References: <20060124232406.50abccd1.akpm@osdl.org>
	<6bffcb0e0601250340x6ca48af0w@mail.gmail.com>
	<43D7A047.3070004@yahoo.com.au>
	<6bffcb0e0601261102j7e0a5d5av@mail.gmail.com>
	<43D92754.4090007@yahoo.com.au>
	<43D927F6.9080807@yahoo.com.au>
	<6bffcb0e0601270211v787f91d2r@mail.gmail.com>
	<43E0718F.1020604@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> > Now I have got this:
>  > 
>  > BUG: unable to handle kernel paging request at virtual address eaa34b3c
>  >  printing eip:
>  > b0161cdd
>  > *pde = 0048a067
>  > *pte = 3aa34000
>  > Oops: 0000 [#1]
>  > PREEMPT SMP DEBUG_PAGEALLOC
>  > last sysfs file: /devices/pci0000:00/0000:00:1d.1/usb3/idVendor
>  > Modules linked in: snd_intel8x0 snd_ac97_codec snd_ac97_bus
>  > snd_pcm_oss snd_mixer_oss snd_pcm snd_timer ide_cd cdrom intel_agp
>  > agpgart snd i2c_i801 hw_random soundcore snd_page_alloc unix
>  > CPU:    0
>  > EIP:    0060:[<b0161cdd>]    Not tainted VLI
>  > EFLAGS: 00010282   (2.6.16-rc1-mm3 #4)
>  > EIP is at do_path_lookup+0x22b/0x259
>  > eax: eaa34b20   ebx: eb328000   ecx: 00000000   edx: eb328f4c
>  > esi: ffffff9c   edi: fffffffe   ebp: eb328f24   esp: eb328f0c
>  > ds: 007b   es: 007b   ss: 0068
>  > Process udevd (pid: 731, threadinfo=eb328000 task=eb30ca80)
>  > Stack: <0>00000000 eb5cb000 b015fab1 eb5cb000 eb5cb000 00000000
>  > eb328f40 b01621f3
>  >        eb328f4c ffffff9c afbf6dec afbf6dec 00000100 eb328f9c b015bf69 eb328f4c
>  >        eaa34b20 b23d5f28 00000000 eb329003 b015f8ce 00000000 00000001 00000000
>  > Call Trace:
>  >  [<b0103917>] show_stack_log_lvl+0xaa/0xb5
>  >  [<b0103a54>] show_registers+0x132/0x19d
>  >  [<b0103d91>] die+0x171/0x1fb
>  >  [<b02ab110>] do_page_fault+0x3be/0x568
>  >  [<b010343f>] error_code+0x4f/0x54
>  >  [<b01621f3>] __user_walk_fd+0x2d/0x41
>  >  [<b015bf69>] sys_readlinkat+0x26/0x93
>  >  [<b015bfe9>] sys_readlink+0x13/0x15
>  >  [<b01028bf>] sysenter_past_esp+0x54/0x75
>  > Code: 00 83 c0 04 e8 9a 82 14 00 8b 03 c7 80 e4 01 00 00 00 00 00 00
>  > 8b 55 08 8b 45 ec e8 55 fa ff ff 89 c7 8b 55 08 8b 02 85 c0 74 24 <8b>
>  > 50 1c 85 d2 74 1d b8 00 f0 ff ff 21 e0 8b 00 83 b8 d4 04 00
>  >  <6>ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 21
>  > 
>  > Here is dmesg:
>  > http://www.stardust.webpages.pl/files/mm/2.6.16-rc1-mm3/mm-dmesg2
>  > 
>  > Here is config
>  > http://www.stardust.webpages.pl/files/mm/2.6.16-rc1-mm3/mm-config
>  > 
>  > Regards,
>  > Michal Piotrowski
>  > 
> 
>  Thanks for testing Michal. Andrew this one looks unrelated -
>  have you seen anything similar?

No, I don't think I have.

> Any ideas?

This has a greggy feel to it.  udev is trying to read a symlink in sysfs,
probably USB-related, but it hit a bad address.  It might boot OK without
CONFIG_DEBUG_PAGEALLOC.

Michal, it'd be useful to look up 0xb0161cdd in gdb, see what line it died
at.
