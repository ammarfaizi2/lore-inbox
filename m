Return-Path: <linux-kernel-owner+w=401wt.eu-S1030208AbWL3BqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWL3BqJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 20:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWL3BqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 20:46:09 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:46464 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030208AbWL3BqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 20:46:07 -0500
Date: Fri, 29 Dec 2006 20:45:57 -0500
From: Eric Buddington <ebuddington@verizon.net>
Subject: Oops in 2.6.19-rc6-mm2 on USB disconnect
To: linux-kernel@vger.kernel.org
Reply-to: ebuddington@wesleyan.edu
Message-id: <20061230014556.GA16451@pool-70-109-253-37.wma.east.verizon.net>
Organization: ECS Labs
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
X-Eric-conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.19-rc6-mm2 on an Athlon XP gave me the following Oops when
unplugging a USB device. I an usually plug and unplug devices without
trouble, so this is probably not easily repeatable.

-Eric

----------------------------------------------------------------------

[1742504.966893] usb 1-6.4.3: USB disconnect, address 16
[1742510.144326] usb 1-6.4.2: USB disconnect, address 15
[1742510.173818] BUG: unable to handle kernel NULL pointer dereference at virtua
l address 0000000c
[1742510.173827]  printing eip:
[1742510.173829] c03eeb2a
[1742510.173832] *pde = 00000000
[1742510.173838] Oops: 0000 [#1]
[1742510.173840] PREEMPT 
[1742510.173844] last sysfs file: /devices/pci0000:00/0000:00:03.2/usb1/1-6/1-6.
4/1-6.4.2/product
[1742510.173848] Modules linked in: fuse ppp_synctty ppp_async crc_ccitt ppp_gen
eric slhc r128 drm softdog capability commoncap sch_tbf raw1394 dv1394 ohci1394 
ieee1394 snd_ice1712 snd_ice17xx_ak4xxx keyspan_pda snd_ak4xxx_adda snd_cs8427 s
nd_i2c snd_mpu401_uart snd_rawmidi usbserial usbhid ff_memless sg usb_storage us
bnet ohci_hcd uhci_hcd ehci_hcd snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq
_oss snd_seq_device snd_seq_midi_event snd_pcm_oss snd_pcm snd_page_alloc snd_se
q snd_mixer_oss snd_timer snd soundcore ipt_tos ipt_owner iptable_nat ipt_MASQUE
RADE ip_nat joydev ip_conntrack tsdev nfnetlink ipt_TOS iptable_filter iptable_m
angle ip_tables x_tables 8139too sis900 mii usbmouse usbcore psmouse sis5595 hwm
on i2c_isa i2c_core sis_agp agpgart ide_scsi
[1742510.173914] CPU:    0
[1742510.173915] EIP:    0060:[<c03eeb2a>]    Tainted: G   M  VLI
[1742510.173917] EFLAGS: 00010286   (2.6.19-rc6-mm2 #1)
[1742510.173931] EIP is at klist_del+0x9/0x49
[1742510.173935] eax: 00000000   ebx: e887a400   ecx: e887a5f8   edx: 00000063
[1742510.173940] esi: e887a4a0   edi: c4e17214   ebp: f5e59e30   esp: f5e59e28
[1742510.173943] ds: 007b   es: 007b   ss: 0068
[1742510.173948] Process khubd (pid: 961, ti=f5e58000 task=f5dd7220 task.ti=f5e5
8000)
[1742510.173951] Stack: e887a400 e887a490 f5e59e44 c02d44ec e887a400 e887a490 f8
b03620 f5e59e54 
[1742510.173959]        c030501d e887a400 d7015400 f5e59e64 c03047b4 00000246 d7
015400 f5e59e74 
[1742510.173967]        c02fdac6 d70156bc f63bde18 f5e59e84 f8af27ff 00000000 d7
0156bc f5e59e90 
[1742510.173975] Call Trace:
[1742510.173993]  [<c02d44ec>] device_del+0x17/0x161
[1742510.174009]  [<c030501d>] __scsi_remove_device+0x34/0x62
[1742510.174021]  [<c03047b4>] scsi_forget_host+0x5e/0x9a
[1742510.174029]  [<c02fdac6>] scsi_remove_host+0xad/0x14b
[1742510.174041]  [<f8af27ff>] quiesce_and_remove_host+0xcf/0xd3 [usb_storage]
[1742510.174089]  [<f8af28be>] storage_disconnect+0x11/0x1b [usb_storage]
[1742510.174106]  [<f89dbf59>] usb_unbind_interface+0x41/0x81 [usbcore]
[1742510.174175]  [<c02d617b>] __device_release_driver+0x71/0x86
[1742510.174183]  [<c02d65c4>] device_release_driver+0x2f/0x45
[1742510.174190]  [<c02d5bc5>] bus_remove_device+0x5e/0x6c
[1742510.174196]  [<c02d45e0>] device_del+0x10b/0x161
[1742510.174203]  [<f89d9a20>] usb_disable_device+0x5f/0xbc [usbcore]
[1742510.174233]  [<f89d617f>] usb_disconnect+0x94/0x134 [usbcore]
[1742510.174256]  [<f89d6cb1>] hub_thread+0x38c/0xa8c [usbcore]
[1742510.174280]  [<c012ae5c>] kthread+0xa3/0xcf
[1742510.174294]  [<c0103a73>] kernel_thread_helper+0x7/0x10
[1742510.174305] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
[1742510.174311] Leftover inexact backtrace:
[1742510.174314]  [<c0103f96>] show_trace_log_lvl+0x1a/0x2f
[1742510.174319]  [<c0104046>] show_stack_log_lvl+0x9b/0xa3
[1742510.174323]  [<c01041eb>] show_registers+0x19d/0x2b8
[1742510.174328]  [<c010442d>] die+0x127/0x202
[1742510.174332]  [<c0114087>] do_page_fault+0x430/0x4fd
[1742510.174339]  [<c03f10bc>] error_code+0x74/0x7c
[1742510.174346]  [<c02d44ec>] device_del+0x17/0x161
[1742510.174351]  [<c030501d>] __scsi_remove_device+0x34/0x62
[1742510.174356]  [<c03047b4>] scsi_forget_host+0x5e/0x9a
[1742510.174360]  [<c02fdac6>] scsi_remove_host+0xad/0x14b
[1742510.174365]  [<f8af27ff>] quiesce_and_remove_host+0xcf/0xd3 [usb_storage]
[1742510.174378]  [<f8af28be>] storage_disconnect+0x11/0x1b [usb_storage]
[1742510.174389]  [<f89dbf59>] usb_unbind_interface+0x41/0x81 [usbcore]
[1742510.174407]  [<c02d617b>] __device_release_driver+0x71/0x86
[1742510.174412]  [<c02d65c4>] device_release_driver+0x2f/0x45
[1742510.174416]  [<c02d5bc5>] bus_remove_device+0x5e/0x6c
[1742510.174420]  [<c02d45e0>] device_del+0x10b/0x161
[1742510.174425]  [<f89d9a20>] usb_disable_device+0x5f/0xbc [usbcore]
[1742510.174443]  [<f89d617f>] usb_disconnect+0x94/0x134 [usbcore]
[1742510.174460]  [<f89d6cb1>] hub_thread+0x38c/0xa8c [usbcore]
[1742510.174477]  [<c012ae5c>] kthread+0xa3/0xcf
[1742510.174481]  [<c0103a73>] kernel_thread_helper+0x7/0x10
[1742510.174486]  =======================
[1742510.174488] Code: 89 10 8d 43 04 c7 43 f8 00 01 10 00 c7 41 04 00 02 20 00 
e8 b3 79 d2 ff c7 43 f4 00 00 00 00 5b c9 c3 55 89 e5 56 89 c6 53 8b 00 <8b> 58 
0c 89 e0 25 00 e0 ff ff ff 40 14 89 f0 e8 9d ff ff ff 85 
[1742510.174517] EIP: [<c03eeb2a>] klist_del+0x9/0x49 SS:ESP 0068:f5e59e28
[1742510.174524]  <5>scsi 6:0:0:0: Attached scsi generic sg0 type 3

