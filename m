Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVEQReF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVEQReF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVEQReE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:34:04 -0400
Received: from mail.aei.ca ([206.123.6.14]:58068 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261931AbVEQRbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:31:18 -0400
Subject: 2.6.12-rc4 OOPS EIP is at free_block
From: Shane Shrybman <shrybman@aei.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 17 May 2005 13:31:12 -0400
Message-Id: <1116351072.4707.26.camel@mars>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, (Please CC me on replies)

New nforce2 board (Asus A7N8X-X) is not stable. Memory has passed 33
loops through memtest+. I have disabled the onboard LAN and have stopped
the NFS server on the system. I have googled and googled and tried
nolapic, noapic, acpi=off... I am not using 4K stacks or regparm config
options.

Are there any issues with device-mapper stripping and ext3 maybe? or
with nforce2 boards and the bttv driver?

Here is a typical oops, any insights appreciated.

saa7115: decoder disable output
saa7115: decoder enable output
Unable to handle kernel paging request at virtual address 222b393e
 printing eip:
c0141cd8
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in: netconsole lirc_i2c lirc_dev msp3400 saa7115 ivtv
i2c_nforce2 nvidia_agp tuner tvaudio bttv video_buf firmware_class
btcx_risc tveeprom snd_cmipci gameport snd_opl3_lib snd_hwdep
snd_mpu401_uart snd_rawmidi snd_seq_device 3c59x mii snd_intel8x0
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
snd_page_alloc ehci_hcd ohci_hcd usbcore agpgart dm_mod realtime rtc
CPU:    0
EIP:    0060:[<c0141cd8>]    Not tainted VLI
EFLAGS: 00010012   (2.6.12-rc4) 
EIP is at free_block+0x48/0xd0
eax: 222b393a   ebx: c764c000   ecx: c764cb3c   edx: c5bc1000
esi: dffe7c60   edi: 00000011   ebp: dffe7c6c   esp: c15bdd18
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 150, threadinfo=c15bc000 task=c155ea60)
Stack: c02d3234 cc8440a0 dffe7c7c dffe9210 00000296 cca76efc dffeeb00
c0141dac 
       dffe7c60 dffe9210 0000003c 0000003c dffe9200 00000296 cca76efc
cca76efc 
       c0141f97 dffe7c60 dffe9200 c15bc000 c11f2880 00000001 c015c13b
dffe7c60 
Call Trace:
 [<c02d3234>] tcp_v4_do_rcv+0x114/0x120
 [<c0141dac>] cache_flusharray+0x4c/0xf0
 [<c0141f97>] kmem_cache_free+0x47/0x50
 [<c015c13b>] free_buffer_head+0x2b/0x70
 [<c015bf6b>] try_to_free_buffers+0x6b/0xb0
 [<c01a5965>] journal_try_to_free_buffers+0x85/0xe0
 [<c01430ab>] __pagevec_release_nonlru+0x6b/0x90
 [<c0195ef8>] ext3_releasepage+0x58/0x90
 [<c015a0c1>] try_to_release_page+0x51/0x70
 [<c01443e8>] shrink_list+0x368/0x430
 [<c0144674>] shrink_cache+0x114/0x2e0
 [<c013f043>] get_writeback_state+0x43/0x50
 [<c013f068>] get_dirty_limits+0x18/0xd0
 [<c0143d4a>] shrink_slab+0x8a/0x190
 [<c0144d2d>] shrink_zone+0xad/0xe0
 [<c0145214>] balance_pgdat+0x294/0x380
 [<c01453de>] kswapd+0xde/0x100
 [<c012f3f0>] autoremove_wake_function+0x0/0x60
 [<c01030be>] ret_from_fork+0x6/0x14
 [<c012f3f0>] autoremove_wake_function+0x0/0x60
 [<c0145300>] kswapd+0x0/0x100
 [<c0101331>] kernel_thread_helper+0x5/0x14
Code: 46 1c 8d 6e 0c 89 44 24 08 8b 44 24 24 8b 15 b0 8b 48 c0 8b 0c b8
8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 02 1c 8b 53 04 8b 03 <89> 50
04 89 02 c7 43 04 00 02 20 00 2b 4b 0c c7 03 00 01 10 00 
 <6>note: kswapd0[150] exited with preempt_count 1
ivtv: ENC: User stopped capture.

I also got one of these:

do_wp_page: bogus page at address b0000000
VM: killing process mythbackend

Regards,

Shane


