Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbUKDTx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbUKDTx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbUKDTu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:50:56 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:15766 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S262387AbUKDTsx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:48:53 -0500
Date: Thu, 4 Nov 2004 20:48:46 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sikkh@wp.pl
Subject: 2.6.9-cko2 oops
Message-ID: <Pine.LNX.4.60.0411042033490.18143@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

under high load (3 X apps and gnome compilation and openoffice launching) 
I got this:

Nov  4 20:09:22 kangur Unable to handle kernel paging request at virtual 
address 14121118
Nov  4 20:09:22 kangur printing eip:
Nov  4 20:09:22 kangur b0138da9
Nov  4 20:09:22 kangur *pde = 00000000
Nov  4 20:09:22 kangur Oops: 0002 [#1]
Nov  4 20:09:22 kangur PREEMPT
Nov  4 20:09:22 kangur Modules linked in: aes_i586 dm_crypt bsd_comp md5 
ipv6 emu10k1_gp tuner tvaudio bttv video_buf firmware_class i2c_algo_bit 
v4l2_common btcx_risc i2c_core videodev nvidia speedtch uhci_hcd 
parport_pc parport snd_bt87x
snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_util_mem 
snd_hwdep snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device 
snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore 
rtc usbcore dm_mod fbcon font vesafb_tng cfbcopyarea cfbimgblt cfbfillrect 
msr edd cpuid nvram cryptoloop loop floppy evdev pcspkr analog gameport 
thermal processor fan button ac psmouse pppoatm atm ppp_deflate
zlib_deflate zlib_inflate ppp_generic slhc unix
Nov  4 20:09:22 kangur CPU:    0
Nov  4 20:09:22 kangur EIP:    0060:[<b0138da9>]    Tainted: P   VLI
Nov  4 20:09:22 kangur EFLAGS: 00010016   (2.6.9-cko2)
Nov  4 20:09:22 kangur EIP is at free_block+0x49/0xd0
Nov  4 20:09:22 kangur eax: 14121114   ebx: dde40000   ecx: dde4002c 
edx: b6de7000
Nov  4 20:09:22 kangur esi: efc5ee60   edi: 00000016   ebp: efc5ee6c 
esp: efc77e88
Nov  4 20:09:22 kangur ds: 007b   es: 007b   ss: 0068
Nov  4 20:09:22 kangur Process kswapd0 (pid: 36, threadinfo=efc76000 
task=efc46aa0)
Nov  4 20:09:22 kangur Stack: efc5ee7c 0000001b efc61070 efc61070 efc5ee60 
c4a8daac efc57740 b0138e71
Nov  4 20:09:22 kangur 0000001b efc61060 efc61060 00000292 c4a8daac 
efc76000 b013915a c4a8db40
Nov  4 20:09:22 kangur efc77ef8 00000009 b0163d93 c4a8db40 b0164013 
efc76000 dd935d00 00000080
Nov  4 20:09:22 kangur Call Trace:
Nov  4 20:09:22 kangur [<b0138e71>] cache_flusharray+0x41/0xd0
Nov  4 20:09:22 kangur [<b013915a>] kmem_cache_free+0x3a/0x50
Nov  4 20:09:22 kangur [<b0163d93>] destroy_inode+0x43/0x50
Nov  4 20:09:22 kangur [<b0164013>] dispose_list+0x43/0x90
Nov  4 20:09:22 kangur [<b016432f>] prune_icache+0xbf/0x200
Nov  4 20:09:22 kangur [<b0164484>] shrink_icache_memory+0x14/0x40
Nov  4 20:09:22 kangur [<b013ac35>] shrink_slab+0x135/0x160
Nov  4 20:09:22 kangur [<b013be97>] balance_pgdat+0x217/0x2a0
Nov  4 20:09:22 kangur [<b013bfde>] kswapd+0xbe/0xd0
Nov  4 20:09:22 kangur [<b0115e50>] autoremove_wake_function+0x0/0x50
Nov  4 20:09:22 kangur [<b0103ede>] ret_from_fork+0x6/0x14
Nov  4 20:09:22 kangur [<b0115e50>] autoremove_wake_function+0x0/0x50
Nov  4 20:09:22 kangur [<b013bf20>] kswapd+0x0/0xd0
Nov  4 20:09:22 kangur [<b010229d>] kernel_thread_helper+0x5/0x18
Nov  4 20:09:22 kangur Code: 8d 40 1c 8d 6e 0c 89 04 24 8b 44 24 08 8b 15 
90 2e 4e b0 8b 0c b8 8d 81 00 00 00 50 c1 e8 0c c1 e0 05 8b 5c 02 1c 8b 53 
04 8b 03 <89> 50 04 89 02 c7 43 04 00 02 20 00 2b 4b 0c c7 03 00 01 10 00
Nov  4 20:09:22 kangur <6>note: kswapd0[36] exited with preempt_count 1


Yes, I know that the kernel was tainted, but it is hard to reproduce this 
kind of problem on my box (it is very rare with good kernels) and no other 
drivers (except nvidia) are working stable for my graphics card. And the 
callstack looks like it is not corrupted, so if you will want to look at 
this or want me to provide any further details fell free to do it.

I was using dm-crypt at this time (for the partition where gnome was going 
to be installed and for swap). But I have 1G RAM, and swap (4G) was not 
probably used at all (or was used for < 8M). I was also testing reiser4 at 
this partition, but it seems to be very stable and reliable and I think I 
got this kind of ooops (under very high load) before using it or dm-crypt.


Thanks,

Grzegorz Kulewski

