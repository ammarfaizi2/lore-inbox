Return-Path: <linux-kernel-owner+w=401wt.eu-S1753632AbWL0LJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbWL0LJs (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 06:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453AbWL0LJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 06:09:47 -0500
Received: from javad.com ([216.122.176.236]:4078 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753632AbWL0LJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 06:09:46 -0500
From: Sergei Organov <osv@javad.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: moxa serial driver testing
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>
	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>
	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>
	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>
	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>
	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>
	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com>
	<87r6urket6.fsf@javad.com> <552766292581216610@wsc.cz>
Date: Wed, 27 Dec 2006 14:09:21 +0300
In-Reply-To: <552766292581216610@wsc.cz> (Jiri Slaby's message of "Sat, 23
 Dec
	2006 02:35:46 +0100 (CET)")
Message-ID: <87bqlpioim.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> writes:
> osv@javad.com wrote:
>> Hi Jiri,
>> 
>> I've figured out that both old and new mxser drivers have two similar
>> problems:
>> 
>> 1. When there are data coming to a port, sometimes opening of the port
>>    entirely locks the box. This is quite reproducible. Any idea what's
>>    wrong and how can I help to debug it?
>
> Could you test the patch below, if something changes?

I've tested the latest version you've sent me yesterday. Still no
luck. The oops is below. I'll try with low_latency commented in a few
minutes.

BUG: unable to handle kernel NULL pointer dereference at virtual address 00000068
 printing eip:
f8f3711f
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: nvidia agpgart ipv6 nfs lockd nfs_acl sunrpc dm_mod sr_mod sbp2 ieee1394 ide_generic ide_disk e1000 snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss i2c_i801 psmouse snd_pcm floppy tsdev serio_raw snd_timer parport_pc parport snd i2c_core pcspkr evdev soundcore snd_page_alloc mxser_new rtc ext3 jbd mbcache sd_mod ide_cd cdrom usb_storage usbhid ata_piix libata piix scsi_mod generic uhci_hcd ide_core usbcore skge thermal processor fan
CPU:    0
EIP:    0060:[<f8f3711f>]    Tainted: P      VLI
EFLAGS: 00010246   (2.6.18-3-686 #1) 
EIP is at mxser_stoprx+0x54/0x74 [mxser_new]
eax: 00000000   ebx: 00000001   ecx: f8f3d79c   edx: dfde7240
esi: f391211b   edi: f4f83fff   ebp: c1b17800   esp: f5bc7d7c
ds: 007b   es: 007b   ss: 0068
Process make (pid: 17088, ti=f5bc6000 task=f4febaa0 task.ti=f5bc6000)
Stack: 00000001 c01fe4af 000000ff f391201c c1b17c04 c011669e 00000000 00000000 
       00000003 00000096 c1b1780c 00000286 00000001 00000096 c01f97c9 00000000 
       f456f800 00000286 f8f38335 f5bc7e14 f8f3d8a8 00000286 c01f9806 f456f800 
Call Trace:
 [<c01fe4af>] n_tty_receive_buf+0xcd6/0xcf9
 [<c011669e>] __wake_up+0x2a/0x3d
 [<c01f97c9>] tty_ldisc_deref+0x50/0x5f
 [<f8f38335>] mxser_receive_chars+0x241/0x249 [mxser_new]
 [<c01f9806>] tty_ldisc_try+0x2e/0x32
 [<c01f9d4c>] flush_to_ldisc+0x12f/0x15c
 [<c01f9793>] tty_ldisc_deref+0x1a/0x5f
 [<f8f38335>] mxser_receive_chars+0x241/0x249 [mxser_new]
 [<f8f37678>] mxser_transmit_chars+0x14/0x164 [mxser_new]
 [<c01f9d21>] flush_to_ldisc+0x104/0x15c
 [<f8f38335>] mxser_receive_chars+0x241/0x249 [mxser_new]
 [<f8f38d7a>] mxser_interrupt+0x15f/0x1e6 [mxser_new]
 [<c013fb83>] handle_IRQ_event+0x23/0x49
 [<c013fc3c>] __do_IRQ+0x93/0xe8
 [<c01050e5>] do_IRQ+0x43/0x52
 [<c01036b6>] common_interrupt+0x1a/0x20
 [<c01bacf4>] __copy_from_user_ll+0x19/0x38
 [<c01071de>] convert_fxsr_from_user+0x15/0xd5
 [<c0164bc8>] pipe_read+0x0/0x1e
 [<c010774e>] restore_i387+0x6f/0xc0
 [<c0102203>] restore_sigcontext+0x10f/0x165
 [<c0102b3d>] sys_sigreturn+0xa4/0xcb
 [<c0102c7b>] syscall_call+0x7/0xb
Code: 83 e0 ee 89 41 3c 25 ee 00 00 00 42 eb 19 0f b6 42 1a 8b 51 08 89 41 38 31 c0 42 ee 89 d8 83 c8 02 89 41 3c 0f b6 c0 ee 8b 41 04 <8b> 40 68 83 78 08 00 79 15 8b 41 40 8b 51 08 83 e0 fd 89 41 40 
EIP: [<f8f3711f>] mxser_stoprx+0x54/0x74 [mxser_new] SS:ESP 0068:f5bc7d7c
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 
