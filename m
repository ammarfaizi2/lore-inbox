Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264839AbTFLSX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbTFLSX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:23:58 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:45323 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S264839AbTFLSXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:23:55 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Thu, 12 Jun 2003 20:37:40 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: 2.4.21-rc8-acpi-20030522 reiserfs crash
Message-ID: <Pine.OSF.4.51.0306122019060.306698@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  when trying to stress my laptop and trigger the ECC circuity error caused
by hdparm turning on DMA under possibly higher load, I did the following:

$ find / -type f | xargs cp {} /dev/null

and in the meantime I did :

# hdparm -d1 /dev/discs/disc0/disc

dmesg shows:

vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1640908 1640914 0x0 SD]
end_request: I/O error, dev 03:02 (hda), sector 45609280
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1640908 1640963 0x0 SD]
end_request: I/O error, dev 03:02 (hda), sector 45610896
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1640908 1640912 0x0 SD]
end_request: I/O error, dev 03:02 (hda), sector 45610896
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1640908 1640910 0x0 SD]
end_request: I/O error, dev 03:02 (hda), sector 45609280
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1640908 1641433 0x0 SD]
end_request: I/O error, dev 03:02 (hda), sector 45610896
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1640905 1990020 0x0 SD]
end_request: I/O error, dev 03:02 (hda), sector 45610896
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1640905 1990028 0x0 SD]
end_request: I/O error, dev 03:02 (hda), sector 45610896
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1640905 1990033 0x0 SD]
end_request: I/O error, dev 03:02 (hda), sector 45610896
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [1640905 1990041 0x0 SD]
end_request: I/O error, dev 03:02 (hda), sector 56512
end_request: I/O error, dev 03:02 (hda), sector 56520
end_request: I/O error, dev 03:02 (hda), sector 56528
end_request: I/O error, dev 03:02 (hda), sector 56536
end_request: I/O error, dev 03:02 (hda), sector 56544
end_request: I/O error, dev 03:02 (hda), sector 56552
journal-601, buffer write failed
kernel BUG at prints.c:334!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01c4be8>]    Not tainted
EFLAGS: 00010282
eax: 00000024   ebx: f7e06c00   ecx: f7594000   edx: f6460074
esi: 00000000   edi: 00000006   ebp: f7e06c00   esp: f7e8fec0
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 6, stackpage=f7e8f000)
Stack: c0340fce c0425dc0 00000006 fa871650 c01cff2a f7e06c00 c0353ca0 00001000
       f636eb80 00000009 00000007 00000000 f636e880 00000000 00000015 f6d8b000
       00000004 c01d4041 f7e06c00 fa871650 00000001 00000006 fa87a1bc 00000004
Call Trace:    [<c01cff2a>] [<c01d4041>] [<c01d3205>] [<c01c1a00>] [<c013efcb>]
  [<c013e49c>] [<c013e7a1>] [<c0105000>] [<c0105000>] [<c01057be>] [<c013e6d0>]

Code: 0f 0b 4e 01 da 54 34 c0 85 db 74 0e 0f b7 43 08 89 04 24 e8


# vim cr
-bash: vim: command not found
# vi cr
-bash: vi: command not found
# id
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),11(floppy),20(dialout),26(tape),27(video)
# bash
# vim cr
bash: vim: command not found
# df
bash: /bin/df: Input/output error
# ls
336_LIST.TXT      asus                                       rp8_irix_mips_65_cs1.bin
[...]

The laptop is unusable now, I cannot get another xterm etc. When I close
remote ssh sessions to use existing shells running in xterms, and do "ls",
I get permission denied. I had to reset, not ctrl+alt+1, ctrl+alt+backspace
etc.
i
After reboot, I resolved the trace as:

ksymoops -o /lib/modules/2.4.21-rc-8 -m /usr/src/linux-2.4.21-rc8-acpi-20030523/System.map --no-lsmod --no-ksyms cr
ksymoops 2.4.9 on i686 2.4.21-rc8.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.21-rc-8 (specified)
     -m /usr/src/linux-2.4.21-rc8-acpi-20030523/System.map (specified)

No modules in ksyms, skipping objects
kernel BUG at prints.c:334!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01c4be8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000024   ebx: f7e06c00   ecx: f7594000   edx: f6460074
esi: 00000000   edi: 00000006   ebp: f7e06c00   esp: f7e8fec0
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 6, stackpage=f7e8f000)
Stack: c0340fce c0425dc0 00000006 fa871650 c01cff2a f7e06c00 c0353ca0 00001000
       f636eb80 00000009 00000007 00000000 f636e880 00000000 00000015 f6d8b000
       00000004 c01d4041 f7e06c00 fa871650 00000001 00000006 fa87a1bc 00000004
Call Trace:    [<c01cff2a>] [<c01d4041>] [<c01d3205>] [<c01c1a00>] [<c013efcb>]
  [<c013e49c>] [<c013e7a1>] [<c0105000>] [<c0105000>] [<c01057be>] [<c013e6d0>]
Code: 0f 0b 4e 01 da 54 34 c0 85 db 74 0e 0f b7 43 08 89 04 24 e8


>>EIP; c01c4be8 <reiserfs_panic+38/70>   <=====

Trace; c01cff2a <flush_commit_list+2da/460>
Trace; c01d4041 <do_journal_end+671/b90>
Trace; c01d3205 <flush_old_commits+125/1b0>
Trace; c01c1a00 <reiserfs_write_super+30/40>
Trace; c013efcb <sync_supers+bb/140>
Trace; c013e49c <sync_old_buffers+1c/50>
Trace; c013e7a1 <kupdate+d1/100>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c01057be <arch_kernel_thread+2e/40>
Trace; c013e6d0 <kupdate+0/100>

Code;  c01c4be8 <reiserfs_panic+38/70>
00000000 <_EIP>:
Code;  c01c4be8 <reiserfs_panic+38/70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01c4bea <reiserfs_panic+3a/70>
   2:   4e                        dec    %esi
Code;  c01c4beb <reiserfs_panic+3b/70>
   3:   01 da                     add    %ebx,%edx
Code;  c01c4bed <reiserfs_panic+3d/70>
   5:   54                        push   %esp
Code;  c01c4bee <reiserfs_panic+3e/70>
   6:   34 c0                     xor    $0xc0,%al
Code;  c01c4bf0 <reiserfs_panic+40/70>
   8:   85 db                     test   %ebx,%ebx
Code;  c01c4bf2 <reiserfs_panic+42/70>
   a:   74 0e                     je     1a <_EIP+0x1a>
Code;  c01c4bf4 <reiserfs_panic+44/70>
   c:   0f b7 43 08               movzwl 0x8(%ebx),%eax
Code;  c01c4bf8 <reiserfs_panic+48/70>
  10:   89 04 24                  mov    %eax,(%esp,1)
Code;  c01c4bfb <reiserfs_panic+4b/70>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>


I tried to reproduce again with same trick, but got:

hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hda: status timeout: status=0xd0 { Busy }

hda: DMA disabled
hda: drive not ready for command
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
ide0: reset: success

But sometimes I get:

hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hda: status timeout: status=0xd0 { Busy }

hda: DMA disabled
hda: drive not ready for command
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
DataRequest }
hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hda: set_drive_speed_status: error=0x04 { DriveStatusError }
ide0: reset: master: ECC circuitry error


-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
