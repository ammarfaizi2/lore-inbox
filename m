Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267879AbUIADc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267879AbUIADc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 23:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUIADc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 23:32:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1963 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267879AbUIADc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 23:32:56 -0400
Date: Tue, 31 Aug 2004 20:32:55 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Oops in percpu_modalloc in 2.6.9-rc1-mm1
Message-Id: <20040831203255.0d3e2883@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an oops on boot, happens every time when iptables-restore is run:

Linux version 2.6.9-rc1-mm1-ub (zaitcev@lembas) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 SMP Tue Aug 31 19:07:35 PDT 2004
.........
ip_tables: (C) 2000-2002 Netfilter core team
------------[ cut here ]------------
kernel BUG at kernel/module.c:264!
invalid operand: 0000 [#1]
SMP 
Modules linked in: iptable_filter ip_tables ide_cd cdrom sg scsi_mod microcode uhci_hcd usbcore thermal processor fan button battery asus_acpi ac rtc
CPU:    0
EIP:    0060:[<c013b495>]    Not tainted VLI
EFLAGS: 00010202   (2.6.9-rc1-mm1-ub) 
EIP is at percpu_modalloc+0x115/0x130
eax: 0000003c   ebx: e08fe000   ecx: 00000017   edx: 00000020
esi: 00000017   edi: 00000398   ebp: 00000000   esp: decb3ef8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2004, threadinfo=decb2000 task=df5ed9b0)
Stack: 0807a218 00000001 e08fe000 00000017 00000398 00000000 c013d344 0000003c 
       00000020 c1673430 00000292 c014b53f dffab980 c1673430 00000292 00000000 
       dfcef8b4 00000000 e0904f20 00000017 00000000 00000000 00000000 00000011 
Call Trace:
 [<c013d344>] load_module+0x3f4/0xa50
 [<c014b53f>] kmem_cache_free+0x2f/0x70
 [<c013da0a>] sys_init_module+0x6a/0x260
 [<c0155e54>] sys_munmap+0x34/0x50
 [<c01050b9>] sysenter_past_esp+0x52/0x79
Code: 59 74 a4 8b 35 94 d7 3e c0 eb d9 29 c8 eb b5 8d b4 26 00 00 00 00 85 c9 0f 84 51 ff ff ff 0f 0b 0e 01 2d de 30 c0 e9 44 ff ff ff <0f> 0b 08 01 2d de 30 c0 e9 f0 fe ff ff 8d b4 26 00 00 00 00 8d 

I'm not sure who may be interested, maybe Rusty? Or AKPM?
This didn't happen in linux-2.6.8.1-mm3, so it's new.

The name of the kernel ends in -ub, but it hasn't got any patches.
I was just about to look at an oops report in ub, rebuilt new kernel
and woops...

-- Pete
