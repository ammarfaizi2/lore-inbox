Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVKRXBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVKRXBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 18:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVKRXBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 18:01:07 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:5793 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751087AbVKRXBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 18:01:06 -0500
Date: Fri, 18 Nov 2005 23:37:44 +0100
Message-Id: <200511182237.jAIMbi8N030215@erigona.fi.muni.cz>
From: Jiri Slaby <jirislaby@gmail.com>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.15-rc1-mm2 breaks strace
In-reply-to: <200511182240.34512.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer wrote:
>2.6.15-rc1-mm2 works nicely here, aside from the artsd stuff someone else 
>already reported, and an new issue with strace (last known working: 
>2.6.14-mm2)
I think, that the problem emerged in rc1-mm1, there are some changes in ptrace.c
(2.6.14-mm2 works fine for me).
>
>[bero@localhost bero]$ strace ls
>execve("/bin/ls", ["ls"], [/* 33 vars */]) = 0
>Segmentation fault
>[ls output without any traces beyond execve-ing ls displayed here]
>
>Also interesting:
>[bero@localhost bero]$ strace strace ls
>execve("/usr/bin/strace", ["strace", "ls"], [/* 20 vars */]) = 0
>Segmentation fault
>execve("/bin/ls", ["ls"], [/* 20 vars */]) = 0
>[ls output without any traces displayed here]

And I have this in logs:

Unable to handle kernel NULL pointer dereference at virtual address 00000010 printing eip:
c0125a25
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
last sysfs file: /devices/platform/i2c-9191/9191-0290/temp3_input
Modules linked in: usblp it87 hwmon_vid i2c_isa sunrpc ipv6 video ohci1394 ieee1394 emu10k1_gp gameport ide_cd cdrom
CPU:    0
EIP:    0060:[<c0125a25>]    Not tainted VLI
EFLAGS: 00210206   (2.6.15-rc1-mm2) 
EIP is at ptrace_check_attach+0x19/0xb8
eax: 00ffffff   ebx: 00000000   ecx: c5ea0b3c   edx: c5ea0b38
esi: 00000000   edi: 00000000   ebp: c6106f90   esp: c6106f80
ds: 007b   es: 007b   ss: 0068
Process strace (pid: 23486, threadinfo=c6106000 task=c17ba550)
Stack: c01262dc 00000000 00000000 00000018 c6106fb4 c0126344 00000000 00000000 
       00000000 c6106fbc 00000018 00000000 5000cff4 c6106000 c0102e15 00000018 
       00005bbf 00000001 00000000 5000cff4 bf8ced48 ffffffda 0000007b c010007b 
Call Trace:
 [<c0103c82>] show_stack+0x9a/0xd0
 [<c0103e42>] show_registers+0x16a/0x1fa
 [<c010407c>] die+0x123/0x1ae
 [<c03c3b3c>] do_page_fault+0x33c/0x66e
 [<c010393b>] error_code+0x4f/0x54
 [<c0126344>] sys_ptrace+0x5a/0xcf
 [<c0102e15>] syscall_call+0x7/0xb
Code: cc ba 42 c0 c7 43 68 c8 ba 42 c0 89 50 04 89 02 eb a4 55 89 e5 57 56 53 83 ec 04 8b 75 08 8b 7d 0c b8 00 2d 4c c0 e8 16 d5 29 00 <8b> 56 10 f6 c2 01 75 25 bb fd ff ff ff b8 00 2d 4c c0 e8 65 d7 
 <3>BUG: strace[23486] exited with nonzero preempt_count 1!

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
