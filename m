Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275759AbRJBB4r>; Mon, 1 Oct 2001 21:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275758AbRJBB4h>; Mon, 1 Oct 2001 21:56:37 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:40065 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S275757AbRJBB40>; Mon, 1 Oct 2001 21:56:26 -0400
Date: Mon, 1 Oct 2001 20:56:43 -0500
From: J Troy Piper <jtp@dok.org>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] when accessing ide-scsi emulated cd-rw
Message-ID: <20011001205643.C548@dok.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is a reproducible OOPS for me.  I mount the drive, cd into the 
directory which it is mounted in, attempt to 'ls' the dir.  On the first  
attempt to 'ls' I get: 

paranoia kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: Request Sense 00 00 00 40 00
paranoia kernel: Info fld=0x0, Current sd0b:00: sense key Medium Error
paranoia kernel:  I/O error: dev 0b:00, sector 96
paranoia kernel: scsi : aborting command due to timeout : pid 0, scsi1, channel 0, id 0, lun 0 Read (10) 00 00 00 00 18 00 00 01 00
paranoia kernel: hdd: timeout waiting for DMA
paranoia kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14

After waiting a second or so for the bus to reset, another 'ls' OOPSes the 
kernel.  I've inline attached the output of the oops I've run thru our 
friend ksymoops below.

The cd-r is an HP CD-Writer Plus (atapi with ide-scsi module).  I can burn 
CDs no problem, listen to music thru it no problem.  This OOPS only occurs 
when I try to use the drive to mount an iso9660 filesystem (ie. a data cd)

Thanks in advance for any help. 
---

/************************/
/*    J. Troy Piper     */
/*    <jtp@dok.org>     */
/* Ignotum per Ignotius */
/************************/


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=cdrw-ksymoops

ksymoops 2.4.3 on i586 2.4.10-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-ac3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtul address 00000178
*pde = 00000000
Oops: 0002
CPU:    2
EIP:    0010:[<c4c672f0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000000   ebx: c2c04d3c   ecx: 00000000   edx: c2c04d3c
esi: 00000000   edi: 000000d0   ebp: c1b7d000   esp: c02e7ed0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02e7000)
Stack: c2c04d3c c034f104 000000d0 c034ef90 00000000 c2c04d3c c0ceb514 c034f104
       c01c00a2 00000000 c11c158c c034f104 c11c158c c4c674c8 000000d0 c01c0c6c
       c034f104 c0287bc2 000000d0 c11c158c c01c0ae8 c031e5a0 00000000 00000292
Call Trace: [<c01c00a2>] [<c4c674c8>] [<c01c0c6c>] [<c01c0ae8>] [<c0117cf2>]
   [<c01175c6>] [<c0114932>] [<c0114869>] [<c011465a>] [<c01082bd>] [<c0105150>]
   [<c0105150>] [<c0105173>] [<c01051d7>] [<c0105000>] [<c0105027>]
Code: c7 80 78 01 00 00 00 00 07 00 83 7c 24 10 00 0f 84 6f 01 00

>>EIP; c4c672f0 <.bss.end+5492/????>   <=====
Trace; c01c00a2 <ide_system_bus_speed+42/6c>
Trace; c4c674c8 <.bss.end+566a/????>
Trace; c01c0c6c <ide_dump_status+21c/2d0>
Trace; c01c0ae8 <ide_dump_status+98/2d0>
Trace; c0117cf2 <timer_bh+be/288>
Trace; c01175c6 <add_timer+66/cc>
Trace; c0114932 <tasklet_kill+2e/64>
Trace; c0114868 <tasklet_hi_action+c/80>
Trace; c011465a <do_softirq+a/ac>
Trace; c01082bc <do_IRQ+9c/b0>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0105172 <default_idle+22/28>
Trace; c01051d6 <cpu_idle+3e/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105026 <rest_init+26/28>
Code;  c4c672f0 <.bss.end+5492/????>
0000000000000000 <_EIP>:
Code;  c4c672f0 <.bss.end+5492/????>   <=====
   0:   c7 80 78 01 00 00 00      movl   $0x70000,0x178(%eax)   <=====
Code;  c4c672f6 <.bss.end+5498/????>
   7:   00 07 00 
Code;  c4c672fa <.bss.end+549c/????>
   a:   83 7c 24 10 00            cmpl   $0x0,0x10(%esp,1)
Code;  c4c672fe <.bss.end+54a0/????>
   f:   0f 84 6f 01 00 00         je     184 <_EIP+0x184> c4c67474 <.bss.end+5616/????>

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

--gKMricLos+KVdGMg--
