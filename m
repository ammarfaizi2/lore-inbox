Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbUAJQ6g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 11:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUAJQ6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 11:58:36 -0500
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:55168 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265251AbUAJQ6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 11:58:33 -0500
Date: Sat, 10 Jan 2004 17:59:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: 2.6.1 sound oops
Message-ID: <20040110165754.GB367@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I got following when trying to play video on 2.6.1... I remmber
similar oops in past. Any ideas?

Jan 10 17:50:37 amd kernel: Unable to handle kernel paging request at virtual address d1917000
Jan 10 17:50:37 amd kernel:  printing eip:
Jan 10 17:50:37 amd kernel: c03497ff
Jan 10 17:50:37 amd kernel: *pde = 0fdf1067
Jan 10 17:50:37 amd kernel: *pte = 00000000
Jan 10 17:50:37 amd kernel: Oops: 0000 [#1]
Jan 10 17:50:37 amd kernel: CPU:    0
Jan 10 17:50:37 amd kernel: EIP:    0060:[<c03497ff>]    Not tainted
Jan 10 17:50:37 amd kernel: EFLAGS: 00210202
Jan 10 17:50:37 amd kernel: EIP is at resample_expand+0x2ff/0x340
Jan 10 17:50:37 amd kernel: eax: c03497ff   ebx: 00000000   ecx: d1919166   edx: 00000000
Jan 10 17:50:37 amd kernel: esi: c6a0cef0   edi: c6a0cf10   ebp: d1916ffe   esp: c3497e74
Jan 10 17:50:37 amd kernel: ds: 007b   es: 007b   ss: 0068
Jan 10 17:50:37 amd kernel: Process vlc (pid: 1024, threadinfo=c3496000 task=c477ccc0)
Jan 10 17:50:37 amd kernel: Stack: c3490000 00000002 c54c2c00 ffffffff c0349771 c03497ff 00000000 00000004
Jan 10 17:50:37 amd kernel:        00000004 00000001 00000000 000003ee 0000045a 00000400 c6a0ce80 cf9822c0
Jan 10 17:50:37 amd kernel:        c0349d00 c6a0ce80 cf9824c0 cf9822c0 00000400 0000045a c6a0ce80 cf9824c0
Jan 10 17:50:37 amd kernel: Call Trace:
Jan 10 17:50:37 amd kernel:  [<c0349771>] resample_expand+0x271/0x340
Jan 10 17:50:37 amd kernel:  [<c03497ff>] resample_expand+0x2ff/0x340
Jan 10 17:50:37 amd kernel:  [<c0349d00>] rate_transfer+0x40/0x50
Jan 10 17:50:37 amd kernel:  [<c0347151>] snd_pcm_plug_write_transfer+0x81/0xf0
Jan 10 17:50:37 amd kernel:  [<c0342e67>] snd_pcm_oss_write2+0xc7/0x130
Jan 10 17:50:37 amd kernel:  [<c03430b8>] snd_pcm_oss_write1+0x1e8/0x220
Jan 10 17:50:37 amd kernel:  [<c0345217>] snd_pcm_oss_write+0x37/0x70
Jan 10 17:50:37 amd kernel:  [<c014edbc>] vfs_write+0x9c/0x100
Jan 10 17:50:37 amd kernel:  [<c014ee9d>] sys_write+0x2d/0x50
Jan 10 17:50:37 amd kernel:  [<c0109047>] syscall_call+0x7/0xb
Jan 10 17:50:37 amd kernel:
Jan 10 17:50:37 amd kernel: Code: 8b 45 00 e9 76 fe ff ff 8a 45 00 83 f0 80 89 c2 c1 e2 08 eb

pavel@amd:~$ lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3188 (rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b188
00:0a.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
00:0c.0 Network controller: Broadcom Corporation BCM94306 802.11g (rev 02)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 50)
00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 80)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
00:13.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 02)


						Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
