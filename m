Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264193AbUDNNXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 09:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUDNNXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 09:23:52 -0400
Received: from mail.interware.hu ([195.70.32.130]:14005 "EHLO
	mail.interware.hu") by vger.kernel.org with ESMTP id S264193AbUDNNXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 09:23:44 -0400
Subject: ALSA problem with 2.6.5-mm5
From: KOVACS Krisztian <hidden@balabit.hu>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1081949017.1645.18.camel@nienna.balabit>
Mime-Version: 1.0
Date: Wed, 14 Apr 2004 15:23:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi,

  I had the following dump using 2.6.5-mm5 with ALSA:

Unable to handle kernel NULL pointer dereference at virtual address 000009d4
 printing eip:
c019bc6c
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c019bc6c>]    Not tainted VLI
EFLAGS: 00210216   (2.6.5-mm5) 
EIP is at __copy_user_zeroing_intel+0x20/0x9c
eax: fa52fa52   ebx: 00000000   ecx: 00001000   edx: fa52fa52
esi: 08297268   edi: 000009d4   ebp: debd2880   esp: d5957e74
ds: 007b   es: 007b   ss: 0068
Process alsaplayer (pid: 16862, threadinfo=d5956000 task=d1fd4e70)
Stack: 08297268 00000004 c019bdae 000009d4 08297268 00001000 00001000 08297268 
       000009d4 c019be4a 000009d4 08297268 00001000 00000020 e08a3f60 df8c1400 
       e0a33a5f 000009d4 08297268 00001000 00000400 004f2275 df8c1400 00000275 
Call Trace:
 [<c019bdae>] __copy_from_user_ll+0x5a/0x68
 [<c019be4a>] copy_from_user+0x42/0x68
 [<e0a33a5f>] snd_pcm_lib_write_transfer+0x5b/0x74 [snd_pcm]
 [<e0a33dbf>] snd_pcm_lib_write1+0x347/0x49c [snd_pcm]
 [<c0114020>] default_wake_function+0x0/0x1c
 [<e0a33fa6>] snd_pcm_lib_write+0x92/0x9c [snd_pcm]
 [<e0a33a04>] snd_pcm_lib_write_transfer+0x0/0x74 [snd_pcm]
 [<e0a2f576>] snd_pcm_playback_ioctl1+0xfe/0x374 [snd_pcm]
 [<e0a2fb2b>] snd_pcm_playback_ioctl+0x23/0x30 [snd_pcm]
 [<c01574c9>] sys_ioctl+0x209/0x260
 [<c0103c33>] syscall_call+0x7/0xb

Code: f3 a5 89 c1 f3 a4 89 c8 5e 5f c3 57 56 8b 7c 24 0c 8b 74 24 10 8b 4c 24 14 8b 46 20 83 f9 43 76 04 8b 46 40 90 8b 46 00 8b 56 04 <89> 47 00 89 57 04 8b 46 08 8b 56 0c 89 47 08 89 57 0c 8b 46 10 

  More information about my config:

nienna:~# uname -a
Linux nienna 2.6.5-mm5 #1 Wed Apr 14 10:12:18 CEST 2004 i686 unknown
nienna:~# lsmod
Module                  Size  Used by
nls_iso8859_2           5248  1 
cifs                  166764  1 
snd_intel8x0           32580  1 
snd_ac97_codec         58500  1 snd_intel8x0
snd_pcm                92672  2 snd_intel8x0
snd_timer              25088  1 snd_pcm
snd_page_alloc         11908  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         7936  1 snd_intel8x0
snd_rawmidi            23808  1 snd_mpu401_uart
nls_iso8859_1           4736  0 
isofs                  35260  0 
zlib_inflate           23040  1 isofs
ide_cd                 40320  0 
cdrom                  36768  1 ide_cd
ipv6                  238368  20 
binfmt_misc            12168  1 
snd                    53380  7 snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi
hw_random               6292  0 
intel_agp              17688  1 
dm_mod                 43168  3 
usbhid                 25344  0 
agpgart                33868  1 intel_agp
sd_mod                 19328  0 
usb_storage            30336  0 
scsi_mod               79780  2 sd_mod,usb_storage
uhci_hcd               30216  0 
ehci_hcd               26624  0 
usbcore               105684  6 usbhid,usb_storage,uhci_hcd,ehci_hcd
soundcore              10464  1 snd
8139too                24064  0 
mii                     5760  1 8139too
crc32                   4864  1 8139too
af_packet              17796  0 
rtc                    13000  0 

nienna:~# lspci -v
00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 03)
        Subsystem: Elitegroup Computer Systems: Unknown device 1862
        Flags: bus master, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [6105]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp.: Unknown device 2561 (rev 03) (prog-if
00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        Memory behind bridge: ec000000-edffffff
        Prefetchable memory behind bridge: e4000000-ebffffff

00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 02)
(prog-if 00 [UHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 1862
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 02)
(prog-if 00 [UHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 1862
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at d000 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 02)
(prog-if 00 [UHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 1862
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at d400 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 02)
(prog-if 20)
        Subsystem: Elitegroup Computer Systems: Unknown device 1862
        Flags: bus master, medium devsel, latency 0, IRQ 23
        Memory at ee100000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev
82) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: ee000000-ee0fffff

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 02)
(prog-if 8a [Master SecP PriP])
        Subsystem: Elitegroup Computer Systems: Unknown device 1862
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at f000 [size=16]
        Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 02)
        Subsystem: Elitegroup Computer Systems: Unknown device 1862
        Flags: medium devsel, IRQ 17
        I/O ports at 0500 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5
(rev 02)
        Subsystem: Elitegroup Computer Systems: Unknown device 1862
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at e000 [size=256]
        I/O ports at e400 [size=64]
        Memory at ee101000 (32-bit, non-prefetchable) [size=512]
        Memory at ee102000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device
0171 (rev a3) (prog-if 00 [VGA])
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
        Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Memory at e8000000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0

02:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 22
        I/O ports at c000 [size=256]
        Memory at ee000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

  I'm using alsaplayer 0.99.59 and alsa-utils 1.0.3. If you need more
information, or something to be tested, please let me know.

-- 
 Regards,
   Krisztian KOVACS


