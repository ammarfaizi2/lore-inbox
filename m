Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263184AbTCTDhw>; Wed, 19 Mar 2003 22:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbTCTDhv>; Wed, 19 Mar 2003 22:37:51 -0500
Received: from franka.aracnet.com ([216.99.193.44]:64158 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263184AbTCTDht>; Wed, 19 Mar 2003 22:37:49 -0500
Date: Wed, 19 Mar 2003 19:48:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 474] New: poisoned oops in ext3_writepage
Message-ID: <1650000.1048132125@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=474

           Summary: poisoned oops in ext3_writepage
    Kernel Version: 2.5.65
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: x86 cpu, PIIX4 IDE, Maxtor ATA DISK drives, 256mb RAM

Software Environment: 
Linux razor 2.5.65 #9 Tue Mar 18 09:48:05 EST 2003 i686 Pentium II (Klamath) 
GenuineIntel GNU/Linux

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      implemented
e2fsprogs              1.30-WIP
reiserfsprogs          3.6.3
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2

CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD_DEBUG=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y

Problem Description:
Unable to handle kernel paging request at virtual address 6b6b6b80
 printing eip:
c019790c
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c019790c>]    Not tainted
EFLAGS: 00010292
EIP is at ext3_writepage+0x40c/0x5bc
eax: 6b6b6b6b   ebx: 00000000   ecx: c13e9a34   edx: 00000000
esi: cf03bd34   edi: ceca3314   ebp: c1945bf0   esp: c1945bd4
ds: 007b   es: 007b   ss: 0068
Process apache (pid: 3429, threadinfo=c1944000 task=c6856000)
Stack: cf03bd34 c1944000 c1945c24 c1945c44 00000001 00000000 c9f10ca4 c1945c8c
       c0140f88 c1170700 c1945c24 c1945cd4 c03b83dc c103bf88 c1170700 00000000
       00000000 ceca33d0 c1945c1c c1945c1c 00000000 00000000 00000000 00000020
Call Trace:
 [<c0140f88>] shrink_list+0x2b8/0x4b0
 [<c010b651>] do_IRQ+0x2d1/0x2ec
 [<c0117172>] schedule+0x39e/0x5c4
 [<c01413d3>] shrink_cache+0x253/0x514
 [<c011545b>] do_page_fault+0x14b/0x40e
 [<c0115310>] do_page_fault+0x0/0x40e
 [<c0142028>] shrink_zone+0x68/0x74
 [<c01420a3>] shrink_caches+0x6f/0xa0
 [<c0142163>] try_to_free_pages+0x8f/0xcc
 [<c013a118>] __alloc_pages+0x1c8/0x274
 [<c0145c12>] do_anonymous_page+0x232/0x4d4
 [<c0145eea>] do_no_page+0x36/0x47c
 [<c013a4ee>] get_page_state+0xe/0x14
 [<c0146410>] handle_mm_fault+0xe0/0x244
 [<c011545b>] do_page_fault+0x14b/0x40e
 [<c0115310>] do_page_fault+0x0/0x40e
 [<c0148b21>] do_brk+0x105/0x1cc
 [<c014728b>] sys_brk+0xcb/0xf8
 [<c0109c7d>] error_code+0x2d/0x38

Code: c6 40 15 01 83 c4 04 85 db 0f 44 da 85 db 74 15 53 68 4d 40

Steps to reproduce:
I was running dbench 32 on an ext3 partition without htree, and was running ab 
(apache bench) on the local webserver, 200 concurrent connections to a php 
script. The system survived the oops.  All filesystems have been fscked within 
the last 5 days. After the oops, a forced fsck shows all filesystems are clean. 
All ext3 filesystems are mounted with "defaults,noatime,errors=remount-ro" 
options.


