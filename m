Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVIXPVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVIXPVu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 11:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVIXPVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 11:21:50 -0400
Received: from newmail.linux4media.de ([193.201.54.81]:63407 "EHLO l4m.mine.nu")
	by vger.kernel.org with ESMTP id S932099AbVIXPVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 11:21:50 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: NULL pointer dereference when loading the budget-av module
Date: Sat, 24 Sep 2005 17:21:07 +0200
User-Agent: KMail/1.8.91
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509241721.07944.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modprobe budget-av results in this NULL pointer dereference when a KNC1 DVB-C 
card is present (this is on 2.6.13-mm3, also tried current CVS DVB drivers):

[  113.754885] saa7146: found saa7146 @ mem d0b52e00 (revision 1, irq 201) 
(0x1894,0x0020).
[  113.755007] DVB: registering new adapter (KNC1 DVB-C).
[  113.923689] adapter failed MAC signature check
[  113.923700] encoded MAC from EEPROM was 
ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff
[  114.930630] budget-av: ci interface initialised.
[  115.012579] KNC1-0: MAC addr = 00:09:d6:ff:f0:2e
[  115.304658] Unable to handle kernel NULL pointer dereference at virtual 
address 00000000
[  115.304668]  printing eip:
[  115.304671] ce831196
[  115.304673] *pde = 00000000
[  115.304677] Oops: 0000 [#1]
[  115.304679] last sysfs file:
[  115.304682] Modules linked in: budget_av saa7146_vv budget_ci tda1004x 
budget_core saa7146 ttpci_eeprom stv0297 psmouse saa7134_empress saa7134 
saa6752hs ir_common v4l1_compat snd_pcm_oss snd_mixer_oss snd_intel8x0 
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc 
dvb_bt8xx nxt6000 mt352 sp887x dst_ca dst bt878 bttv video_buf i2c_algo_bit 
v4l2_common btcx_risc tveeprom cx24110 or51211 ati_remote raw1394 sbp2 
scsi_mod lp parport ipv6 pcmcia firmware_class yenta_socket rsrc_nonstatic 
pcmcia_core 8139too mii af_packet ohci1394 ieee1394 ves1820 tda10021 stv0299 
dvb_core i2c_core videodev 8250 serial_core lirc_serial ide_cd cdrom ohci_hcd 
ehci_hcd usbcore video thermal processor hotkey fan container button battery 
ac rtc
[  115.304736] CPU:    0
[  115.304737] EIP:    0060:[<ce831196>]    Not tainted VLI
[  115.304739] EFLAGS: 00010282   (2.6.13-0.rc5.1ark)
[  115.304751] EIP is at tda10021_readreg+0xb0/0xcc [tda10021]
[  115.304756] eax: 00000000   ebx: c660b000   ecx: 00000002   edx: ffffff87
[  115.304762] esi: ce8326b4   edi: c660b0f8   ebp: c660b000   esp: cb2bed80
[  115.304766] ds: 007b   es: 007b   ss: 0068
[  115.304771] Process modprobe (pid: 1677, threadinfo=cb2be000 task=cd4aa030)
[  115.304774] Stack: c6791088 cb2bedb4 ce8319ca ffffff87 1a008480 0000000c 
ca0d0001 cb2bed93
[  115.304783]        0001000c cb2b0001 cb2bed92 00000003 d08dcc33 0000000c 
ca0d0001 cb2bed93
[  115.304792]        0001000c cb2b0001 cb2bed92 00000246 c6791000 c660b004 
ce83196a cdfef500
[  115.304801] Call Trace:
[  115.304843]  [<d08dcc33>] i2c_transfer+0x3e/0x50 [i2c_core]
[  115.304889]  [<ce83196a>] tda10021_attach+0x7c/0xca [tda10021]
[  115.304918]  [<d0b9f23d>] budget_av_attach+0x356/0x776 [budget_av]
[  115.305002]  [<d0b8f71f>] saa7146_init_one+0x321/0x5c5 [saa7146]
[  115.305044]  [<c01c8e08>] kobject_get+0x17/0x1e
[  115.305057]  [<c01d1fc6>] pci_match_device+0x1d/0xa7
[  115.305080]  [<c01d240c>] pci_device_probe+0x68/0x80
[  115.305101]  [<c024dc5f>] driver_probe_device+0x38/0xc2
[  115.305128]  [<c024dd57>] __driver_attach+0x0/0x48
[  115.305133]  [<c024dd9d>] __driver_attach+0x46/0x48
[  115.305148]  [<c024d2b0>] bus_for_each_dev+0x58/0x77
[  115.305188]  [<c024ddc5>] driver_attach+0x26/0x2a
[  115.305203]  [<c024dd57>] __driver_attach+0x0/0x48
[  115.305208]  [<c024d792>] bus_add_driver+0x8f/0x168
[  115.305241]  [<c024e15f>] driver_register+0x2b/0x30
[  115.305266]  [<c01d223e>] pci_register_driver+0x6a/0x92
[  115.305278]  [<d0b8fbb8>] saa7146_register_extension+0x3b/0x79 [saa7146]
[  115.305299]  [<d0a5500f>] budget_av_init+0xf/0x13 [budget_av]
[  115.305309]  [<c0133675>] sys_init_module+0x119/0x19b
[  115.305334]  [<c0102cff>] sysenter_past_esp+0x54/0x75
[  115.305394] Code: 24 44 8d 44 24 34 89 44 24 04 8b 03 89 04 24 e8 76 ba 0a 
02 83 f8 02 74 24 89 44 24 0c c7 44 24 08 ca 19 83 ce 8b 83 00 01 00 00 <8b> 
00 c7 04 24 80 1a 83 ce 89 44 24 04 e8 36 95 8e f1 0f b6 44
[  115.305434]
