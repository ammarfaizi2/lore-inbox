Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbTKYAAN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTKYAAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:00:13 -0500
Received: from devil.servak.biz ([209.124.81.2]:8350 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S261806AbTKYAAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:00:03 -0500
Subject: 2.6.-test10: bad "__might_sleep" in ALSA sound drivers
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux-Kernel List <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org
Content-Type: text/plain
Message-Id: <1069718546.2268.9.camel@moria.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 24 Nov 2003 16:02:26 -0800
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this every time I boot 2.6.0-test10.  I think this problem has
been around for a while.

Debug: sleeping function called from invalid context at
include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c01229d0>] __might_sleep+0xab/0xc9
 [<fcff57bd>] ap_cs8427_sendbytes+0x38/0xd2 [snd_ice1712]
 [<fcfa825a>] snd_i2c_sendbytes+0x22/0x26 [snd_i2c]
 [<fcfaf15e>] snd_cs8427_reg_read+0x2c/0x8c [snd_cs8427]
 [<fcfaf414>] snd_cs8427_create+0xa4/0x347 [snd_cs8427]
 [<c02dc4b0>] snd_device_new+0x20/0x6a
 [<fcff151a>] snd_ice1712_init_cs8427+0x2f/0x6f [snd_ice1712]
 [<fcff6153>] snd_ice1712_delta_init+0x230/0x2b9 [snd_ice1712]
 [<fcff5227>] snd_ice1712_probe+0x323/0x34c [snd_ice1712]
 [<c017360f>] dput+0x24/0x25f
 [<c020c833>] pci_device_probe_static+0x4d/0x5e
 [<c020c87c>] __pci_device_probe+0x38/0x4b
 [<c020c8bb>] pci_device_probe+0x2c/0x48
 [<c0272efd>] bus_match+0x3d/0x65
 [<c0273016>] driver_attach+0x59/0x83
 [<c02732df>] bus_add_driver+0x9e/0xb1
 [<c020ca82>] pci_register_driver+0x6b/0x90
 [<fcfa2015>] alsa_card_ice1712_init+0x15/0x4e [snd_ice1712]
 [<c013cbc5>] sys_init_module+0x14f/0x233
 [<c010b3e5>] sysenter_past_esp+0x52/0x71

The system is a P4 with HT, kernel has SMP & preempt enabled. 
There are two sound cards. Here are all the snd_ drivers mentioned in
the output of lsmod:

snd_ice1712            55428  -
snd_ice17xx_ak4xxx      2880  -
snd_cs8427              8224  -
snd_i2c                 4512  -
snd_ak4xxx_adda         4832  -
snd_intel8x0           28612  -
snd_ac97_codec         50660  -
snd_pcm                88352  -
snd_timer              22052  -
snd_page_alloc          8772  -
snd_mpu401_uart         6016  -
snd_rawmidi            20192  -
snd_seq_device          6440  -


-- 
Torrey Hoffman <thoffman@arnor.net>

