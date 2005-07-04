Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVGDTcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVGDTcV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 15:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVGDTcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 15:32:20 -0400
Received: from [80.227.130.154] ([80.227.130.154]:25034 "EHLO DXB.NetComm.IE")
	by vger.kernel.org with ESMTP id S261585AbVGDTam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 15:30:42 -0400
Message-ID: <42C98E5A.2050309@0Bits.COM>
Date: Mon, 04 Jul 2005 23:30:34 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Mail/News Client 1.0+ (X11/20050703)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Consistent kernel panic on 2.6.12 in sk_alloc when using vmware vmnet
 bridge. Works perfect on 2.6.11.x
Content-Type: multipart/mixed;
 boundary="------------060309030008070700020106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060309030008070700020106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm getting a 100% reproduceable panic (stack attached) when testing out 
vmware bridged net module on 2.6.12, 2.6.12.[12]. Reverting back to 
2.6.11.12 (or 2.6.11) works fine.

M

--------------060309030008070700020106
Content-Type: text/plain;
 name="kernel.log.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel.log.txt"

Jul  4 21:59:32 localhost kernel: vmmon: module license 'unspecified' taints kernel.
Jul  4 21:59:32 localhost kernel: /dev/vmmon[6516]: Module vmmon: registered with major=10 minor=165
Jul  4 21:59:32 localhost kernel: /dev/vmmon[6516]: Module vmmon: initialized
Jul  4 21:59:32 localhost kernel: /dev/vmmon[6526]: Module vmmon: unloaded
Jul  4 21:59:45 localhost kernel: /dev/vmmon[6761]: Module vmmon: registered with major=10 minor=165
Jul  4 21:59:45 localhost kernel: /dev/vmmon[6761]: Module vmmon: initialized
Jul  4 21:59:45 localhost kernel: /dev/vmnet: open called by PID 6805 (vmnet-bridge)
Jul  4 21:59:45 localhost kernel: /dev/vmnet: hub 0 does not exist, allocating memory.
Jul  4 21:59:45 localhost kernel: /dev/vmnet: port on hub 0 successfully opened
Jul  4 21:59:45 localhost kernel: bridge-eth1: enabling the bridge
Jul  4 21:59:45 localhost kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000069
Jul  4 21:59:45 localhost kernel:  printing eip:
Jul  4 21:59:45 localhost kernel: c02d3f4b
Jul  4 21:59:45 localhost kernel: *pde = 00000000
Jul  4 21:59:45 localhost kernel: Oops: 0000 [#1]
Jul  4 21:59:45 localhost kernel: PREEMPT 
Jul  4 21:59:45 localhost kernel: Modules linked in: vmnet vmmon af_packet ipw2200 firmware_class ieee80211 ieee80211_crypt irda crc_ccitt nfsd exportfs lockd sunrpc ohci_hcd 8250_pnp 8250 serial_core yenta_socket rsrc_nonstatic e1000 ieee1394 snd_intel8x0m ehci_hcd hci_usb bluetooth uhci_hcd evdev psmouse snd_intel8x0 snd_ac97_codec snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss usb_storage usbcore nls_iso8859_1 unix
Jul  4 21:59:45 localhost kernel: CPU:    0
Jul  4 21:59:45 localhost kernel: EIP:    0060:[sk_alloc+27/256]    Tainted: P      VLI
Jul  4 21:59:45 localhost kernel: EFLAGS: 00210296   (2.6.12.2) 
Jul  4 21:59:45 localhost kernel: EIP is at sk_alloc+0x1b/0x100
Jul  4 21:59:45 localhost kernel: eax: 00000020   ebx: df91c000   ecx: 0000000b   edx: 00000020
Jul  4 21:59:45 localhost kernel: esi: 00000001   edi: e2df920c   ebp: 00000000   esp: df91dde4
Jul  4 21:59:45 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jul  4 21:59:45 localhost kernel: Process vmnet-bridge (pid: 6805, threadinfo=df91c000 task=e22fc060)
Jul  4 21:59:45 localhost kernel: Stack: df91de2c e020c000 ef5b3060 df91c000 e2df9200 e2df920c 00000000 f1137fb5 
Jul  4 21:59:45 localhost kernel:        00000010 00000020 00000001 00000000 e2df9200 e020c005 e2df9211 e2df920c 
Jul  4 21:59:45 localhost kernel:        f1138185 e2df9200 e2df920c 0000016a c15f28e0 e020c000 e2df9200 00000000 
Jul  4 21:59:45 localhost kernel: Call Trace:
Jul  4 21:59:45 localhost kernel:  [pg0+818671541/1069044736] VNetBridgeUp+0x125/0x200 [vmnet]
Jul  4 21:59:45 localhost kernel:  [pg0+818672005/1069044736] VNetBridgeNotify+0x85/0x180 [vmnet]
Jul  4 21:59:45 localhost kernel:  [register_netdevice_notifier+114/128] register_netdevice_notifier+0x72/0x80
Jul  4 21:59:45 localhost kernel:  [pg0+818669465/1069044736] VNetBridge_Create+0x99/0x290 [vmnet]
Jul  4 21:59:45 localhost kernel:  [copy_from_user+70/128] copy_from_user+0x46/0x80
Jul  4 21:59:45 localhost kernel:  [pg0+818657204/1069044736] VNetFileOpIoctl+0x2e4/0x5b0 [vmnet]
Jul  4 21:59:45 localhost kernel:  [handle_mm_fault+420/512] handle_mm_fault+0x1a4/0x200
Jul  4 21:59:45 localhost kernel:  [do_page_fault+454/1492] do_page_fault+0x1c6/0x5d4
Jul  4 21:59:45 localhost kernel:  [dentry_open+128/624] dentry_open+0x80/0x270
Jul  4 21:59:45 localhost kernel:  [do_ioctl+112/176] do_ioctl+0x70/0xb0
Jul  4 21:59:45 localhost kernel:  [vfs_ioctl+101/512] vfs_ioctl+0x65/0x200
Jul  4 21:59:45 localhost kernel:  [get_unused_fd+44/208] get_unused_fd+0x2c/0xd0
Jul  4 21:59:45 localhost kernel:  [sys_ioctl+69/112] sys_ioctl+0x45/0x70
Jul  4 21:59:45 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul  4 21:59:45 localhost kernel: Code: 24 14 e9 57 fc ff ff 89 f6 8d bc 27 00 00 00 00 83 ec 1c 8b 54 24 24 89 74 24 10 8b 74 24 28 89 5c 24 0c 89 7c 24 14 89 6c 24 18 <8b> 46 68 85 c0 0f 84 aa 00 00 00 89 54 24 04 89 04 24 e8 2e 31 
Jul  4 21:59:45 localhost kernel:  <6>note: vmnet-bridge[6805] exited with preempt_count 1
Jul  4 21:59:45 localhost kernel: scheduling while atomic: vmnet-bridge/0x10000001/6805
Jul  4 21:59:45 localhost kernel:  [schedule+1428/1616] schedule+0x594/0x650
Jul  4 21:59:45 localhost kernel:  [unmap_page_range+131/192] unmap_page_range+0x83/0xc0
Jul  4 21:59:45 localhost kernel:  [cond_resched+39/64] cond_resched+0x27/0x40
Jul  4 21:59:45 localhost kernel:  [unmap_vmas+512/544] unmap_vmas+0x200/0x220
Jul  4 21:59:45 localhost kernel:  [exit_mmap+127/336] exit_mmap+0x7f/0x150
Jul  4 21:59:45 localhost kernel:  [mmput+55/160] mmput+0x37/0xa0
Jul  4 21:59:45 localhost kernel:  [do_exit+184/896] do_exit+0xb8/0x380
Jul  4 21:59:45 localhost kernel:  [die+382/384] die+0x17e/0x180
Jul  4 21:59:45 localhost kernel:  [printk+23/32] printk+0x17/0x20
Jul  4 21:59:45 localhost kernel:  [do_page_fault+980/1492] do_page_fault+0x3d4/0x5d4
Jul  4 21:59:45 localhost kernel:  [recalc_task_prio+140/352] recalc_task_prio+0x8c/0x160
Jul  4 21:59:45 localhost kernel:  [__wake_up_common+56/112] __wake_up_common+0x38/0x70
Jul  4 21:59:45 localhost kernel:  [preempt_schedule+69/112] preempt_schedule+0x45/0x70
Jul  4 21:59:45 localhost kernel:  [release_console_sem+201/224] release_console_sem+0xc9/0xe0
Jul  4 21:59:45 localhost kernel:  [do_page_fault+0/1492] do_page_fault+0x0/0x5d4
Jul  4 21:59:45 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
Jul  4 21:59:45 localhost kernel:  [monotonic_clock_tsc+59/192] monotonic_clock_tsc+0x3b/0xc0
Jul  4 21:59:45 localhost kernel:  [sk_alloc+27/256] sk_alloc+0x1b/0x100
Jul  4 21:59:45 localhost kernel:  [pg0+818671541/1069044736] VNetBridgeUp+0x125/0x200 [vmnet]
Jul  4 21:59:45 localhost kernel:  [pg0+818672005/1069044736] VNetBridgeNotify+0x85/0x180 [vmnet]
Jul  4 21:59:45 localhost kernel:  [register_netdevice_notifier+114/128] register_netdevice_notifier+0x72/0x80
Jul  4 21:59:45 localhost kernel:  [pg0+818669465/1069044736] VNetBridge_Create+0x99/0x290 [vmnet]
Jul  4 21:59:45 localhost kernel:  [copy_from_user+70/128] copy_from_user+0x46/0x80
Jul  4 21:59:45 localhost kernel:  [pg0+818657204/1069044736] VNetFileOpIoctl+0x2e4/0x5b0 [vmnet]
Jul  4 21:59:45 localhost kernel:  [handle_mm_fault+420/512] handle_mm_fault+0x1a4/0x200
Jul  4 21:59:45 localhost kernel:  [do_page_fault+454/1492] do_page_fault+0x1c6/0x5d4
Jul  4 21:59:45 localhost kernel:  [dentry_open+128/624] dentry_open+0x80/0x270
Jul  4 21:59:45 localhost kernel:  [do_ioctl+112/176] do_ioctl+0x70/0xb0
Jul  4 21:59:45 localhost kernel:  [vfs_ioctl+101/512] vfs_ioctl+0x65/0x200
Jul  4 21:59:45 localhost kernel:  [get_unused_fd+44/208] get_unused_fd+0x2c/0xd0
Jul  4 21:59:45 localhost kernel:  [sys_ioctl+69/112] sys_ioctl+0x45/0x70
Jul  4 21:59:45 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul  4 21:59:45 localhost kernel: /dev/vmnet: open called by PID 6808 (vmnet-bridge)
Jul  4 21:59:45 localhost kernel: /dev/vmnet: hub 2 does not exist, allocating memory.
Jul  4 21:59:45 localhost kernel: /dev/vmnet: port on hub 2 successfully opened
Jul  4 22:01:06 localhost init: Switching to runlevel: 0
Jul  4 22:01:14 localhost kernel: /dev/vmmon[6886]: Module vmmon: unloaded
Jul  4 22:01:14 localhost exiting on signal 15
Jul  4 22:01:48 localhost syslogd 1.4.1: restart (remote reception).

--------------060309030008070700020106--
