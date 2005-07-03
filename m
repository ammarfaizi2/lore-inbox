Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVGCWHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVGCWHf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 18:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVGCWH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 18:07:29 -0400
Received: from mail58-s.fg.online.no ([148.122.161.58]:4258 "EHLO
	mail58-s.fg.online.no") by vger.kernel.org with ESMTP
	id S261552AbVGCWGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 18:06:00 -0400
To: linux-kernel@vger.kernel.org
Subject: A Sudden Death of Audio (linux-2.6.12-RT-V0.7.50-15)
From: Esben Stien <b0ef@esben-stien.name>
Date: Mon, 04 Jul 2005 00:02:21 +0200
Message-ID: <87ll4nk0pe.fsf@quasar.esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All of a sudden, audio died and all apps using the device froze. I'm
on a p3-600 with a emu10k1 chip.

Compiling with the latest patch now, but here's the dmesg output:

BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000107
 printing eip:
f8865c12
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: capability commoncap snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul loop radeon usb_midi audio snd_usb_audio snd_usb_lib 8139too ne2k_pci 8390 snd_emu10k1 snd_rawmidi snd_util_mem snd_hwdep evdev
CPU:    0
EIP:    0060:[<f8865c12>]    Not tainted VLI
EFLAGS: 00210292   (2.6.12-RT-V0.7.50-15) 
EIP is at snd_emu10k1_pcm_init_voice+0x12/0x5e0 [snd_emu10k1]
eax: 000000ff   ebx: 0000e000   ecx: 00000000   edx: f6268b74
esi: f62696a4   edi: 0000e000   ebp: f6268000   esp: e2883e1c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process jackd (pid: 26621, threadinfo=e2882000 task=dfa222f0)
Stack: f6268000 0808001a 03020100 00000000 f6268590 c17e4920 e2883e80 00000000 
       00000001 00000000 e4c44c00 000000ff 00000000 0e0d000e 00000000 0000e000 
       f62696a4 0000e000 00000010 f886666d f6268000 00000000 00000000 f6268b74 
Call Trace:
 [<f886666d>] snd_emu10k1_efx_playback_prepare+0x10d/0x120 [snd_emu10k1] (80)
 [<c036f991>] snd_pcm_do_prepare+0x11/0x30 (60)
 [<c036ee6c>] snd_pcm_action_group+0x11c/0x1e0 (16)
 [<c036f1e9>] snd_pcm_action_nonatomic+0x49/0xa0 (32)
 [<c036f9fd>] snd_pcm_prepare+0x1d/0x30 (32)
 [<c03721b2>] snd_pcm_playback_ioctl1+0x52/0x2c0 (16)
 [<c0130dbb>] futex_wake+0x6b/0xc0 (16)
 [<c0130d04>] wake_futex+0x34/0x80 (4)
 [<c012fe43>] rt_up_read+0x23/0x40 (8)
 [<c0130dcf>] futex_wake+0x7f/0xc0 (8)
 [<c0130dcf>] futex_wake+0x7f/0xc0 (4)
 [<c017041e>] do_ioctl+0x9e/0xb0 (28)
 [<c012fff2>] up_mutex+0x32/0x80 (16)
 [<c01705d5>] vfs_ioctl+0x65/0x200 (20)
 [<c015cc15>] fget_light+0x85/0x90 (16)
 [<c01707f8>] sys_ioctl+0x88/0xa0 (20)
 [<c0102d2b>] sysenter_past_esp+0x54/0x75 (40)
Code: 00 fe 05 00 00 00 06 89 f6 c3 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 90 55 57 56 53 83 ec 3c 8b 54 24 5c 8b 6c 24 50 8b 42 10 <8b> 40 08 8b 40 60 89 44 24 28 8b 4c 24 28 8b 72 04 83 78 2c 02 
 
-- 
Esben Stien is b0ef@e     s      a             
         http://www. s     t    n m
          irc://irc.  b  -  i  .   e/%23contact
          [sip|iax]:   e     e 
           jid:b0ef@    n     n
