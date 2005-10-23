Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbVJWSmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbVJWSmH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 14:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbVJWSmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 14:42:07 -0400
Received: from mail.fieldses.org ([66.93.2.214]:28046 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751448AbVJWSmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 14:42:06 -0400
Date: Sun, 23 Oct 2005 14:42:02 -0400
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc5 apm suspend failure--ALSA patch?
Message-ID: <20051023184202.GB10037@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I upgraded my laptop (Thinkpad X31) from 2.6.14-rc1 to 2.6.14-rc5 I
found apm suspend had stopped working.  With git bisect I found the
commit 16dab54b8cbac39bd3f639db5d7d0fd8300a6cb0, "[ALSA] Add
snd_card_set_generic_dev() call", and verified that suspend worked again
in 2.6.14-rc5 with that patch reverted.

The symptoms are that when I suspend to RAM, the screen blanks but
nothing further happens.  At that point I can ssh into the laptop and
find the appended oops.  Any idea what's going on?--b.

Oct 22 13:47:58 puzzle apmd[4362]: Suspending now
Oct 22 13:47:59 puzzle kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oct 22 13:47:59 puzzle kernel:  printing eip:
Oct 22 13:47:59 puzzle kernel: 00000000
Oct 22 13:47:59 puzzle kernel: *pde = 00000000
Oct 22 13:47:59 puzzle kernel: Oops: 0000 [#1]
Oct 22 13:47:59 puzzle kernel: PREEMPT 
Oct 22 13:47:59 puzzle kernel: Modules linked in:
Oct 22 13:47:59 puzzle kernel: CPU:    0
Oct 22 13:47:59 puzzle kernel: EIP:    0060:[<00000000>]    Not tainted VLI
Oct 22 13:47:59 puzzle kernel: EFLAGS: 00010287   (2.6.14-rc5) 
Oct 22 13:47:59 puzzle kernel: EIP is at rest_init+0x3feffdc0/0x40
Oct 22 13:47:59 puzzle kernel: eax: f7cb1008   ebx: f7c9b000   ecx: 00000066   edx: 00000000
Oct 22 13:47:59 puzzle kernel: esi: 00000002   edi: 00000000   ebp: f7744ea4   esp: f7744e94
Oct 22 13:47:59 puzzle kernel: ds: 007b   es: 007b   ss: 0068
Oct 22 13:47:59 puzzle kernel: Process apmd (pid: 4362, threadinfo=f7744000 task=f7728000)
Oct 22 13:47:59 puzzle kernel: Stack: c040c62f f7c9b000 00000002 f7cb1008 f7744ec0 c035d5a5 f7cb1008 00000002 
Oct 22 13:47:59 puzzle kernel:        00000002 f7cb1008 00000002 f7744ee4 c035f15d f7cb1008 00000002 f7cb1140 
Oct 22 13:47:59 puzzle kernel:        f7cb10f8 f7cb1140 f7cb1008 00000000 f7744f04 c035f22c f7cb1008 00000002 
Oct 22 13:47:59 puzzle kernel: Call Trace:
Oct 22 13:47:59 puzzle kernel:  [<c0103296>] show_stack+0x86/0xd0
Oct 22 13:47:59 puzzle kernel:  [<c010344a>] show_registers+0x14a/0x1e0
Oct 22 13:47:59 puzzle kernel:  [<c0103637>] die+0xc7/0x160
Oct 22 13:47:59 puzzle kernel:  [<c04e1839>] do_page_fault+0x1e9/0x680
Oct 22 13:47:59 puzzle kernel:  [<c0102f2f>] error_code+0x4f/0x60
Oct 22 13:47:59 puzzle kernel:  [<c035d5a5>] platform_suspend+0x25/0x70
Oct 22 13:47:59 puzzle kernel:  [<c035f15d>] suspend_device+0xcd/0xe0
Oct 22 13:47:59 puzzle kernel:  [<c035f22c>] device_suspend+0xbc/0x1c0
Oct 22 13:47:59 puzzle kernel:  [<c010fe50>] suspend+0x30/0x1a0
Oct 22 13:47:59 puzzle kernel:  [<c0110759>] do_ioctl+0x149/0x180
Oct 22 13:47:59 puzzle kernel:  [<c0167ccb>] do_ioctl+0x6b/0x80
Oct 22 13:47:59 puzzle kernel:  [<c0167e71>] vfs_ioctl+0x51/0x1e0
Oct 22 13:47:59 puzzle kernel:  [<c016802e>] sys_ioctl+0x2e/0x50
Oct 22 13:47:59 puzzle kernel:  [<c0102c59>] syscall_call+0x7/0xb
Oct 22 13:47:59 puzzle kernel: Code:  Bad EIP value.
Oct 22 13:57:07 puzzle syslogd 1.4.1#17: restart.
Oct 22 13:57:08 puzzle kernel: klogd 1.4.1#17, log source = /proc/kmsg started.
Oct 22 13:57:08 puzzle kernel: Cannot find map file.
Oct 22 13:57:08 puzzle kernel: No module symbols loaded - kernel modules not enabled. 
Oct 22 13:57:08 puzzle kernel: Linux version 2.6.14-rc5 (bfields@puzzle) (gcc version 4.0.2 (Debian 4.0.2-2)) #12 PREEMPT Sat Oct 22 13:37:56 EDT 2005
Oct 22 13:57:08 puzzle kernel: BIOS-provided physical RAM map:
Oct 22 13:57:08 puzzle kernel:  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
Oct 22 13:57:08 puzzle kernel:  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
Oct 22 13:57:08 puzzle kernel:  BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
Oct 22 13:57:08 puzzle kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
Oct 22 13:57:08 puzzle kernel:  BIOS-e820: 0000000000100000 - 000000003ff60000 (usable)
Oct 22 13:57:08 puzzle kernel:  BIOS-e820: 000000003ff60000 - 000000003ff79000 (ACPI data)
Oct 22 13:57:08 puzzle kernel:  BIOS-e820: 000000003ff79000 - 000000003ff7b000 (ACPI NVS)
Oct 22 13:57:08 puzzle kernel:  BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
Oct 22 13:57:08 puzzle kernel:  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
