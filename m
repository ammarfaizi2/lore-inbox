Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273729AbRI3QaY>; Sun, 30 Sep 2001 12:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273734AbRI3QaP>; Sun, 30 Sep 2001 12:30:15 -0400
Received: from dhcp065-024-024-040.columbus.rr.com ([65.24.24.40]:15876 "EHLO
	united.codewhore.org") by vger.kernel.org with ESMTP
	id <S273729AbRI3QaA>; Sun, 30 Sep 2001 12:30:00 -0400
Date: Sun, 30 Sep 2001 12:29:57 -0400
From: David Brown <dave@codewhore.org>
To: linux-kernel@vger.kernel.org
Subject: Reproducible Oops: 2.4.10 Initio SCSI driver (tul_alloc_scb)
Message-ID: <20010930122957.A25024@codewhore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi:


On a Domex 3194U pci ultra scsi card, i'm able to produce the oops below
with any fast read access to an attached yamaha 16/10/40 CD-RW (2100S).
`cat /dev/cdroms/cdrom0 > /dev/null` reproduces it quite well on a couple
of machines. It doesn't seem to show up when reading a mounted filesystem,
though.

The driver is for the Initio 9100 chip, in initio.o.


---
Unable to handle kernel paging request at virtual address 00e21200
c49a41ff
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c49a41ff>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: c249fa00   ebx: c49a6e60   ecx: 00000087   edx: 00e21200
esi: c2852800   edi: c49a6e60   ebp: c2852800   esp: c1b7fe6c
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 17830, stackpage=c1b7f000)
Stack: 00000246 c49a36d7 c49a6e60 00000246 c0782978 c249fa00 c4996531 c2852800
       c499af50 c2852800 c0782978 c2852904 c0782920 00000000 c499c59f c2852800
       c2852800 00000286 c1b7feec c1b7e000 c1b7ff14 c49be800 c249fa00 c1c45000
Call Trace: [<c49a36d7>] [<c49a6e60>] [<c4996531>] [<c499af50>] [<c499c59f>]
   [<c49be800>] [<c0180a64>] [<c0117bbc>] [<c013156e>] [<c01222b9>] [<c01222fe>]
   [<c0122811>] [<c0122ce5>] [<c0122c10>] [<c012da76>] [<c0106b0b>]
Code: 8b 02 89 43 38 85 c0 75 08 c7 43 3c 00 00 00 00 90 c7 02 00

>>EIP; c49a41fe <[initio]tul_alloc_scb+e/30>   <=====
Trace; c49a36d6 <[initio]i91u_queue+36/68>
Trace; c49a6e60 <[initio]tul_hcs+0/860>
Trace; c4996530 <[scsi_mod]__kstrtab_scsi_hostlist+a/18>
Trace; c499af50 <[scsi_mod]scsi_old_done+0/578>
Trace; c499c59e <[scsi_mod]scsi_request_fn+2c2/2f8>
Trace; c49be800 <[sr_mod]sr_template+0/0>
Trace; c0180a64 <generic_unplug_device+20/28>
Trace; c0117bbc <__run_task_queue+50/5c>^Z
Trace; c013156e <block_sync_page+16/1c>
Trace; c01222b8 <__lock_page+64/94>
Trace; c01222fe <lock_page+16/1c>
Trace; c0122810 <do_generic_file_read+2a4/4bc>
Trace; c0122ce4 <generic_file_read+80/19c>
Trace; c0122c10 <file_read_actor+0/54>
Trace; c012da76 <sys_read+96/cc>
Trace; c0106b0a <system_call+32/38>
Code;  c49a41fe <[initio]tul_alloc_scb+e/30>
0000000000000000 <_EIP>:
Code;  c49a41fe <[initio]tul_alloc_scb+e/30>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c49a4200 <[initio]tul_alloc_scb+10/30>
   2:   89 43 38                  mov    %eax,0x38(%ebx)
Code;  c49a4202 <[initio]tul_alloc_scb+12/30>
   5:   85 c0                     test   %eax,%eax
Code;  c49a4204 <[initio]tul_alloc_scb+14/30>
   7:   75 08                     jne    11 <_EIP+0x11> c49a420e <[initio]tul_alloc_scb+1e/30>
Code;  c49a4206 <[initio]tul_alloc_scb+16/30>
   9:   c7 43 3c 00 00 00 00      movl   $0x0,0x3c(%ebx)
Code;  c49a420e <[initio]tul_alloc_scb+1e/30>
  10:   90                        nop
Code;  c49a420e <[initio]tul_alloc_scb+1e/30>
  11:   c7 02 00 00 00 00         movl   $0x0,(%edx)
---


If anyone needs any further information, feel free to ask. :)


Thanks in advance,
- Dave
  dave@codewhore.org
