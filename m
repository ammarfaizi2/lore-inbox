Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUF2SQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUF2SQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 14:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265885AbUF2SQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 14:16:33 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:34281 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265890AbUF2SQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 14:16:24 -0400
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Tue, 29 Jun 2004 20:13:47 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-mm4: regression: ieee1394: sbp2: null pointer dereference
Message-ID: <20040629181347.GA5259@kiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
X-Smurf-Spam-Score: -3.8 (---)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.7-mm4 oopses when confronted with an unresponsive iee1394 disk.

-mm4:
kernel: ieee1394: sbp2: Error logging into SBP-2 device - login timed-out
kernel: sbp2: probe of 00a0b80a0000144f-0 failed with error -16
kernel: ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect timed-out
kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000013
kernel:  printing eip:
kernel: fb2c55a3
kernel: *pde = 00000000
kernel: Oops: 0002 [#1]
kernel: PREEMPT SMP
kernel: Modules linked in: saa7115 saa7127 raw1394 sbp2 dv1394 eth1394 ivtv tun radeonfb agpgart btaudio tuner tvaudio msp3400 bttv video_buf i2c_algo_bit v4l2_common btcx_risc i2c_core videodev psmouse snd_pcm_oss snd_mixer_oss snd_seq_midi snd_seq_oss snd_seq_midi_event snd_seq snd_ens1370 snd_ak4531_codec snd_via82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ide_cd cdrom ohci1394 ieee1394
via_rhine mii crc32 rtc sata_via libata reiserfs sym53c8xx scsi_transport_spi sd_mod scsi_mod via82cxxx piix ide_disk ide_core ext3 jbd mbcache kernel: CPU:    0
kernel: EIP:    0060:[<fb2c55a3>]    Not tainted VLI
kernel: EFLAGS: 00010282   (2.6.7-mm4-1.16)
kernel: EIP is at sbp2_logout_device+0x13/0x140 [sbp2]
kernel: eax: 00000013   ebx: c1a61b60   ecx: c02d0dd8   edx: 00004a00
kernel: esi: 00000020   edi: c1a5f8f4   ebp: f689df64   esp: f689df4c
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process knodemgrd_0 (pid: 867, threadinfo=f689c000 task=f7013210)
kernel: Stack: f7a69878 0000c0ff 00e0e537 c1a61b60 c1a61b60 c1a5f800 f689df74 fb2c49f1
kernel:        f7fc5600 f7fc5600 f689df90 f8f7a5b5 f0000234 fb31b000 f7fc5600 f75f71f8
kernel:        00000002 f689dfa8 f8f7a697 f7fc5640 f7fc56fc f75f71f8 00000002 f689dfc0
kernel: Call Trace:
kernel:  [<c010801a>] show_stack+0x7a/0x90
kernel:  [<c01081a2>] show_registers+0x152/0x1c0
kernel:  [<c0108376>] die+0xb6/0x180
kernel:  [<c011a8f5>] do_page_fault+0x1e5/0x583
kernel:  [<c0107ca9>] error_code+0x2d/0x38
kernel:  [<fb2c49f1>] sbp2_update+0x21/0x80 [sbp2]
kernel:  [<f8f7a5b5>] nodemgr_update_pdrv+0x95/0x100 [ieee1394]
kernel:  [<f8f7a697>] nodemgr_probe_ne+0x77/0x90 [ieee1394]
kernel:  [<f8f7a70f>] nodemgr_node_probe+0x5f/0xa0 [ieee1394]
kernel:  [<f8f7aab6>] nodemgr_host_thread+0x176/0x1a0 [ieee1394]
kernel:  [<c01052c5>] kernel_thread_helper+0x5/0x10
kernel: Code: 25 fe ff ff c7 04 24 c0 75 2c fb eb 81 8d 74 26 00 8d bc 27 00 00 00 00 55 89 e5 56 53 83 ec 10 89 c3 8b b0 b0 00 00 00 8b 40 30 <c7> 00 00 00 00 00 8b 43 30 c7 40 04 00 00 00 00 8b 43 30 c7 40

No -mm4:

kernel: ieee1394: sbp2: Error logging into SBP-2 device - login timed-out
kernel: sbp2: probe of 00a0b80a0000144f-0 failed with error -16
kernel: ieee1394: raw1394: /dev/raw1394 device initialized
kernel: ieee1394: Error parsing configrom for node 0-01:1023
kernel: ieee1394: Error parsing configrom for node 0-03:1023
kernel: ieee1394: Node suspended: ID:BUS[0-03:1023]  GUID[006037444d4c4353]
kernel: scsi6 : SCSI emulation for IEEE-1394 SBP-2 Devices
kernel: ieee1394: sbp2: Error logging into SBP-2 device - login failed
kernel: sbp2: probe of 00a0b80a0000144f-0 failed with error -16

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
