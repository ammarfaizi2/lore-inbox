Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262559AbTCRTc2>; Tue, 18 Mar 2003 14:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262560AbTCRTc2>; Tue, 18 Mar 2003 14:32:28 -0500
Received: from [218.244.176.102] ([218.244.176.102]:17932 "EHLO
	wideinfo.com.cn") by vger.kernel.org with ESMTP id <S262559AbTCRTcX>;
	Tue, 18 Mar 2003 14:32:23 -0500
From: "Zhenghui Zhou" <zzh@wideinfo.com.cn>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM:<maybe 2.4.xx oops> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Date: Wed, 19 Mar 2003 03:44:59 +0800
Message-ID: <000001c2ed86$dc2d1da0$0e00a8c0@wideinfo.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Authenticated-Sender: zzh@wideinfo.com.cn
X-MDRemoteIP: 192.168.0.14
X-Return-Path: zzh@wideinfo.com.cn
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I runing a heavy stress on a linux system with kernel 2.4.20,
and I got error message "Segmentation Fault" now and again
when I load a new program to run. There are many running processes
in system, all of them are OK. Also any process which need load
file/program
from disk may meet the problem too, some show "(Core Dump)" or program
error.
The frequency got higher as the number of processes. But everyting seems
nice
in low weight.

It is a i686 system with 2 promise raid card and ide disks, I also
tested with
Kernel 2.4.18, and try load program from several different block device,
It presents the same result.

The command dmesg shows:
	Code: 8b 51 04 83 fa ff 0f 84 56 01 00 00 83 fa fc 77 07 c7 41
04
	 <1>Unable to handle kernel NULL pointer dereference at virtual
address 00000004
	 printing eip:
	dfd91718
	*pde = 00000000
	Oops: 0000
	CPU:    0
	EIP:    0010:[<dfd91718>]    Not tainted
	EFLAGS: 00010286
	eax: bffffae4   ebx: cff46000   ecx: 00000000   edx: cff46000
	esi: c0106c33   edi: 0000000b   ebp: cff47fb8   esp: cff47f84
	ds: 0018   es: 0018   ss: 0018
	Process more (pid: 20846, stackpage=cff47000)
	Stack: cff46000 c0106c33 0000000b 00000000 d3ef2000 0000000b
cff47fbc c0105987
     	  bffffae4 c01059a7 00000000 00000a3a 00000020 bffffa5c dfd918e8
00000000
	       00000000 00000000 00000000 00000000 00000000 00000000
00000000 0000002b
	Call Trace:    [<c0106c33>] [<c0105987>] [<c01059a7>]
	
	Code: 8b 51 04 83 fa ff 0f 84 56 01 00 00 83 fa fc 77 07 c7 41
04

I run ksymoops with correct specified vmlinux and System.map, the result
shows:

	Warning (compare_maps): ksyms_base symbol
default_idle_R__ver_default_idle not f
	ound in vmlinux.  Ignoring ksyms_base entry
	Warning (compare_maps): ksyms_base symbol
machine_real_restart_R__ver_machine_re
	al_restart not found in vmlinux.  Ignoring ksyms_base entry
	Reading Oops report from the terminal
	Code: 8b 51 04 83 fa ff 0f 84 56 01 00 00 83 fa fc 77 07 c7 41
04
	Using defaults from ksymoops -t elf32-i386 -a i386
	
	
	Code;  00000000 Before first symbol
	00000000 <_EIP>:
	Code;  00000000 Before first symbol
	   0:   8b 51 04                  mov    0x4(%ecx),%edx
	Code;  00000003 Before first symbol
	   3:   83 fa ff                  cmp    $0xffffffff,%edx
	Code;  00000006 Before first symbol
	   6:   0f 84 56 01 00 00         je     162 <_EIP+0x162>
00000162 Before first
	symbol
	Code;  0000000c Before first symbol
	   c:   83 fa fc                  cmp    $0xfffffffc,%edx
	Code;  0000000f Before first symbol
	   f:   77 07                     ja     18 <_EIP+0x18> 00000018
Before first sy
	mbol
	Code;  00000011 Before first symbol
	  11:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
	
	 <1>Unable to handle kernel NULL pointer dereference at virtual
address 00000004
	dfd91718
	*pde = 00000000
	Oops: 0000
	CPU:    0
	EIP:    0010:[<dfd91718>]    Not tainted
	EFLAGS: 00010286
	eax: bffffae4   ebx: cff46000   ecx: 00000000   edx: cff46000
	esi: c0106c33   edi: 0000000b   ebp: cff47fb8   esp: cff47f84
	ds: 0018   es: 0018   ss: 0018
	Process more (pid: 20846, stackpage=cff47000)
	Stack: cff46000 c0106c33 0000000b 00000000 d3ef2000 0000000b
cff47fbc c0105987
	       bffffae4 c01059a7 00000000 00000a3a 00000020 bffffa5c
dfd918e8 00000000
	       00000000 00000000 00000000 00000000 00000000 00000000
00000000 0000002b
	Call Trace:    [<c0106c33>] [<c0105987>] [<c01059a7>]
	Code: 8b 51 04 83 fa ff 0f 84 56 01 00 00 83 fa fc 77 07 c7 41
04
	
	
	>>EIP; dfd91718 <_end+1fb00020/205fa908>   <=====
	
	>>eax; bffffae4 Before first symbol
	>>ebx; cff46000 <_end+fcb4908/205fa908>
	>>edx; cff46000 <_end+fcb4908/205fa908>
	>>esi; c0106c33 <system_call+2f/34>
	>>ebp; cff47fb8 <_end+fcb68c0/205fa908>
	>>esp; cff47f84 <_end+fcb688c/205fa908>
	
	Trace; c0106c33 <system_call+2f/34>
	Trace; c0105987 <sys_execve+2f/60>
	Trace; c01059a7 <sys_execve+4f/60>
	
	Code;  dfd91718 <_end+1fb00020/205fa908>
	00000000 <_EIP>:
	Code;  dfd91718 <_end+1fb00020/205fa908>   <=====
	   0:   8b 51 04                  mov    0x4(%ecx),%edx   <=====
	Code;  dfd9171b <_end+1fb00023/205fa908>
	   3:   83 fa ff                  cmp    $0xffffffff,%edx
	Code;  dfd9171e <_end+1fb00026/205fa908>
	   6:   0f 84 56 01 00 00         je     162 <_EIP+0x162>
dfd9187a <_end+1fb0018
	2/205fa908>
	Code;  dfd91724 <_end+1fb0002c/205fa908>
	   c:   83 fa fc                  cmp    $0xfffffffc,%edx
	Code;  dfd91727 <_end+1fb0002f/205fa908>
	   f:   77 07                     ja     18 <_EIP+0x18> dfd91730
<_end+1fb00038/
	205fa908>
	Code;  dfd91729 <_end+1fb00031/205fa908>
	  11:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)

