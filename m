Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUGNBIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUGNBIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 21:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267280AbUGNBIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 21:08:50 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:24991 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267278AbUGNBIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 21:08:44 -0400
Subject: ALSA errors when renicing unrelated process
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1089767321.2729.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 21:08:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found that I can reliably produce the following errors by
renicing the X server from -10 (the default on Debian) to 0 and back.  I
get the same error going from 0 to -10 as -10 back to 0, as if renicing
the process causes some kind of hiccup in the scheduler.  I do not seem
to get XRUNs when this happens.

Jul 13 21:02:13 mindpipe kernel:
Jul 13 21:02:13 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 0, delta: -31, max jitter = 32): wrong interrupt acknowledge?
Jul 13 21:02:13 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 21:02:13 mindpipe kernel:  [__crc_totalram_pages+46349/3558647] snd_pcm_period_elapsed+0x1a7/0x400 [snd_pcm]
Jul 13 21:02:13 mindpipe kernel:  [__crc_totalram_pages+115629/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 21:02:13 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 21:02:13 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 21:02:13 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 21:02:13 mindpipe kernel:  [do_anonymous_page+124/384] do_anonymous_page+0x7c/0x180
Jul 13 21:02:13 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
Jul 13 21:02:13 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
Jul 13 21:02:13 mindpipe kernel:  [do_page_fault+805/1356] do_page_fault+0x325/0x54c
Jul 13 21:02:13 mindpipe kernel:  [error_code+45/64] error_code+0x2d/0x40
Jul 13 21:02:13 mindpipe kernel:
Jul 13 21:02:13 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 0, delta: -31, max jitter = 32): wrong interrupt acknowledge?
Jul 13 21:02:13 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 13 21:02:13 mindpipe kernel:  [__crc_totalram_pages+46349/3558647] snd_pcm_period_elapsed+0x1a7/0x400 [snd_pcm]
Jul 13 21:02:13 mindpipe kernel:  [__crc_totalram_pages+115629/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
Jul 13 21:02:13 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 13 21:02:13 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 13 21:02:13 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 21:02:13 mindpipe kernel:  [do_anonymous_page+124/384] do_anonymous_page+0x7c/0x180
Jul 13 21:02:13 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
Jul 13 21:02:13 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
Jul 13 21:02:13 mindpipe kernel:  [do_page_fault+805/1356] do_page_fault+0x325/0x54c
Jul 13 21:02:13 mindpipe kernel:  [error_code+45/64] error_code+0x2d/0x40
Jul 13 21:02:13 mindpipe kernel:

Lee



