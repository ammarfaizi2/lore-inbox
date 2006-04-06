Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWDFNUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWDFNUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 09:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWDFNUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 09:20:44 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:64636 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751249AbWDFNUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 09:20:44 -0400
Date: Thu, 6 Apr 2006 15:20:42 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Subject: [BUG ALSA 2.6.17-rc1] Oops when Gaim tries to play sound
Message-ID: <20060406132042.GF20402@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this Oops when Gaim (instant messages) tried to play a sound:

BUG: unable to handle kernel NULL pointer dereference at virtual address 00000098
 printing eip:
e0a37dea
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: arc4 ieee80211_crypt_wep bcm43xx ieee80211softmac ieee80211 ieee80211_crypt lp binfmt_misc autofs4 ipv6 ide_cd cdrom 8250_pnp floppy eth1394 8139too mii ohci1394 ieee1394 snd_via82xx_modem snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore via686a i2c_isa i2c_core usbhid uhci_hcd usbcore parport_pc parport tun cpufreq_conservative cpufreq_ondemand powernow_k7 freq_table 8250 serial_core psmouse pcspkr r128 drm via_agp agpgart
CPU:    0
EIP:    0060:[<e0a37dea>]    Not tainted VLI
EFLAGS: 00210046   (2.6.17-rc1-dirty #2) 
EIP is at snd_pcm_drain+0x248/0x2cb [snd_pcm]
eax: 00000000   ebx: dfb025c8   ecx: 00000000   edx: c1750ca0
esi: 00000000   edi: cd1c3c00   ebp: e0a49b00   esp: c3d64e80
ds: 007b   es: 007b   ss: 0068
Process gaim (pid: 8111, threadinfo=c3d64000 task=c2112af0)
Stack: <0>c3d64e90 00000001 00000000 dfb02400 c1750ca0 00000000 c2112af0 c01138fa 
       cd1c3ca4 cd1c3ca4 00008000 e0b9b000 00004144 00000000 00000010 c3d64f44 
       e0a39699 c1750ca0 00004144 00000000 00200246 00000000 cd1c3c00 e0a4d58d 
Call Trace:
 <c01138fa> default_wake_function+0x0/0x12   <e0a39699> snd_pcm_playback_ioctl1+0x1f6/0x205 [snd_pcm]
 <e0a4d58d> snd_pcm_oss_sync1+0xcf/0xd9 [snd_pcm_oss]   <c01138fa> default_wake_function+0x0/0x12
 <e0a3992e> snd_pcm_kernel_ioctl+0x33/0x58 [snd_pcm]   <e0a4d783> snd_pcm_oss_sync+0x1ec/0x25d [snd_pcm_oss]
 <e0a4e5f0> snd_pcm_oss_release+0x1c/0x83 [snd_pcm_oss]   <c01458d7> __fput+0x95/0x126
 <c01445cf> filp_close+0x4c/0x55   <c014461e> sys_close+0x46/0x52
 <c0102a07> syscall_call+0x7/0xb  
Code: c3 c8 01 00 00 89 d8 e8 f9 14 81 df b8 c4 09 00 00 e8 8c 12 81 df 89 c6 89 d8 e8 d5 14 81 df fa 85 f6 75 87 8b 54 24 44 8b 42 5c <8b> 80 98 00 00 00 8b 00 c7 44 24 08 aa ff ff ff 83 f8 07 74 12 
 BUG: gaim/8111, lock held at task exit time!
 [dfb025c8] {snd_card_new}
.. held by:              gaim: 8111 [c2112af0, 115]
... acquired at:               snd_pcm_drain+0x23c/0x2cb [snd_pcm]

Kernel version: Linux version 2.6.17-rc1-dirty (root@arthur) (gcc
version 3.3.5 (Debian 1:3.3.5-13)) #2 Mon Apr 3 16:18:21 CEST 2006

This used to work with 2.6.16. CPU is a Mobile Athlon 1.2 GHz on a Sony
Vaio PCG-FX505 laptop. Alsa userland utils from Debian alsa 1.0.8
packages, but I guess Gaim uses /dev/dsp and friends.

Output from lspci:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a)
0000:00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a)
0000:00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] rev 40)
0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 audio Controller (rev 50)
0000:00:07.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller (rev 30)
0000:00:0a.0 CardBus bridge: Texas Instruments PCI1420
0000:00:0a.1 CardBus bridge: Texas Instruments PCI1420
0000:00:0e.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)
0000:00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64)
0000:02:00.0 Network controller: Broadcom Corporation BCM4318 [AirForce One 54g]802.11g Wireless LAN Controller (rev 02)

Could be a locking error or an ALSA error, so message posted to lkml
and alsa-devel lists. Feel free to ask for more information.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
