Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVLCI7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVLCI7p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 03:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVLCI7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 03:59:44 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:16716 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751221AbVLCI7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 03:59:44 -0500
Date: Sat, 03 Dec 2005 01:59:40 -0700
From: Duane Evenson <devenson@shaw.ca>
Subject: Re: system freezes
In-reply-to: <5dbfP-2AF-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Reply-to: devenson@shaw.ca
Message-id: <43915E7C.9080001@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5daMR-21r-33@gated-at.bofh.it> <5dbfP-2AF-15@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, 2005-11-26 at 09:06 -0700, Duane Evenson wrote:
> 
>>My system keeps freezing. This has been an issue since I moved to 2.6.x.
>>I've tried various 2.6 kernels and various rebuilds.
> 
> 
> well better try without the binary only nvidia driver if you want most
> people to even look further.
> 

OK, no nvidia -- unfortunately, my kernel is still freezing. It seems to
happen when the kernel is paging memory. Here's some recent log output:

====================================================================
Dec  2 22:00:01 dave kernel: bttv0: PLL can sleep, using XTAL (28636363).
Dec  2 22:04:27 dave kernel: Unable to handle kernel paging request at
virtual address 7c827f7f
Dec  2 22:04:27 dave kernel:  printing eip:
Dec  2 22:04:27 dave kernel: c0144bc3
Dec  2 22:04:27 dave kernel: *pde = 00000000
Dec  2 22:04:27 dave kernel: Oops: 0000 [#1]
Dec  2 22:04:27 dave kernel: Modules linked in: sd_mod(U) usb_storage(U)
scsi_mod(U) usbhid(U) parport_pc(U) lp(U) parport(U) md5(U) ipv6(U)
w83627hf(U) hwmon_vid(U) hwmon(U) i2c_isa(U) ipt_TCPMSS(U) ipt_limit(U)
ip_nat_irc(U) ip_nat_ftp(U) ipt_LOG(U) ipt_TOS(U) ip_conntrack_irc(U)
ip_conntrack_ftp(U) ipt_MASQUERADE(U) iptable_nat(U) ip_nat(U)
ipt_state(U) ip_conntrack(U) nfnetlink(U) ipt_REJECT(U)
iptable_filter(U) iptable_mangle(U) ip_tables(U) vfat(U) fat(U) video(U)
thermal(U) processor(U) fan(U) button(U) uhci_hcd(U) tuner(U) tvaudio(U)
bttv(U) video_buf(U) firmware_class(U) v4l2_common(U) btcx_risc(U)
tveeprom(U) videodev(U) snd_bt87x(U) via_agp(U) agpgart(U) i2c_viapro(U)
snd_ens1371(U) gameport(U) snd_rawmidi(U) snd_ac97_codec(U)
snd_seq_dummy(U) snd_seq_oss(U) snd_seq_midi_event(U) snd_seq(U)
snd_seq_device(U) snd_pcm_oss(U) snd_mixer_oss(U) snd_pcm(U)
snd_timer(U) snd(U) soundcore(U) snd_page_alloc(U) snd_ac97_bus(U)
sundance(U) 3c59x(U) mii(U) floppy(U)
Dec  2 22:04:27 dave kernel: CPU:    0
Dec  2 22:04:27 dave kernel: EIP:    0060:[<c0144bc3>]    Not tainted VLI
Dec  2 22:04:27 dave kernel: EFLAGS: 00010046   (2.6.14-prep)
Dec  2 22:04:27 dave kernel: EIP is at free_block+0x73/0xf0
Dec  2 22:04:27 dave kernel: eax: 7c827f7b   ebx: ee205de4   ecx:
ee205000   edx: cef17000
Dec  2 22:04:27 dave kernel: esi: f7ffdbe0   edi: f7fffc00   ebp:
00000034   esp: f7c35de0
Dec  2 22:04:27 dave kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 22:04:27 dave kernel: Process kswapd0 (pid: 116,
threadinfo=f7c34000 task=c19a9570)
Dec  2 22:04:27 dave kernel: Stack: 00000000 0000003c f7ff9610 f7fffc00
00000296 c87d23c4 f7ff9610 c0144cdb
Dec  2 22:04:27 dave kernel:        00000000 f7ff9600 f7ffeb80 0000003c
f7ff9600 00000296 c87d23c4 f7c35f7c
Dec  2 22:04:27 dave kernel:        c0144e9f c87d23c4 00000001 f7c35f14
c015e6f4 c015e578 c87d23c4 c0197710
Dec  2 22:04:27 dave kernel: Call Trace:
Dec  2 22:04:27 dave kernel:  [<c0144cdb>] cache_flusharray+0x9b/0xe0
Dec  2 22:04:28 dave kernel:  [<c0144e9f>] kmem_cache_free+0x3f/0x50
Dec  2 22:04:28 dave kernel:  [<c015e6f4>] free_buffer_head+0x14/0x30
Dec  2 22:04:28 dave kernel:  [<c015e578>] try_to_free_buffers+0x48/0x80
Dec  2 22:04:28 dave kernel:  [<c0197710>] ext3_releasepage+0x0/0xa0
Dec  2 22:04:28 dave kernel:  [<c015c694>] try_to_release_page+0x34/0x60
Dec  2 22:04:28 dave kernel:  [<c01471fa>] shrink_list+0x3ba/0x440
Dec  2 22:04:28 dave kernel:  [<c014742f>] shrink_cache+0xdf/0x290
Dec  2 22:04:28 dave kernel:  [<c0141cf0>] get_writeback_state+0x30/0x40
Dec  2 22:04:28 dave kernel:  [<c0141d29>] get_dirty_limits+0x29/0x130
Dec  2 22:04:28 dave kernel:  [<c01479f8>] shrink_zone+0x88/0xe0
Dec  2 22:04:28 dave kernel:  [<c0147e5e>] balance_pgdat+0x1fe/0x3e0
Dec  2 22:04:28 dave kernel:  [<c014810c>] kswapd+0xcc/0x110
Dec  2 22:04:28 dave kernel:  [<c012d1a0>] autoremove_wake_function+0x0/0x50
Dec  2 22:04:28 dave kernel:  [<c0148040>] kswapd+0x0/0x110
Dec  2 22:04:28 dave kernel:  [<c0101349>] kernel_thread_helper+0x5/0xc
Dec  2 22:04:28 dave kernel: Code: 08 8b 15 f0 af 3c c0 8b 1c a8 8d 83
00 00 00 40 c1 e8 0c c1 e0 05 8b 4c 10 1c 8b 54 24 20 8b 74 97 14 8b 51
04 3b 0a 75 6a 8b 01 <3b> 48 04 75 6d 89 50 04 89 02 31 d2 2b 59 0c c7
01 00 01 10 00
Dec  2 22:05:01 dave kernel:  ------------[ cut here ]------------
Dec  2 22:05:01 dave kernel: kernel BUG at include/linux/list.h:165!
Dec  2 22:05:01 dave kernel: invalid operand: 0000 [#2]
Dec  2 22:05:01 dave kernel: Modules linked in: sd_mod(U) usb_storage(U)
scsi_mod(U) usbhid(U) parport_pc(U) lp(U) parport(U) md5(U) ipv6(U)
w83627hf(U) hwmon_vid(U) hwmon(U) i2c_isa(U) ipt_TCPMSS(U) ipt_limit(U)
ip_nat_irc(U) ip_nat_ftp(U) ipt_LOG(U) ipt_TOS(U) ip_conntrack_irc(U)
ip_conntrack_ftp(U) ipt_MASQUERADE(U) iptable_nat(U) ip_nat(U)
ipt_state(U) ip_conntrack(U) nfnetlink(U) ipt_REJECT(U)
iptable_filter(U) iptable_mangle(U) ip_tables(U) vfat(U) fat(U) video(U)
thermal(U) processor(U) fan(U) button(U) uhci_hcd(U) tuner(U) tvaudio(U)
bttv(U) video_buf(U) firmware_class(U) v4l2_common(U) btcx_risc(U)
tveeprom(U) videodev(U) snd_bt87x(U) via_agp(U) agpgart(U) i2c_viapro(U)
snd_ens1371(U) gameport(U) snd_rawmidi(U) snd_ac97_codec(U)
snd_seq_dummy(U) snd_seq_oss(U) snd_seq_midi_event(U) snd_seq(U)
snd_seq_device(U) snd_pcm_oss(U) snd_mixer_oss(U) snd_pcm(U)
snd_timer(U) snd(U) soundcore(U) snd_page_alloc(U) snd_ac97_bus(U)
sundance(U) 3c59x(U) mii(U) floppy(U)
Dec  2 22:05:01 dave kernel: CPU:    0
Dec  2 22:05:01 dave kernel: EIP:    0060:[<c0144c2b>]    Not tainted VLI
Dec  2 22:05:01 dave kernel: EFLAGS: 00010812   (2.6.14-prep)
Dec  2 22:05:01 dave kernel: EIP is at free_block+0xdb/0xf0
Dec  2 22:05:01 dave kernel: eax: 00138c20   ebx: c9c61a84   ecx:
c9c61000   edx: ee205000
Dec  2 22:05:01 dave kernel: esi: f7ffdbe0   edi: f7fffc00   ebp:
00000024   esp: effdfcfc
Dec  2 22:05:01 dave kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 22:05:01 dave kernel: Process mrtg (pid: 2907,
threadinfo=effde000 task=ecca4a70)
Dec  2 22:05:01 dave kernel: Stack: 00000000 0000003c f7ff9610 f7fffc00
00000282 df185244 f7ff9610 c0144cdb
Dec  2 22:05:01 dave kernel:        00000000 f7ff9600 f7ffeb80 0000003c
f7ff9600 00000282 df185244 effdfe80
Dec  2 22:05:01 dave kernel:        c0144e9f df185244 00000001 effdfe30
c015e6f4 c015e578 df185244 c0197710
Dec  2 22:05:01 dave kernel: Call Trace:
Dec  2 22:05:01 dave kernel:  [<c0144cdb>] cache_flusharray+0x9b/0xe0
Dec  2 22:05:01 dave kernel:  [<c0144e9f>] kmem_cache_free+0x3f/0x50
Dec  2 22:05:01 dave kernel:  [<c015e6f4>] free_buffer_head+0x14/0x30
Dec  2 22:05:01 dave kernel:  [<c015e578>] try_to_free_buffers+0x48/0x80
Dec  2 22:05:01 dave kernel:  [<c0197710>] ext3_releasepage+0x0/0xa0
Dec  2 22:05:01 dave kernel:  [<c015c694>] try_to_release_page+0x34/0x60
Dec  2 22:05:01 dave kernel:  [<c01471fa>] shrink_list+0x3ba/0x440
Dec  2 22:05:01 dave kernel:  [<c014759d>] shrink_cache+0x24d/0x290
Dec  2 22:05:01 dave kernel:  [<c01479f8>] shrink_zone+0x88/0xe0
Dec  2 22:05:01 dave kernel:  [<c0147aa7>] shrink_caches+0x57/0x70
Dec  2 22:05:01 dave kernel:  [<c0147b91>] try_to_free_pages+0xd1/0x1a0
Dec  2 22:05:01 dave kernel:  [<c0140af3>] __alloc_pages+0x1e3/0x410
Dec  2 22:05:01 dave kernel:  [<c0145ca0>] activate_page+0x90/0xb0
Dec  2 22:05:01 dave kernel:  [<c014b9be>] do_anonymous_page+0x7e/0x160
Dec  2 22:05:01 dave kernel:  [<c014bcc4>] do_no_page+0x224/0x3a0
Dec  2 22:05:01 dave kernel:  [<c014c08c>] __handle_mm_fault+0x15c/0x1a0
Dec  2 22:05:01 dave kernel:  [<c02cecf9>] do_page_fault+0x259/0x65a
Dec  2 22:05:01 dave kernel:  [<c02ceaa0>] do_page_fault+0x0/0x65a
Dec  2 22:05:01 dave kernel:  [<c0103bc7>] error_code+0x4f/0x54
Dec  2 22:05:01 dave kernel: Code: 84 6f ff ff ff 8b 46 04 89 31 89 4e
04 89 08 89 41 04 e9 77 ff ff ff 2b 47 1c 89 ca 89 46 18 89 f8 e8 4a ef
ff ff e9 63 ff ff ff <0f> 0b a5 00 5f fe 2d c0 eb 8c 0f 0b a6 00 5f fe
2d c0 eb 89 90

