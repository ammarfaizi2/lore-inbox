Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266191AbUGTUhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266191AbUGTUhx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUGTUhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 16:37:53 -0400
Received: from cirrus.purplecloud.com ([217.158.94.220]:30219 "EHLO
	cirrus.purplecloud.com") by vger.kernel.org with ESMTP
	id S266191AbUGTUhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 16:37:24 -0400
Message-ID: <1090355841.40fd828136bd2@webmail.lichp.co.uk>
Date: Tue, 20 Jul 2004 21:37:21 +0100
From: phil.stewart@lichp.co.uk
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.sourceforge.net, phil.stewart@lichp.co.uk
Subject: dri ioctl32 problem on amd64/x86_64 on 2.6.8-rc2 and earlier
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 81.5.147.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a working direct rendering mechanism in my 64-bit userland. However,
32-bit software running in a 32-bit chroot environment cannot operate with the
64-bit drm. I get the following error when executing the 32-bit glxinfo inside
the chroot:

# /usr/X11R6/bin/glxinfo
name of display: :0.0
libGL error: failed to open DRM: Operation not permitted
libGL error: reverting to (slow) indirect rendering
display: :0  screen: 0
direct rendering: No

This generates the following entry in kernel messages:

Jul 20 21:18:46 gordon ioctl32(glxinfo:12562): Unknown cmd fd(4)
cmd(c0086401){00} arg(bffff0f0) on /dev/dri/card0

Similarly for the 32-bit glxgears:

Jul 20 21:21:21 gordon ioctl32(glxgears:12567): Unknown cmd fd(4)
cmd(c0086401){00} arg(bfffeff0) on /dev/dri/card0

Kernels versions tested (all consistently produce the same error):
2.6.8-rc2
2.6.7-mm6
2.6.7-gentoo-r11

System hardware:
1x AMD Opteron 242
AMD 8151/8111 chipset
Radeon RV100 graphics card

Output of lspci -v regarding graphics card:
0000:02:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY
[Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: PC Partner Limited RV100 QY [Sapphire Radeon VE 7000]
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ 16
        Memory at e0000000 (32-bit, prefetchable) [size=ff5c0000]
        I/O ports at b800 [size=256]
        Memory at ff5f0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

Output of scripts/ver_linux:
Linux gordon 2.6.8-rc2 #1 Tue Jul 20 20:37:41 BST 2004 x86_64 5  GNU/Linux
  
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.1.1
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         radeon eth1394 snd_seq_midi snd_seq_midi_event snd_seq
ohci1394 ieee1394 snd_pcm_oss snd_mixer_oss snd_cs46xx snd_rawmidi
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc budget
budget_core dvb_core saa7146 ttpci_eeprom e1000

Please keep me CC'd in if more information is required.

--
Phil Stewart


