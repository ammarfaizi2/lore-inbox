Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWH2Q0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWH2Q0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWH2Q0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:26:09 -0400
Received: from natblert.rzone.de ([81.169.145.181]:63435 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S964999AbWH2Q0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:26:07 -0400
Date: Tue, 29 Aug 2006 18:26:06 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org
Subject: oops in aty128_bl_set_power in 2.6.18-rc5
Message-ID: <20060829162606.GA26378@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This oops happes on a G4/466 when X blanks the screen.

date:~ # lsmod
Module                  Size  Used by
snd_pcm_oss            61568  0 
snd_mixer_oss          21376  1 snd_pcm_oss
snd_seq                68160  0 
snd_seq_device         10028  1 snd_seq
r128                   44740  2 
drm                    79992  3 r128
ipv6                  291340  16 
loop                   19912  0 
dm_mod                 65424  0 
ehci_hcd               35752  0 
8139too                28032  0 
sungem                 34564  0 
sungem_phy             10368  1 sungem
uninorth_agp           10728  1 
mii                     6560  1 8139too
uhci_hcd               32460  0 
agpgart                36892  2 drm,uninorth_agp
ohci1394               39952  0 
snd_aoa_i2sbus         23876  0 
ieee1394              114352  1 ohci1394
snd_aoa_soundbus        7780  1 snd_aoa_i2sbus
ide_floppy             21728  0 
ide_cd                 47332  0 
cdrom                  43388  1 ide_cd
snd_powermac           50748  1 
snd_pcm                99332  3 snd_pcm_oss,snd_aoa_i2sbus,snd_powermac
snd_timer              28292  2 snd_seq,snd_pcm
snd                    73268  10 snd_pcm_oss,snd_mixer_oss,snd_seq,snd_seq_device,snd_aoa_i2sbus,snd_powermac,snd_pcm,snd_timer
soundcore              10980  1 snd
snd_page_alloc         11496  1 snd_pcm

...
Total memory = 256MB; using 512kB for hash table (at cff80000)
Linux version 2.6.18-rc5-default-mainline (olaf@pomegranate) (gcc version 4.1.0 (SUSE Linux)) #3 Tue Aug 29 16:41:44 CEST 2006
Found initrd at 0xc4100000:0xc4330000
Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x11
Mapped at 0xfdfc0000
Found a Keylargo mac-io controller, rev: 3, mapped at 0xfdf40000
Processor NAP mode on idle enabled.
PowerMac motherboard: PowerMac G4 Silver
...
PCI: Enabling device 0000:00:10.0 (0086 -> 0087)
aty128fb: Invalid ROM signature 1111 should  be 0xaa55
aty128fb: BIOS not located, guessing timings.
aty128fb: Rage128 PF PRO AGP [chip rev 0x1] 16M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 128x48
fb0: ATY Rage128 frame buffer device on Rage128 PF PRO AGP
...
eth1: Link is up at 100 Mbps, full-duplex.
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
loop: loaded (max 8 devices)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link down
eth1: Link is up at 100 Mbps, full-duplex.
eth1: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth0: link is not ready
IPv6 over IPv4 tunneling driver
[drm] Initialized drm 1.0.1 20051102
[drm] Initialized r128 2.5.0 20030725 on minor 0
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 1x mode
audit(1156867816.177:2): audit_pid=3980 old=0 by auid=4294967295
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc01a62e8
Oops: Kernel access of bad area, sig: 11 [#1]

Modules linked in: snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device r128 drm ipv6 loop dm_mod ehci_hcd 8139too sungem sungem_phy uninorth_agp mii uhci_hcd agpgart ohci1394 snd_aoa_i2sbus ieee1394 snd_aoa_soundbus ide_floppy ide_cd cdrom snd_powermac snd_pcm snd_timer snd soundcore snd_page_alloc
NIP: C01A62E8 LR: C01A62E4 CTR: C01A6544
REGS: cdf95cc0 TRAP: 0300   Not tainted  (2.6.18-rc5-default-mainline)
MSR: 00009032 <EE,ME,IR,DR>  CR: 28002422  XER: 20000000
DAR: 00000000, DSISR: 40000000
TASK = ced218f0[3081] 'X' THREAD: cdf94000
GPR00: C01A62E4 CDF95D70 CED218F0 00000000 00000004 00004611 00000002 10220000
GPR08: 00004611 CDF94000 FFFFFFE7 00000000 00000000 10228A14 10220000 10220F0C
GPR16: 7FCDE570 10220F0C 10220000 10220000 7FCDE318 7FCDE570 10230000 00000000
GPR24: 10220000 101F0000 10220000 00000007 FFFFFFED C42F0000 C42F0214 00000004
NIP [C01A62E8] aty128_bl_set_power+0x28/0x9c
LR [C01A62E4] aty128_bl_set_power+0x24/0x9c
Call Trace:
[CDF95D70] [C01A62E4] aty128_bl_set_power+0x24/0x9c (unreliable)
[CDF95D90] [C01A65A8] aty128fb_blank+0x64/0x120
[CDF95DB0] [C01706DC] fb_blank+0x4c/0x84
[CDF95DE0] [C01716C0] fb_ioctl+0x4e4/0x5c4
[CDF95ED0] [C00977A0] do_ioctl+0x6c/0x84
[CDF95EE0] [C0097B38] vfs_ioctl+0x380/0x3b4
[CDF95F10] [C0097BD4] sys_ioctl+0x68/0x98
[CDF95F40] [C0012480] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0xfd75f48
    LR = 0xfd75ee0
Instruction dump:
7c0803a6 4e800020 9421ffe0 7c0802a6 bfa10014 3bc30214 7c7d1b78 7fc3f378
90010024 7c9f2378 48125df1 807d0220 <7c001828> 30000001 7c00192d 40a2fff4

