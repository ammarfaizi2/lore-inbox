Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTKLSBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 13:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbTKLSBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 13:01:21 -0500
Received: from devil.servak.biz ([209.124.81.2]:12185 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S263868AbTKLSBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 13:01:20 -0500
Subject: ALSA crash in 2.6.0-test9-mm2
From: Torrey Hoffman <thoffman@arnor.net>
To: perex@perex.cz, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1068659915.1446.16.camel@moria.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 12 Nov 2003 09:58:35 -0800
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a crash and system hang in my system initialization scripts.

My startup scripts essentially do (this is the short version):
	modprobe snd
	modprobe sound-slot-0
	modprobe sound-slot-1
	/usr/sbin/alsactl restore >/dev/null 2>&1

I'm not sure if the hang was in one of the modprobes or 
when alsactl was run.   /etc/modprobe.conf contains:
	alias sound-slot-0 snd-intel8x0
	alias sound-slot-1 snd-ice1712

Nov 12 09:15:22 moria kernel: intel8x0_measure_ac97_clock: measured 49593 usecs
Nov 12 09:15:22 moria kernel: intel8x0: clocking to 48000
Nov 12 09:15:22 moria kernel: Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
Nov 12 09:15:22 moria kernel: in_atomic():1, irqs_disabled():0
Nov 12 09:15:22 moria kernel: Call Trace:
Nov 12 09:15:22 moria kernel:  [<c012405c>] __might_sleep+0xab/0xc9
Nov 12 09:15:22 moria kernel:  [<fcc637bd>] ap_cs8427_sendbytes+0x38/0xd2 [snd_ice1712]
Nov 12 09:15:22 moria kernel:  [<fcc1329b>] snd_i2c_sendbytes+0x22/0x26 [snd_i2c]
Nov 12 09:15:22 moria kernel:  [<fcc1a15e>] snd_cs8427_reg_read+0x2c/0x8c [snd_cs8427]
Nov 12 09:15:22 moria kernel:  [<fcc1a414>] snd_cs8427_create+0xa4/0x347 [snd_cs8427]
Nov 12 09:15:22 moria kernel:  [<c02e6e5c>] snd_device_new+0x20/0x6a
Nov 12 09:15:22 moria kernel:  [<fcc5f51a>] snd_ice1712_init_cs8427+0x2f/0x6f [snd_ice1712]
Nov 12 09:15:22 moria kernel:  [<fcc64153>] snd_ice1712_delta_init+0x230/0x2b9 [snd_ice1712]
Nov 12 09:15:22 moria kernel:  [<fcc63227>] snd_ice1712_probe+0x323/0x34c [snd_ice1712]
Nov 12 09:15:22 moria kernel:  [<c0178a5b>] dput+0x24/0x2b5
Nov 12 09:15:22 moria kernel:  [<c0215dcf>] pci_device_probe_static+0x4d/0x5e
Nov 12 09:15:22 moria kernel:  [<c0215e18>] __pci_device_probe+0x38/0x4b
Nov 12 09:15:22 moria kernel:  [<c0215e57>] pci_device_probe+0x2c/0x48
Nov 12 09:15:22 moria kernel:  [<c027c725>] bus_match+0x3d/0x65
Nov 12 09:15:22 moria kernel:  [<c027c83e>] driver_attach+0x59/0x83
Nov 12 09:15:22 moria kernel:  [<c027cb07>] bus_add_driver+0x9e/0xb1
Nov 12 09:15:22 moria kernel:  [<c021601e>] pci_register_driver+0x6b/0x90
Nov 12 09:15:22 moria kernel:  [<fcbda015>] alsa_card_ice1712_init+0x15/0x4e [snd_ice1712]
Nov 12 09:15:22 moria kernel:  [<c013ead0>] sys_init_module+0x14f/0x233
Nov 12 09:15:22 moria kernel:  [<c034769a>] sysenter_past_esp+0x43/0x65

-- 
Torrey Hoffman <thoffman@arnor.net>

