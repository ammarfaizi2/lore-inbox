Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWHMHrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWHMHrG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 03:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWHMHrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 03:47:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:8610 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750739AbWHMHrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 03:47:05 -0400
X-Authenticated: #14349625
Subject: 2.6.18-rc3-mm2:  oops in sysfs_follow_link()
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Content-Type: text/plain
Date: Sun, 13 Aug 2006 09:54:53 +0000
Message-Id: <1155462893.6125.13.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend with corrected cc)

Greetings,

I just got the below double warning from lib/kref.c:32 followed by oops.

I had just rebooted after upping my printk buffer to 20 (to be able to
see a complete boot despite the spam), and was poking Ctrl+Alt+F1 trying
to get to a vt to watch.

	-Mike

DEV: registering device: ID = 'vcs6'
PM: Adding info for No Bus:vcs6
DEV: registering device: ID = 'vcsa6'
PM: Adding info for No Bus:vcsa6
DEV: Unregistering device. ID = 'vcs6'
PM: Removing info for No Bus:vcs6
device_create_release called for vcs6
DEV: Unregistering device. ID = 'vcsa6'
PM: Removing info for No Bus:vcsa6
device_create_release called for vcsa6
BUG: warning at lib/kref.c:32/kref_get()
 [<c1003eba>] show_trace_log_lvl+0x16e/0x191
 [<c1004647>] show_trace+0x12/0x14
 [<c1004768>] dump_stack+0x19/0x1b
 [<c11d3f28>] kref_get+0x41/0x43
 [<c11d3416>] kobject_get+0x12/0x17
 [<c10b0dea>] sysfs_follow_link+0x1d0/0x245
 [<c107d187>] generic_readlink+0x28/0x70
 [<c10796de>] sys_readlinkat+0x7c/0xa1
 [<c107972a>] sys_readlink+0x27/0x29
 [<c10030db>] syscall_call+0x7/0xb
 [<b7d309c4>] 0xb7d309c4
 [<c1004647>] show_trace+0x12/0x14
 [<c1004768>] dump_stack+0x19/0x1b
 [<c11d3f28>] kref_get+0x41/0x43
 [<c11d3416>] kobject_get+0x12/0x17
 [<c10b0dea>] sysfs_follow_link+0x1d0/0x245
 [<c107d187>] generic_readlink+0x28/0x70
 [<c10796de>] sys_readlinkat+0x7c/0xa1
 [<c107972a>] sys_readlink+0x27/0x29
 [<c10030db>] syscall_call+0x7/0xb
BUG: warning at lib/kref.c:32/kref_get()
 [<c1003eba>] show_trace_log_lvl+0x16e/0x191
 [<c1004647>] show_trace+0x12/0x14
 [<c1004768>] dump_stack+0x19/0x1b
 [<c11d3f28>] kref_get+0x41/0x43
 [<c11d3416>] kobject_get+0x12/0x17
 [<c10b0ccd>] sysfs_follow_link+0xb3/0x245
 [<c107d187>] generic_readlink+0x28/0x70
 [<c10796de>] sys_readlinkat+0x7c/0xa1
 [<c107972a>] sys_readlink+0x27/0x29
 [<c10030db>] syscall_call+0x7/0xb
 [<b7d309c4>] 0xb7d309c4
 [<c1004647>] show_trace+0x12/0x14
 [<c1004768>] dump_stack+0x19/0x1b
 [<c11d3f28>] kref_get+0x41/0x43
 [<c11d3416>] kobject_get+0x12/0x17
 [<c10b0ccd>] sysfs_follow_link+0xb3/0x245
 [<c107d187>] generic_readlink+0x28/0x70
 [<c10796de>] sys_readlinkat+0x7c/0xa1
 [<c107972a>] sys_readlink+0x27/0x29
 [<c10030db>] syscall_call+0x7/0xb
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c10b0d1f
*pde = 00000000
Oops: 0000 [#3]
4K_STACKS PREEMPT SMP 
last sysfs file: /class/net/lo/address
Modules linked in: ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables nls_iso8859_1 nls_cp437 nls_utf8 sd_mod ir_kbd_i2c prism54 bt878 ohci1394 bttv video_buf ir_common btcx_risc tveeprom ieee1394 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device i2c_i801 snd soundcore
CPU:    0
EIP:    0060:[<c10b0d1f>]    Not tainted VLI
EFLAGS: 00010246   (2.6.18-rc3-mm2-smp #182) 
EIP is at sysfs_follow_link+0x105/0x245
eax: 00000000   ebx: 00000001   ecx: ffffffff   edx: ffffffff
esi: 00000000   edi: 00000000   ebp: dff85ec4   esp: dff85e94
ds: 007b   es: 007b   ss: 0068
Process hald (pid: 4133, ti=dff85000 task=c24a3030 task.ti=dff85000)
Stack: f8b0e078 dff85ed8 f7bca000 00000001 dff0d704 f7c15e40 ffffffea f8b0e078 
       f8b0e168 c14b19a0 f7bc9800 00000100 dff85f34 c107d187 c10824d1 0809ab00 
       c10822f8 dff0d77c 00001000 08096f54 00000070 dff85fb4 f7811000 44dee880 
Call Trace:
 [<c107d187>] generic_readlink+0x28/0x70
 [<c10796de>] sys_readlinkat+0x7c/0xa1
 [<c107972a>] sys_readlink+0x27/0x29
 [<c10030db>] syscall_call+0x7/0xb
 [<b7d309c4>] 0xb7d309c4
 [<c1003f83>] show_stack_log_lvl+0xa6/0xcb
 [<c1004180>] show_registers+0x1d8/0x286
 [<c100437f>] die+0x151/0x333
 [<c10197f9>] do_page_fault+0x26b/0x51f
 [<c13e1a99>] error_code+0x39/0x40
 [<c107d187>] generic_readlink+0x28/0x70
 [<c10796de>] sys_readlinkat+0x7c/0xa1
 [<c107972a>] sys_readlink+0x27/0x29
 [<c10030db>] syscall_call+0x7/0xb
Code: dc 00 00 00 00 83 45 dc 01 8b 40 24 85 c0 75 f5 8b 45 ec 89 45 d0 bb 01 00 00 00 31 f6 ba ff ff ff ff 8b 4d d0 8b 39 89 d1 89 f0 <f2> ae f7 d1 49 83 c1 01 01 cb 8b 4d d0 8b 49 24 89 4d d0 85 c9 
EIP: [<c10b0d1f>] sysfs_follow_link+0x105/0x245 SS:ESP 0068:dff85e94
 <7>DEV: registering device: ID = 'vcs2'


