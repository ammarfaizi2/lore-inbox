Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133062AbRDMCey>; Thu, 12 Apr 2001 22:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135388AbRDMCep>; Thu, 12 Apr 2001 22:34:45 -0400
Received: from 24.68.117.103.on.wave.home.com ([24.68.117.103]:128 "EHLO
	cs865114-a.amp.dhs.org") by vger.kernel.org with ESMTP
	id <S133062AbRDMCeb>; Thu, 12 Apr 2001 22:34:31 -0400
Date: Thu, 12 Apr 2001 22:34:31 -0400 (EDT)
From: Arthur Pedyczak <arthur-p@home.com>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: BUG at exit.c:458
Message-ID: <Pine.LNX.4.33.0104122229240.1230-100000@cs865114-a.amp.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
After running 2.4.3 for 9 days my system froze when copying a cd
(dd if=/dev/cdrom of=file)

After rebooting I found the following in the syslog:
=======================================================

Apr 12 22:05:28 cs865114-a kernel: Unable to handle kernel paging request at virtual address a95af80d
Apr 12 22:05:28 cs865114-a kernel:  printing eip:
Apr 12 22:05:28 cs865114-a kernel: c01433b6
Apr 12 22:05:28 cs865114-a kernel: *pde = 00000000
Apr 12 22:05:28 cs865114-a kernel: Oops: 0000
Apr 12 22:05:28 cs865114-a kernel: CPU:    0
Apr 12 22:05:28 cs865114-a kernel: EIP:    0010:[iput+38/336]
Apr 12 22:05:28 cs865114-a kernel: EFLAGS: 00210282
Apr 12 22:05:28 cs865114-a kernel: eax: a95af7fd   ebx: d2b12400   ecx: d2b12410   edx: d2b12410
Apr 12 22:05:28 cs865114-a kernel: esi: a95af7fd   edi: d2b12400   ebp: 00003470   esp: d7fe7f64
Apr 12 22:05:28 cs865114-a kernel: ds: 0018   es: 0018   ss: 0018
Apr 12 22:05:28 cs865114-a kernel: Process kswapd (pid: 4, stackpage=d7fe7000)
Apr 12 22:05:28 cs865114-a kernel: Stack: d2290a60 d2290a40 c0141806 d2b12400 d7e618a0 d7e618a0 00000008 00000545
Apr 12 22:05:28 cs865114-a kernel:        d7fe6000 00000000 00000759 c012a6d1 00010f00 00000004 00000000 00000004
Apr 12 22:05:28 cs865114-a kernel:        c0141b11 000037cd c012a74e 00000006 00000004 00010f00 c0236f8c 00000006
Apr 12 22:05:28 cs865114-a kernel: Call Trace: [prune_dcache+230/336] [refill_inactive+129/160] [shrink_dcache_memory+33/64] [do_try_to_free_pages+94/128] [kswapd+107/240] [init+0/320] [init+0/320]
Apr 12 22:05:28 cs865114-a kernel:        [kernel_thread+38/48] [kswapd+0/240]
Apr 12 22:05:28 cs865114-a kernel:
Apr 12 22:05:28 cs865114-a kernel: Code: 8b 46 10 85 c0 74 04 53 ff d0 58 ff 4b 24 0f 94 c0 84 c0 0f
Apr 12 22:05:29 cs865114-a kernel: kernel BUG at exit.c:458!

=======================================================================


ksymoops output:

===================================
ksymoops 2.3.4 on i686 2.4.3.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3/ (default)
     -m /usr/src/linux/System.map (specified)

Apr 12 22:05:28 cs865114-a kernel: Unable to handle kernel paging request at virtual address a95af80d
Apr 12 22:05:28 cs865114-a kernel: c01433b6
Apr 12 22:05:28 cs865114-a kernel: *pde = 00000000
Apr 12 22:05:28 cs865114-a kernel: Oops: 0000
Apr 12 22:05:28 cs865114-a kernel: CPU:    0
Apr 12 22:05:28 cs865114-a kernel: EIP:    0010:[iput+38/336]
Apr 12 22:05:28 cs865114-a kernel: EFLAGS: 00210282
Apr 12 22:05:28 cs865114-a kernel: eax: a95af7fd   ebx: d2b12400   ecx: d2b12410   edx: d2b12410
Apr 12 22:05:28 cs865114-a kernel: esi: a95af7fd   edi: d2b12400   ebp: 00003470   esp: d7fe7f64
Apr 12 22:05:28 cs865114-a kernel: ds: 0018   es: 0018   ss: 0018
Apr 12 22:05:28 cs865114-a kernel: Process kswapd (pid: 4, stackpage=d7fe7000)
Apr 12 22:05:28 cs865114-a kernel: Stack: d2290a60 d2290a40 c0141806 d2b12400 d7e618a0 d7e618a0 00000008 00000545
Apr 12 22:05:28 cs865114-a kernel:        d7fe6000 00000000 00000759 c012a6d1 00010f00 00000004 00000000 00000004
Apr 12 22:05:28 cs865114-a kernel:        c0141b11 000037cd c012a74e 00000006 00000004 00010f00 c0236f8c 00000006
Apr 12 22:05:28 cs865114-a kernel: Call Trace: [prune_dcache+230/336] [refill_inactive+129/160] [shrink_dcache_memory+33/64] [do_try_to_free_pages+94/128] [kswapd+107/240] [init+0/320] [init+0/320]
Apr 12 22:05:28 cs865114-a kernel: Code: 8b 46 10 85 c0 74 04 53 ff d0 58 ff 4b 24 0f 94 c0 84 c0 0f
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 46 10                  mov    0x10(%esi),%eax
Code;  00000003 Before first symbol
   3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
   5:   74 04                     je     b <_EIP+0xb> 0000000b Before first symbol
Code;  00000007 Before first symbol
   7:   53                        push   %ebx
Code;  00000008 Before first symbol
   8:   ff d0                     call   *%eax
Code;  0000000a Before first symbol
   a:   58                        pop    %eax
Code;  0000000b Before first symbol
   b:   ff 4b 24                  decl   0x24(%ebx)
Code;  0000000e Before first symbol
   e:   0f 94 c0                  sete   %al
Code;  00000011 Before first symbol
  11:   84 c0                     test   %al,%al
Code;  00000013 Before first symbol
  13:   0f 00 00                  sldt   (%eax)

======================================================
My hardware:
Motherboard: Asus P2B
CPU        : P-III 600 (no overclocking)
RAM        : 384 MB
IDE        : PIIX4: IDE controller on PCI bus 00 dev 21
             PIIX4: chipset revision 1
             hda: WDC WD200BB-00AUA1, ATA DISK drive
             hdb: MATSHITA CR-589, ATAPI CD/DVD-ROM drive  (ide-scsi)
             hdc: WDC AC313000R, ATA DISK drive
             hdd: MITSBICDRW4420a, ATAPI CD/DVD-ROM drive  (ide-scsi)
eth0       : eepro100
eth1       : 3c590
sound      : es1370


