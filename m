Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbUDSGAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 02:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUDSGAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 02:00:43 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:64665 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S263138AbUDSGAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 02:00:35 -0400
Subject: usb and preempt oopses with 2.6.6-rc1 on ppc
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@KERNEL.CRASHING.ORG>
Content-Type: text/plain
Message-Id: <1082354034.1717.8.camel@localhost>
Mime-Version: 1.0
Date: Mon, 19 Apr 2004 07:53:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I get the following 2 oopses with the 2.6.6-rc1 kernel on my G4 powerbook.
The first one is an usb oops (from 2.6.5) and the second one probably a preempt issue on ppc.

This is the usb oops I get when I don't hciconfig hci0 down and stop all
blue-* programs before *REMOVING* the bluetooth dongle.

Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C022F204 LR: F2060400 SP: EFE49DD0 REGS: efe49d20 TRAP: 0600    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 6B6B6BB7, DSISR: 00000120
TASK = c100e030[5] 'khubd' Last syscall: -1
GPR00: FFFF0001 EFE49DD0 C100E030 EF0425FC 6B6B6B6B 00000000 C13E64A0 00000000
GPR08: 00001388 C1122514 00010C00 C022F1D0 82008022 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00220000 00230000 00000000
GPR24: 00000000 EFE49F7E 00000001 6B6B6B6B 6B6B6BB7 D1D18464 EF0425FC EF0424D0
Call trace:
[f2060400] hci_unregister_sysfs+0x14/0x24 [bluetooth]
[f205ad80] hci_unregister_dev+0x18/0xdc [bluetooth]
[f204e2fc] hci_usb_disconnect+0x48/0x90 [hci_usb]
[c0298298] usb_unbind_interface+0x88/0x8c
[c022e2c8] device_release_driver+0x84/0x88
[c022e468] bus_remove_device+0x74/0xd0
[c022ce44] device_del+0xa8/0x114
[c022cec8] device_unregister+0x18/0x30
[c029f0a8] usb_disable_device+0x9c/0xd8
[c0298fdc] usb_disconnect+0x9c/0x134
[c029b514] hub_port_connect_change+0x294/0x298
[c029b810] hub_events+0x2f8/0x3a4
[c029b8f8] hub_thread+0x3c/0xf4
[c0009470] kernel_thread+0x44/0x60


That one happened on a debian apt-get update/upgrade procedure (right
after all the packages got downloaded)

Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT 
NIP: C0058634 LR: C0058910 SP: ED775E00 REGS: ed775d50 TRAP: 0301    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 6B6B6B7B, DSISR: 40000000
TASK = e6224ce8[19769] 'apt-listbugs' Last syscall: 163 
GPR00: C0058910 ED775E00 E6224CE8 6B6B6B6B 30E44000 30E1B000 00023000 CFACCA9C 
GPR08: 00000000 00000001 00000000 ED774000 84002488 
Call trace:
 [c0058910] move_one_page+0x80/0x2f0
 [c0058bd4] move_page_tables+0x54/0x6c
 [c0058c80] move_vma+0x94/0x1d4
 [c0058ff4] do_mremap+0x234/0x3a4
 [c00591d0] sys_mremap+0x6c/0xbc
 [c0005e00] ret_from_syscall+0x0/0x44
note: apt-listbugs[19769] exited with preempt_count 1
bad: scheduling while atomic!
Call trace:
 [c0009dd8] dump_stack+0x18/0x28
 [c034918c] schedule+0x848/0x84c
 [c0349bc0] rwsem_down_read_failed+0xec/0x1e8
 [c0023848] do_exit+0x548/0x588
 [c0006834] die+0xd8/0xe0
 [c0011368] bad_page_fault+0x6c/0x84
 [c0010f84] do_page_fault+0x94/0x40c
 [c0006440] ret_from_except+0x0/0x14
 [c0058634] get_one_pte_map_nested+0x18/0x1bc
 [c0058910] move_one_page+0x80/0x2f0
 [c0058bd4] move_page_tables+0x54/0x6c
 [c0058c80] move_vma+0x94/0x1d4
 [c0058ff4] do_mremap+0x234/0x3a4
 [c00591d0] sys_mremap+0x6c/0xbc
 [c0005e00] ret_from_syscall+0x0/0x44

Soeren

