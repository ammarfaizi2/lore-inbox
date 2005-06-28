Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVF1Vgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVF1Vgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVF1Vgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:36:35 -0400
Received: from alpha.polcom.net ([217.79.151.115]:60637 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261301AbVF1VcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:32:08 -0400
Date: Tue, 28 Jun 2005 23:31:58 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, John McCutchan <ttb@tentacle.dhs.org>
Subject: Re: [patch] latest inotify.
In-Reply-To: <1119989024.6745.20.camel@betsy>
Message-ID: <Pine.LNX.4.63.0506282322000.7125@alpha.polcom.net>
References: <1119989024.6745.20.camel@betsy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Are you aware of the following:

Jun 21 18:34:04 kangur ------------[ cut here ]------------
Jun 21 18:34:04 kangur kernel BUG at fs/inode.c:1100!
Jun 21 18:34:04 kangur invalid operand: 0000 [#1]
Jun 21 18:34:04 kangur PREEMPT
Jun 21 18:34:04 kangur Modules linked in: nls_iso8859_2 ntfs nls_base 
pppoatm snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_seq_midi_emul snd_pcm_oss snd_mixer_oss snd_seq_dummy snd_seq_oss 
snd_seq_midi_event snd_seq psmouse 8250_pnp 8250 serial_core floppy pcspkr 
rtc nvidia 8139too mii emu10k1_gp gameport snd_emu10k1 snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc 
snd_util_mem snd_hwdep snd soundcore tuner tvaudio bttv video_buf 
i2c_algo_bit v4l2_common btcx_risc tveeprom videodev speedtch 
firmware_class usb_atm atm via686a i2c_sensor i2c_core uhci_hcd parport_pc 
parport evdev usbcore nvram cpuid edd msr loop button ppp_generic slhc 
unix
Jun 21 18:34:04 kangur CPU:    0
Jun 21 18:34:04 kangur EIP:    0060:[<b0173342>]    Tainted: P      VLI
Jun 21 18:34:04 kangur EFLAGS: 00010246   (2.6.12-rc6-ck2-gk1)
Jun 21 18:34:04 kangur EIP is at iput+0x62/0x70
Jun 21 18:34:04 kangur eax: d11fbc00   ebx: c65a20dc   ecx: c65a20e4 
edx: c0ede000
Jun 21 18:34:04 kangur esi: c65a21e8   edi: c65a21e8   ebp: c65a20dc 
esp: c0edeeec
Jun 21 18:34:04 kangur ds: 007b   es: 007b   ss: 0068
Jun 21 18:34:04 kangur Process umount (pid: 10472, threadinfo=c0ede000 
task=cac79a40)
Jun 21 18:34:04 kangur Stack: cf63bc74 b017feff 00000000 00000000 c0ede000 
c65a21f0 c65a20dc cf63bc74
Jun 21 18:34:04 kangur cf63bc74 c0ede000 c0edef20 c0ede000 b01722ea 
c0edef20 c0edef20 c8fcea8c
Jun 21 18:34:04 kangur cf63bc00 d11fbc00 b015e3b3 0804d35c b14df3c0 
cf63bc00 0804d35c b015efa5
Jun 21 18:34:04 kangur Call Trace:
Jun 21 18:34:04 kangur [<b017feff>] inotify_unmount_inodes+0xcf/0x110
Jun 21 18:34:04 kangur [<b01722ea>] invalidate_inodes+0x3a/0x80
Jun 21 18:34:04 kangur [<b015e3b3>] generic_shutdown_super+0x63/0x160
Jun 21 18:34:04 kangur [<b015efa5>] kill_block_super+0x25/0x40
Jun 21 18:34:04 kangur [<b015e240>] deactivate_super+0x50/0x80
Jun 21 18:34:04 kangur [<b0175515>] sys_umount+0x35/0x80
Jun 21 18:34:04 kangur [<b014c708>] do_munmap+0xe8/0x150
Jun 21 18:34:04 kangur [<b0175577>] sys_oldumount+0x17/0x20
Jun 21 18:34:04 kangur [<b01030cb>] sysenter_past_esp+0x54/0x75
Jun 21 18:34:04 kangur Code: 94 00 00 00 ba c0 32 17 b0 8b 40 24 85 c0 74 
08 8b 40 18 85 c0 0f 45 d0 89 d8 ff d2 5b c3 89 d8 ff d2 8d b4 26 00 00 00 
00 eb c2 <0f> 0b 4c 04 6c 6d 2d b0 eb ad 8d 74 26 00 83 ec 08 89 74 24 04
Jun 21 18:34:04 kangur Badness in do_exit at kernel/exit.c:781
Jun 21 18:34:04 kangur [<b011be0c>] do_exit+0x3cc/0x3e0
Jun 21 18:34:04 kangur [<b01043db>] die+0x16b/0x170
Jun 21 18:34:04 kangur [<b0104700>] do_invalid_op+0x0/0xa0
Jun 21 18:34:04 kangur [<b0104790>] do_invalid_op+0x90/0xa0
Jun 21 18:34:04 kangur [<b0144342>] pagevec_lookup+0x22/0x30
Jun 21 18:34:04 kangur [<b0173342>] iput+0x62/0x70
Jun 21 18:34:04 kangur [<b017c343>] write_inode_now+0x73/0xe0
Jun 21 18:34:04 kangur [<d11eb764>] __ntfs_clear_inode+0x54/0x160 [ntfs]
Jun 21 18:34:04 kangur [<d11eb909>] ntfs_clear_big_inode+0x59/0xc0 [ntfs]
Jun 21 18:34:04 kangur [<b0187b00>] dquot_drop+0x0/0x70
Jun 21 18:34:04 kangur [<b01720ae>] clear_inode+0xae/0x130
Jun 21 18:34:04 kangur [<b01447f7>] truncate_inode_pages+0x17/0x20
Jun 21 18:34:04 kangur [<b0103c23>] error_code+0x4f/0x54
Jun 21 18:34:04 kangur [<b0173342>] iput+0x62/0x70
Jun 21 18:34:04 kangur [<b017feff>] inotify_unmount_inodes+0xcf/0x110
Jun 21 18:34:04 kangur [<b01722ea>] invalidate_inodes+0x3a/0x80
Jun 21 18:34:04 kangur [<b015e3b3>] generic_shutdown_super+0x63/0x160
Jun 21 18:34:04 kangur [<b015efa5>] kill_block_super+0x25/0x40
Jun 21 18:34:04 kangur [<b015e240>] deactivate_super+0x50/0x80
Jun 21 18:34:04 kangur [<b0175515>] sys_umount+0x35/0x80
Jun 21 18:34:04 kangur [<b014c708>] do_munmap+0xe8/0x150
Jun 21 18:34:04 kangur [<b0175577>] sys_oldumount+0x17/0x20
Jun 21 18:34:04 kangur [<b01030cb>] sysenter_past_esp+0x54/0x75

I know that the kernel was tainted but I am afraid that this can be easily 
reproduced with any 2.6.12 like kernel + inotify after mounting and using 
NTFS for a while (maybe even mounting and reading of single file 
and then trying to umount suffices). This breaks the box pretty bad and I 
needed to reboot with SysRq because init could not.

This was with kernel:

kangur ~ # uname -a
Linux kangur 2.6.12-rc6-ck2-gk1 #1 Mon Jun 6 21:07:12 CEST 2005 i686 
Unknown CPU Type AuthenticAMD GNU/Linux

probably with this:

0aa3dfb1940a12a4245ec87b4246db85b55abe40  inotify-0.23-rml-2.6.12-rc4-8.patch

inoftify patch.

Are you aware of this bug (or maybe you already fixed it)?


Thanks,

Grzegorz Kulewski
