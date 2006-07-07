Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWGGDv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWGGDv3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 23:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWGGDv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 23:51:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:59912 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751174AbWGGDv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 23:51:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=udyJ1jSoSsbfqHR6sIzRG726tZo4EhH0Ov2/K9vGaRaX2d5gEqp2QSKKGDNV6TpgFpJbcg65z8K7Npe+rh1QpEfbTPjKSf6+QJp5JESstgjHbI2gl+M41g0tPQ30gJam2yhVcZ/sIwttSBRmPwDuRyjmZhewB4ykLv9ZDy+xzdo=
Message-ID: <dda83e780607062051x220841c7ya88ff0aefd5d3071@mail.gmail.com>
Date: Thu, 6 Jul 2006 20:51:27 -0700
From: "Bret Towe" <magnade@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.18-rc1 bttv modprobe null pointer dereference
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when upgrading to 2.6.18-rc1 i got the below error
when doing modprobe bttv card=78
tho the card option didnt seem to matter much
i did see a email on the list on what looked to me the same issue
but was for a -mm kernel only 3 message in the thread i have
and no follow up was done from what i see


bttv0: registered device video0
Unable to handle kernel NULL pointer dereference at 0000000000000149 RIP:
 [<ffffffff802f1f9b>] sysfs_add_file+0x2b/0xb0
PGD 27755067 PUD 27754067 PMD 0
Oops: 0000 [1] PREEMPT
CPU 0
Modules linked in: bttv video_buf firmware_class ir_common
compat_ioctl32 i2c_algo_bit btcx_risc tveeprom videodev v4l2_common
radeon drm snd_seq_midi snd_emu10k1_synth snd_emux_synth
snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss snd_mixer_oss
snd_seq_oss snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi
snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd vfat fat w83627hf hwmon_vid
i2c_isa i2c_core r8169 dm_snapshot dm_mirror dm_mod sbp2 ohci1394
ieee1394 usb_storage
Pid: 9330, comm: modprobe Tainted: G   M  2.6.18-rc1 #1
RIP: 0010:[<ffffffff802f1f9b>]  [<ffffffff802f1f9b>] sysfs_add_file+0x2b/0xb0
RSP: 0018:ffff81002ac71c28  EFLAGS: 00010286
RAX: 00000000ffffff00 RBX: ffffffff88207460 RCX: 00000000ffffffff
RDX: 0000000000000004 RSI: ffffffff881fd6c0 RDI: 0000000000000001
RBP: ffff81002ac71c58 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff80218b42 R11: 0000000000000000 R12: ffffffff881fd6c0
R13: 0000000000000001 R14: 00000000ffffffef R15: 0000000000000000
FS:  00002b58f0e16d50(0000) GS:ffffffff809f2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000149 CR3: 0000000027740000 CR4: 00000000000006e0
Process modprobe (pid: 9330, threadinfo ffff81002ac70000, task ffff8100284ea040)
Stack:  000000042ac71c38 ffffffff88207460 0000000000000000 ffff81003ff5f000
 ffffffff88208160 0000000000000000 ffff81002ac71c68 ffffffff802f205e
 ffff81002ac71c78 ffffffff8040c307 ffff81002ac71cb8 ffffffff881e6b9d
Call Trace:
 [<ffffffff802f205e>] sysfs_create_file+0x3e/0x40
 [<ffffffff8040c307>] class_device_create_file+0x17/0x20
 [<ffffffff881e6b9d>] :bttv:bttv_probe+0x64d/0x840
 [<ffffffff8039f4cd>] pci_device_probe+0x5d/0xa0
 [<ffffffff8040b327>] driver_probe_device+0x67/0xe0
 [<ffffffff8040b4cd>] __driver_attach+0x8d/0xf0
 [<ffffffff8040abdf>] bus_for_each_dev+0x4f/0x80
 [<ffffffff8040b22c>] driver_attach+0x1c/0x20
 [<ffffffff8040a75e>] bus_add_driver+0x8e/0x160
 [<ffffffff8040b80d>] driver_register+0xcd/0xe0
 [<ffffffff8039f713>] __pci_register_driver+0x63/0x90
 [<ffffffff881e3414>] :bttv:bttv_init_module+0xb4/0xc0
 [<ffffffff802ad7ab>] sys_init_module+0x155b/0x1760
 [<ffffffff80267b92>] system_call+0x7e/0x83
 [<00002b58f0ca66cc>]

Code: 4c 8b bf 48 01 00 00 48 8b bf c0 00 00 00 8b 5e 10 48 81 c7
RIP  [<ffffffff802f1f9b>] sysfs_add_file+0x2b/0xb0
 RSP <ffff81002ac71c28>
CR2: 0000000000000149
