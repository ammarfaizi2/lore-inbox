Return-Path: <linux-kernel-owner+w=401wt.eu-S1754187AbWLRP41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbWLRP41 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189AbWLRP41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:56:27 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35555 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754187AbWLRP40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:56:26 -0500
Date: Mon, 18 Dec 2006 16:53:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>
Subject: bug: kobject_add failed for audio with -EEXIST
Message-ID: <20061218155349.GA21282@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


an allyesconfig bootup generates the driver core warning below, in 
alsa_card_dummy_init().

	Ingo

------------------>
Calling initcall 0xc1ee1d35: alsa_card_dummy_init+0x0/0x8a()
PM: Adding info for platform:snd_dummy.0
kobject_add failed for audio with -EEXIST, don't try to register things with the same name in the same directory.
 [<c0106273>] show_trace_log_lvl+0x34/0x4a
 [<c01063a9>] show_trace+0x2c/0x2e
 [<c01063d6>] dump_stack+0x2b/0x2d
 [<c04f06a3>] kobject_add+0x15f/0x187
 [<c06e3421>] class_device_add+0xb5/0x45c
 [<c06e37e5>] class_device_register+0x1d/0x21
 [<c06e3892>] class_device_create+0xa9/0xcc
 [<c0ff98d0>] sound_insert_unit+0x13c/0x154
 [<c0ff9a7b>] register_sound_special_device+0x11b/0x123
 [<c104bcee>] snd_register_oss_device+0x12c/0x18e
 [<c1060e01>] register_oss_dsp+0x61/0x9a
 [<c1060e78>] snd_pcm_oss_register_minor+0x3e/0x174
 [<c1051043>] snd_pcm_dev_register+0x1d4/0x1fa
 [<c104b705>] snd_device_register_all+0x61/0x87
 [<c1046d6d>] snd_card_register+0x52/0x2e5
 [<c1ee200d>] snd_dummy_probe+0x24e/0x260
 [<c06e4026>] platform_drv_probe+0x1b/0x1d
 [<c06e229c>] really_probe+0x42/0xee
 [<c06e253f>] driver_probe_device+0xa6/0xb2
 [<c06e25d2>] __device_attach+0x1c/0x1e
 [<c06e171b>] bus_for_each_drv+0x55/0x86
 [<c06e23a2>] device_attach+0x5a/0x6c
 [<c06e17b9>] bus_attach_device+0x2a/0x57
 [<c06e0a4f>] device_add+0x388/0x4de
 [<c06e3ef7>] platform_device_add+0x10a/0x13d
 [<c06e43c4>] platform_device_register_simple+0x53/0x6f
 [<c1ee1d80>] alsa_card_dummy_init+0x4b/0x8a
 [<c0100567>] init+0x178/0x451
 [<c0105feb>] kernel_thread_helper+0x7/0x10
 =======================
Calling initcall 0xc1ee201f: alsa_card_virmidi_init+0x0/0x8a()
PM: Adding info for platform:snd_virmidi.0
