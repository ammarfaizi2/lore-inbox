Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279103AbRKMNsA>; Tue, 13 Nov 2001 08:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279113AbRKMNru>; Tue, 13 Nov 2001 08:47:50 -0500
Received: from alex.intersurf.net ([216.115.129.11]:51214 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S279103AbRKMNrl>; Tue, 13 Nov 2001 08:47:41 -0500
Date: Tue, 13 Nov 2001 07:47:38 -0600
From: Mark Orr <markorr@intersurf.com>
To: linux-kernel@vger.kernel.org
Subject: [oops]  SCSI / loop device / HFS crash in 2.4.15-pre4 (ksymoops output incl.)
Message-Id: <20011113074738.2a4faf96.markorr@intersurf.com>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just compiled 2.4.15pre4 (upgraded from -pre1aa1) and was
torture testing it.   I found a 100% repeatable crash - it
doesnt hang the system, but it leave the CDROM drive stuck.

What I was doing:  Since you cant mount Macintosh (HFS) formatted
CD's with SCSI cdrom drives,  I did as Alan Cox suggested and mounted
it through a loop device.   i.e.:

% losetup /dev/loop0 /dev/sr0
% mount -t hfs /dev/loop0 /cdrom

This mounted my HFS cdrom, and allowed me to do directory listings
and such.   But when I tried to read a file from that HFS CD, there
was a crash which left the CDROM drive and provess [scsi_eh_0] stuck.
(I was trying to read a textfile on the CD with "less")

Here's the ksymoops output:

ksymoops 2.4.3 on i586 2.4.15-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre4/ (default)
     -m /System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c183f535
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c183f535>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010212
eax: 00000008   ebx: 00000028   ecx: 00000002   edx: 00000004
esi: 00000000   edi: c0adbe54   ebp: c0adbe00   esp: c0c15d70
ds: 0018   es: 0018   ss: 0018
Process less (pid: 1571, stackpage=c0c15000)
Stack: 00000800 c04af600 00000000 00007a4d 00000001 00000000 c0adbe50 c0adb600
       c0adb200 00000800 00000400 c0adb000 c183f76d c04af600 00000800 c04af600
       c0715c50 c04af708 c0715c00 00000004 00000000 c181fa5d c04af600 00000282
Call Trace: [<c183f76d>] [<c181fa5d>] [<c1841e40>] [<c01657e4>] [<c01145c4>]
   [<c012a7c6>] [<c180ed4a>] [<c015e858>] [<c0110cb3>] [<c0160d55>] [<c0110cb3>]
   [<c0161448>] [<c0156b70>] [<c015295d>] [<c180e971>] [<c0129af6>] [<c0106b63>]
Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 8b 54 24 34 31 c0 66

>>EIP; c183f534 <[sr_mod]sr_scatter_pad+1d8/2f8>   <=====
Trace; c183f76c <[sr_mod]sr_init_command+118/26c>
Trace; c181fa5c <[scsi_mod]scsi_request_fn+260/2f8>
Trace; c1841e40 <[sr_mod]sr_template+0/0>
Trace; c01657e4 <generic_unplug_device+20/28>
Trace; c01145c4 <__run_task_queue+4c/60>
Trace; c012a7c6 <__wait_on_buffer+5a/90>
Trace; c180ed4a <[hfs]hfs_do_read+2ae/364>
Trace; c015e858 <lf+34/64>
Trace; c0110cb2 <release_console_sem+72/78>
Trace; c0160d54 <do_con_write+610/674>
Trace; c0110cb2 <release_console_sem+72/78>
Trace; c0161448 <con_flush_chars+2c/34>
Trace; c0156b70 <write_chan+1fc/214>
Trace; c015295c <tty_write+154/1c0>
Trace; c180e970 <[hfs]hfs_file_read+88/ac>
Trace; c0129af6 <sys_read+96/cc>
Trace; c0106b62 <system_call+32/40>
Code;  c183f534 <[sr_mod]sr_scatter_pad+1d8/2f8>
00000000 <_EIP>:
Code;  c183f534 <[sr_mod]sr_scatter_pad+1d8/2f8>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c183f536 <[sr_mod]sr_scatter_pad+1da/2f8>
   2:   a8 02                     test   $0x2,%al
Code;  c183f538 <[sr_mod]sr_scatter_pad+1dc/2f8>
   4:   74 02                     je     8 <_EIP+0x8> c183f53c <[sr_mod]sr_scatter_pad+1e0/2f8>
Code;  c183f53a <[sr_mod]sr_scatter_pad+1de/2f8>
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c183f53c <[sr_mod]sr_scatter_pad+1e0/2f8>
   8:   a8 01                     test   $0x1,%al
Code;  c183f53e <[sr_mod]sr_scatter_pad+1e2/2f8>
   a:   74 01                     je     d <_EIP+0xd> c183f540 <[sr_mod]sr_scatter_pad+1e4/2f8>
Code;  c183f540 <[sr_mod]sr_scatter_pad+1e4/2f8>
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c183f540 <[sr_mod]sr_scatter_pad+1e4/2f8>
   d:   8b 54 24 34               mov    0x34(%esp,1),%edx
Code;  c183f544 <[sr_mod]sr_scatter_pad+1e8/2f8>
  11:   31 c0                     xor    %eax,%eax
Code;  c183f546 <[sr_mod]sr_scatter_pad+1ea/2f8>
  13:   66                        data16


---
Mark Orr
markorr@intersurf.com


