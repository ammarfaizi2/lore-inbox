Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312745AbSCVQPk>; Fri, 22 Mar 2002 11:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312746AbSCVQPa>; Fri, 22 Mar 2002 11:15:30 -0500
Received: from barn.holstein.com ([198.134.143.193]:33799 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S312745AbSCVQPS>;
	Fri, 22 Mar 2002 11:15:18 -0500
Date: Fri, 22 Mar 2002 11:13:53 -0500
Message-Id: <200203221613.g2MGDrH01448@pcx6212.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: linux-kernel@vger.kernel.org
Subject: ide-cd oops in 2.4.19-pre3-ac5
Reply-To: troy@holstein.com
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 03/22/2002 11:13:54 AM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 03/22/2002 11:13:55 AM,
	Serialize complete at 03/22/2002 11:13:55 AM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got an oops trying to load ide-cd, which is 
perpetually stuck on initialization:
here is the ksymoops output:
(ide-cd loaded as a module)
kernel BUG at ide-cd.c:790!
invalid operand: 0000
CPU:    0
EIP:    0010:[<d8f88951>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013246
eax: c1511160   ebx: c02f0100   ecx: 0880cd97   edx: 00000177
esi: 000001f4   edi: c8a2be34   ebp: d8f89428   esp: c8a2bc50
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 1252, stackpage=c8a2b000)
Stack: c02f0100 cbf4c200 00000000 d8f89428 00800363 d8f89454 c02f0100 c8a2be1c 
       d8f89260 d8f888a5 c02f0100 c02f0100 cbf4c200 c8a2bd6c 00000000 00000190 
       d8f8949b c02f0100 00000018 d8f89428 d8f899d8 c02f0100 00000000 c02f0100 
Call Trace: [<d8f89428>] [<d8f89454>] [<d8f89260>] [<d8f888a5>] [<d8f8949b>] 
   [<d8f89428>] [<d8f899d8>] [<c01c6032>] [<c01c6349>] [<c01c691a>] [<d8f89513>] 
   [<c012a7a4>] [<c012e8fe>] [<d8f8a39f>] [<d8f8e740>] [<d8f817ee>] [<d8f8e1b9>] 
   [<d8f8e740>] [<d8f8aa9b>] [<d8f8e350>] [<d8f8ab0b>] [<d8f8e350>] [<d8f8b44c>] 
   [<d8f8b9b4>] [<c011476d>] [<d8f88060>] [<c0106e43>] [<c023002b>] 
Code: 0f 0b 16 03 62 dd f8 d8 68 2c 87 f8 d8 56 8b 44 24 28 50 53 

>>EIP; d8f88951 <[ide-cd]cdrom_transfer_packet_command+71/a4>   <=====
Trace; d8f89428 <[ide-cd]cdrom_do_pc_continuation+0/30>
Trace; d8f89454 <[ide-cd]cdrom_do_pc_continuation+2c/30>
Trace; d8f89260 <[ide-cd]cdrom_pc_intr+0/1c8>
Trace; d8f888a5 <[ide-cd]cdrom_start_packet_command+141/17c>
Trace; d8f8949b <[ide-cd]cdrom_do_packet_command+43/48>
Trace; d8f89428 <[ide-cd]cdrom_do_pc_continuation+0/30>
Trace; d8f899d8 <[ide-cd]ide_do_rw_cdrom+108/144>
Trace; c01c6032 <start_request+1a2/1fc>
Trace; c01c6349 <ide_do_request+27d/2c8>
Trace; c01c691a <ide_do_drive_cmd+ee/120>
Trace; d8f89513 <[ide-cd]cdrom_queue_packet_command+4f/b4>
Trace; c012a7a4 <__alloc_pages+64/2b0>
Trace; c012e8fe <page_add_rmap+2a/40>
Trace; d8f8a39f <[ide-cd]ide_cdrom_packet+6b/78>
Trace; d8f8e740 <[ide-cd]ide_cdrom_dops+0/40>
Trace; d8f817ee <[cdrom]cdrom_mode_sense+5a/64>
Trace; d8f8e1b9 <[ide-cd]sense_data_texts+21e1/25a7>
Trace; d8f8e740 <[ide-cd]ide_cdrom_dops+0/40>
Trace; d8f8aa9b <[ide-cd]ide_cdrom_get_capabilities+9f/b4>
Trace; d8f8e350 <[ide-cd]sense_data_texts+2378/25a7>
Trace; d8f8ab0b <[ide-cd]ide_cdrom_probe_capabilities+5b/44c>
Trace; d8f8e350 <[ide-cd]sense_data_texts+2378/25a7>
Trace; d8f8b44c <[ide-cd]ide_cdrom_setup+468/4e4>
Trace; d8f8b9b4 <[ide-cd]init_module+f0/19b>
Trace; c011476d <sys_init_module+505/5a8>
Trace; d8f88060 <[ide-cd]__module_license+0/0>
Trace; c0106e43 <system_call+33/38>
Trace; c023002b <rwsem_wake+1843/1e64>
Code;  d8f88951 <[ide-cd]cdrom_transfer_packet_command+71/a4>
00000000 <_EIP>:
Code;  d8f88951 <[ide-cd]cdrom_transfer_packet_command+71/a4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  d8f88953 <[ide-cd]cdrom_transfer_packet_command+73/a4>
   2:   16                        push   %ss
Code;  d8f88954 <[ide-cd]cdrom_transfer_packet_command+74/a4>
   3:   03 62 dd                  add    0xffffffdd(%edx),%esp
Code;  d8f88957 <[ide-cd]cdrom_transfer_packet_command+77/a4>
   6:   f8                        clc    
Code;  d8f88958 <[ide-cd]cdrom_transfer_packet_command+78/a4>
   7:   d8 68 2c                  fsubrs 0x2c(%eax)
Code;  d8f8895b <[ide-cd]cdrom_transfer_packet_command+7b/a4>
   a:   87 f8                     xchg   %edi,%eax
Code;  d8f8895d <[ide-cd]cdrom_transfer_packet_command+7d/a4>
   c:   d8 56 8b                  fcoms  0xffffff8b(%esi)
Code;  d8f88960 <[ide-cd]cdrom_transfer_packet_command+80/a4>
   f:   44                        inc    %esp
Code;  d8f88961 <[ide-cd]cdrom_transfer_packet_command+81/a4>
  10:   24 28                     and    $0x28,%al
Code;  d8f88963 <[ide-cd]cdrom_transfer_packet_command+83/a4>
  12:   50                        push   %eax
Code;  d8f88964 <[ide-cd]cdrom_transfer_packet_command+84/a4>
  13:   53                        push   %ebx


