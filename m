Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262738AbRE0EPq>; Sun, 27 May 2001 00:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262742AbRE0EP1>; Sun, 27 May 2001 00:15:27 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:31912 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S262738AbRE0EPL>; Sun, 27 May 2001 00:15:11 -0400
Date: Sat, 26 May 2001 21:14:48 -0700 (PDT)
From: Chris Rankin <rankinc@pacbell.net>
Subject: Linux-2.4.5, reiserfs, Oops!
To: linux-kernel@vger.kernel.org, reiser@namesys.com
Message-id: <200105270414.f4R4Emk01883@twopit.underworld>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL3]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.5, SMP, devfs, < 1 GB memory, compiled with gcc-2.95.3


Hi,
I have just experimented with using reiserfs; since I didn't have a
hard disc partition free I used a 250MB Zip disc instead with my USB
drive. I didn't do anything clever with parameters or anything; just
"mkreisferfs /dev/sda1", mounted it and then unmounted it again. And
the kernel oopsed on me.

The kernel log says:
May 26 20:49:53 twopit kernel: SCSI subsystem driver Revision: 1.00
May 26 20:49:53 twopit kernel: scsi: host order: usb-storage-0:ide-scsi:ppa
May 26 20:49:53 twopit kernel: Initializing USB Mass Storage driver...
May 26 20:49:53 twopit kernel: usb.c: registered new driver usb-storage
May 26 20:49:53 twopit kernel: scsi0 : SCSI emulation for USB Mass Storage devices
May 26 20:49:53 twopit kernel:   Vendor: IOMEGA    Model: ZIP 250           Rev: 31.G
May 26 20:49:53 twopit kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
May 26 20:49:53 twopit kernel: Detected scsi removable disk sda at scsi0, channel 0, id 0, lun 0
May 26 20:49:55 twopit kernel: SCSI device sda: 489532 512-byte hdwr sectors (251 MB)
May 26 20:49:55 twopit kernel: sda: Write Protect is off
May 26 20:49:56 twopit kernel:  /dev/scsi/host0/bus0/target0/lun0: p1
May 26 20:49:56 twopit kernel: WARNING: USB Mass Storage data integrity not assured
May 26 20:49:56 twopit kernel: USB Mass Storage device found at 2
May 26 20:49:56 twopit kernel: USB Mass Storage support registered.
May 26 20:51:15 twopit kernel: reiserfs: checking transaction log (device 08:01) ...
May 26 20:52:48 twopit kernel: Using r5 hash to sort names
May 26 20:52:48 twopit kernel: ReiserFS version 3.6.25
May 26 20:58:45 twopit kernel: journal_begin called without kernel lock held
May 26 20:58:45 twopit kernel: kernel BUG at journal.c:423!
May 26 20:58:45 twopit kernel: invalid operand: 0000
May 26 20:58:45 twopit kernel: CPU:    1
May 26 20:58:45 twopit kernel: EIP:    0010:[<d299a3b0>]
May 26 20:58:45 twopit kernel: EFLAGS: 00010286
May 26 20:58:45 twopit kernel: eax: 0000001d   ebx: c8f21f2c   ecx: c155c000   edx: 00000001
May 26 20:58:45 twopit kernel: esi: cc4eea00   edi: c8f21f2c   ebp: 0000000a   esp: c8f21ec4
May 26 20:58:45 twopit kernel: ds: 0018   es: 0018   ss: 0018
May 26 20:58:45 twopit kernel: Process umount (pid: 1809, stackpage=c8f21000)
May 26 20:58:45 twopit kernel: Stack: d29a40cf d29a4264 000001a7 d299c886 d29a5281 c8f21f2c cc4eea00 d29a6100 
... etc.

The translated oops looks like this:

ksymoops 2.4.1 on i686 2.4.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5/ (default)
     -m /boot/System.map-2.4.5 (specified)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
May 26 20:58:45 twopit kernel: kernel BUG at journal.c:423!
May 26 20:58:45 twopit kernel: invalid operand: 0000
May 26 20:58:45 twopit kernel: CPU:    1
May 26 20:58:45 twopit kernel: EIP:    0010:[<d299a3b0>]
Using defaults from ksymoops -t elf32-i386 -a i386
May 26 20:58:45 twopit kernel: EFLAGS: 00010286
May 26 20:58:45 twopit kernel: eax: 0000001d   ebx: c8f21f2c   ecx: c155c000   edx: 00000001
May 26 20:58:45 twopit kernel: esi: cc4eea00   edi: c8f21f2c   ebp: 0000000a   esp: c8f21ec4
May 26 20:58:45 twopit kernel: ds: 0018   es: 0018   ss: 0018
May 26 20:58:45 twopit kernel: Process umount (pid: 1809, stackpage=c8f21000)
May 26 20:58:45 twopit kernel: Stack: d29a40cf d29a4264 000001a7 d299c886 d29a5281 c8f21f2c cc4eea00 d29a6100 
May 26 20:58:45 twopit kernel:        cc4eea44 3b107b75 40119ca8 00000000 c9864464 ca79ebe0 4001b000 d299caaa 
May 26 20:58:45 twopit kernel:        c8f21f2c cc4eea00 0000000a 00000000 d298ed2c c8f21f2c cc4eea00 0000000a 
May 26 20:58:45 twopit kernel: Call Trace: [<d29a40cf>] [<d29a4264>] [<d299c886>] [<d29a5281>] [<d29a6100>] [<d299caaa>] [<d298ed2c>] 
May 26 20:58:45 twopit kernel:        [<d29a6100>] [kill_super+132/332] [kill_super+183/332] [<d29a6138>] [__mntput+80/88] [path_release+40/48] [sys_umount+289/328] [sys_munmap+54/84] 
May 26 20:58:45 twopit kernel: Code: 0f 0b 83 c4 0c c3 89 f6 31 c0 c3 90 31 c0 c3 90 56 53 31 db 

>>EIP; d299a3b0 <[reiserfs]reiserfs_check_lock_depth+38/40>   <=====
Trace; d29a40cf <[reiserfs].rodata.start+456f/643f>
Trace; d29a4264 <[reiserfs].rodata.start+4704/643f>
Trace; d299c886 <[reiserfs]do_journal_begin_r+26/218>
Trace; d29a5281 <[reiserfs].rodata.start+5721/643f>
Trace; d29a6100 <[reiserfs]reiserfs_sops+0/38>
Trace; d299caaa <[reiserfs]journal_begin+16/1c>
Trace; d298ed2c <[reiserfs]reiserfs_put_super+1c/e4>
Trace; d29a6100 <[reiserfs]reiserfs_sops+0/38>
Code;  d299a3b0 <[reiserfs]reiserfs_check_lock_depth+38/40>
00000000 <_EIP>:
Code;  d299a3b0 <[reiserfs]reiserfs_check_lock_depth+38/40>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  d299a3b2 <[reiserfs]reiserfs_check_lock_depth+3a/40>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  d299a3b5 <[reiserfs]reiserfs_check_lock_depth+3d/40>
   5:   c3                        ret    
Code;  d299a3b6 <[reiserfs]reiserfs_check_lock_depth+3e/40>
   6:   89 f6                     mov    %esi,%esi
Code;  d299a3b8 <[reiserfs]push_journal_writer+0/4>
   8:   31 c0                     xor    %eax,%eax
Code;  d299a3ba <[reiserfs]push_journal_writer+2/4>
   a:   c3                        ret    
Code;  d299a3bb <[reiserfs]push_journal_writer+3/4>
   b:   90                        nop    
Code;  d299a3bc <[reiserfs]pop_journal_writer+0/4>
   c:   31 c0                     xor    %eax,%eax
Code;  d299a3be <[reiserfs]pop_journal_writer+2/4>
   e:   c3                        ret    
Code;  d299a3bf <[reiserfs]pop_journal_writer+3/4>
   f:   90                        nop    
Code;  d299a3c0 <[reiserfs]dump_journal_writers+0/34>
  10:   56                        push   %esi
Code;  d299a3c1 <[reiserfs]dump_journal_writers+1/34>
  11:   53                        push   %ebx
Code;  d299a3c2 <[reiserfs]dump_journal_writers+2/34>
  12:   31 db                     xor    %ebx,%ebx


1 warning issued.  Results may not be reliable.
