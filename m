Return-Path: <linux-kernel-owner+w=401wt.eu-S1750932AbWLXLvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWLXLvX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 06:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWLXLvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 06:51:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:42249 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbWLXLvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 06:51:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=f7ejTXvCOxZXw2V4c4/OI9RksNcldT3OFZpv07Yl7KZbbGiWLBRbrZf+MlX9fxhMFzbczc0Cb2h6BNRAJ6VHLb+uh76AHt2m48oqU92zAUseTPhDKELMVA8XVdwYUbK34X3lF2A8MejWhEFRmA58iLp6ljAdORjfwwPODljowJI=
Message-ID: <458E69CB.6000107@gmail.com>
Date: Sun, 24 Dec 2006 12:51:16 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: Re: ptrace() memory corruption?
References: <20061223234305.GA1809@elf.ucw.cz> <20061223235501.GA1740@elf.ucw.cz> <20061224000150.GA1812@elf.ucw.cz> <20061224000605.GA1768@elf.ucw.cz> <20061224000753.GA1811@elf.ucw.cz> <458DD459.2030209@gmail.com>
In-Reply-To: <458DD459.2030209@gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Pavel Machek wrote:
>>> Is there something wrong with gdb?
>> Yep. If I do gdb /bin/bash, run; I'll get similar oops. Am I alone
>> seeing this?
> 
> Nope, I have this nasty thing here too and will post oopses in the afternoon,
> just before Jezisek comes :).

Ok, I captured this through netconosle:
[    8.499155] usb 3-2: new low speed USB device using uhci_hcd and address 2
[    8.721946] usb 3-2: new device found, idVendor=045e, idProduct=00f0
[    8.722016] usb 3-2: new device strings: Mfr=1, Product=2, SerialNumber=0
[    8.722081] usb 3-2: Product: Microsoft � Laser Mouse 6000
[    8.722145] usb 3-2: Manufacturer: Microsoft Corporation
[    8.722344] usb 3-2: configuration #1 chosen from 1 choice
[    8.753100] input: Microsoft Corporation Microsoft � Laser Mouse 6000 as
/class/input/input4
[    8.753310] input: USB HID v1.11 Mouse [Microsoft Corporation Microsoft �
Laser Mouse 6000] on usb-0000:00:1d.1-2
[   58.672510] WARNING (!__warned) at /home/l/latest/xxx/kernel/softirq.c:137
local_bh_enable()
[   58.672562]  [<c0103f1b>] show_trace_log_lvl+0x1a/0x30
[   58.672682]  [<c01045d5>] show_trace+0x12/0x14
[   58.672787]  [<c010465c>] dump_stack+0x16/0x18
[   58.672893]  [<c0126ccc>] local_bh_enable+0x8c/0x9b
[   58.672998]  [<c030a499>] lock_sock_nested+0xa3/0xab
[   58.673107]  [<c03080e1>] sock_fasync+0x3e/0x145
[   58.673216]  [<c0309056>] sock_close+0x19/0x3d
[   58.673322]  [<c0165baf>] __fput+0xa6/0x161
[   58.673432]  [<c0165e25>] fput+0x22/0x3b
[   58.673538]  [<c016358a>] filp_close+0x41/0x67
[   58.673646]  [<c01645f3>] sys_close+0x67/0xaf
[   58.673753]  [<c0102fe4>] syscall_call+0x7/0xb
[   58.673855]  =======================
[   58.674091] ------------[ cut here ]------------
[   58.674158] kernel BUG at /home/l/latest/xxx/fs/buffer.c:1244!
[   58.674224] invalid opcode: 0000 [#1]
[   58.674286] SMP
[   58.674414] last sysfs file: /devices/platform/i2c-9191/9191-0290/fan3_min
[   58.674478] Modules linked in: eth1394 floppy ohci1394 ieee1394 ide_cd cdrom
[   58.674778] CPU:    1
[   58.674779] EIP:    0060:[<c0181fa0>]    Not tainted VLI
[   58.674780] EFLAGS: 00010046   (2.6.20-rc1-mm1 #207)
[   58.674971] EIP is at __find_get_block+0x165/0x171
[   58.675035] eax: 00000092   ebx: f78e6ec0   ecx: 00001000   edx: 00008025
[   58.675101] esi: 00000001   edi: 00001000   ebp: f76efc6c   esp: f76efc34
[   58.675166] ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0068
[   58.675232] Process bash (pid: 1595, ti=f76ee000 task=c1a40560 task.ti=f76ee000)
[   58.675297] Stack: c1b31ac0 f7df7e3c 0000003a c1b31bd0 f76efc74 c0181bb4
00000001 00000000
[   58.675693]        f7df7e3c f76efc74 c0181544 f78e6ec0 00000001 00001000
f76efc9c c0181fc2
[   58.676083]        f76efcb4 c0181eab 00008025 c1b31ac0 f74e5d40 f76efcb8
c01aa46a f78e6ec0
[   58.676476] Call Trace:
[   58.676594]  [<c0103f1b>] show_trace_log_lvl+0x1a/0x30
[   58.676692]  [<c0103fd6>] show_stack_log_lvl+0xa5/0xca
[   58.676789]  [<c01041ce>] show_registers+0x1d3/0x2b8
[   58.676887]  [<c01043d4>] die+0x121/0x243
[   58.676984]  [<c010456c>] do_trap+0x76/0x9c
[   58.677083]  [<c0104dcf>] do_invalid_op+0x97/0xa1
[   58.677181]  [<c038a7e4>] error_code+0x7c/0x84
[   58.677278]  [<c0181fc2>] __getblk+0x16/0x20a
[   58.677375]  [<c019ec64>] __ext3_get_inode_loc+0x139/0x332
[   58.677476]  [<c019ee71>] ext3_get_inode_loc+0x14/0x16
[   58.677575]  [<c019ee93>] ext3_reserve_inode_write+0x20/0x6c
[   58.677674]  [<c019eeff>] ext3_mark_inode_dirty+0x20/0x37
[   58.677772]  [<c01a1cd0>] ext3_dirty_inode+0x6b/0x6d
[   58.677871]  [<c017e7c4>] __mark_inode_dirty+0x2a/0x170
[   58.677969]  [<c0176d3c>] touch_atime+0xb4/0xe8
[   58.678067]  [<c016ce4d>] __link_path_walk+0x91e/0xcb6
[   58.678164]  [<c016d22b>] link_path_walk+0x46/0xc3
[   58.678262]  [<c016d46f>] do_path_lookup+0x86/0x1b0
[   58.678359]  [<c016df00>] __path_lookup_intent_open+0x44/0x7f
[   58.678457]  [<c016dfb3>] path_lookup_open+0x21/0x27
[   58.678555]  [<c016e088>] open_namei+0x62/0x5cb
[   58.678653]  [<c01638d2>] do_filp_open+0x26/0x43
[   58.678750]  [<c0163930>] do_sys_open+0x41/0xca
[   58.678847]  [<c01639f1>] sys_open+0x1c/0x1e
[   58.678943]  [<c0102fe4>] syscall_call+0x7/0xb
[   58.679040]  =======================
[   58.679101] Code: 45 d0 e8 b6 f5 ff ff e9 22 ff ff ff 89 d8 e8 aa f5 ff ff eb
8c 89 ce 8d 4e ff 8b 04 8f 89 04 b7 85 c9 75 f1 89 1f e9 f6 fe ff ff <0f> 0b eb
fe 0f 0b eb fe 0f 0b eb fe 55 89 e5 57 56 53 83 ec 1c
[   58.681386] EIP: [<c0181fa0>] __find_get_block+0x165/0x171 SS:ESP 0068:f76efc34
[   58.681545]

after gdb /bin/bash
(gdb) run

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
