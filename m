Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267445AbSKQDjv>; Sat, 16 Nov 2002 22:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267447AbSKQDjv>; Sat, 16 Nov 2002 22:39:51 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:43575
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267445AbSKQDju>; Sat, 16 Nov 2002 22:39:50 -0500
Date: Sat, 16 Nov 2002 22:50:22 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Patrick Mochel <mochel@osdl.org>
Subject: 2.5.47 vanilla oops in device_shutdown
Message-ID: <Pine.LNX.4.44.0211162247330.1543-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c024e80c
*pde = 00000000
Oops: 0000
 
CPU:    0
EIP:    0060:[<c024e80c>]    Not tainted
EFLAGS: 00010246
EIP is at device_shutdown+0x6c/0x8c
eax: ffffffff   ebx: 00000000   ecx: c05fefb0   edx: 00000000
esi: 4321fedc   edi: fee1dead   ebp: bffffdb8   esp: c5bf1e9c
ds: 0068   es: 0068   ss: 0068
Process halt (pid: 798, threadinfo=c5bf0000 task=c61d4680)
Stack: 00000000 c0133a27 c0678e28 00000003 00000000 c7fa6040 00000000 00000014 
       c7fa6040 00000000 c5bf1f40 c013123a 00000014 c5bf1f40 c7fa6040 00000000 
       c7da8580 c7da8580 c5bf0000 c7fa6040 00000282 c01312b3 00000014 c5bf1f40 
Call Trace:
 [<c0133a27>] sys_reboot+0x207/0x220
 [<c013123a>] __send_sig_info+0x11a/0x130
 [<c01312b3>] send_sig_info+0x63/0xc0
 [<c0131507>] kill_proc_info+0x57/0x80
 [<c01324bc>] sys_kill+0x4c/0x60
 [<c015b20c>] __fput+0x12c/0x160
 [<c0158c60>] filp_close+0xa0/0xc0
 [<c0158d05>] sys_close+0x85/0xc0
 [<c010b227>] syscall_call+0x7/0xb

Code: 8b 1b 81 fb a0 ef 5f c0 75 ca b9 b0 ef 5f c0 f0 ff 05 b0 ef 

0xc024e80c is in device_shutdown (drivers/base/power.c:86).
81              struct list_head * entry;
82
83              printk(KERN_EMERG "Shutting down devices\n");
84
85              down(&device_sem);
86              list_for_each(entry,&global_device_list) {
87                      struct device * dev = to_dev(entry);
88                      if (device_present(dev) && dev->driver && dev->driver->shutdown) {
89                              pr_debug("shutting down %s\n",dev->name);
90                              dev->driver->shutdown(dev);



-- 
function.linuxpower.ca

