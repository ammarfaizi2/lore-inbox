Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVKCKpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVKCKpo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 05:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVKCKpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 05:45:44 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:35286 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S964842AbVKCKpo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 05:45:44 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: mchehab@brturbo.com.br
Subject: 2.6.14: Oops in bttv_irq_wakeup_video
Date: Thu, 3 Nov 2005 11:45:40 +0100
User-Agent: KMail/1.8.3
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511031145.41163.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux version 2.6.14 (root@baldrick) (gcc version 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)) #1 Sun Oct 30 12:30:39 CET 2005
x86

Got this the moment I launched xawtv (using "grabdisplay").  The card is
a cheap and nasty wintv:

0000:00:08.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Flags: bus master, medium devsel, latency 32, IRQ 20
        Memory at dfbfe000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>

on a VIA chipset:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Flags: bus master, 66MHz, medium devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: <available only to root>

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: dfc00000-dfcfffff
        Prefetchable memory behind bridge: bfb00000-dfafffff
        Capabilities: <available only to root>

I don't use overlay, since it always eventually manages to freeze the machine.
Oops captured via serial console:

[17179710.648000] bttv0: OCERR @ 1d36b01c,bits: HSYNC OFLOW RISCI* OCERR*
[17179710.672000] bttv0: OCERR @ 1d36b01c,bits: HSYNC OFLOW OCERR*
[17179710.708000] bttv0: OCERR @ 1d36b01c,bits: HSYNC OFLOW OCERR*
[17179710.748000] bttv0: OCERR @ 1d36b01c,bits: HSYNC OFLOW OCERR*
[17179710.808000] bttv0: OCERR @ 1d36b01c,bits: HSYNC OFLOW OCERR*
[17179710.848000] bttv0: OCERR @ 1d36b01c,bits: HSYNC OFLOW OCERR*
[17179710.888000] bttv0: OCERR @ 1d36b01c,bits: HSYNC OFLOW OCERR*
[17179710.928000] bttv0: OCERR @ 1d36b01c,bits: HSYNC OFLOW OCERR*
[17179710.968000] bttv0: OCERR @ 1d36b01c,bits: HSYNC OFLOW OCERR*
[17179711.008000] bttv0: OCERR @ 1d36b01c,bits: HSYNC OFLOW OCERR*
[17179711.048000] bttv0: OCERR @ 1d36b01c,bits: HSYNC OFLOW OCERR*
[17179711.088000] bttv0: timeout: drop=0 irq=147/147, risc=1d36b03c, <6>bttv0: OCERR @ 1d36b01c,bits: VSYNC* HSYNC OFLOW FBUS OCERR*
[17179711.124000] bits:<6>bttv0: OCERR @ 1d36b01c,bits: VSYNC* HSYNC OFLOW FBUS OCERR*
[17179711.148000]  OFLOW
[17179711.156000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[17179711.156000]  printing eip:
[17179711.156000] 00000000
[17179711.156000] *pde = 00000000
[17179711.156000] Oops: 0000 [#1]
[17179711.156000] Modules linked in: rfcomm l2cap bluetooth cpufreq_stats cpufreq_powersave cpufreq_ondemand cpufreq_userspace freq_table cpufreq_conservative usblp radeon drm tun video battery container button ac ipv6 ipt_TOS ipt_MASQUERADE ipt_REJECT ipt_LOG ipt_state ipt_pkttype ipt_owner ipt_iprange ipt_physdev ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp iptable_nat ip_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables floppy pcspkr rtc cdc_ether usbnet snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_via82xx snd_mpu401_uart i2c_viapro via_ircc irda crc_ccitt snd_bt87x bt878 tuner tvaudio bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc tveeprom i2c_core videodev snd_cs46xx gameport snd_rawmidi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc shpchp pci_hotplug via_agp agpgart nls_cp437 ntfs reiserfs dm_mod tsdev parport_pc lp parport mousedev psmouse md_mod ext3 jbd mbcache thermal processor fan ehci_hcd uhci_hcd usbcore 8139too 8139cp mii ide_cd cdrom ide_disk ide_generic via82cxxx generic ide_core unix vga16fb vgastate softcursor cfbimgblt cfbfillrect cfbcopyarea fbcon tileblit font bitblit
[17179711.156000] CPU:    0
[17179711.156000] EIP:    0060:[<00000000>]    Not tainted VLI
[17179711.156000] EFLAGS: 00010017   (2.6.14)
[17179711.156000] EIP is at rest_init+0x3feffde0/0x30
[17179711.156000] eax: 0804cff4   ebx: ffffffff   ecx: 00000001   edx: 00000003
[17179711.156000] esi: 00000000   edi: 00000001   ebp: d86ebed0   esp: d86ebeb0
[17179711.156000] ds: 007b   es: 007b   ss: 0068
[17179711.156000] Process modprobe (pid: 10883, threadinfo=d86ea000 task=d86530b0)
[17179711.156000] Stack: c0118263 0804cff4 00000003 00000000 00000000 00000000 00000096 d86ebf3c
[17179711.156000]        d86ebef4 c01182be dc2d6cec 00000003 00000001 00000000 00000000 00000000
[17179711.156000]        d86ebf4c e0cb29e0 e0c977c4 00000000 e0cb29e0 e0c9e080 4369e7d9 00069a62
[17179711.156000] Call Trace:
[17179711.156000]  [<c0118263>] __wake_up_common+0x43/0x70
[17179711.156000]  [<c01182be>] __wake_up+0x2e/0x40
[17179711.156000]  [<e0c977c4>] bttv_irq_wakeup_video+0x114/0x180 [bttv]
[17179711.156000]  [<e0c9e080>] bttv_buffer_activate_vbi+0xc0/0xd0 [bttv]
[17179711.156000]  [<e0c97973>] bttv_irq_timeout+0xe3/0x220 [bttv]
[17179711.156000]  [<e0c97890>] bttv_irq_timeout+0x0/0x220 [bttv]
[17179711.156000]  [<c0124635>] run_timer_softirq+0xb5/0x190
[17179711.156000]  [<c0120473>] __do_softirq+0x43/0x90
[17179711.156000]  [<c01204e6>] do_softirq+0x26/0x30
[17179711.156000]  [<c01051fe>] do_IRQ+0x1e/0x30
[17179711.156000]  [<c0103a72>] common_interrupt+0x1a/0x20
[17179711.156000] Code:  Bad EIP value.
[17179711.156000]  <0>Kernel panic - not syncing: Fatal exception in interrupt
