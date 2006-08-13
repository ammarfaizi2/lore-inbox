Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbWHMBDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWHMBDG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 21:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWHMBDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 21:03:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21217 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932636AbWHMBDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 21:03:05 -0400
Date: Sat, 12 Aug 2006 18:02:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: 2.6.18-rc3-mm2:  oops in device_bind_driver()
Message-Id: <20060812180256.445caea9.akpm@osdl.org>
In-Reply-To: <1155385726.6151.6.camel@Homer.simpson.net>
References: <1155385726.6151.6.camel@Homer.simpson.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2006 12:28:46 +0000
Mike Galbraith <efault@gmx.de> wrote:

> Greetings,
> 
> I'm hitting the oops below, though not on every boot.
> 
> DEV: registering device: ID = 'dvb0'
> PM: Adding info for bttv-sub:dvb0
> saa7130/34: v4l2 driver version 0.2.14 loaded
> bus bttv-sub: add device dvb0
> bttv0: add subdevice "dvb0"
> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c126e43f
> *pde = 00000000
> Oops: 0000 [#1]
> 4K_STACKS PREEMPT SMP 
> last sysfs file: /class/input/input2/name
> Modules linked in: saa7134 bt878 ir_kbd_i2c bttv video_buf ir_common sd_mod i2c_i801 btcx_risc snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm tveeprom ohci1394 snd_timer snd_page_alloc prism54 snd_mpu401 ieee1394 snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore
> CPU:    1
> EIP:    0060:[<c126e43f>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.18-rc3-mm2-smp #169) 
> EIP is at device_bind_driver+0x49/0xd0
> eax: 00000000   ebx: c1fdb048   ecx: f8b4e268   edx: 00000000
> esi: c1fdb084   edi: f8b46db8   ebp: dfccef98   esp: dfccef80
> ds: 007b   es: 007b   ss: 0068
> Process probe-0000:02:0 (pid: 3623, ti=dfcce000 task=dff57030 task.ti=dfcce000)
> Stack: f8b46d80 dfccef98 c11de322 c1fdb048 00000000 f8b46db8 dfccefc4 c126e56d 
>        c146e438 c145210e f8b3c243 c1fdb114 c1fdb114 c1fa3740 fffffffc dfccbe8c 
>        c1fa3740 dfccefe4 c10361d6 c126e4c6 ffffffff ffffffff c10360f2 00000000 
> Call Trace:
>  [<c126e56d>] really_probe+0xa7/0x10c
>  [<c10361d6>] kthread+0xe4/0xe8
>  [<c1001005>] kernel_thread_helper+0x5/0xb
> DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
> Leftover inexact backtrace:
>  [<c1003f83>] show_stack_log_lvl+0xa6/0xcb
>  [<c1004180>] show_registers+0x1d8/0x286
>  [<c100437f>] die+0x151/0x333
>  [<c10197f9>] do_page_fault+0x26b/0x51f
>  [<c13e02c9>] error_code+0x39/0x40
>  [<c126e56d>] really_probe+0xa7/0x10c
>  [<c10361d6>] kthread+0xe4/0xe8
>  [<c1001005>] kernel_thread_helper+0x5/0xb
> Code: 00 89 44 24 08 c7 44 24 04 ac 53 40 c1 c7 04 24 f0 e3 46 c1 e8 38 4b db ff 31 f6 89 f0 83 c4 0c 5b 5e 5f 5d c3 8b 83 14 01 00 00 <8b> 00 89 44 24 08 8d 83 cc 00 00 00 89 44 24 04 c7 04 24 10 e4 
> EIP: [<c126e43f>] device_bind_driver+0x49/0xd0 SS:ESP 0068:dfccef80

I'd assume that you have CONFIG_PCI_MULTITHREAD_PROBE set, and
gregkh-driver-driver-multithread.patch and
gregkh-driver-pci-multithreaded-probe.patch have found a DVB race.
