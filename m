Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVCBBSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVCBBSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 20:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVCBBSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 20:18:11 -0500
Received: from newmail.linux4media.de ([193.201.54.81]:5805 "EHLO l4m.mine.nu")
	by vger.kernel.org with ESMTP id S261957AbVCBBRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 20:17:33 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: Ark Linux team
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc5-mm1: (seemingly non-fatal) NULL pointer dereference on startup
Date: Wed, 2 Mar 2005 02:13:00 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503020213.00174.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this right after the initramfs script was finished and the root 
filesystem was mounted:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
printing eip:
c02f52fa
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c02f52fa>]    Not tainted VLI
EFLAGS: 00010246   (2.6.11-0.rc5.1ark)
EIP is at __down+0x10a/0x130
eax: 00000000   ebx: cf63652c   ecx: cfd6d020   edx: ffffffff
esi: 00000286   edi: cfbcd000   ebp: cfbb3020   esp: cfbcddc0
ds: 007b   es: 007b   ss: 0068
Process hotplug (pid: 286, threadinfo=cfbcd000 task=cfbb3020)
Stack: cf636534 00000001 cfbb3020 c0116cb0 00100100 00200200 cfbcde04 9bbf6ac4
       d70e78df cf727d14 cfbcdf54 cfbcde6c cffe4140 c02f51c7 00000010 cf6364bc
       c01711ad cf727d14 cfbcde6c c016c7b6 cf6364bc 00000001 cf6349fa cfbcde6c
Call Trace:
[<c0116cb0>] default_wake_function+0x0/0x20
[<c02f51c7>] __down_failed+0x7/0xc
[<c01711ad>] .text.lock.namei+0x8/0x1db
[<c016c7b6>] permission+0xe6/0xf0
[<c016d762>] link_path_walk+0x882/0xf80
[<c010218c>] __up+0x1c/0x20
[<c01711c7>] .text.lock.namei+0x22/0x1db
[<c016d8a1>] link_path_walk+0x9c1/0xf80
[<c014e2ea>] handle_mm_fault+0x1ea/0x540
[<c016dee3>] path_lookup+0x83/0x150
[<c016e7ef>] open_namei+0x8f/0x620
[<c015d49b>] filp_open+0x3b/0x70
[<c015d4fc>] get_unused_fd+0x2c/0xd0
[<c015d677>] sys_open+0x57/0xf0
[<c01030d1>] syscall_call+0x7/0xb
Code: ff 21 e0 ff 48 14 8b 40 08 a8 08 75 19 c7 45 00 00 00 00 00 83 c4 24 
5b5e 5f 5d c3 e8 00 07 00 00 e9 73 ff ff ff e8 f6 06 00 00 <00> 00 00 00 00 
00 eb da 0f 0b a4 00 7b 48 30 c0 eb 8e 0f 0b a5


Same box, same kernel, with hotplug disabled boots up fine and produces a 
similar oops later:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
printing eip:
c02f52fa
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: usbkbd usbhid snd_cmipci gameport snd_pcm snd_page_alloc 
snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device 
snd soundcore psmouse binfmt_misc lp parport md5 ipv6 8139too mii af_packet 
8250 serial_core ide_cd cdrom ohci_hcd usbcore video thermal sony_acpi 
processor pcc_acpi fan container button battery ac genrtc
CPU:    0
EIP:    0060:[<c02f52fa>]    Not tainted VLI
EFLAGS: 00210246   (2.6.11-0.rc5.1ark)
EIP is at __down+0x10a/0x130
eax: 00000000   ebx: c0346644   ecx: cda20540   edx: ffffffff
esi: 00200286   edi: c6b6f000   ebp: c4c68020   esp: c6b6fed4
ds: 007b   es: 007b   ss: 0068
Process iwconfig (pid: 3080, threadinfo=c6b6f000 task=c4c68020)
Stack: c034664c 00000001 c4c68020 c0116cb0 00100100 00200200 30746973 00000000
       00000001 cfe71ee0 cfe71ee0 c55006e0 c55006e0 c02f51c7 00000000 c4c68020
       c02f6c94 c019279f 00000000 00000000 00000000 c019288f 00000000 c55006e0
Call Trace:
[<c0116cb0>] default_wake_function+0x0/0x20
[<c02f51c7>] __down_failed+0x7/0xc
[<c02f6c94>] .text.lock.kernel_lock+0x28/0x37
[<c019279f>] de_put+0xf/0xa0
[<c019288f>] proc_delete_inode+0x5f/0xc0
[<c0192830>] proc_delete_inode+0x0/0xc0
[<c017b225>] generic_delete_inode+0xb5/0x190
[<c017a27c>] iput+0x3c/0x90
[<c01774bb>] dput+0x6b/0x2b0
[<c015f39e>] __fput+0x11e/0x1c0
[<c015d792>] filp_close+0x52/0xa0
[<c015d838>] sys_close+0x58/0xa0
[<c010307b>] sysenter_past_esp+0x54/0x75
Code: ff 21 e0 ff 48 14 8b 40 08 a8 08 75 19 c7 45 00 00 00 00 00 83 c4 24 
5b5e 5f 5d c3 e8 00 07 00 00 e9 73 ff ff ff e8 f6 06 00 00 <00> 00 00 00 00 
00 eb da 0f 0b a4 00 7b 48 30 c0 eb 8e 0f 0b a5
