Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266528AbUFQP4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266528AbUFQP4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUFQP4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:56:04 -0400
Received: from sampa1.prodam.sp.gov.br ([200.230.190.2]:4876 "EHLO
	netlab96.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S266528AbUFQPzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:55:16 -0400
Date: Thu, 17 Jun 2004 10:42:48 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: Jakub Bogusz <qboosh@pld-linux.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: CONFIG_FB_3DFX_ACCEL is unusable (in 2.6.7)
Message-ID: <20040617134248.GA1297@tirion.prodam>
Mail-Followup-To: Jakub Bogusz <qboosh@pld-linux.org>,
	linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
References: <20040616192433.GA5874@satan.blackhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616192433.GA5874@satan.blackhosts>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello Jakub,

Em Wed, Jun 16, 2004 at 09:24:33PM +0200, Jakub Bogusz escreveu:

| I suggest marking this option as BROKEN or remove at all for now.

 I enabled this option. This code was generating warnings, and I
prefer to enable it, otherwise people can forget it (I think
mark it as EXPERIMENTAL is enough).

 This code is under development, anyway. Actually, I think people is
not working in it because there is no people to test. So, I
think you is welcome. :-)

 I'll forward to fb-devel list.

| It looks like some artifact of old hwcursor code which never worked in
| 2.6.x.
| It uses some fields (namely par->hwcursor.*) never initialized,
| uninitialized timer, contains obvious bugs (using "&&" for testing
| bitfields) and finally causes oopses crashing system - like this:
| 
| kernel: Console: switching consoles 1-1 to colour frame buffer device 100x37
| kernel: Console: switching consoles 2-2 to colour frame buffer device 100x37
| kernel: Console: switching consoles 3-3 to colour frame buffer device 100x37
| kernel: Console: switching consoles 4-4 to colour frame buffer device 100x37
| kernel: Console: switching consoles 5-5 to colour frame buffer device 100x37
| kernel: Console: switching consoles 6-6 to colour frame buffer device 100x37
| kernel: Console: switching consoles 7-7 to colour frame buffer device 100x37
| kernel: Uninitialised timer!
| kernel: This is just a warning.  Your computer is OK
| kernel: function=0x00000000, data=0x0
| kernel: [<c011b09f>] check_timer_failed+0x5f/0x70
| kernel: [<c011b3c2>] del_timer+0x12/0x80
| kernel: [<d88c4555>] tdfxfb_cursor+0x315/0x380 [tdfxfb]
| kernel: [<c01e5c63>] fbcon_cursor+0x273/0x380
| kernel: [<c01e59d3>] fbcon_putcs+0x93/0xb0
| kernel: [<c01bee01>] do_update_region+0xc1/0x180
| kernel: [<c01bf893>] set_cursor+0x63/0x80
| kernel: [<c01bfa6c>] redraw_screen+0xfc/0x1e0
| kernel: [<c01bf132>] update_attr+0xb2/0xd0
| kernel: [<c01c3662>] take_over_console+0x2f2/0x420
| kernel: [<c01e4931>] set_con2fb_map+0x41/0x50
| kernel: [<c01e93bc>] fb_ioctl+0x2cc/0x330
| kernel: [<c012c28d>] filemap_nopage+0x1ed/0x330
| kernel: [<c0139009>] do_no_page+0x189/0x2e0
| kernel: [<c013932e>] handle_mm_fault+0xbe/0x150
| kernel: [<c010fbc9>] do_page_fault+0x2e9/0x4c6
| kernel: [<c014e32f>] cdev_get+0x4f/0xb0
| kernel: [<c014e06c>] chrdev_open+0xec/0x210
| kernel: [<c01451e9>] dentry_open+0xf9/0x210
| kernel: [<c01450ec>] filp_open+0x4c/0x50
| kernel: [<c01568c9>] sys_ioctl+0x109/0x280
| kernel: [<c0103c1b>] syscall_call+0x7/0xb
| kernel:
| kernel: Console: switching consoles 8-8 to colour frame buffer device 100x37
| kernel: Console: switching consoles 9-9 to colour frame buffer device 100x37
| kernel: Console: switching consoles 13-13 to colour frame buffer device 100x37
| kernel: Console: switching consoles 14-14 to colour frame buffer device 100x37
| kernel: Console: switching consoles 15-15 to colour frame buffer device 100x37
| kernel: Console: switching consoles 16-16 to colour frame buffer device 100x37
| kernel: Console: switching consoles 17-17 to colour frame buffer device 100x37
| kernel: Console: switching consoles 18-18 to colour frame buffer device 100x37
| kernel: Console: switching consoles 19-19 to colour frame buffer device 100x37
| kernel: Console: switching consoles 20-20 to colour frame buffer device 100x37
| kernel: Console: switching consoles 21-21 to colour frame buffer device 100x37
| kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000001f
| kernel: printing eip:
| kernel: d88c42dd
| kernel: *pde = 00000000
| kernel: Oops: 0000 [#1]
| kernel: PREEMPT
| kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000002f
| kernel: printing eip:
| kernel: d88c42dd
| kernel: *pde = 00000000
| kernel: Oops: 0000 [#2]
| kernel: PREEMPT
| kernel: Modules linked in: binfmt_misc af_packet via686a i2c_sensor i2c_isa i2c_core tdfxfb cfbimgblt snd_ens1371 snd_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer snd_ac97_codec snd ne2k_pci 8390 crc32 parport_pc parport via_agp agpgart evdev 8250 serial_core joydev analog es1371 soundcore gameport ac97_codec pcspkr uhci_hcd usbcore rtc
| kernel: CPU:    0
| kernel: EIP:    0060:[<d88c42dd>]    Not tainted
| kernel: EFLAGS: 00010086   (2.6.7)
| kernel: EIP is at tdfxfb_cursor+0x9d/0x380 [tdfxfb]
| kernel: eax: c01e59d3   ebx: d7fc8e01   ecx: 0000000f   edx: 00000010
| kernel: esi: c028ab10   edi: d265bb90   ebp: 0000000c   esp: d265bb24
| kernel: ds: 007b   es: 007b   ss: 0068
| kernel: Process tput (pid: 5644, threadinfo=d265a000 task=d22bac90)
| kernel: Stack: c01e4c93 00000008 d795866c d265bb90 d7958400 00000010 00000002
| 
| kernel: d7fc8e01 c028ab10 c01e59d3 ffffffff ffffffff d7fc8e00 00000002 d7958400
| kernel: 0000000c c01e5d45 0000ffff 00000019 00000001 c0342708 c01e00ff 0000000f
| kernel: Call Trace:
| kernel: [<c01e4c93>] accel_putcs+0x253/0x2d0
| kernel: [<c01e59d3>] fbcon_putcs+0x93/0xb0
| kernel: [<c01e5d45>] fbcon_cursor+0x355/0x380
| kernel: [<c01e00ff>] proc_ide_write_settings+0x14f/0x260
| kernel: [<c01e59d3>] fbcon_putcs+0x93/0xb0
| kernel: [<c01bf81d>] hide_cursor+0x1d/0x30
| kernel: [<c01c2d94>] vt_console_print+0x2c4/0x2d0
| kernel: [<c01bf893>] set_cursor+0x63/0x80
| kernel: [<c01c2ad0>] vt_console_print+0x0/0x2d0
| kernel: [<c0114762>] __call_console_drivers+0x42/0x50
| kernel: [<c0114855>] call_console_drivers+0x75/0x100
| kernel: [<c0114baa>] release_console_sem+0x4a/0xe0
| kernel: [<c0114aac>] printk+0xfc/0x160
| kernel: [<c01043f0>] die+0x80/0x100
| kernel: [<c010fa97>] do_page_fault+0x1b7/0x4c6
| kernel: [<c01ac422>] copy_to_user+0x32/0x50
| kernel: [<c016a7d3>] load_elf_binary+0x513/0xc00
| kernel: [<c010f8e0>] do_page_fault+0x0/0x4c6
| kernel: [<c0103dc5>] error_code+0x2d/0x38
| kernel: [<d88c42dd>] tdfxfb_cursor+0x9d/0x380 [tdfxfb]
| kernel: [<c01e5c63>] fbcon_cursor+0x273/0x380
| kernel: [<c01bf893>] set_cursor+0x63/0x80
| kernel: [<c01c30e1>] con_flush_chars+0x31/0x40
| kernel: [<c01c2f54>] con_write+0x24/0x40
| kernel: [<c01b6186>] opost_block+0xc6/0x170
| kernel: [<c012c247>] filemap_nopage+0x1a7/0x330
| kernel: [<c0139009>] do_no_page+0x189/0x2e0
| kernel: [<c01b834d>] write_chan+0x1ad/0x230
| kernel: [<c0111360>] default_wake_function+0x0/0x10
| kernel: [<c010fbc9>] do_page_fault+0x2e9/0x4c6
| kernel: [<c0111360>] default_wake_function+0x0/0x10
| kernel: [<c013a621>] vma_merge+0x121/0x190
| kernel: [<c01b3291>] tty_write+0x1c1/0x260
| kernel: [<c013ac72>] do_mmap_pgoff+0x512/0x650
| kernel: [<c01b81a0>] write_chan+0x0/0x230
| kernel: [<c0145f8d>] vfs_write+0xcd/0x120
| kernel: [<c0146078>] sys_write+0x38/0x60
| kernel: [<c0103c1b>] syscall_call+0x7/0xb
| kernel:
| kernel: Code: 0f b7 04 51 c1 e0 10 89 44 24 04 0f b7 04 53 c1 e0 08 09 44
| kernel: <6>note: tput[5644] exited with preempt_count 2
| 
| 
| -- 
| Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
