Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267421AbTA3GRP>; Thu, 30 Jan 2003 01:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267432AbTA3GRP>; Thu, 30 Jan 2003 01:17:15 -0500
Received: from h234n2fls24o900.telia.com ([217.208.132.234]:15848 "EHLO
	oden.fish.net") by vger.kernel.org with ESMTP id <S267421AbTA3GRN>;
	Thu, 30 Jan 2003 01:17:13 -0500
Date: Thu, 30 Jan 2003 07:26:42 +0100
From: Voluspa <046-136912@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops in modutils
Message-Id: <20030130072642.58628e72.046-136912@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David van Hoose wrote (at 2003-01-17 14:14:52):

> This occured at the insmod/modprobe point at the end of 'make install'

I got practically the same OOPS at the point of loading my NIC. Is the only thing, apart from sound, which I've compiled as a module:

KVERSION=$(/bin/uname -r | /bin/sed -n -e 's/[^\.]\{1,\}$//p')
if [ "$KVERSION" = "2.4." ]; then
/sbin/modprobe de4x5
else
/usr/local/sbin/modprobe de4x5
fi

Kernel 2.5.59 (not tainted)
module-init-tools-0.9.9-pre

Here's the /var/log/kernel message:

Jan 29 23:59:22 loke kernel: VFS: Mounted root (ext2 filesystem) readonly.
Jan 29 23:59:22 loke kernel: Freeing unused kernel memory: 252k freed
Jan 29 23:59:22 loke kernel: Adding 489940k swap on /dev/hda7.  Priority:-1 exte
nts:1
Jan 29 23:59:22 loke kernel: Unable to handle kernel paging request at virtual a
ddress 16a0c029
Jan 29 23:59:22 loke kernel:  printing eip:
Jan 29 23:59:22 loke kernel: c01236d1
Jan 29 23:59:22 loke kernel: *pde = 00000000
Jan 29 23:59:23 loke kernel: Oops: 0000
Jan 29 23:59:23 loke kernel: CPU:    0
Jan 29 23:59:23 loke kernel: EIP:    0060:[__find_symbol+61/120]    Not tainted
Jan 29 23:59:23 loke kernel: EFLAGS: 00010093
Jan 29 23:59:23 loke kernel: EIP is at __find_symbol+0x3d/0x78
Jan 29 23:59:23 loke kernel: eax: c028e48e   ebx: c8840ef1   ecx: 00000000   edx
: c0317adc
Jan 29 23:59:23 loke kernel: esi: 16a0c029   edi: c8840ef1   ebp: 00000616   esp
: c7d57ec8
Jan 29 23:59:23 loke kernel: ds: 007b   es: 007b   ss: 0068
Jan 29 23:59:23 loke kernel: Process modprobe (pid: 55, threadinfo=c7d56000 task
=c11da660)
Jan 29 23:59:23 loke kernel: Stack: c7d56000 c8840e14 c8840f40 c883de5c c01240ab
 c8840ef1 c7d57ef4 00000001 
Jan 29 23:59:23 loke kernel:        c8840dc4 c8840e14 00000021 c7d57f28 c01242dd
 c883de5c 00000010 c8840e14 
Jan 29 23:59:23 loke kernel:        c8840ef1 c8840f40 c883de5c 00000004 00000011
 c8840f40 00000000 00000026 
Jan 29 23:59:23 loke kernel: Call Trace:
Jan 29 23:59:23 loke kernel:  [resolve_symbol+43/104] resolve_symbol+0x2b/0x68
Jan 29 23:59:23 loke kernel:  [simplify_symbols+129/228] simplify_symbols+0x81/0
xe4
Jan 29 23:59:23 loke kernel:  [load_module+1468/2020] load_module+0x5bc/0x7e4
Jan 29 23:59:23 loke kernel:  [sys_init_module+95/420] sys_init_module+0x5f/0x1a
4
Jan 29 23:59:23 loke kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 29 23:59:23 loke kernel: 
Jan 29 23:59:23 loke kernel: Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 
01 85 c0 75 0e 
Jan 29 23:59:23 loke kernel:  <6>note: modprobe[55] exited with preempt_count 1
Jan 29 23:59:25 loke kernel: end_request: I/O error, dev hdd, sector 0
Jan 29 23:59:25 loke kernel: end_request: I/O error, dev hdd, sector 0
Jan 29 23:59:25 loke kernel: hdd: DMA disabled

Note, /dev/hdd is my cdrom, hence the DMA messages...

Regards,
Mats Johannesson
