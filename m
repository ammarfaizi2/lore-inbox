Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTCELsz>; Wed, 5 Mar 2003 06:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbTCELsz>; Wed, 5 Mar 2003 06:48:55 -0500
Received: from [213.229.38.18] ([213.229.38.18]:61109 "HELO
	home.winischhofer.net") by vger.kernel.org with SMTP
	id <S265339AbTCELsy>; Wed, 5 Mar 2003 06:48:54 -0500
Message-ID: <3E65E60C.3090509@winischhofer.net>
Date: Wed, 05 Mar 2003 12:57:00 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en-us, en, de-at, de, de-de, sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.5.63
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.5.63 oopses upon fopen-ing for instance /dev/fb0 if no framebuffer 
driver is loaded.

The SiS X driver does this in order to find out if the SiS framebuffer 
driver is loaded. In 2.4, the fopen failed "correcrly".

Mar  5 12:47:08 oland modprobe: FATAL: Module fb0 not found.
Mar  5 12:47:08 oland modprobe: FATAL: Module fb32 not found.
Mar  5 12:47:08 oland modprobe: FATAL: Module fb64 not found.
Mar  5 12:47:08 oland kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Mar  5 12:47:08 oland kernel:  printing eip:
Mar  5 12:47:08 oland kernel: c024ce74
Mar  5 12:47:08 oland kernel: *pde = 00000000
Mar  5 12:47:08 oland kernel: Oops: 0000
Mar  5 12:47:08 oland kernel: CPU:    0
Mar  5 12:47:08 oland kernel: EIP:    0060:[fb_open+60/180]    Not tainted
Mar  5 12:47:08 oland kernel: EIP:    0060:[<c024ce74>]    Not tainted
Mar  5 12:47:08 oland kernel: EFLAGS: 00013286
Mar  5 12:47:08 oland kernel: EIP is at fb_open+0x3c/0xb4
Mar  5 12:47:08 oland kernel: eax: 00000000   ebx: c1586000   ecx: 
c03557c0   edx: 00000001
Mar  5 12:47:08 oland kernel: esi: c03be100   edi: 00000000   ebp: 
d9405f28   esp: d9405f1c
Mar  5 12:47:08 oland kernel: ds: 007b   es: 007b   ss: 0068
Mar  5 12:47:08 oland kernel: Process X (pid: 995, threadinfo=d9404000 
task=d8927920)
Mar  5 12:47:08 oland kernel: Stack: 00000000 d9953120 dabae6c0 d9405f44 
c014792f dabae6c0 d9953120 d9953120
Mar  5 12:47:08 oland kernel:        dabae6c0 00000000 d9405f60 c01402ec 
dabae6c0 d9953120 bffff818 d8b94000
Mar  5 12:47:08 oland kernel:        00000002 d9405f9c c0140203 dabb0840 
dbfea560 00000002 00000006 0826d160
Mar  5 12:47:08 oland kernel: Call Trace:
Mar  5 12:47:08 oland kernel:  [chrdev_open+63/80] chrdev_open+0x3f/0x50
Mar  5 12:47:08 oland kernel:  [<c014792f>] chrdev_open+0x3f/0x50
Mar  5 12:47:08 oland kernel:  [dentry_open+220/416] dentry_open+0xdc/0x1a0
Mar  5 12:47:08 oland kernel:  [<c01402ec>] dentry_open+0xdc/0x1a0
Mar  5 12:47:08 oland kernel:  [filp_open+79/92] filp_open+0x4f/0x5c
Mar  5 12:47:08 oland kernel:  [<c0140203>] filp_open+0x4f/0x5c
Mar  5 12:47:08 oland kernel:  [sys_open+55/116] sys_open+0x37/0x74
Mar  5 12:47:08 oland kernel:  [<c014059f>] sys_open+0x37/0x74
Mar  5 12:47:08 oland kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar  5 12:47:08 oland kernel:  [<c0108ac7>] syscall_call+0x7/0xb
Mar  5 12:47:08 oland kernel:
Mar  5 12:47:08 oland kernel: Code: 8b 00 85 c0 74 16 83 38 02 74 08 ff 
80 c0 00 00 00 eb 09 31

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          http://www.winischhofer.net/

