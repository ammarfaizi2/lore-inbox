Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130200AbQLLFjM>; Tue, 12 Dec 2000 00:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130999AbQLLFjD>; Tue, 12 Dec 2000 00:39:03 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:33291 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130200AbQLLFiq>; Tue, 12 Dec 2000 00:38:46 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14901.45762.767170.48949@wire.cadcamlab.org>
Date: Mon, 11 Dec 2000 23:08:18 -0600 (CST)
To: linux-kernel@vger.kernel.org
CC: linux-lvm@msede.com
Subject: OOPS on test12pre8: vgcreate with /dev/md0 as PV
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- test12pre8, i586, 128MB, narrow aha2940 (aic7xxx, no tag queueing)
----- LVM (0.8final) and MD RAID5 compiled in


I was experimenting with LVM over MD (I thought this was supposed to
work but had never tried it).

  # mkraid /dev/md0           (ok)
  # pvcreate /dev/md0         (ok)
  # vgcreate vgraid /dev/md0  (oopsed, now vgcreate is hung in 'D' state)

md0 is RAID 5 with 3x3GB scsi partitions.  It was still doing the
initial sync when I ran vgcreate.  (Is it bad to use a RAID partition
while it is syncing?)  It is still syncing, but much slower than
before.

I do at least somewhat suspect the RAM on this box.

Peter




ksymoops 2.3.4 on i586 2.4.0-test12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /boot/System.map-2.4.0-test12 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

invalid operand: 0000
CPU:    0
EIP:    0010:[<c012cac2>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001c   ebx: c7dc36c8   ecx: 00000000   edx: 00000000
esi: c600d960   edi: c600d800   ebp: c7dc3680   esp: c5ee9e98
ds: 0018   es: 0018   ss: 0018
Process raid5d (pid: 361, stackpage=c5ee9000)
Stack: c01f3b14 c01f3dfa 000002fd 00000008 c01af0d8 c7dc3680 00000001 00000008
       c600d800 00000002 00000000 c01afbff c600d800 00000002 00000001 c600d800
       c600d800 00000003 c77dd9a0 00000003 c5c68000 c01b0755 c600d800 c600d800
Call Trace: [<c01f3b14>] [<c01f3dfa>] [<c01af0d8>] [<c01afbff>] [<c01b0755>] [<c0198870>] [<c017a709>]
       [<c0113476>] [<c01b0c66>] [<c01aa0cd>] [<c010762c>]
Code: 0f 0b 83 c4 0c 5b c3 8d 76 00 55 57 56 53 8b 74 24 14 8b 54

>>EIP; c012cac2 <end_buffer_io_bad+52/5c>   <=====
Trace; c01f3b14 <tvecs+35e0/ea18>
Trace; c01f3dfa <tvecs+38c6/ea18>
Trace; c01af0d8 <raid5_end_buffer_io+44/84>
Trace; c01afbff <complete_stripe+97/110>
Trace; c01b0755 <handle_stripe+149/404>
Trace; c0198870 <aic7xxx_queue+140/14c>
Trace; c017a709 <scsi_dispatch_cmd+10d/150>
Trace; c0113476 <schedule+26a/394>
Trace; c01b0c66 <raid5d+86/c8>
Trace; c01aa0cd <md_thread+f9/194>
Trace; c010762c <kernel_thread+28/38>
Code;  c012cac2 <end_buffer_io_bad+52/5c>
00000000 <_EIP>:
Code;  c012cac2 <end_buffer_io_bad+52/5c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012cac4 <end_buffer_io_bad+54/5c>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012cac7 <end_buffer_io_bad+57/5c>
   5:   5b                        pop    %ebx
Code;  c012cac8 <end_buffer_io_bad+58/5c>
   6:   c3                        ret    
Code;  c012cac9 <end_buffer_io_bad+59/5c>
   7:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c012cacc <end_buffer_io_async+0/f4>
   a:   55                        push   %ebp
Code;  c012cacd <end_buffer_io_async+1/f4>
   b:   57                        push   %edi
Code;  c012cace <end_buffer_io_async+2/f4>
   c:   56                        push   %esi
Code;  c012cacf <end_buffer_io_async+3/f4>
   d:   53                        push   %ebx
Code;  c012cad0 <end_buffer_io_async+4/f4>
   e:   8b 74 24 14               mov    0x14(%esp,1),%esi
Code;  c012cad4 <end_buffer_io_async+8/f4>
  12:   8b 54 00 00               mov    0x0(%eax,%eax,1),%edx


1 warning issued.  Results may not be reliable.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
